"use client";

import { useActionState, useEffect } from "react";
import Form from "next/form";
import { useQueryClient } from "@tanstack/react-query";
import { EraserIcon, PencilIcon } from "lucide-react";
import { useUserQuery } from "@/hooks/use-user-query";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";
import { Input } from "@/components/ui/input";
import {
  updateTranslation,
  type UpdateTranslationAction,
} from "@/app/actions/update-translation";
import {
  removeTranslation,
  type RemoveTranslationAction,
} from "@/app/actions/remove-translation";

export default function TranslationActions({
  id,
  authorId,
  name,
}: {
  id: string;
  authorId: string;
  name: string;
}) {
  const queryClient = useQueryClient();

  const { data: user } = useUserQuery();
  const isAdmin = user?.app_metadata?.userrole === "admin";
  const canManage = !!user && (user.id === authorId || isAdmin);

  const [updateState, updateAction] = useActionState(
    updateTranslation.bind(null, id) satisfies UpdateTranslationAction,
    { ok: false, error: "" },
  );
  const [removeState, removeAction] = useActionState(
    removeTranslation.bind(null, id) satisfies RemoveTranslationAction,
    { ok: false, error: "" },
  );

  useEffect(() => {
    if (updateState.ok || removeState.ok) {
      queryClient.invalidateQueries({ queryKey: ["translations"] });
      window.location.reload();
    }
  }, [updateState.ok, removeState.ok, queryClient]);

  if (!canManage) return null;

  return (
    <div className="ml-1 flex items-center gap-1">
      <Dialog>
        <DialogTrigger asChild>
          <Button type="button" variant="ghost" size="sm">
            <PencilIcon className="size-3.5" />
          </Button>
        </DialogTrigger>
        <DialogContent className="sm:max-w-[420px]">
          <DialogHeader>
            <DialogTitle>번역 고치기</DialogTitle>
            <DialogDescription>새로운 번역을 입력해 주세요.</DialogDescription>
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
            size="sm"
            variant="ghost"
            className="text-red-600 hover:text-red-700"
          >
            <EraserIcon className="size-3.5" />
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>정말로 번역을 지울까요?</AlertDialogTitle>
            <AlertDialogDescription>
              이 작업은 되돌릴 수 없어요. 연결된 댓글의 표기도 함께 사라져요.
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
