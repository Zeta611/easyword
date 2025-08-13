import { readdirSync, readFileSync, writeFileSync } from "fs";
import { join, dirname, basename, extname } from "path";
import { execSync } from "child_process";

const ROOT = "/workspace";

function shouldSkipDir(dirName) {
  return dirName === "node_modules" || dirName === ".git";
}

function isTsFile(path) {
  return path.endsWith(".ts") || path.endsWith(".tsx");
}

function hasUppercaseInFilename(filePath) {
  const base = basename(filePath);
  return /[A-Z]/.test(base) && isTsFile(filePath);
}

function toKebabCase(name) {
  // QueryProvider -> query-provider, GitHub -> git-hub, createComment -> create-comment
  return name
    .replace(/([a-z0-9])([A-Z])/g, "$1-$2")
    .replace(/([A-Z]+)([A-Z][a-z])/g, "$1-$2")
    .toLowerCase();
}

function walk(dir, acc) {
  const entries = readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    if (entry.isDirectory()) {
      if (shouldSkipDir(entry.name)) continue;
      walk(join(dir, entry.name), acc);
    } else {
      acc.push(join(dir, entry.name));
    }
  }
}

async function main() {
  const allFiles = [];
  walk(ROOT, allFiles);

  const renameTargets = allFiles.filter(hasUppercaseInFilename);

  const mappings = [];
  for (const oldPath of renameTargets) {
    const dir = dirname(oldPath);
    const base = basename(oldPath);
    const name = base.slice(0, base.lastIndexOf("."));
    const ext = extname(oldPath);
    const kebabBase = toKebabCase(name);
    const nextPath = join(dir, `${kebabBase}${ext}`);
    if (nextPath !== oldPath) {
      mappings.push({ oldPath, nextPath, oldBase: name, newBase: kebabBase });
    }
  }

  // Deduplicate mappings by destination in case of accidental duplicates
  const seen = new Set();
  const deduped = [];
  for (const m of mappings) {
    const key = `${m.oldPath} -> ${m.nextPath}`;
    if (seen.has(key)) continue;
    seen.add(key);
    deduped.push(m);
  }

  // Perform renames using git mv; fallback to fs rename if necessary
  for (const { oldPath, nextPath } of deduped) {
    try {
      execSync(`git mv -f -- "${oldPath}" "${nextPath}"`, { stdio: "inherit" });
    } catch {
      // ignore and try direct rename
      try {
        const fs = await import("fs");
        fs.renameSync(oldPath, nextPath);
      } catch (e) {
        console.error("Failed to rename:", oldPath, "->", nextPath, e);
      }
    }
  }

  // Update import paths in all TS/TSX files
  const sourceFiles = allFiles.filter((p) => isTsFile(p) && !p.includes("/node_modules/") && !p.includes("/.git/"));
  for (const file of sourceFiles) {
    let content = readFileSync(file, "utf8");
    let changed = false;

    for (const { oldBase, newBase } of deduped) {
      // Replace path segments only. Handle alias paths (e.g. @/...), and relative paths.
      const before = content;
      content = content
        .replace(new RegExp(`/${oldBase}(?=["'\\/])`, "g"), `/${newBase}`)
        .replace(new RegExp(`\\./${oldBase}(?=["'\\/])`, "g"), `./${newBase}`)
        .replace(new RegExp(`\\.\\./${oldBase}(?=["'\\/])`, "g"), `../${newBase}`);
      if (content !== before) changed = true;
    }

    if (changed) writeFileSync(file, content);
  }

  console.log("Renamed files (count):", deduped.length);
  for (const m of deduped) {
    console.log(m.oldPath.replace(ROOT + "/", ""), "->", m.nextPath.replace(ROOT + "/", ""));
  }
}

main();