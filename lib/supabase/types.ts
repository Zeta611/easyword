export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instanciate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "12.2.12 (cd3cf9e)"
  }
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      category: {
        Row: {
          acronym: string
          id: number
          name: string
        }
        Insert: {
          acronym: string
          id?: number
          name: string
        }
        Update: {
          acronym?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      comment: {
        Row: {
          author_id: string
          content: string
          created_at: string
          id: string
          jargon_id: string
          parent_id: string | null
          removed: boolean
          translation_id: string | null
          updated_at: string
        }
        Insert: {
          author_id: string
          content: string
          created_at?: string
          id?: string
          jargon_id: string
          parent_id?: string | null
          removed?: boolean
          translation_id?: string | null
          updated_at?: string
        }
        Update: {
          author_id?: string
          content?: string
          created_at?: string
          id?: string
          jargon_id?: string
          parent_id?: string | null
          removed?: boolean
          translation_id?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "comment_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "user"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "comment_jargon_id_new_fkey"
            columns: ["jargon_id"]
            isOneToOne: false
            referencedRelation: "jargon"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "comment_parent_id_new_fkey"
            columns: ["parent_id"]
            isOneToOne: false
            referencedRelation: "comment"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "comment_translation_id_new_fkey"
            columns: ["translation_id"]
            isOneToOne: true
            referencedRelation: "translation"
            referencedColumns: ["id"]
          },
        ]
      }
      html: {
        Row: {
          created_at: string
          data: string
          id: number
          updated_at: string
        }
        Insert: {
          created_at?: string
          data: string
          id?: number
          updated_at?: string
        }
        Update: {
          created_at?: string
          data?: string
          id?: number
          updated_at?: string
        }
        Relationships: []
      }
      jargon: {
        Row: {
          author_id: string
          created_at: string
          id: string
          name: string
          updated_at: string
        }
        Insert: {
          author_id: string
          created_at?: string
          id?: string
          name: string
          updated_at?: string
        }
        Update: {
          author_id?: string
          created_at?: string
          id?: string
          name?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "jargon_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "user"
            referencedColumns: ["id"]
          },
        ]
      }
      jargon_category: {
        Row: {
          category_id: number
          jargon_id: string
        }
        Insert: {
          category_id: number
          jargon_id: string
        }
        Update: {
          category_id?: number
          jargon_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "jargon_category_category_fkey"
            columns: ["category_id"]
            isOneToOne: false
            referencedRelation: "category"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "jargon_category_jargon_fkey"
            columns: ["jargon_id"]
            isOneToOne: false
            referencedRelation: "jargon"
            referencedColumns: ["id"]
          },
        ]
      }
      related_jargon: {
        Row: {
          jargon1: string
          jargon2: string
        }
        Insert: {
          jargon1: string
          jargon2: string
        }
        Update: {
          jargon1?: string
          jargon2?: string
        }
        Relationships: [
          {
            foreignKeyName: "related_jargon_jargon1_fkey"
            columns: ["jargon1"]
            isOneToOne: false
            referencedRelation: "jargon"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "related_jargon_jargon2_fkey"
            columns: ["jargon2"]
            isOneToOne: false
            referencedRelation: "jargon"
            referencedColumns: ["id"]
          },
        ]
      }
      translation: {
        Row: {
          author_id: string
          comment_id: string
          created_at: string
          id: string
          jargon_id: string
          name: string
          updated_at: string
        }
        Insert: {
          author_id: string
          comment_id: string
          created_at?: string
          id?: string
          jargon_id: string
          name: string
          updated_at?: string
        }
        Update: {
          author_id?: string
          comment_id?: string
          created_at?: string
          id?: string
          jargon_id?: string
          name?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "translation_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "user"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "translation_jargon_id_new_fkey"
            columns: ["jargon_id"]
            isOneToOne: false
            referencedRelation: "jargon"
            referencedColumns: ["id"]
          },
        ]
      }
      user: {
        Row: {
          display_name: string
          email: string
          id: string
          last_seen: string | null
          photo_url: string | null
        }
        Insert: {
          display_name: string
          email: string
          id: string
          last_seen?: string | null
          photo_url?: string | null
        }
        Update: {
          display_name?: string
          email?: string
          id?: string
          last_seen?: string | null
          photo_url?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      armor: {
        Args: { "": string }
        Returns: string
      }
      dearmor: {
        Args: { "": string }
        Returns: string
      }
      gen_random_bytes: {
        Args: { "": number }
        Returns: string
      }
      gen_random_uuid: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
      gen_salt: {
        Args: { "": string }
        Returns: string
      }
      list_jargon_random: {
        Args: { seed?: unknown }
        Returns: {
          author_id: string
          created_at: string
          id: string
          name: string
          updated_at: string
        }[]
      }
      pgp_armor_headers: {
        Args: { "": string }
        Returns: Record<string, unknown>[]
      }
      pgp_key_id: {
        Args: { "": string }
        Returns: string
      }
      to_lowercase: {
        Args: { jargon: Database["public"]["Tables"]["jargon"]["Row"] }
        Returns: string
      }
      to_lowercase_no_spaces: {
        Args: { jargon: Database["public"]["Tables"]["jargon"]["Row"] }
        Returns: string
      }
      to_lowercase_no_spaces_translation: {
        Args: {
          translation: Database["public"]["Tables"]["translation"]["Row"]
        }
        Returns: string
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {},
  },
} as const
