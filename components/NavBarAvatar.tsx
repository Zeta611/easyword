"use client";

import Link from "next/link";
import { User } from "lucide-react";
import { CurrentUserAvatar } from "@/components/CurrentUserAvatar";
import { useUserQuery } from "@/hooks/useUserQuery";
import { useLoginPrompt } from "@/components/LoginPromptProvider";

export default function NavBarAvatar() {
  const { data: user, isLoading } = useUserQuery();
  const { openLogin } = useLoginPrompt();

  switch (isLoading ? null : !!user) {
    case null:
      return (
        <div className="rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl">
          <User />
        </div>
      );

    case false:
      return (
        <button
          type="button"
          onClick={() => openLogin()}
          className="rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl"
        >
          <User />
        </button>
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
