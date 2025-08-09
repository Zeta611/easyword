"use client";

import Link from "next/link";
import { User } from "lucide-react";
import { CurrentUserAvatar } from "@/components/CurrentUserAvatar";
import { useUserQuery } from "@/hooks/useUserQuery";

export default function NavBarAvatar() {
  const { data: user, isLoading } = useUserQuery();

  switch (isLoading ? null : !!user) {
    case null:
      return (
        <div className="rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl">
          <User />
        </div>
      );
    case false:
      return (
        <Link href="/auth/login">
          <div className="rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl">
            <User />
          </div>
        </Link>
      );

    case true:
      return (
        <Link href="/profile">
          <div className="rounded-full bg-black p-1">
            <CurrentUserAvatar />
          </div>
        </Link>
      );
  }
}
