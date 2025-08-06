import { redirect } from "next/navigation";

import { LogoutButton } from "@/components/LogoutButton";
import { createClient } from "@/lib/supabase/server";

export default async function Profile() {
  const supabase = await createClient();

  // const { data, error } = await supabase.auth.getClaims();
  // if (error || !data?.claims) {
  //   redirect("/auth/login");
  // }

  const { data, error } = await supabase.auth.getSession();
  if (error || !data?.session?.user) {
    redirect("/auth/login");
  }

  return (
    <div className="flex w-full items-center justify-center gap-2">
      <p>
        안녕하세요 <span>{data.session.user.user_metadata.full_name}님!</span>
        <br />
        이메일: <span>{data.session.user.email}</span>
      </p>
      <LogoutButton />
    </div>
  );
}
