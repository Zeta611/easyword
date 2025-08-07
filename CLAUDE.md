# 쉬운 전문용어

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
- **Search**: Real-time search with debounced queries using cmdk
- **UI Components**: shadcn/ui with custom command palette
- **Time Handling**: Day.js with Korean locale for relative timestamps

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

- **Browse & Discovery**: Computer science terms with Korean translations in responsive grid layout
- **Search Functionality**: Real-time search with keyboard shortcuts (`⌘K` or `/`) across both original terms and translations
- **Categorization**: Terms organized by categories with acronym tags
- **User Experience**:
  - Comment counts and relative timestamps ("하루 전", "이틀 전") on term cards
  - Responsive design with mobile-optimized search button
  - Loading states and error handling
- **Authentication**: Social login with Supabase Auth and protected user profiles
- **Navigation**: Avatar-based navigation with modular component structure

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
├── JargonCard.tsx         # Term display component with comments & timestamps
├── Kbd.tsx                # Keyboard shortcut component
├── LoginForm.tsx          # Login form component
├── LogoutButton.tsx       # Logout functionality
├── NavBar.tsx             # Modular navigation bar (refactored)
├── NavBarAvatar.tsx       # Navigation avatar component
├── NavBarSearchButton.tsx # Search button with command dialog
├── NavBarTitle.tsx        # Navigation title component
└── ui/                    # shadcn/ui components
    ├── avatar.tsx
    ├── button.tsx
    ├── card.tsx
    ├── command.tsx        # Command palette with custom shouldFilter
    └── dialog.tsx         # Dialog with custom close button support

hooks/
├── useCurrentUserNameAndImage.ts  # User data hook
└── useSearch.ts                   # Debounced search hook with Supabase queries

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

- `bun dev`: Start development server with Turbopack
- `bun build`: Build production version
- `bun lint`: Run ESLint
- `bun format`: Auto-fix linting issues

## Dependencies

### Core

- **Next.js 15**: React framework with App Router
- **React 19**: Latest React with concurrent features
- **TypeScript**: Type safety and developer experience

### UI & Styling

- **Tailwind CSS v4**: Utility-first CSS framework
- **Radix UI**: Headless UI components (@radix-ui/react-\*)
- **Lucide React**: Icon library
- **Class Variance Authority**: Component variant management
- **cmdk**: Command palette library

### Data & Time

- **Supabase**: Database and authentication (@supabase/supabase-js, @supabase/ssr)
- **Day.js**: Date manipulation with Korean locale support
- **match-sorter**: Fuzzy search and sorting

### Development

- **Bun**: Package manager and runtime
- **ESLint**: Code linting
- **PostCSS**: CSS processing

## Environment Variables

Requires Supabase configuration:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

## Search Implementation

- **Real-time search** with 300ms debounced queries
- **Dual search scope**: Original jargon terms and Korean translations
- **Grouped results**: "원어" (original) and "번역어" (translation) sections
- **Keyboard navigation**: `⌘K` or `/` to open, arrow keys to navigate
- **Custom filtering**: Disabled built-in cmdk filtering for custom match-sorter integration
- **Performance**: Limited to 8 results per group with loading states

## UI Architecture

- **Modular navigation**: NavBar broken into reusable components
- **Command palette**: Custom implementation with shouldFilter=false
- **Responsive design**: Mobile search icon, desktop search button
- **Keyboard shortcuts**: Visual kbd component for accessibility
- **Relative timestamps**: Korean localized time display ("하루 전", "이틀 전")

## Current Branch Status

Working on `nextjs` branch with comprehensive search functionality, modular component architecture, and enhanced user experience features.

