import { SupabaseClient } from "@supabase/supabase-js";
import { Database } from "@/lib/supabase/types";

export const DB = {
  searchJargons: function (
    supabase: SupabaseClient<Database>,
    searchQuery: string,
    limitCount: number,
    offsetCount: number,
    sortOption: string,
    categoryAcronyms: string[] | null,
  ) {
    return supabase.rpc("search_jargons", {
      search_query: searchQuery,
      limit_count: limitCount,
      offset_count: offsetCount,
      sort_option: sortOption,
      category_acronyms: categoryAcronyms ?? undefined,
    });
  },

  countSearchJargons: function (
    supabase: SupabaseClient<Database>,
    searchQuery: string,
  ) {
    return supabase.rpc("count_search_jargons", {
      search_query: searchQuery,
    });
  },

  suggestJargon: function (
    supabase: SupabaseClient<Database>,
    jargon: string,
    noTranslation: boolean,
    translation: string,
    comment: string,
    categoryIds: number[],
  ) {
    return supabase
      .rpc("suggest_jargon", {
        p_name: jargon,
        p_translation: noTranslation ? "" : translation,
        p_comment: comment,
        p_category_ids: categoryIds,
      })
      .single();
  },

  suggestTranslation: function (
    supabase: SupabaseClient<Database>,
    jargonId: string,
    translation: string,
    comment: string,
  ) {
    return supabase
      .rpc("suggest_translation", {
        p_jargon_id: jargonId,
        p_translation: translation,
        p_comment: comment,
      })
      .single();
  },

  createComment: function (
    supabase: SupabaseClient<Database>,
    jargonId: string,
    parentId: string | null,
    content: string,
  ) {
    return supabase.rpc("create_comment", {
      p_jargon_id: jargonId,
      p_parent_id: parentId ?? undefined,
      p_content: content,
    });
  },
};
