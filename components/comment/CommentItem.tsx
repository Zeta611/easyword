"use client";

import { useState } from "react";
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

dayjs.extend(relativeTime);
dayjs.locale("ko");

interface CommentItemProps {
  comment: Comment;
  depth?: number;
}

export default function CommentItem({ comment, depth = 0 }: CommentItemProps) {
  const { data: user } = useUserQuery();
  const { openLogin } = useLoginDialog();

  const [showReplyForm, setShowReplyForm] = useState(false);
  const [showReplies, setShowReplies] = useState(true);
  const initials = (comment.profile.display_name || "")
    .split(" ")
    .map((w) => w[0])
    .join("")
    .toUpperCase();

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
        <div className="mb-2 text-sm whitespace-pre-wrap">
          {comment.content}
        </div>

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
