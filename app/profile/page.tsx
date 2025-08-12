import { redirect } from "next/navigation";

import { LogoutButton } from "@/components/auth/LogoutButton";
import { createClient } from "@/lib/supabase/server";
import { QUERIES } from "@/lib/supabase/repository";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

export default async function Profile() {
  const supabase = await createClient();

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser();
  if (error || !user) redirect("/auth/login");

  const { data: profile } = await QUERIES.getNameAndPhoto(supabase, user.id);

  const initials = (profile?.display_name || (user.email ?? "")).slice(0, 2).toUpperCase();

  return (
    <div className="mx-auto flex w-full max-w-xl items-center justify-center p-4">
      <Card className="w-full">
        <CardHeader className="flex flex-row items-center gap-4">
          <Avatar className="h-12 w-12">
            {profile?.photo_url ? (
              <AvatarImage src={profile.photo_url} alt={profile?.display_name ?? ""} />
            ) : null}
            <AvatarFallback>{initials}</AvatarFallback>
          </Avatar>
          <div className="flex flex-col">
            <CardTitle className="text-xl">
              {profile?.display_name ?? "이름 없는 사용자"}
            </CardTitle>
            <span className="text-sm text-muted-foreground">{user.email}</span>
          </div>
          <div className="ml-auto">
            <LogoutButton />
          </div>
        </CardHeader>
        <CardContent>
          <div className="text-sm text-muted-foreground">
            환영합니다. 프로필 관련 기능은 곧 더 추가될 예정이에요.
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
