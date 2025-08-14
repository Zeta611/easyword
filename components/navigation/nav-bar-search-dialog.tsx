"use client";

import { Button } from "@/components/ui/button";
import Kbd from "@/components/ui/kbd";
import { useSearchDialog } from "@/components/dialogs/search-dialog-provider";

export default function NavBarSearchDialog() {
  const { openDialog } = useSearchDialog();

  return (
    <>
      <Button
        variant="outline"
        className="bg-accent hidden justify-between sm:flex sm:w-40 md:w-56 lg:w-64"
        onClick={openDialog}
      >
        쉬운 전문용어 찾기
        <Kbd>/</Kbd>
      </Button>
    </>
  );
}
