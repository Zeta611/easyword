CREATE OR REPLACE FUNCTION public.update_jargon(
  p_jargon_id uuid,
  p_name text
) RETURNS TABLE(
  jargon_id uuid,
  jargon_slug text
)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_actor_id uuid := auth.uid();
  v_author_id uuid;
  v_is_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
  v_slug text;
  v_constraint text;
begin
  -- Auth check
  if v_actor_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_jargon_id is null then
    raise exception 'Jargon ID is required' using errcode = '22023';
  end if;

  if p_name is null or trim(p_name) = '' then
    raise exception 'Name is required' using errcode = '22023';
  end if;

  -- Load author
  select author_id into v_author_id from public.jargon where id = p_jargon_id;
  if not found then
    raise exception 'Jargon not found' using errcode = 'NO_JARGON';
  end if;

  -- Authorization: author or admin
  if v_actor_id <> v_author_id and not v_is_admin then
    raise exception 'Not authorized to update this jargon' using errcode = '42501';
  end if;

  v_slug := public.generate_slug(trim(p_name));
  if v_slug is null or v_slug = '' then
    raise exception 'Invalid slug' using errcode = '22023';
  end if;

  begin
    update public.jargon
       set name = trim(p_name),
           slug = v_slug,
           updated_at = now()
     where id = p_jargon_id;
  exception
    when unique_violation then
      get stacked diagnostics v_constraint = constraint_name;
      if v_constraint = 'jargon_slug_key' then
        raise exception using errcode = '23505', message = 'Slug already exists', detail = 'jargon_slug_key';
      elsif v_constraint = 'jargon_name_key' then
        raise exception using errcode = '23505', message = 'Name already exists', detail = 'jargon_name_key';
      else
        raise;
      end if;
  end;

  jargon_id := p_jargon_id;
  jargon_slug := v_slug;
  return next;
end;
$$;

CREATE OR REPLACE FUNCTION public.remove_jargon(p_jargon_id uuid) RETURNS boolean
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
  if p_jargon_id is null then
    raise exception 'Jargon ID is required' using errcode = '22023';
  end if;

  -- Load author
  select author_id into v_author_id from public.jargon where id = p_jargon_id;
  if not found then
    raise exception 'Jargon not found' using errcode = 'NO_JARGON';
  end if;

  -- Authorization: author or admin
  if v_actor_id <> v_author_id and not v_is_admin then
    raise exception 'Not authorized to remove this jargon' using errcode = '42501';
  end if;

  delete from public.jargon where id = p_jargon_id;

  return true;
end;
$$;

GRANT ALL ON FUNCTION public.update_jargon(p_jargon_id uuid, p_name text) TO anon;
GRANT ALL ON FUNCTION public.update_jargon(p_jargon_id uuid, p_name text) TO authenticated;
GRANT ALL ON FUNCTION public.update_jargon(p_jargon_id uuid, p_name text) TO service_role;

GRANT ALL ON FUNCTION public.remove_jargon(p_jargon_id uuid) TO anon;
GRANT ALL ON FUNCTION public.remove_jargon(p_jargon_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.remove_jargon(p_jargon_id uuid) TO service_role;

NOTIFY pgrst, 'reload schema';
