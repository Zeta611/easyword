"use client";

import {
  useActionState,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import { useQuery } from "@tanstack/react-query";
import Form from "next/form";
import { useFormStatus } from "react-dom";
import { Pencil } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { MultiSelect } from "@/components/ui/multi-select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { getClient } from "@/lib/supabase/client";
import { useLoginDialog } from "@/components/auth/login-dialog-provider";
import { QUERIES } from "@/lib/supabase/repository";
import {
  updateJargonCategories,
  type UpdateJargonCategoriesState,
} from "@/app/actions/update-jargon-categories";

function Submit({ label }: { label: string }) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" disabled={pending}>
      {pending ? "저장 중..." : label}
    </Button>
  );
}

export default function UpdateJargonCategoriesDialog({
  jargonId,
  initialCategoryIds,
}: {
  jargonId: string;
  initialCategoryIds: number[];
}) {
  const supabase = getClient();
  const { openLogin } = useLoginDialog();

  const [open, setOpen] = useState(false);
  const formRef = useRef<HTMLFormElement>(null);
  const [selected, setSelected] = useState<string[]>(
    initialCategoryIds.map((id) => String(id)),
  );

  const { data: categories, isLoading } = useQuery({
    queryKey: ["categories"],
    enabled: open,
    queryFn: async ({ signal }) => {
      const { data, error } = await QUERIES.listCategories(supabase, {
        signal,
      });
      if (error) throw error;
      return data;
    },
  });

  const options = useMemo(
    () =>
      (categories ?? []).map((c) => ({
        value: String(c.id),
        label: `${c.acronym} (${c.name})`,
        shortLabel: c.acronym,
      })),
    [categories],
  );

  const resetForm = useCallback(() => {
    formRef.current?.reset();
  }, []);

  const [state, action] = useActionState(
    updateJargonCategories.bind(null, jargonId),
    {
      ok: false,
      error: "",
    } as UpdateJargonCategoriesState,
  );

  const handleOpenChange = useCallback(
    async (nextOpen: boolean) => {
      if (nextOpen) {
        const {
          data: { user },
        } = await supabase.auth.getUser();
        if (!user) {
          openLogin();
          return;
        }
        // Ensure defaults reflect current props each time dialog opens
        setSelected(initialCategoryIds.map((id) => String(id)));
      }
      setOpen(nextOpen);
    },
    [openLogin, supabase, initialCategoryIds],
  );

  useEffect(() => {
    if (state && state.ok) {
      resetForm();
      // Refresh the page to reflect updated categories on SSR
      window.location.reload();
    }
  }, [state, resetForm]);

  return (
    <Dialog open={open} onOpenChange={handleOpenChange}>
      <DialogTrigger asChild>
        <button className="bg-background text-foreground border-accent flex rounded-full border px-1.5 py-1.5 font-mono text-sm hover:cursor-pointer">
          <Pencil className="size-3" />
        </button>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[520px]">
        <DialogHeader>
          <DialogTitle>분야 고치기</DialogTitle>
          <DialogDescription>
            이 용어에 해당하는 분야를 선택해 주세요
          </DialogDescription>
        </DialogHeader>
        <Form ref={formRef} action={action} className="flex flex-col gap-3">
          <div className="flex flex-col gap-1">
            <Label className="text-sm font-medium">분야</Label>
            <MultiSelect
              variant="outline"
              options={options}
              defaultValue={selected}
              onValueChange={setSelected}
              closeOnSelect={true}
              hideSelectAll={true}
              placeholder={isLoading ? "불러오는 중..." : "분야 선택"}
              disabled={isLoading}
              popoverClassName="w-full"
            />
            {selected.map((cid) => (
              <input key={cid} type="hidden" name="categoryIds" value={cid} />
            ))}
          </div>

          {state && !state.ok ? (
            <p className="text-sm text-red-600">{state.error}</p>
          ) : null}

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => {
                setOpen(false);
                resetForm();
              }}
            >
              닫기
            </Button>
            <Submit label="저장" />
          </DialogFooter>
        </Form>
      </DialogContent>
    </Dialog>
  );
}
