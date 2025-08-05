# EasyWord - 쉬운 전문용어

A Korean computer science terminology translation platform built with Next.js 15, React 19, and Supabase.

## Project Overview
EasyWord (쉬운 전문용어) is a web platform for translating computer science and computer engineering terms into Korean. It's supported by the Korean Information Science Society (KIISE) Easy Professional Terminology Committee.

## Architecture & Tech Stack
- **Framework**: Next.js 15 with App Router
- **Frontend**: React 19, TypeScript
- **Styling**: Tailwind CSS v4, Radix UI components
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth with social login
- **Development**: Bun package manager, ESLint, Prettier

## Database Schema
The app uses these main tables:
- `jargon`: Computer science terms (id, name, author_id, timestamps)
- `translation`: Korean translations of jargon terms
- `category`: Term categories with acronyms
- `jargon_category`: Many-to-many relationship between jargon and categories
- `comment`: Comments on jargons and translations
- `user`: User profiles (id, display_name, email, photo_url)
- `related_jargon`: Links between related terms

## Key Features
- Browse computer science terms with Korean translations
- Categorized terminology with acronym tags
- User authentication with social login
- Responsive grid layout for term cards
- Protected user profile pages
- Avatar-based navigation and user display

## Authentication Setup
- Uses Supabase SSR for authentication
- Middleware protects `/profile/*` routes only
- All other routes are publicly accessible
- Social authentication with OAuth providers
- Login/logout functionality with user avatars
- Auth error handling and redirect flows

## File Structure
```
app/
├── auth/
│   ├── error/      # Auth error handling
│   ├── login/      # Login page
│   └── oauth/      # OAuth callback route
├── jargon/[id]/    # Individual jargon term pages
├── profile/        # User profile page (protected)
├── page.tsx        # Home page with jargon grid
└── layout.tsx      # Root layout with nav and footer

components/
├── CurrentUserAvatar.tsx  # User avatar component
├── JargonCard.tsx         # Term display component
├── LoginForm.tsx          # Login form component
├── LogoutButton.tsx       # Logout functionality
├── NavBar.tsx             # Main navigation bar
├── NavBarAvatar.tsx       # Navigation avatar component
└── ui/                    # Reusable UI components
    ├── avatar.tsx
    ├── button.tsx
    └── card.tsx

hooks/
└── useCurrentUserNameAndImage.ts  # User data hook

lib/
├── supabase/       # Supabase client, server, middleware, types
│   ├── client.ts
│   ├── middleware.ts
│   ├── server.ts
│   └── types.ts
└── utils.ts        # Utility functions

middleware.ts       # Next.js middleware for route protection
```

## Development Commands
- `npm run dev` / `bun dev`: Start development server with Turbopack
- `npm run build`: Build production version
- `npm run lint`: Run ESLint
- `npm run format`: Auto-fix linting issues

## Environment Variables
Requires Supabase configuration:
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

## Current Branch Status
Working on `nextjs` branch with recent auth setup additions and middleware configuration for selective route protection.