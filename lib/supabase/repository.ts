import { SupabaseClient } from "@supabase/supabase-js";
import { Database } from "@/lib/supabase/types";

export const QUERIES = {
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

  countJargons: function (
    supabase: SupabaseClient<Database>,
    searchQuery: string,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase.rpc("count_search_jargons", {
      search_query: searchQuery,
    });
    if (options?.signal) query = query.abortSignal(options.signal);
    return query;
  },

  getJargonBySlug: function (supabase: SupabaseClient<Database>, slug: string) {
    return supabase
      .from("jargon")
      .select(
        "id, name, slug, created_at, translations:translation(name), categories:jargon_category(category:category(acronym))",
      )
      .eq("slug", slug)
      .limit(1)
      .single();
  },

  listComments: function (
    supabase: SupabaseClient<Database>,
    jargonId: string,
  ) {
    return supabase
      .from("comment")
      .select(
        `
          *,
          profile:author_id(display_name, photo_url),
          translation(name)
        `,
      )
      .eq("jargon_id", jargonId)
      .order("created_at", { ascending: true });
  },

  listCategories: function (
    supabase: SupabaseClient<Database>,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase
      .from("category")
      .select("id, name, acronym")
      .order("acronym", { ascending: true });
    if (options?.signal) query = query.abortSignal(options.signal);
    return query;
  },

  searchJargonNames: function (
    supabase: SupabaseClient<Database>,
    searchQuery: string,
    limitCount: number,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase
      .from("jargon")
      .select("id, name, slug")
      .ilike("name", `%${searchQuery}%`)
      .limit(limitCount);
    if (options?.signal) query = query.abortSignal(options.signal);
    return query;
  },

  searchTranslationsByName: function (
    supabase: SupabaseClient<Database>,
    searchQuery: string,
    limitCount: number,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase
      .from("translation")
      .select(
        `
          id,
          name,
          jargon_id,
          jargon:jargon_id(id, name, slug)
        `,
      )
      .ilike("name", `%${searchQuery}%`)
      .limit(limitCount);
    if (options?.signal) query = query.abortSignal(options.signal);
    return query;
  },

  getNameAndPhoto: function (
    supabase: SupabaseClient<Database>,
    userId: string,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase
      .from("profile")
      .select("display_name, photo_url, created_at")
      .eq("id", userId);
    if (options?.signal) query = query.abortSignal(options.signal);
    return query.maybeSingle();
  },

  getName: function (
    supabase: SupabaseClient<Database>,
    userId: string,
    options?: { signal?: AbortSignal },
  ) {
    let query = supabase
      .from("profile")
      .select("display_name")
      .eq("id", userId);
    if (options?.signal) query = query.abortSignal(options.signal);
    return query.maybeSingle();
  },
};

export const MUTATIONS = {
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

  updateComment: function (
    supabase: SupabaseClient<Database>,
    commentId: string,
    content: string,
  ) {
    return supabase
      .from("comment")
      .update({ content, updated_at: new Date().toISOString() })
      .eq("id", commentId);
  },

  removeComment: function (
    supabase: SupabaseClient<Database>,
    commentId: string,
  ) {
    return supabase
      .from("comment")
      .update({ removed: true, updated_at: new Date().toISOString() })
      .eq("id", commentId);
  },
};
