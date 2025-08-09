import { useEffect, useState } from "react";
import { getClient } from "@/lib/supabase/client";

export const useCurrentUserNameAndImage = () => {
  const [name, setName] = useState<string | null>(null);
  const [image, setImage] = useState<string | null>(null);

  useEffect(() => {
    const fetchProfile = async () => {
      const { data, error } = await getClient().auth.getSession();
      if (error) {
        console.error(error);
      }

      setName(data.session?.user.user_metadata.full_name ?? "");
      setImage(data.session?.user.user_metadata.avatar_url ?? null);
    };

    fetchProfile();
  }, []);

  return [name || "", image];
};
