CREATE OR REPLACE FUNCTION public.remove_comment(p_comment_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_author_id uuid := auth.uid();
  v_comment_author_id uuid;
  v_is_userrole_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
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

  -- Authorization: author or userrole "admin" may remove
  if v_comment_author_id <> v_author_id and not v_is_userrole_admin then
    raise exception 'Not authorized to remove this comment' using errcode = '42501';
  end if;

  -- Perform the update
  update public.comment
  set removed = true,
      updated_at = now()
  where id = p_comment_id;

  return true;
end;
$$;

NOTIFY pgrst, 'reload schema';
