"use client";

import { useState, useEffect } from "react";
import dayjs from "dayjs";
import relativeTime from "dayjs/plugin/relativeTime";
import "dayjs/locale/ko";
import { MessageCircle, Minus, Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Comment } from "@/types/comment";
import CommentForm from "@/components/comment/CommentForm";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { useUserQuery } from "@/hooks/useUserQuery";
import { useLoginDialog } from "@/components/auth/LoginDialogProvider";
import { Textarea } from "@/components/ui/textarea";
import { useActionState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import {
  updateComment,
  UpdateCommentAction,
} from "@/app/actions/updateComment";
import {
  removeComment,
  RemoveCommentAction,
} from "@/app/actions/removeComment";

dayjs.extend(relativeTime);
dayjs.locale("ko");

export default function CommentItem({
  comment,
  depth = 0,
}: {
  comment: Comment;
  depth?: number;
}) {
  const { data: user } = useUserQuery();
  const { openLogin } = useLoginDialog();

  const [showReplyForm, setShowReplyForm] = useState(false);
  const [showReplies, setShowReplies] = useState(true);
  const [isEditing, setIsEditing] = useState(false);
  const [editContent, setEditContent] = useState(comment.content);
  const queryClient = useQueryClient();

  const initials = (comment.profile.display_name || "")
    .split(" ")
    .map((w) => w[0])
    .join("")
    .toUpperCase();

  const [updateState, updateAction] = useActionState(
    updateComment.bind(null, comment.id) as UpdateCommentAction,
    { ok: false, error: "" },
  );

  const [removeState, removeAction] = useActionState(
    removeComment.bind(null, comment.id) as RemoveCommentAction,
    { ok: false, error: "" },
  );

  useEffect(() => {
    if (updateState?.ok) {
      setIsEditing(false);
      queryClient.invalidateQueries({ queryKey: ["comments", comment.jargon_id] });
    }
  }, [updateState?.ok, queryClient, comment.jargon_id]);

  useEffect(() => {
    if (removeState?.ok) {
      queryClient.invalidateQueries({ queryKey: ["comments", comment.jargon_id] });
    }
  }, [removeState?.ok, queryClient, comment.jargon_id]);

  if (comment.removed) {
    return (
      <div className="border-accent relative ml-3 rounded-b-md border-l-2 transition-colors before:absolute before:inset-y-0 before:left-0 before:w-3 before:cursor-pointer before:bg-transparent before:content-[''] hover:border-orange-200">
        <button
          onClick={() => setShowReplies((b) => !b)}
          aria-label="Close replies"
          className="absolute inset-y-0 left-0 w-3 cursor-pointer bg-transparent"
        />
        <div className="text-muted-foreground py-2 pl-3 italic">
          삭제된 댓글이에요
        </div>
      </div>
    );
  }

  return (
    <div className="border-accent relative ml-3 rounded-b-md border-l-2 transition-colors hover:border-orange-200">
      <button
        onClick={() => setShowReplies((b) => !b)}
        aria-label="Close replies"
        className="absolute inset-y-0 left-0 w-1 cursor-pointer"
      />
      {/* Comment content */}
      <div className="pt-1 pb-2 pl-2.5">
        {/* Comment header */}
        <div className="mb-1 flex items-center gap-2">
          <Avatar className="size-5.5">
            {comment.profile.photo_url ? (
              <AvatarImage
                src={comment.profile.photo_url}
                alt={comment.profile.display_name || ""}
              />
            ) : null}
            <AvatarFallback className="text-[10px]">{initials}</AvatarFallback>
          </Avatar>
          <div className="flex items-center gap-1 text-sm text-black">
            <span className="line-clamp-1 font-medium">
              {comment.profile.display_name || ""}
            </span>
            {comment.translation?.name ? (
              <>
                <span className="text-muted-foreground">·</span>
                <span className="shrink-0 font-medium text-orange-800">
                  {comment.translation.name}
                </span>
              </>
            ) : null}
            ·
            <span className="text-muted-foreground shrink-0">
              {dayjs(comment.created_at).fromNow()}
            </span>
          </div>
        </div>

        {/* Comment content */}
        {isEditing ? (
          <form action={updateAction} className="mb-2 flex flex-col gap-1.5">
            <Textarea
              name="content"
              value={editContent}
              onChange={(e) => setEditContent(e.target.value)}
              rows={4}
            />
            {updateState?.error && (
              <p className="mt-1 text-sm text-red-600">{updateState.error}</p>
            )}
            <div className="flex justify-end gap-1.5">
              <Button
                type="button"
                variant="outline"
                size="sm"
                onClick={() => {
                  setIsEditing(false);
                  setEditContent(comment.content);
                }}
              >
                취소
              </Button>
              <Button type="submit" size="sm">
                저장
              </Button>
            </div>
          </form>
        ) : (
          <div className="mb-2 text-sm whitespace-pre-wrap">{comment.content}</div>
        )}

        {/* Comment actions */}
        <div className="text-muted-foreground flex items-center gap-3 text-xs">
          {comment.replies && comment.replies.length > 0 && (
            <button
              onClick={() => setShowReplies(!showReplies)}
              className="text-muted-foreground -ml-5.5 flex size-5 items-center justify-center rounded-full border-2 border-orange-200 bg-white transition-colors hover:cursor-pointer"
            >
              {showReplies ? (
                <Minus className="size-2.5" />
              ) : (
                <Plus className="size-2.5" />
              )}
            </button>
          )}
          <Button
            variant="ghost"
            onClick={() => {
              if (!user) {
                openLogin();
              } else {
                setShowReplyForm(!showReplyForm);
              }
            }}
            className="flex h-6 w-15 items-center gap-1 text-xs"
          >
            <MessageCircle className="size-3" />
            답글
          </Button>
          {user?.id === comment.author_id && !isEditing && (
            <>
              <Button
                variant="ghost"
                className="h-6 px-2"
                onClick={() => setIsEditing(true)}
              >
                수정
              </Button>
              <form action={removeAction}>
                {removeState?.error && (
                  <span className="text-xs text-red-600">{removeState.error}</span>
                )}
                <Button
                  type="submit"
                  variant="ghost"
                  className="h-6 px-2 text-red-600 hover:text-red-700"
                >
                  삭제
                </Button>
              </form>
            </>
          )}
        </div>

        {/* Reply form */}
        {showReplyForm && (
          <div className="mt-1.5 ml-0.5">
            <CommentForm
              jargonId={comment.jargon_id}
              parentId={comment.id}
              close={() => setShowReplyForm(false)}
              placeholder="여러분의 생각은 어떤가요?"
              submitLabel="답글 달기"
            />
          </div>
        )}
      </div>

      {/* Nested replies */}
      {showReplies && comment.replies && comment.replies.length > 0 && (
        <div>
          {comment.replies.map((reply) => (
            <CommentItem key={reply.id} comment={reply} depth={depth + 1} />
          ))}
        </div>
      )}
    </div>
  );
}
