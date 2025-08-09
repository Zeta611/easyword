"use client";

import { useState, useEffect, useCallback } from "react";
import { createClient } from "@/lib/supabase/client";
import { Comment, CommentTree } from "@/types/comment";
import CommentItem from "@/components/CommentItem";
import CommentForm from "@/components/CommentForm";

interface CommentThreadProps {
  jargonId: string;
  initialComments?: Comment[];
}

// Helper function to build comment tree structure
function buildCommentTree(comments: Comment[]): CommentTree[] {
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
}: CommentThreadProps) {
  const [comments, setComments] = useState<Comment[]>(initialComments);
  const [commentTree, setCommentTree] = useState<CommentTree[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const supabase = createClient();

  // Build comment tree whenever comments change
  useEffect(() => {
    setCommentTree(buildCommentTree(comments));
  }, [comments]);

  // Fetch comments
  const fetchComments = useCallback(async () => {
    setIsLoading(true);
    try {
      const { data, error } = await supabase
        .from("comments_with_authors")
        .select("*, translation(name)")
        .eq("jargon_id", jargonId)
        .order("created_at", { ascending: true });

      if (error) throw error;
      setComments(data as Comment[]);
    } catch (err) {
      console.error("Error fetching comments:", err);
    } finally {
      setIsLoading(false);
    }
  }, [jargonId, supabase]);

  // Fetch comments on mount if no initial data
  useEffect(() => {
    console.debug("Fetching comments in useEffect");
    if (initialComments.length === 0) {
      fetchComments();
    }
  }, [jargonId, initialComments, fetchComments]);

  const handleCommentSuccess = () => {
    // Refetch comments when a new comment is added
    fetchComments();
  };

  return (
    <div className="flex flex-col gap-1">
      {/* New comment form */}
      <div className="flex flex-col gap-2">
        <span className="text-base font-semibold">
          댓글 {comments.length}개
        </span>
        <CommentForm jargonId={jargonId} onSuccess={handleCommentSuccess} />
      </div>

      {/* Comment list */}
      {isLoading ? (
        <div className="py-4 text-center text-gray-500">
          댓글 불러오는 중...
        </div>
      ) : commentTree.length > 0 ? (
        <div className="-ml-2 flex flex-col gap-2">
          {commentTree.map((comment) => (
            <CommentItem
              key={comment.id}
              comment={comment}
              onReplySuccess={handleCommentSuccess}
            />
          ))}
        </div>
      ) : (
        <div className="py-4 text-center text-gray-500">
          첫 댓글을 작성해보세요
        </div>
      )}
    </div>
  );
}
