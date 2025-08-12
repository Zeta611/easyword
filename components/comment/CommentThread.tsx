"use client";

import { useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { getClient } from "@/lib/supabase/client";
import { QUERIES } from "@/lib/supabase/repository";
import { Comment, CommentTree } from "@/types/comment";
import CommentItem from "@/components/comment/CommentItem";
import CommentForm from "@/components/comment/CommentForm";
import { useUserQuery } from "@/hooks/useUserQuery";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { useLoginDialog } from "@/components/auth/LoginDialogProvider";

function buildCommentTree(comments: Omit<Comment, "replies">[]): CommentTree[] {
  const commentMap = new Map<string, CommentTree>();
  const roots: CommentTree[] = [];

  // First pass: create all comment nodes
  comments.forEach((comment) => {
    commentMap.set(comment.id, {
      ...comment,
      replies: [],
    });
  });

  // Second pass: build tree structure
  comments.forEach((comment) => {
    const commentNode = commentMap.get(comment.id)!;

    if (comment.parent_id) {
      const parent = commentMap.get(comment.parent_id);
      if (parent) {
        parent.replies.push(commentNode);
      }
    } else {
      roots.push(commentNode);
    }
  });

  // Sort comments by creation date (newest first for roots, oldest first for replies)
  const sortComments = (
    comments: CommentTree[],
    isRoot = false,
  ): CommentTree[] => {
    return comments
      .sort((a, b) => {
        const dateA = new Date(a.created_at).getTime();
        const dateB = new Date(b.created_at).getTime();
        return isRoot ? dateB - dateA : dateA - dateB; // newest first for roots, oldest first for replies
      })
      .map((comment) => ({
        ...comment,
        replies: sortComments(comment.replies, false),
      }));
  };

  return sortComments(roots, true);
}

export default function CommentThread({
  jargonId,
  initialComments = [],
}: {
  jargonId: string;
  initialComments?: Omit<Comment, "replies">[];
}) {
  const { data: user, isLoading: isUserLoading } = useUserQuery();
  const { openLogin } = useLoginDialog();
  const supabase = getClient();

  const { data: comments, isLoading } = useQuery({
    queryKey: ["comments", jargonId],
    queryFn: async () => {
      const { data, error } = await QUERIES.listComments(supabase, jargonId);
      if (error) throw error;
      return data;
    },
    initialData: initialComments,
  });

  const commentTree = useMemo(() => buildCommentTree(comments), [comments]);

  return (
    <div className="flex flex-col gap-1">
      {/* New comment form */}
      <div className="flex flex-col gap-2">
        <span className="text-base font-semibold">
          댓글 {comments.length}개
        </span>
        {isUserLoading ? (
          <Skeleton className="my-2 h-10 w-full" />
        ) : user ? (
          <CommentForm jargonId={jargonId} />
        ) : (
          <Button
            variant="outline"
            onClick={() => openLogin()}
            className="my-2 text-xs"
          >
            로그인 후 댓글 달기
          </Button>
        )}
      </div>

      {/* Comment list */}
      {isLoading ? (
        <Skeleton className="my-2 h-30 w-full" />
      ) : commentTree.length > 0 ? (
        <div className="-ml-2 flex flex-col gap-2">
          {commentTree.map((comment) => (
            <CommentItem key={comment.id} comment={comment} />
          ))}
        </div>
      ) : (
        <div className="text-muted-foreground py-4 text-center">
          첫 댓글을 작성해보세요
        </div>
      )}
    </div>
  );
}
