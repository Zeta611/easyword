CREATE OR REPLACE FUNCTION public.update_jargon_categories(
  p_jargon_id uuid,
  p_category_ids int[]
) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
AS $$
declare
  v_actor_id uuid := auth.uid();
  v_exists boolean;
begin
  -- Auth check (any authenticated user can update)
  if v_actor_id is null then
    raise exception 'Not authenticated' using errcode = '28000';
  end if;

  -- Input validation
  if p_jargon_id is null then
    raise exception 'Jargon ID is required' using errcode = '22023';
  end if;

  -- Ensure jargon exists for clearer error reporting
  select true into v_exists from public.jargon where id = p_jargon_id;
  if not found then
    raise exception 'Jargon not found' using errcode = 'NO_JARGON';
  end if;

  -- Replace category mappings
  delete from public.jargon_category where jargon_id = p_jargon_id;

  if p_category_ids is not null and array_length(p_category_ids, 1) > 0 then
    insert into public.jargon_category (jargon_id, category_id)
    select p_jargon_id, unnest(p_category_ids);
  end if;

  return true;
exception
  when foreign_key_violation then
    -- invalid category id
    raise exception using errcode = '23503', message = 'Invalid category id';
end;
$$;

GRANT ALL ON FUNCTION public.update_jargon_categories(p_jargon_id uuid, p_category_ids int[]) TO anon;
GRANT ALL ON FUNCTION public.update_jargon_categories(p_jargon_id uuid, p_category_ids int[]) TO authenticated;
GRANT ALL ON FUNCTION public.update_jargon_categories(p_jargon_id uuid, p_category_ids int[]) TO service_role;

NOTIFY pgrst, 'reload schema';
