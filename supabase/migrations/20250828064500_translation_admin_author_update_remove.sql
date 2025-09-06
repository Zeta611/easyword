CREATE OR REPLACE FUNCTION public.update_translation(
  p_translation_id uuid,
  p_name text
) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_actor_id uuid := auth.uid();
  v_author_id uuid;
  v_is_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
begin
  -- Auth check
  if v_actor_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_translation_id is null then
    raise exception 'Translation ID is required' using errcode = '22023';
  end if;

  if p_name is null or trim(p_name) = '' then
    raise exception 'Name is required' using errcode = '22023';
  end if;

  -- Load author
  select author_id into v_author_id from public.translation where id = p_translation_id;
  if not found then
    raise exception 'Translation not found' using errcode = 'NO_TRANSLATION';
  end if;

  -- Authorization: author or admin
  if v_actor_id <> v_author_id and not v_is_admin then
    raise exception 'Not authorized to update this translation' using errcode = '42501';
  end if;

  begin
    update public.translation
       set name = trim(p_name),
           updated_at = now()
     where id = p_translation_id;
  exception
    when unique_violation then
      -- Surface a consistent error code for duplicates
      raise exception using errcode = '23505', message = 'Translation already exists';
  end;

  return true;
end;
$$;

CREATE OR REPLACE FUNCTION public.remove_translation(p_translation_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_actor_id uuid := auth.uid();
  v_author_id uuid;
  v_is_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
begin
  -- Auth check
  if v_actor_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_translation_id is null then
    raise exception 'Translation ID is required' using errcode = '22023';
  end if;

  -- Load author
  select author_id into v_author_id from public.translation where id = p_translation_id;
  if not found then
    raise exception 'Translation not found' using errcode = 'NO_TRANSLATION';
  end if;

  -- Authorization: author or admin
  if v_actor_id <> v_author_id and not v_is_admin then
    raise exception 'Not authorized to remove this translation' using errcode = '42501';
  end if;

  delete from public.translation where id = p_translation_id;

  return true;
end;
$$;

GRANT ALL ON FUNCTION public.update_translation(p_translation_id uuid, p_name text) TO anon;
GRANT ALL ON FUNCTION public.update_translation(p_translation_id uuid, p_name text) TO authenticated;
GRANT ALL ON FUNCTION public.update_translation(p_translation_id uuid, p_name text) TO service_role;

GRANT ALL ON FUNCTION public.remove_translation(p_translation_id uuid) TO anon;
GRANT ALL ON FUNCTION public.remove_translation(p_translation_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.remove_translation(p_translation_id uuid) TO service_role;

NOTIFY pgrst, 'reload schema';
