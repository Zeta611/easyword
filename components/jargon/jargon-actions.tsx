"use client";

import { useActionState, useEffect } from "react";
import { redirect, RedirectType } from "next/navigation";
import Form from "next/form";
import { useQueryClient } from "@tanstack/react-query";
import { EraserIcon, PencilIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useUserQuery } from "@/hooks/use-user-query";
import {
  AlertDialog,
  AlertDialogTrigger,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogCancel,
  AlertDialogAction,
} from "@/components/ui/alert-dialog";
import {
  Dialog,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
  DialogClose,
} from "@/components/ui/dialog";
import { updateJargon } from "@/app/actions/update-jargon";
import { removeJargon } from "@/app/actions/remove-jargon";

export default function JargonActions({
  jargonId,
  authorId,
  name,
}: {
  jargonId: string;
  authorId: string;
  name: string;
}) {
  const queryClient = useQueryClient();

  const { data: user } = useUserQuery();
  const isAdmin = user?.app_metadata?.userrole === "admin";
  const canManage = !!user && (user.id === authorId || isAdmin);

  const [updateState, updateAction] = useActionState(
    updateJargon.bind(null, jargonId),
    { ok: false, error: "" },
  );
  const [removeState, removeAction] = useActionState(
    removeJargon.bind(null, jargonId),
    { ok: false, error: "" },
  );

  useEffect(() => {
    if (removeState.ok) {
      queryClient.invalidateQueries({ queryKey: ["jargons"] });
      redirect("/", RedirectType.replace);
    }
  }, [removeState.ok, queryClient]);

  useEffect(() => {
    if (updateState.ok) {
      queryClient.invalidateQueries({ queryKey: ["jargons"] });
      redirect(`/jargon/${updateState.jargonSlug}`, RedirectType.replace);
    }
  }, [updateState.ok, updateState, queryClient]);

  if (!canManage) return null;

  return (
    <div className="ml-1 flex items-center gap-1">
      <Dialog>
        <DialogTrigger asChild>
          <Button type="button" variant="ghost" title="고치기">
            <PencilIcon />
          </Button>
        </DialogTrigger>
        <DialogContent className="sm:max-w-[420px]">
          <DialogHeader>
            <DialogTitle>용어 이름 고치기</DialogTitle>
            <DialogDescription>
              새로운 용어 이름을 입력해 주세요. 저장하면 짧은 이름(slug)도 함께
              바뀌어요.
            </DialogDescription>
          </DialogHeader>
          <Form action={updateAction} className="grid gap-3">
            <Input name="name" defaultValue={name} autoFocus />
            {updateState?.error && (
              <span className="text-xs text-red-600">{updateState.error}</span>
            )}
            <DialogFooter>
              <DialogClose asChild>
                <Button type="button" variant="outline">
                  닫기
                </Button>
              </DialogClose>
              <Button type="submit">저장</Button>
            </DialogFooter>
          </Form>
        </DialogContent>
      </Dialog>

      <AlertDialog>
        <AlertDialogTrigger asChild>
          <Button
            type="button"
            variant="ghost"
            className="text-red-600 hover:text-red-700"
            title="지우기"
          >
            <EraserIcon />
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>정말로 용어를 지울까요?</AlertDialogTitle>
            <AlertDialogDescription>
              이 작업은 되돌릴 수 없어요. 관련 댓글과 번역도 함께 지워져요.
            </AlertDialogDescription>
          </AlertDialogHeader>
          {removeState?.error && (
            <span className="text-xs text-red-600">{removeState.error}</span>
          )}
          <AlertDialogFooter>
            <AlertDialogCancel>닫기</AlertDialogCancel>
            <Form action={removeAction}>
              <AlertDialogAction
                type="submit"
                className="bg-red-600 hover:bg-red-700"
              >
                지우기
              </AlertDialogAction>
            </Form>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
