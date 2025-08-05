"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { User } from "lucide-react";
import { CurrentUserAvatar } from "@/components/CurrentUserAvatar";
import { createClient } from "@/lib/supabase/client";

export default function NavBarAvatar() {
  const [signedIn, setSignedIn] = useState<boolean | null>(null);

  useEffect(() => {
    const fetchSession = async () => {
      const { data, error } = await createClient().auth.getSession();
      if (error) {
        console.error(error);
      }

      setSignedIn(!!data.session?.user);
    };

    fetchSession();
  }, []);

  switch (signedIn) {
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
