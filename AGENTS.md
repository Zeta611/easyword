## AGENTS guide

This document is for AI coding agents working on easyword.kr (쉬운 전문용어). It summarizes the architecture, constraints, and repeatable recipes to safely implement changes.

Read this alongside `CLAUDE.md` (project overview and tech notes) and the codebase. Prefer server-driven data access via Supabase SSR and keep UI/UX copy in Korean.

### Quick start

- Dev: `bun run dev`
- Build: `bun run build`
- Lint: `bun run lint`
- Format (lint --fix): `bun run format`

Environment variables (set in `.env.local`):

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### Architecture snapshot

- Framework: Next.js 15 (App Router), React 19, TypeScript (strict)
- Styling/UI: Tailwind CSS v4, shadcn/ui (Radix primitives), cmdk palette
- Data/Auth: Supabase (Postgres, Auth). SSR client for server routes; browser client for client components
- Notable patterns: Hybrid SSR + client pagination, RPC-based search, Korean locale time with dayjs

Key directories:

- `app/`: App Router pages. Public routes by default; protected paths are checked in middleware
- `components/`: Presentational/interactive UI. Includes `JargonInfiniteList`, `Comment*`, `NavBar*`, `ui/*`
- `hooks/`: Client hooks (`useSearch`, `useInfiniteQuery`, `useCurrentUserNameAndImage`)
- `lib/supabase/`: `client.ts` (browser), `server.ts` (SSR), `middleware.ts` (session), `types.ts` (generated types)
- `types/`: App-level types (`types/comment.ts`)

### Supabase usage

- Server components/pages: create SSR client via `createClient` from `lib/supabase/server`
- Client components/hooks: create browser client via `createClient` from `lib/supabase/client`
- RPC-first search: `search_jargons_with_translations`, `count_search_jargons`
- Comments read: `comments_with_authors` view; write to `comment` table
- Type-safety: Prefer types from `lib/supabase/types.ts`. Treat this file as generated—do not hand-edit schema definitions here

Auth/session rules (critical):

- Session refresh and route protection live in `lib/supabase/middleware.ts`
- Do not insert logic between client creation and `supabase.auth.getClaims()` in middleware
- Middleware currently redirects unauthenticated users from `/profile` and `/add-jargon` to `/auth/login`

### UI/UX conventions

- Language: Korean UI copy; keep tone consistent
- Time: dayjs with `relativeTime` and `ko` locale
- Command palette: custom filtering (cmdk `shouldFilter=false`); keyboard shortcuts `⌘K` and `/`
- Mobile-first: floating search button on mobile, hidden on desktop
- Pagination: button-driven "더보기" rather than infinite scroll on viewport

### Code conventions

- TypeScript strict; explicit component/prop types
- Client vs server: mark client components with `"use client"`; prefer server data fetching where possible
- Naming: descriptive function/variable names; avoid abbreviations
- Control flow: early returns; shallow nesting
- Comments: add only where non-obvious; explain “why” not “how”
- Formatting: match existing style; avoid unrelated refactors in edits

### Data model (essentials)

- Tables: `jargon`, `translation`, `category`, `jargon_category`, `comment`, `related_jargon`, legacy `legacy_fb_user`
- View: `comments_with_authors` (joined comment + author metadata)
- RPCs: `search_jargons_with_translations`, `count_search_jargons`, `list_jargon_random`, and helpers (`generate_slug`, lowercasing helpers)

If you need new SQL/RPC:

- The maintainer executes SQL manually in Supabase. Provide exact SQL body and name the function explicitly. Reflect the return shape in TS if used on the client

### Important files to read before changes

- `app/page.tsx`: SSR entry + initial search data via RPC
- `app/jargon/[slug]/page.tsx`: Jargon details + comment thread
- `components/CommentThread.tsx`: Client comment fetching + tree building
- `components/CommentItem.tsx`: Nested replies UI, relative timestamps
- `components/CommentForm.tsx`: Auth check + insert into `comment`
- `hooks/useSearch.ts`: Debounced client search (jargon + translation)
- `hooks/useInfiniteQuery.ts`: Generic, typed, client-side pager
- `middleware.ts` and `lib/supabase/middleware.ts`: Session update and route guard

### Safe change recipes

Add a new protected page under `app/`:

1) Create server component under `app/your-page/page.tsx`
2) Fetch data with SSR client from `lib/supabase/server`
3) Add `request.nextUrl.pathname.startsWith("/your-page")` to the guard list in `lib/supabase/middleware.ts`

Query more columns with type-safety:

1) Use `createClient` appropriate to environment
2) Prefer `.rpc()` when logic belongs in SQL; otherwise `.from("table").select(...)`
3) Align selected fields with `lib/supabase/types.ts` shapes; extend app-local types in `types/` if needed

Extend search sorting or filters:

1) Update RPC `search_jargons_with_translations` to accept a new `sort_option` or filter params
2) Pass-through from `app/page.tsx` to RPC. Keep initial SSR count via `count_search_jargons`
3) Mirror any new result fields in `JargonData` in `JargonInfiniteList`

Add comment features (e.g., soft-delete, edit):

1) Prefer server-side enforcement in SQL (e.g., RLS policies, views)
2) For writes, use client `comment` table mutations; for reads, extend `comments_with_authors`
3) Keep tree-building rules: roots newest-first, replies oldest-first

### Guardrails for agents

- Do not modify `lib/supabase/types.ts` by hand; it’s generated from DB schema
- Keep `lib/supabase/middleware.ts` claim-check flow intact; do not insert logic before `getClaims()`
- Avoid introducing heavy state libraries; reuse existing hooks/components
- Keep copy in Korean; avoid mixed language unless a proper translation is provided
- Maintain accessibility: buttons, aria labels, keyboard flows in cmdk
- Validate any user write operations require an authenticated user (`supabase.auth.getUser()`)

### Testing/build checklist

- `bun lint` passes with no new warnings
- App builds (`bun build`) and loads primary routes:
  - `/` with and without `?q=...`
  - `/jargon/[slug]` with comments
  - Protected routes redirect when unauthenticated

### References

- See `CLAUDE.md` for a fuller architecture, feature, and dependency summary
- Supabase SSR patterns are implemented per official guidance in `lib/supabase/*`