

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE DOMAIN "public"."seed_float" AS double precision
	CONSTRAINT "seed_float_check" CHECK ((VALUE <= (1)::double precision))
	CONSTRAINT "seed_float_check1" CHECK ((VALUE >= ('-1'::integer)::double precision));


ALTER DOMAIN "public"."seed_float" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."count_search_jargons"("search_query" "text" DEFAULT NULL::"text") RETURNS bigint
    LANGUAGE "plpgsql"
    AS $$
  DECLARE
    total_count bigint;
  BEGIN
    IF search_query IS NULL OR search_query = '' THEN
      -- For browse mode, just count all jargons
      SELECT COUNT(*) INTO total_count FROM jargon;
    ELSE
      -- For search mode, count unique jargons from both searches
      WITH combined AS (
        SELECT DISTINCT j.id
        FROM jargon j
        WHERE j.name ILIKE '%' || search_query || '%'

        UNION

        SELECT DISTINCT j.id
        FROM translation t
        JOIN jargon j ON t.jargon_id = j.id
        WHERE t.name ILIKE '%' || search_query || '%'
      )
      SELECT COUNT(*) INTO total_count FROM combined;
    END IF;

    RETURN total_count;
  END;
  $$;


ALTER FUNCTION "public"."count_search_jargons"("search_query" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_comment"("p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid" DEFAULT NULL::"uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$declare
  v_author_id uuid := auth.uid();
  v_comment_id uuid;
  v_removed boolean;
begin
  -- Auth check
  if v_author_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_jargon_id is null then
    raise exception 'Jargon ID is required' using errcode = '22023';
  end if;

  if p_content is null or trim(p_content) = '' then
    raise exception 'Content is required' using errcode = '22023';
  end if;

  -- Parent comment check
  if p_parent_id is not null then
    select removed
    into v_removed
    from public.comment
    where id = p_parent_id;

    if not found then
      raise exception 'Parent comment not found' using errcode = 'NO_PARENT';
    end if;

    if v_removed then
      raise exception 'Cannot reply to a removed comment'
        using errcode = 'PARENT_REMOVED';
    end if;
  end if;

  -- Insert the comment
  insert into public.comment (
    content,
    author_id,
    jargon_id,
    parent_id
  )
  values (
    trim(p_content),
    v_author_id,
    p_jargon_id,
    p_parent_id
  )
  returning id into v_comment_id;

  return v_comment_id;
end;$$;


ALTER FUNCTION "public"."create_comment"("p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."create_comment_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid" DEFAULT NULL::"uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_comment_id uuid;
begin
  -- Basic validation
  if p_author_id is null then
    raise exception 'Author ID is required' using errcode = '28000';
  end if;

  if p_jargon_id is null then
    raise exception 'Jargon ID is required' using errcode = '22023';
  end if;

  if p_content is null or trim(p_content) = '' then
    raise exception 'Content is required' using errcode = '22023';
  end if;

  -- Insert the comment
  insert into public.comment (
    content,
    author_id,
    jargon_id,
    parent_id
  )
  values (
    trim(p_content),
    p_author_id,
    p_jargon_id,
    p_parent_id
  )
  returning id into v_comment_id;

  -- Update the jargon updated_at timestamp
  update public.jargon
  set updated_at = now()
  where id = p_jargon_id;

  -- Return the new comment ID
  return v_comment_id;
end;
$$;


ALTER FUNCTION "public"."create_comment_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."generate_slug"("input_text" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
  BEGIN
    RETURN lower(
      regexp_replace(
        regexp_replace(
          trim(input_text),
          '[^a-zA-Z0-9\s-]', '', 'g'  -- Remove special characters except spaces and hyphens
        ),
        '\s+', '-', 'g'  -- Replace spaces with hyphens
      )
    );
  END;
  $$;


ALTER FUNCTION "public"."generate_slug"("input_text" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  insert into public.profile (id, display_name, created_at, photo_url)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name',
    now(),
    new.raw_user_meta_data ->> 'avatar_url'
  );
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."jargon" (
    "name" "text" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "slug" "text" NOT NULL,
    CONSTRAINT "jargon_slug_not_empty" CHECK ((("slug" IS NOT NULL) AND ("slug" <> ''::"text")))
);


ALTER TABLE "public"."jargon" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."list_jargon_random"("seed" "public"."seed_float" DEFAULT (0)::"public"."seed_float") RETURNS SETOF "public"."jargon"
    LANGUAGE "sql" STABLE
    AS $$
  SELECT
    SETSEED(seed);

  SELECT
    *
  FROM
    public.jargon
  ORDER BY
    random();

$$;


ALTER FUNCTION "public"."list_jargon_random"("seed" "public"."seed_float") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."remove_comment"("p_comment_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_author_id uuid := auth.uid();
  v_comment_author_id uuid;
begin
  -- Auth check
  if v_author_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_comment_id is null then
    raise exception 'Comment ID is required' using errcode = '22023';
  end if;

  -- Check comment exists and get its author
  select author_id
  into v_comment_author_id
  from public.comment
  where id = p_comment_id;

  if not found then
    raise exception 'Comment not found' using errcode = 'NO_COMMENT';
  end if;

  -- Authorization check (only author can remove)
  if v_comment_author_id <> v_author_id then
    raise exception 'Not authorized to remove this comment'
      using errcode = '42501';
  end if;

  -- Perform the update
  update public.comment
  set removed = true,
      updated_at = now()
  where id = p_comment_id;

  return true;
end;
$$;


ALTER FUNCTION "public"."remove_comment"("p_comment_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."search_jargons"("search_query" "text" DEFAULT NULL::"text", "sort_option" "text" DEFAULT 'recent'::"text", "limit_count" integer DEFAULT 20, "offset_count" integer DEFAULT 0, "category_acronyms" "text"[] DEFAULT NULL::"text"[]) RETURNS TABLE("id" "uuid", "name" "text", "slug" "text", "updated_at" timestamp with time zone, "translations" json, "categories" json, "comments" json)
    LANGUAGE "plpgsql"
    AS $$BEGIN
  RETURN QUERY
  ------------------------------------------------------------------
  -- Precompute allowed jargons by category filter
  ------------------------------------------------------------------
  WITH allowed_jargon AS (
    SELECT j.id
    FROM jargon j
    WHERE CASE
      -- NULL => no filtering
      WHEN category_acronyms IS NULL THEN TRUE

      -- Empty array => only jargons with NO categories
      WHEN COALESCE(array_length(category_acronyms, 1), 0) = 0 THEN NOT EXISTS (
        SELECT 1
        FROM jargon_category jc
        WHERE jc.jargon_id = j.id
      )

      -- Non-empty array => jargons with any of the listed categories
      ELSE EXISTS (
        SELECT 1
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
          AND c.acronym = ANY (category_acronyms)
      )
    END
  ),

  ------------------------------------------------------------------
  -- 1. jargons matched on their own name
  ------------------------------------------------------------------
  jargon_matches AS (
    SELECT
      j.id,
      j.name,
      j.slug,
      j.updated_at,
      (
        SELECT json_agg(json_build_object('name', t.name))
        FROM translation t
        WHERE t.jargon_id = j.id
      ) AS translations,
      (
        SELECT json_agg(json_build_object('acronym', c.acronym))
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
      ) AS categories,
      (
        SELECT json_build_array(json_build_object('count', COUNT(*)))
        FROM comment c
        WHERE c.jargon_id = j.id
      ) AS comments
    FROM jargon j
    JOIN allowed_jargon aj ON aj.id = j.id
    WHERE COALESCE(search_query, '') = ''
       OR j.name ILIKE '%' || search_query || '%'
  ),

  ------------------------------------------------------------------
  -- 2. jargons reached through a translation hit
  ------------------------------------------------------------------
  translation_hits AS (
    SELECT DISTINCT j.id
    FROM translation t
    JOIN jargon j ON j.id = t.jargon_id
    JOIN allowed_jargon aj ON aj.id = j.id
    WHERE COALESCE(search_query, '') <> ''
      AND t.name ILIKE '%' || search_query || '%'
  ),
  translation_matches AS (
    SELECT
      j.id,
      j.name,
      j.slug,
      j.updated_at,
      (
        SELECT json_agg(json_build_object('name', t2.name))
        FROM translation t2
        WHERE t2.jargon_id = j.id
      ) AS translations,
      (
        SELECT json_agg(json_build_object('acronym', c.acronym))
        FROM jargon_category jc
        JOIN category c ON c.id = jc.category_id
        WHERE jc.jargon_id = j.id
      ) AS categories,
      (
        SELECT json_build_array(json_build_object('count', COUNT(*)))
        FROM comment c
        WHERE c.jargon_id = j.id
      ) AS comments
    FROM translation_hits th
    JOIN jargon j ON j.id = th.id
  ),

  ------------------------------------------------------------------
  -- 3. union + final de-duplication
  ------------------------------------------------------------------
  combined AS (
    SELECT * FROM jargon_matches
    UNION ALL
    SELECT * FROM translation_matches
  ),
  final AS (
    SELECT DISTINCT ON (combined.id)
      combined.id,
      combined.name,
      combined.slug,
      combined.updated_at,
      combined.translations,
      combined.categories,
      combined.comments
    FROM combined
    ORDER BY combined.id, combined.updated_at DESC
  )

  ------------------------------------------------------------------
  -- 4. paging with dynamic sorting
  ------------------------------------------------------------------
  SELECT
    f.id,
    f.name,
    f.slug,
    f.updated_at,
    COALESCE(f.translations, '[]'::json)            AS translations,
    COALESCE(f.categories,   '[]'::json)            AS categories,
    COALESCE(f.comments,     '[{"count":0}]'::json) AS comments
  FROM final AS f
  ORDER BY
    CASE WHEN sort_option = 'recent'  THEN f.updated_at END DESC,
    CASE
      WHEN sort_option = 'popular'
      THEN (f.comments->0->>'count')::integer
    END DESC,
    CASE WHEN sort_option = 'abc' THEN f.name END ASC,
    CASE WHEN sort_option = 'zyx' THEN f.name END DESC,
    f.updated_at DESC,
    f.id ASC
  LIMIT  limit_count
  OFFSET offset_count;
END;$$;


ALTER FUNCTION "public"."search_jargons"("search_query" "text", "sort_option" "text", "limit_count" integer, "offset_count" integer, "category_acronyms" "text"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;


ALTER FUNCTION "public"."set_current_timestamp_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_public_comment_jargon_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  -- Update the jargon row's updated_at to now()
  UPDATE public.jargon
  SET updated_at = now()
  WHERE id = NEW.jargon_id;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."set_public_comment_jargon_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_public_translation_jargon_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  -- Update the related jargon row's updated_at to now()
  UPDATE public.jargon
  SET updated_at = now()
  WHERE id = NEW.jargon_id;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."set_public_translation_jargon_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."suggest_jargon"("p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) RETURNS TABLE("jargon_id" "uuid", "jargon_slug" "text", "comment_id" "uuid", "translation_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$declare
  v_author_id       uuid := auth.uid();
  v_name            text := trim(p_name);
  v_translation     text := nullif(trim(p_translation), '');
  v_comment         text := trim(p_comment);

  v_slug            text;
  v_jargon_id       uuid;
  v_comment_id      uuid;
  v_translation_id  uuid;

  v_constraint      text;
begin
  -- Auth and basic validation
  if v_author_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  if v_name is null or v_name = '' then
    raise exception 'Name is required' using errcode = '22023';
  end if;

  if v_comment is null or v_comment = '' then
    raise exception 'Comment is required' using errcode = '22023';
  end if;

  -- Generate slug
  v_slug := public.generate_slug(v_name);
  if v_slug is null or v_slug = '' then
    raise exception 'Invalid slug' using errcode = '22023';
  end if;

  begin
    insert into public.jargon (name, author_id, slug)
    values (v_name, v_author_id, v_slug)
    returning id into v_jargon_id;
  exception
    when unique_violation then
      get stacked diagnostics v_constraint = constraint_name;

      if v_constraint = 'jargon_slug_key' then
        raise exception using
          errcode = '23505',
          message = 'Slug already exists',
          detail  = 'jargon_slug_key';
      elsif v_constraint = 'jargon_name_key' then
        raise exception using
          errcode = '23505',
          message = 'Name already exists',
          detail  = 'jargon_name_key';
      else
        raise;
      end if;
  end;

  -- Initial comment
  insert into public.comment (content, author_id, jargon_id)
  values (v_comment, v_author_id, v_jargon_id)
  returning id into v_comment_id;

  -- Optional translation
  if v_translation is not null then
    insert into public.translation (name, author_id, jargon_id, comment_id)
    values (v_translation, v_author_id, v_jargon_id, v_comment_id)
    returning id into v_translation_id;

    update public.comment
       set translation_id = v_translation_id,
           updated_at     = now()
     where id = v_comment_id;
  end if;

  -- Zero or more categories (dedup; skip nulls)
  if coalesce(array_length(p_category_ids, 1), 0) > 0 then
    insert into public.jargon_category (jargon_id, category_id)
    select v_jargon_id, c
    from (
      select distinct c
      from unnest(p_category_ids) as t(c)
      where c is not null
    ) u;
    -- FK will raise 23503 if any category id is invalid
  end if;

  -- Return created identifiers
  jargon_id := v_jargon_id;
  jargon_slug := v_slug;
  comment_id := v_comment_id;
  translation_id := v_translation_id; -- may be null
  return next;
end;$$;


ALTER FUNCTION "public"."suggest_jargon"("p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."suggest_jargon_as_admin"("p_author_id" "uuid", "p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) RETURNS TABLE("jargon_id" "uuid", "jargon_slug" "text", "comment_id" "uuid", "translation_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_name            text := trim(p_name);
  v_translation     text := nullif(trim(p_translation), '');
  v_comment         text := trim(p_comment);

  v_slug            text;
  v_jargon_id       uuid;
  v_comment_id      uuid;
  v_translation_id  uuid;

  v_constraint      text;
begin
  -- Basic validation
  if p_author_id is null then
    raise exception 'Author ID is required' using errcode = '28000';
  end if;

  if v_name is null or v_name = '' then
    raise exception 'Name is required' using errcode = '22023';
  end if;

  if v_comment is null or v_comment = '' then
    raise exception 'Comment is required' using errcode = '22023';
  end if;

  -- Generate slug
  v_slug := public.generate_slug(v_name);
  if v_slug is null or v_slug = '' then
    raise exception 'Invalid slug' using errcode = '22023';
  end if;

  -- Insert jargon
  begin
    insert into public.jargon (name, author_id, slug)
    values (v_name, p_author_id, v_slug)
    returning id into v_jargon_id;
  exception
    when unique_violation then
      get stacked diagnostics v_constraint = constraint_name;

      if v_constraint = 'jargon_slug_key' then
        raise exception using
          errcode = '23505',
          message = 'Slug already exists',
          detail  = 'jargon_slug_key';
      elsif v_constraint = 'jargon_name_key' then
        raise exception using
          errcode = '23505',
          message = 'Name already exists',
          detail  = 'jargon_name_key';
      else
        raise;
      end if;
  end;

  -- Initial comment
  insert into public.comment (content, author_id, jargon_id)
  values (v_comment, p_author_id, v_jargon_id)
  returning id into v_comment_id;

  -- Optional translation
  if v_translation is not null then
    insert into public.translation (name, author_id, jargon_id, comment_id)
    values (v_translation, p_author_id, v_jargon_id, v_comment_id)
    returning id into v_translation_id;

    update public.comment
       set translation_id = v_translation_id,
           updated_at     = now()
     where id = v_comment_id;
  end if;

  -- Zero or more categories (dedup; skip nulls)
  if coalesce(array_length(p_category_ids, 1), 0) > 0 then
    insert into public.jargon_category (jargon_id, category_id)
    select v_jargon_id, c
    from (
      select distinct c
      from unnest(p_category_ids) as t(c)
      where c is not null
    ) u;
    -- FK will raise 23503 if any category id is invalid
  end if;

  -- Return created identifiers
  jargon_id := v_jargon_id;
  jargon_slug := v_slug;
  comment_id := v_comment_id;
  translation_id := v_translation_id; -- may be null
  return next;
end;
$$;


ALTER FUNCTION "public"."suggest_jargon_as_admin"("p_author_id" "uuid", "p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."suggest_translation"("p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") RETURNS TABLE("translation_id" "uuid", "comment_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$declare
  v_author_id       uuid := auth.uid();
  v_translation     text := trim(p_translation);
  v_comment         text := trim(p_comment);
  v_comment_id      uuid;
  v_translation_id  uuid;
begin
  -- Auth check
  if v_author_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if v_translation is null or v_translation = '' then
    raise exception 'Translation is required' using errcode = '22023';
  end if;
  if v_comment is null or v_comment = '' then
    raise exception 'Comment is required' using errcode = '22023';
  end if;

  -- Ensure target jargon exists
  if not exists (
    select 1 from public.jargon j where j.id = p_jargon_id
  ) then
    raise exception 'Jargon not found' using errcode = '22023';
  end if;

  -- Insert comment
  insert into public.comment (content, author_id, jargon_id)
  values (v_comment, v_author_id, p_jargon_id)
  returning id into v_comment_id;

  -- Insert translation linked to comment
  insert into public.translation (name, author_id, jargon_id, comment_id)
  values (v_translation, v_author_id, p_jargon_id, v_comment_id)
  returning id into v_translation_id;

  -- Back-link comment to translation
  update public.comment
     set translation_id = v_translation_id,
         updated_at = now()
   where id = v_comment_id;

  -- Return only the IDs
  translation_id := v_translation_id;
  comment_id     := v_comment_id;
  return next;
end;$$;


ALTER FUNCTION "public"."suggest_translation"("p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."suggest_translation_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") RETURNS TABLE("translation_id" "uuid", "comment_id" "uuid")
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_translation     text := trim(p_translation);
  v_comment         text := trim(p_comment);
  v_comment_id      uuid;
  v_translation_id  uuid;
begin
  -- Input validation
  if p_author_id is null then
    raise exception 'Author ID is required' using errcode = '28000';
  end if;

  if v_translation is null or v_translation = '' then
    raise exception 'Translation is required' using errcode = '22023';
  end if;

  if v_comment is null or v_comment = '' then
    raise exception 'Comment is required' using errcode = '22023';
  end if;

  -- Ensure target jargon exists
  if not exists (
    select 1 from public.jargon j where j.id = p_jargon_id
  ) then
    raise exception 'Jargon not found' using errcode = '22023';
  end if;

  -- Insert comment
  insert into public.comment (content, author_id, jargon_id)
  values (v_comment, p_author_id, p_jargon_id)
  returning id into v_comment_id;

  -- Insert translation linked to comment
  insert into public.translation (name, author_id, jargon_id, comment_id)
  values (v_translation, p_author_id, p_jargon_id, v_comment_id)
  returning id into v_translation_id;

  -- Back-link comment to translation
  update public.comment
     set translation_id = v_translation_id,
         updated_at = now()
   where id = v_comment_id;

  -- Touch jargon updated_at
  update public.jargon
     set updated_at = now()
   where id = p_jargon_id;

  -- Return only the IDs
  translation_id := v_translation_id;
  comment_id     := v_comment_id;
  return next;
end;
$$;


ALTER FUNCTION "public"."suggest_translation_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."to_lowercase"("jargon" "public"."jargon") RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  SELECT LOWER(jargon.name)
$$;


ALTER FUNCTION "public"."to_lowercase"("jargon" "public"."jargon") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."to_lowercase_no_spaces"("jargon" "public"."jargon") RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  SELECT REGEXP_REPLACE(LOWER(jargon.name), '\s+', '', 'g')
$$;


ALTER FUNCTION "public"."to_lowercase_no_spaces"("jargon" "public"."jargon") OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."translation" (
    "name" "text" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "jargon_id" "uuid" NOT NULL,
    "comment_id" "uuid" NOT NULL
);


ALTER TABLE "public"."translation" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."to_lowercase_no_spaces_translation"("translation" "public"."translation") RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  SELECT REGEXP_REPLACE(LOWER(translation.name), '\s+', '', 'g')
$$;


ALTER FUNCTION "public"."to_lowercase_no_spaces_translation"("translation" "public"."translation") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_comment"("p_comment_id" "uuid", "p_content" "text") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_author_id uuid := auth.uid();
  v_comment_author_id uuid;
  v_removed boolean;
begin
  -- Auth check
  if v_author_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_comment_id is null then
    raise exception 'Comment ID is required' using errcode = '22023';
  end if;

  if p_content is null or trim(p_content) = '' then
    raise exception 'Content is required' using errcode = '22023';
  end if;

  -- Check comment exists, get author and removed status
  select author_id, removed
  into v_comment_author_id, v_removed
  from public.comment
  where id = p_comment_id;

  if not found then
    raise exception 'Comment not found' using errcode = 'NO_COMMENT';
  end if;

  -- Prevent updates to removed comments
  if v_removed then
    raise exception 'Cannot update a removed comment'
      using errcode = 'COMMENT_REMOVED';
  end if;

  -- Authorization check (only author can update)
  if v_comment_author_id <> v_author_id then
    raise exception 'Not authorized to update this comment'
      using errcode = '42501';
  end if;

  -- Perform the update
  update public.comment
  set content = trim(p_content),
      updated_at = now()
  where id = p_comment_id;

  return true;
end;
$$;


ALTER FUNCTION "public"."update_comment"("p_comment_id" "uuid", "p_content" "text") OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."category" (
    "id" integer NOT NULL,
    "name" "text" NOT NULL,
    "acronym" "text" NOT NULL
);


ALTER TABLE "public"."category" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."category_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."category_id_seq" OWNED BY "public"."category"."id";



CREATE TABLE IF NOT EXISTS "public"."comment" (
    "content" "text" NOT NULL,
    "author_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "removed" boolean DEFAULT false NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "jargon_id" "uuid" NOT NULL,
    "translation_id" "uuid",
    "parent_id" "uuid"
);


ALTER TABLE "public"."comment" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."comment_safe" WITH ("security_invoker"='on') AS
 SELECT "id",
    "author_id",
    "created_at",
    "updated_at",
    "jargon_id",
    "translation_id",
    "parent_id",
        CASE
            WHEN (("removed" = false) OR ("auth"."uid"() = "author_id")) THEN "content"
            ELSE NULL::"text"
        END AS "content",
    "removed"
   FROM "public"."comment";


ALTER VIEW "public"."comment_safe" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."html" (
    "id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "data" "text" NOT NULL
);


ALTER TABLE "public"."html" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."html_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."html_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."html_id_seq" OWNED BY "public"."html"."id";



CREATE TABLE IF NOT EXISTS "public"."jargon_category" (
    "jargon_id" "uuid" NOT NULL,
    "category_id" integer NOT NULL
);


ALTER TABLE "public"."jargon_category" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."legacy_fb_user" (
    "id" "text" NOT NULL,
    "display_name" "text" NOT NULL,
    "email" "text" NOT NULL,
    "photo_url" "text",
    "last_seen" timestamp with time zone
);


ALTER TABLE "public"."legacy_fb_user" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profile" (
    "id" "uuid" NOT NULL,
    "display_name" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "photo_url" "text"
);


ALTER TABLE "public"."profile" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."related_jargon" (
    "jargon1" "uuid" NOT NULL,
    "jargon2" "uuid" NOT NULL
);


ALTER TABLE "public"."related_jargon" OWNER TO "postgres";


ALTER TABLE ONLY "public"."category" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."category_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."html" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."html_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_acronym_key" UNIQUE ("acronym");



ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_translation_id_new_key" UNIQUE ("translation_id");



ALTER TABLE ONLY "public"."html"
    ADD CONSTRAINT "html_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."jargon_category"
    ADD CONSTRAINT "jargon_category_pkey" PRIMARY KEY ("jargon_id", "category_id");



ALTER TABLE ONLY "public"."jargon"
    ADD CONSTRAINT "jargon_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."jargon"
    ADD CONSTRAINT "jargon_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."jargon"
    ADD CONSTRAINT "jargon_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."related_jargon"
    ADD CONSTRAINT "related_jargon_pkey" PRIMARY KEY ("jargon1", "jargon2");



ALTER TABLE ONLY "public"."translation"
    ADD CONSTRAINT "translation_comment_id_new_key" UNIQUE ("comment_id");



ALTER TABLE ONLY "public"."translation"
    ADD CONSTRAINT "translation_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."legacy_fb_user"
    ADD CONSTRAINT "user_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."legacy_fb_user"
    ADD CONSTRAINT "user_photo_url_key" UNIQUE ("photo_url");



ALTER TABLE ONLY "public"."legacy_fb_user"
    ADD CONSTRAINT "user_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_comment_author_id" ON "public"."comment" USING "btree" ("author_id");



CREATE INDEX "idx_comment_jargon_id" ON "public"."comment" USING "btree" ("jargon_id");



CREATE INDEX "idx_comment_parent_id" ON "public"."comment" USING "btree" ("parent_id");



CREATE INDEX "idx_jargon_author_id" ON "public"."jargon" USING "btree" ("author_id");



CREATE INDEX "idx_jargon_category_category_id" ON "public"."jargon_category" USING "btree" ("category_id");



CREATE INDEX "idx_jargon_slug" ON "public"."jargon" USING "btree" ("slug");



CREATE INDEX "idx_related_jargon_jargon2" ON "public"."related_jargon" USING "btree" ("jargon2");



CREATE INDEX "idx_translation_author_id" ON "public"."translation" USING "btree" ("author_id");



CREATE INDEX "idx_translation_jargon_id" ON "public"."translation" USING "btree" ("jargon_id");



CREATE OR REPLACE TRIGGER "set_public_comment_jargon_updated_at" AFTER INSERT ON "public"."comment" FOR EACH ROW EXECUTE FUNCTION "public"."set_public_comment_jargon_updated_at"();



CREATE OR REPLACE TRIGGER "set_public_comment_updated_at" BEFORE UPDATE ON "public"."comment" FOR EACH ROW EXECUTE FUNCTION "public"."set_current_timestamp_updated_at"();



COMMENT ON TRIGGER "set_public_comment_updated_at" ON "public"."comment" IS 'trigger to set value of column "updated_at" to current timestamp on row update';



CREATE OR REPLACE TRIGGER "set_public_html_updated_at" BEFORE UPDATE ON "public"."html" FOR EACH ROW EXECUTE FUNCTION "public"."set_current_timestamp_updated_at"();



COMMENT ON TRIGGER "set_public_html_updated_at" ON "public"."html" IS 'trigger to set value of column "updated_at" to current timestamp on row update';



CREATE OR REPLACE TRIGGER "set_public_translation_jargon_updated_at" AFTER INSERT ON "public"."translation" FOR EACH ROW EXECUTE FUNCTION "public"."set_public_translation_jargon_updated_at"();



CREATE OR REPLACE TRIGGER "set_public_translation_updated_at" BEFORE UPDATE ON "public"."translation" FOR EACH ROW EXECUTE FUNCTION "public"."set_current_timestamp_updated_at"();



COMMENT ON TRIGGER "set_public_translation_updated_at" ON "public"."translation" IS 'trigger to set value of column "updated_at" to current timestamp on row update';



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_author_id_profile_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profile"("id") ON UPDATE RESTRICT ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_jargon_id_new_fkey" FOREIGN KEY ("jargon_id") REFERENCES "public"."jargon"("id") ON UPDATE RESTRICT ON DELETE CASCADE;



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_parent_id_new_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."comment"("id") ON UPDATE RESTRICT ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."comment"
    ADD CONSTRAINT "comment_translation_id_new_fkey" FOREIGN KEY ("translation_id") REFERENCES "public"."translation"("id") ON UPDATE RESTRICT ON DELETE SET NULL;



ALTER TABLE ONLY "public"."jargon"
    ADD CONSTRAINT "jargon_author_id_profile_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profile"("id") ON UPDATE RESTRICT ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."jargon_category"
    ADD CONSTRAINT "jargon_category_category_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."jargon_category"
    ADD CONSTRAINT "jargon_category_jargon_fkey" FOREIGN KEY ("jargon_id") REFERENCES "public"."jargon"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profile"
    ADD CONSTRAINT "profile_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON UPDATE RESTRICT ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."related_jargon"
    ADD CONSTRAINT "related_jargon_jargon1_fkey" FOREIGN KEY ("jargon1") REFERENCES "public"."jargon"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."related_jargon"
    ADD CONSTRAINT "related_jargon_jargon2_fkey" FOREIGN KEY ("jargon2") REFERENCES "public"."jargon"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."translation"
    ADD CONSTRAINT "translation_author_id_profile_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."profile"("id") ON UPDATE RESTRICT ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."translation"
    ADD CONSTRAINT "translation_jargon_id_new_fkey" FOREIGN KEY ("jargon_id") REFERENCES "public"."jargon"("id") ON UPDATE RESTRICT ON DELETE CASCADE;



CREATE POLICY "Anyone can view HTML documents" ON "public"."html" FOR SELECT USING (true);



CREATE POLICY "Anyone can view categories" ON "public"."category" FOR SELECT USING (true);



CREATE POLICY "Anyone can view jargon categories" ON "public"."jargon_category" FOR SELECT USING (true);



CREATE POLICY "Anyone can view jargons" ON "public"."jargon" FOR SELECT USING (true);



CREATE POLICY "Anyone can view profiles" ON "public"."profile" FOR SELECT USING (true);



CREATE POLICY "Anyone can view related jargons" ON "public"."related_jargon" FOR SELECT USING (true);



CREATE POLICY "Anyone can view translations" ON "public"."translation" FOR SELECT USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."comment" FOR SELECT USING (true);



ALTER TABLE "public"."category" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."comment" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."html" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."jargon" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."jargon_category" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."legacy_fb_user" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profile" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."related_jargon" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."translation" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."count_search_jargons"("search_query" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."count_search_jargons"("search_query" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."count_search_jargons"("search_query" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_comment"("p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."create_comment"("p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_comment"("p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."create_comment_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."create_comment_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_comment_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_content" "text", "p_parent_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."generate_slug"("input_text" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."generate_slug"("input_text" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."generate_slug"("input_text" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON TABLE "public"."jargon" TO "anon";
GRANT ALL ON TABLE "public"."jargon" TO "authenticated";
GRANT ALL ON TABLE "public"."jargon" TO "service_role";



GRANT ALL ON FUNCTION "public"."list_jargon_random"("seed" "public"."seed_float") TO "anon";
GRANT ALL ON FUNCTION "public"."list_jargon_random"("seed" "public"."seed_float") TO "authenticated";
GRANT ALL ON FUNCTION "public"."list_jargon_random"("seed" "public"."seed_float") TO "service_role";



GRANT ALL ON FUNCTION "public"."remove_comment"("p_comment_id" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."remove_comment"("p_comment_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."remove_comment"("p_comment_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."search_jargons"("search_query" "text", "sort_option" "text", "limit_count" integer, "offset_count" integer, "category_acronyms" "text"[]) TO "anon";
GRANT ALL ON FUNCTION "public"."search_jargons"("search_query" "text", "sort_option" "text", "limit_count" integer, "offset_count" integer, "category_acronyms" "text"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_jargons"("search_query" "text", "sort_option" "text", "limit_count" integer, "offset_count" integer, "category_acronyms" "text"[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."set_current_timestamp_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_current_timestamp_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_current_timestamp_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."set_public_comment_jargon_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_public_comment_jargon_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_public_comment_jargon_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."set_public_translation_jargon_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_public_translation_jargon_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_public_translation_jargon_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."suggest_jargon"("p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."suggest_jargon"("p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."suggest_jargon"("p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."suggest_jargon_as_admin"("p_author_id" "uuid", "p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."suggest_jargon_as_admin"("p_author_id" "uuid", "p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."suggest_jargon_as_admin"("p_author_id" "uuid", "p_name" "text", "p_translation" "text", "p_comment" "text", "p_category_ids" integer[]) TO "service_role";



GRANT ALL ON FUNCTION "public"."suggest_translation"("p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."suggest_translation"("p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."suggest_translation"("p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."suggest_translation_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."suggest_translation_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."suggest_translation_as_admin"("p_author_id" "uuid", "p_jargon_id" "uuid", "p_translation" "text", "p_comment" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."to_lowercase"("jargon" "public"."jargon") TO "anon";
GRANT ALL ON FUNCTION "public"."to_lowercase"("jargon" "public"."jargon") TO "authenticated";
GRANT ALL ON FUNCTION "public"."to_lowercase"("jargon" "public"."jargon") TO "service_role";



GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces"("jargon" "public"."jargon") TO "anon";
GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces"("jargon" "public"."jargon") TO "authenticated";
GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces"("jargon" "public"."jargon") TO "service_role";



GRANT ALL ON TABLE "public"."translation" TO "anon";
GRANT ALL ON TABLE "public"."translation" TO "authenticated";
GRANT ALL ON TABLE "public"."translation" TO "service_role";



GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces_translation"("translation" "public"."translation") TO "anon";
GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces_translation"("translation" "public"."translation") TO "authenticated";
GRANT ALL ON FUNCTION "public"."to_lowercase_no_spaces_translation"("translation" "public"."translation") TO "service_role";



GRANT ALL ON FUNCTION "public"."update_comment"("p_comment_id" "uuid", "p_content" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."update_comment"("p_comment_id" "uuid", "p_content" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_comment"("p_comment_id" "uuid", "p_content" "text") TO "service_role";


















GRANT ALL ON TABLE "public"."category" TO "anon";
GRANT ALL ON TABLE "public"."category" TO "authenticated";
GRANT ALL ON TABLE "public"."category" TO "service_role";



GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."comment" TO "anon";
GRANT ALL ON TABLE "public"."comment" TO "authenticated";
GRANT ALL ON TABLE "public"."comment" TO "service_role";



GRANT ALL ON TABLE "public"."comment_safe" TO "anon";
GRANT ALL ON TABLE "public"."comment_safe" TO "authenticated";
GRANT ALL ON TABLE "public"."comment_safe" TO "service_role";



GRANT ALL ON TABLE "public"."html" TO "anon";
GRANT ALL ON TABLE "public"."html" TO "authenticated";
GRANT ALL ON TABLE "public"."html" TO "service_role";



GRANT ALL ON SEQUENCE "public"."html_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."html_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."html_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."jargon_category" TO "anon";
GRANT ALL ON TABLE "public"."jargon_category" TO "authenticated";
GRANT ALL ON TABLE "public"."jargon_category" TO "service_role";



GRANT ALL ON TABLE "public"."legacy_fb_user" TO "anon";
GRANT ALL ON TABLE "public"."legacy_fb_user" TO "authenticated";
GRANT ALL ON TABLE "public"."legacy_fb_user" TO "service_role";



GRANT ALL ON TABLE "public"."profile" TO "anon";
GRANT ALL ON TABLE "public"."profile" TO "authenticated";
GRANT ALL ON TABLE "public"."profile" TO "service_role";



GRANT ALL ON TABLE "public"."related_jargon" TO "anon";
GRANT ALL ON TABLE "public"."related_jargon" TO "authenticated";
GRANT ALL ON TABLE "public"."related_jargon" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






























RESET ALL;
