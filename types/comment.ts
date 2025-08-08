export interface Comment {
  id: string;
  content: string;
  author_id: string;
  created_at: string;
  updated_at: string;
  removed: boolean;
  jargon_id: string;
  translation_id?: string;
  translation?: {
    name: string;
  };
  parent_id?: string;
  // Joined data from view
  full_name?: string;
  photo_url?: string;
  // For nested structure
  replies?: Comment[];
  depth?: number;
}

export interface CommentTree extends Comment {
  replies: CommentTree[];
}
