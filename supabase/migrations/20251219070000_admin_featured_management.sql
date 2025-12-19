-- RPC for admin to update featured order
CREATE OR REPLACE FUNCTION public.admin_update_featured_order(
  p_translation_id uuid,
  p_featured_rank integer
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER
SET search_path TO 'public'
AS $$
DECLARE
  v_is_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
BEGIN
  -- Auth check
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'Not authenticated' USING errcode = '28000';
  END IF;

  -- Admin check
  IF NOT v_is_admin THEN
    RAISE EXCEPTION 'Not authorized' USING errcode = '42501';
  END IF;

  -- Update featured rank
  UPDATE public.translation
  SET featured = p_featured_rank
  WHERE id = p_translation_id;

  RETURN true;
END;
$$;

-- RPC for admin to remove featured status
CREATE OR REPLACE FUNCTION public.admin_remove_featured(
  p_translation_id uuid
) RETURNS boolean
LANGUAGE plpgsql SECURITY DEFINER
SET search_path TO 'public'
AS $$
DECLARE
  v_is_admin boolean := coalesce(get_my_claim('userrole')::text, '') = '"admin"';
BEGIN
  -- Auth check
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'Not authenticated' USING errcode = '28000';
  END IF;

  -- Admin check
  IF NOT v_is_admin THEN
    RAISE EXCEPTION 'Not authorized' USING errcode = '42501';
  END IF;

  -- Remove featured status
  UPDATE public.translation
  SET featured = NULL
  WHERE id = p_translation_id;

  RETURN true;
END;
$$;

GRANT EXECUTE ON FUNCTION public.admin_update_featured_order(uuid, integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.admin_remove_featured(uuid) TO authenticated;

NOTIFY pgrst, 'reload schema';
