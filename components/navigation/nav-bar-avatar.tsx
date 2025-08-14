"use client";

import Link from "next/link";
import { User } from "lucide-react";
import { CurrentUserAvatar } from "@/components/auth/current-user-avatar";
import { useUserQuery } from "@/hooks/use-user-query";
import { useLoginDialog } from "@/components/auth/login-dialog-provider";
import { Button } from "@/components/ui/button";

export default function NavBarAvatar() {
  const { data: user, isLoading } = useUserQuery();
  const { openLogin } = useLoginDialog();

  switch (isLoading ? null : !!user) {
    case null:
      return (
        <Button className="size-8.5 rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl">
          <User />
        </Button>
      );

    case false:
      return (
        <Button
          onClick={() => openLogin()}
          className="size-8.5 rounded-sm bg-black p-2 text-white transition-all ease-in-out hover:rounded-3xl"
        >
          <User />
        </Button>
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
