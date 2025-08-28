CREATE OR REPLACE FUNCTION public.update_comment(p_comment_id uuid, p_content text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_author_id uuid := auth.uid();
  v_comment_author_id uuid;
  v_removed boolean;
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
    raise exception 'Cannot update a removed comment' using errcode = 'COMMENT_REMOVED';
  end if;

  -- Authorization check (author or admin can update)
  if v_comment_author_id <> v_author_id and not v_is_userrole_admin then
    raise exception 'Not authorized to update this comment' using errcode = '42501';
  end if;

  -- Perform the update
  update public.comment
  set content = trim(p_content),
      updated_at = now()
  where id = p_comment_id;

  return true;
end;
$$;

NOTIFY pgrst, 'reload schema';
