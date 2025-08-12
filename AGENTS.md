## AGENTS guide

This document is for AI coding agents working on easyword.kr (쉬운 전문용어). It summarizes the architecture, constraints, and repeatable recipes to safely implement changes.

Read this alongside `README.md` and the codebase. Prefer server-driven data access via Supabase SSR and keep UI/UX copy in Korean.

### Quick start

- Dev: `bun run dev`
- Build: `bun run build`
- Lint: `bun run lint`
- Format (lint --fix): `bun run format`
- Typecheck: `bun run typecheck`
- Full check (format + lint + typecheck): `bun run check`

Environment variables (set in `.env.local`):

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### Architecture snapshot

- Framework: Next.js 15 (App Router), React 19, TypeScript (strict)
- Styling/UI: Tailwind CSS v4, shadcn/ui (Radix primitives), cmdk palette
- Data/Auth: Supabase (Postgres, Auth)
  - Server components/pages: SSR client from `lib/supabase/server` via `createClient()`
  - Client components/hooks: browser client from `lib/supabase/client` via `getClient()`
- Notable patterns: Hybrid SSR + client pagination (TanStack Query), RPC-based search (wrapped in `lib/supabase/repository.ts`), Korean locale time with dayjs

Key directories:

- `app/`: App Router pages. Public routes by default; protected paths are checked in middleware
- `components/`: Presentational/interactive UI. Includes `jargon/JargonInfiniteList`, `comment/*`, `navigation/NavBar*`, `ui/*`
- `hooks/`: Client hooks (`useSearch`, `useCurrentUserNameAndImage`, `useUserQuery`, `useDebounce`)
- `lib/supabase/`: `client.ts` (browser), `server.ts` (SSR), `middleware.ts` (session), `types.ts` (generated types), `repository.ts` (DB helpers)
- `types/`: App-level types (`types/comment.ts`)

### Supabase usage

- Server components/pages: create SSR client via `createClient()` from `lib/supabase/server`
- Client components/hooks: create browser client via `getClient()` from `lib/supabase/client`
- Prefer DB helpers in `lib/supabase/repository.ts` when available:
  - `DB.searchJargons`, `DB.countSearchJargons`
  - `DB.suggestJargon`, `DB.suggestTranslation`, `DB.createComment`
- Comments read: query `comment` with joins (profile and translation) rather than a separate view
- Type-safety: Prefer types from `lib/supabase/types.ts`. Treat this file as generated—do not hand-edit schema definitions here

Auth/session rules (critical):

- Session refresh and route protection live in `lib/supabase/middleware.ts`
- Do not insert logic between client creation and `supabase.auth.getClaims()` in middleware
- Middleware currently redirects unauthenticated users from `/profile` to `/auth/login`
- To protect additional routes, extend the `pathname.startsWith(...)` checks in the middleware

### UI/UX conventions

- Language: Korean UI copy; keep tone consistent
- Time: dayjs with `relativeTime` and `ko` locale
- Command palette: via `components/dialogs/SearchDialogProvider.tsx`, cmdk with `shouldFilter=false`; keyboard shortcuts `⌘K` and `/`
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
- RPCs used: `search_jargons`, `count_search_jargons`, `suggest_jargon`, `suggest_translation`, `create_comment`

If you need new SQL/RPC:

- The maintainer executes SQL manually in Supabase. Provide exact SQL body and name the function explicitly. Reflect the return shape in TS if used on the client or add a typed wrapper in `repository.ts`

### Important files to read before changes

- `app/page.tsx`: SSR entry + initial search data via RPC (count + first page)
- `components/home/HomePageClient.tsx`: URL param management for sort/category; opens filter dialog; passes props to list
- `components/home/FloatingActionButtons.tsx`: Mobile FABs (search, sort, filter)
- `components/jargon/JargonInfiniteList.tsx`: Client pagination (useInfiniteQuery) + "더보기"
- `app/jargon/[slug]/page.tsx`: Jargon details + initial comments
- `components/comment/CommentThread.tsx`: Client comment fetching + tree building
- `components/comment/CommentItem.tsx`: Nested replies UI, relative timestamps
- `components/comment/CommentForm.tsx`: Auth gating + insert via RPC
- `hooks/useSearch.ts`: Debounced search source for cmdk dialog
- `hooks/useUserQuery.ts`, `hooks/useCurrentUserNameAndImage.ts`: Auth state helpers
- `components/dialogs/SearchDialogProvider.tsx`: Command palette implementation
- `middleware.ts` and `lib/supabase/middleware.ts`: Session update and route guard

### Safe change recipes

Add a new protected page under `app/`:

1) Create a server component under `app/your-page/page.tsx`
2) Fetch data with SSR client from `lib/supabase/server` or via `lib/supabase/repository`
3) Extend the guard in `lib/supabase/middleware.ts` by adding `request.nextUrl.pathname.startsWith("/your-page")`

Query more columns with type-safety:

1) Use `getClient()` in client or `createClient()` on the server
2) Prefer repository RPCs when logic belongs in SQL; otherwise `.from("table").select(...)`
3) Align selected fields with `lib/supabase/types.ts`; extend app-local types in `types/` if needed

Extend search sorting or filters:

1) Update the `search_jargons` RPC signature and the `DB.searchJargons` wrapper to accept new `sort_option` or filter params (e.g., categories)
2) Pass-through from `app/page.tsx` to RPC. Keep initial SSR count via `DB.countSearchJargons`
3) Mirror any new result fields in `JargonData` in `components/jargon/JargonInfiniteList.tsx` and update URL params handling in `HomePageClient`

Add comment features (e.g., soft-delete, edit):

1) Prefer server-side enforcement in SQL (e.g., RLS policies, RPCs)
2) For writes, use `DB.createComment` or add new RPCs; for reads, extend the `comment` select joins (profile, translation)
3) Keep tree-building rules: roots newest-first, replies oldest-first

### Guardrails for agents

- Do not modify `lib/supabase/types.ts` by hand; it’s generated from DB schema
- Keep `lib/supabase/middleware.ts` claim-check flow intact; do not insert logic before `getClaims()` and always return the mutated `supabaseResponse`
- Avoid introducing heavy state libraries; reuse existing hooks/components
- Keep copy in Korean; avoid mixed language unless a proper translation is provided
- Maintain accessibility: buttons, aria labels, keyboard flows in cmdk
- Validate any user write operations require an authenticated user (client-side gating via hooks; server-side via RLS/RPC)

### Testing/build checklist

- `bun run check` passes (format + lint + typecheck)
- App builds (`bun run build`) and loads primary routes:
  - `/` with and without `?q=...`, `?sort=...`, `?categories=...`
  - `/jargon/[slug]` with comments
  - Protected routes (e.g., `/profile`) redirect when unauthenticated

### References

- See `README.md` for a high-level roadmap and TODOs
- Supabase SSR patterns are implemented per official guidance in `lib/supabase/*`