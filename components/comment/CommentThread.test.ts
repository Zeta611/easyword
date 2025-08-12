import { describe, it, expect } from "vitest";
import type { Comment, CommentTree } from "@/types/comment";

// Copied from component for unit-level validation of the algorithm
function buildCommentTree(comments: Comment[]): CommentTree[] {
  const commentMap = new Map<string, CommentTree>();
  const roots: CommentTree[] = [];

  comments.forEach((comment) => {
    commentMap.set(comment.id, {
      ...comment,
      replies: [],
    } as CommentTree);
  });

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

  const sortComments = (comments: CommentTree[], isRoot = false): CommentTree[] => {
    return comments
      .sort((a, b) => {
        const dateA = new Date(a.created_at).getTime();
        const dateB = new Date(b.created_at).getTime();
        return isRoot ? dateB - dateA : dateA - dateB;
      })
      .map((comment) => ({
        ...comment,
        replies: sortComments(comment.replies, false),
      }));
  };

  return sortComments(roots, true);
}

describe("buildCommentTree", () => {
  const base = (id: string, parent: string | null, created: string): Comment => ({
    id,
    parent_id: parent,
    created_at: created,
    content: "",
    author_id: "u",
    jargon_id: "j",
    profile: { display_name: "n", photo_url: null },
    translation: null,
    updated_at: created,
  } as any);

  it("groups replies under parents and sorts correctly", () => {
    const input: Comment[] = [
      base("1", null, "2024-01-02T00:00:00Z"),
      base("2", null, "2024-01-03T00:00:00Z"),
      base("3", "2", "2024-01-04T00:00:00Z"),
      base("4", "2", "2024-01-05T00:00:00Z"),
      base("5", "1", "2024-01-01T00:00:00Z"),
    ];

    const tree = buildCommentTree(input);

    // Roots sorted newest first: id 2 (Jan 3) then id 1 (Jan 2)
    expect(tree.map((n) => n.id)).toEqual(["2", "1"]);

    // Replies sorted oldest first
    expect(tree[0].replies.map((n) => n.id)).toEqual(["3", "4"]);
    expect(tree[1].replies.map((n) => n.id)).toEqual(["5"]);
  });
});