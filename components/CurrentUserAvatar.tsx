"use client";

import { useCurrentUserNameAndImage } from "@/hooks/useCurrentUserNameAndImage";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";

export const CurrentUserAvatar = () => {
  const [name, profileImage] = useCurrentUserNameAndImage();
  const initials = name
    ?.split(" ")
    ?.map((word) => word[0])
    ?.join("")
    ?.toUpperCase();

  return (
    <Avatar>
      {profileImage && <AvatarImage src={profileImage} alt={initials} />}
      <AvatarFallback>{initials}</AvatarFallback>
    </Avatar>
  );
};
