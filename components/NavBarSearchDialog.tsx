"use client";

import { Button } from "@/components/ui/button";
import Kbd from "@/components/Kbd";
import { useSearchDialog } from "@/components/SearchDialogProvider";

export default function NavBarSearchDialog() {
  const { openDialog } = useSearchDialog();

  return (
    <>
      <Button
        variant="outline"
        className="bg-accent hidden w-64 justify-between sm:flex"
        onClick={openDialog}
      >
        쉬운 전문용어 찾기
        <Kbd>/</Kbd>
      </Button>
    </>
  );
}
