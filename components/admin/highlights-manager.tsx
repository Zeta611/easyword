"use client";

import { useState, useTransition, useSyncExternalStore } from "react";
import Link from "next/link";
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  type DragEndEvent,
} from "@dnd-kit/core";
import {
  arrayMove,
  SortableContext,
  sortableKeyboardCoordinates,
  useSortable,
  verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { GripVertical, Trash2, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
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
import { updateFeaturedOrder } from "@/app/actions/update-featured-order";
import { removeFeatured } from "@/app/actions/remove-featured";

// Hook to detect if we're on the client (prevents hydration mismatch from dnd-kit)
const emptySubscribe = () => () => {};
function useIsClient() {
  return useSyncExternalStore(
    emptySubscribe,
    () => true,
    () => false,
  );
}

export type FeaturedTranslation = {
  id: string;
  name: string;
  featured: number;
  jargonName: string;
  jargonSlug: string;
};

function SortableItem({
  item,
  onRemove,
  isRemoving,
}: {
  item: FeaturedTranslation;
  onRemove: (id: string) => void;
  isRemoving: boolean;
}) {
  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: item.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  return (
    <Card
      ref={setNodeRef}
      style={style}
      className={`flex flex-row items-center gap-3 p-4 ${isDragging ? "opacity-50 shadow-lg" : ""}`}
    >
      <button
        className="text-muted-foreground hover:text-foreground cursor-grab touch-none active:cursor-grabbing"
        {...attributes}
        {...listeners}
      >
        <GripVertical className="size-5" />
      </button>
      <span className="bg-muted text-muted-foreground shrink-0 rounded px-2 py-0.5 text-xs font-medium">
        #{item.featured}
      </span>
      <div className="flex min-w-0 flex-1 items-center gap-2">
        <span className="truncate font-medium">{item.name}</span>
        <span className="text-muted-foreground">—</span>
        <Link
          href={`/jargon/${item.jargonSlug}`}
          className="text-muted-foreground hover:text-foreground flex shrink-0 items-center gap-1 text-sm"
        >
          {item.jargonName}
          <ExternalLink className="size-3" />
        </Link>
      </div>
      <AlertDialog>
        <AlertDialogTrigger asChild>
          <Button
            variant="ghost"
            size="icon"
            className="text-muted-foreground hover:text-destructive shrink-0"
            disabled={isRemoving}
          >
            <Trash2 className="size-4" />
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>하이라이트 삭제</AlertDialogTitle>
            <AlertDialogDescription>
              &quot;{item.name}&quot;을(를) 하이라이트에서 삭제하시겠어요?
              번역어 자체는 삭제되지 않습니다.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>취소</AlertDialogCancel>
            <AlertDialogAction
              onClick={() => onRemove(item.id)}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              삭제
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </Card>
  );
}

export default function HighlightsManager({
  initialData,
}: {
  initialData: FeaturedTranslation[];
}) {
  const [items, setItems] = useState(initialData);
  const [isPending, startTransition] = useTransition();
  const isClient = useIsClient();

  const sensors = useSensors(
    useSensor(PointerSensor),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    }),
  );

  function handleDragEnd(event: DragEndEvent) {
    const { active, over } = event;

    if (over && active.id !== over.id) {
      const oldIndex = items.findIndex((item) => item.id === active.id);
      const newIndex = items.findIndex((item) => item.id === over.id);
      const newItems = arrayMove(items, oldIndex, newIndex);

      // Update featured ranks
      const updatedItems = newItems.map((item, index) => ({
        ...item,
        featured: index + 1,
      }));

      // Optimistic update
      setItems(updatedItems);

      // Persist to server
      startTransition(async () => {
        const result = await updateFeaturedOrder(
          updatedItems.map((item) => item.id),
        );
        if (!result.ok) {
          // Revert on error
          setItems(items);
        }
      });
    }
  }

  function handleRemove(id: string) {
    startTransition(async () => {
      const result = await removeFeatured(id);
      if (result.ok) {
        setItems((prev) => {
          const filtered = prev.filter((item) => item.id !== id);
          // Re-number the remaining items
          return filtered.map((item, index) => ({
            ...item,
            featured: index + 1,
          }));
        });
        // Update the server with new order
        const remaining = items
          .filter((item) => item.id !== id)
          .map((item) => item.id);
        if (remaining.length > 0) {
          await updateFeaturedOrder(remaining);
        }
      }
    });
  }

  if (items.length === 0) {
    return (
      <div className="text-muted-foreground rounded-lg border border-dashed p-8 text-center">
        하이라이트로 지정된 번역어가 없습니다.
      </div>
    );
  }

  // Render static list on server, interactive list on client
  if (!isClient) {
    return (
      <div className="flex flex-col gap-2">
        {items.map((item) => (
          <Card key={item.id} className="flex flex-row items-center gap-3 p-4">
            <GripVertical className="text-muted-foreground size-5" />
            <span className="bg-muted text-muted-foreground shrink-0 rounded px-2 py-0.5 text-xs font-medium">
              #{item.featured}
            </span>
            <div className="flex min-w-0 flex-1 items-center gap-2">
              <span className="truncate font-medium">{item.name}</span>
              <span className="text-muted-foreground">—</span>
              <span className="text-muted-foreground text-sm">
                {item.jargonName}
              </span>
            </div>
          </Card>
        ))}
      </div>
    );
  }

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragEnd={handleDragEnd}
    >
      <SortableContext items={items} strategy={verticalListSortingStrategy}>
        <div className="flex flex-col gap-2">
          {items.map((item) => (
            <SortableItem
              key={item.id}
              item={item}
              onRemove={handleRemove}
              isRemoving={isPending}
            />
          ))}
        </div>
      </SortableContext>
      {isPending && (
        <div className="text-muted-foreground mt-4 text-center text-sm">
          저장 중...
        </div>
      )}
    </DndContext>
  );
}
