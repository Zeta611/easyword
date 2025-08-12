export interface Comment {
  id: string;
  content: string;
  author_id: string;
  created_at: string;
  updated_at: string;
  removed: boolean;
  jargon_id: string;
  translation_id: string | null;
  translation?: {
    name: string;
  } | null;
  parent_id: string | null;
  profile: {
    display_name: string | null;
    photo_url: string | null;
  };
  replies: Comment[];
}

export interface CommentTree extends Comment {
  replies: CommentTree[];
}
