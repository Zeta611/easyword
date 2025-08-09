import { redirect } from "next/navigation";

import { LogoutButton } from "@/components/LogoutButton";
import { createClient } from "@/lib/supabase/server";

export default async function Profile() {
  const supabase = await createClient();

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();
  if (error || !user) redirect("/auth/login");

  const { data: profile } = await supabase
    .from("profile")
    .select("display_name")
    .eq("id", user.id)
    .maybeSingle();

  return (
    <div className="flex w-full items-center justify-center gap-2">
      <p>
        안녕하세요 <span>{profile?.display_name ?? ""}님!</span>
        <br />
        이메일: <span>{user.email}</span>
      </p>
      <LogoutButton />
    </div>
  );
}
