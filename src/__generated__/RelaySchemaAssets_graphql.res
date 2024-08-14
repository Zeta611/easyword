/* @generated */
@@warning("-30")

@live @unboxed
type enum_category_constraint = 
  | @as("category_acronym_key") Category_acronym_key
  | @as("category_name_key") Category_name_key
  | @as("category_pkey") Category_pkey
  | FutureAddedValue(string)


@live @unboxed
type enum_category_constraint_input = 
  | @as("category_acronym_key") Category_acronym_key
  | @as("category_name_key") Category_name_key
  | @as("category_pkey") Category_pkey


@live @unboxed
type enum_category_select_column = 
  | @as("acronym") Acronym
  | @as("id") Id
  | @as("name") Name
  | FutureAddedValue(string)


@live @unboxed
type enum_category_select_column_input = 
  | @as("acronym") Acronym
  | @as("id") Id
  | @as("name") Name


@live @unboxed
type enum_category_update_column = 
  | @as("acronym") Acronym
  | @as("id") Id
  | @as("name") Name
  | FutureAddedValue(string)


@live @unboxed
type enum_category_update_column_input = 
  | @as("acronym") Acronym
  | @as("id") Id
  | @as("name") Name


@live @unboxed
type enum_comment_constraint = 
  | @as("comment_id_key") Comment_id_key
  | @as("comment_pkey") Comment_pkey
  | @as("comment_translation_id_new_key") Comment_translation_id_new_key
  | FutureAddedValue(string)


@live @unboxed
type enum_comment_constraint_input = 
  | @as("comment_id_key") Comment_id_key
  | @as("comment_pkey") Comment_pkey
  | @as("comment_translation_id_new_key") Comment_translation_id_new_key


@live @unboxed
type enum_comment_select_column = 
  | @as("author_id") Author_id
  | @as("content") Content
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("parent_id") Parent_id
  | @as("removed") Removed
  | @as("translation_id") Translation_id
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_comment_select_column_input = 
  | @as("author_id") Author_id
  | @as("content") Content
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("parent_id") Parent_id
  | @as("removed") Removed
  | @as("translation_id") Translation_id
  | @as("updated_at") Updated_at


@live @unboxed
type enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns = 
  | @as("removed") Removed
  | FutureAddedValue(string)


@live
type enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input = 
  | @as("removed") Removed


@live @unboxed
type enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns = 
  | @as("removed") Removed
  | FutureAddedValue(string)


@live
type enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input = 
  | @as("removed") Removed


@live @unboxed
type enum_comment_update_column = 
  | @as("author_id") Author_id
  | @as("content") Content
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("parent_id") Parent_id
  | @as("removed") Removed
  | @as("translation_id") Translation_id
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_comment_update_column_input = 
  | @as("author_id") Author_id
  | @as("content") Content
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("parent_id") Parent_id
  | @as("removed") Removed
  | @as("translation_id") Translation_id
  | @as("updated_at") Updated_at


@live @unboxed
type enum_html_constraint = 
  | @as("html_pkey") Html_pkey
  | FutureAddedValue(string)


@live
type enum_html_constraint_input = 
  | @as("html_pkey") Html_pkey


@live @unboxed
type enum_html_select_column = 
  | @as("created_at") Created_at
  | @as("data") Data
  | @as("id") Id
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_html_select_column_input = 
  | @as("created_at") Created_at
  | @as("data") Data
  | @as("id") Id
  | @as("updated_at") Updated_at


@live @unboxed
type enum_html_update_column = 
  | @as("created_at") Created_at
  | @as("data") Data
  | @as("id") Id
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_html_update_column_input = 
  | @as("created_at") Created_at
  | @as("data") Data
  | @as("id") Id
  | @as("updated_at") Updated_at


@live @unboxed
type enum_jargon_category_constraint = 
  | @as("jargon_category_pkey") Jargon_category_pkey
  | FutureAddedValue(string)


@live
type enum_jargon_category_constraint_input = 
  | @as("jargon_category_pkey") Jargon_category_pkey


@live @unboxed
type enum_jargon_category_select_column = 
  | @as("category_id") Category_id
  | @as("jargon_id") Jargon_id
  | FutureAddedValue(string)


@live @unboxed
type enum_jargon_category_select_column_input = 
  | @as("category_id") Category_id
  | @as("jargon_id") Jargon_id


@live @unboxed
type enum_jargon_category_update_column = 
  | @as("category_id") Category_id
  | @as("jargon_id") Jargon_id
  | FutureAddedValue(string)


@live @unboxed
type enum_jargon_category_update_column_input = 
  | @as("category_id") Category_id
  | @as("jargon_id") Jargon_id


@live @unboxed
type enum_jargon_constraint = 
  | @as("jargon_id_key") Jargon_id_key
  | @as("jargon_name_key") Jargon_name_key
  | @as("jargon_pkey") Jargon_pkey
  | FutureAddedValue(string)


@live @unboxed
type enum_jargon_constraint_input = 
  | @as("jargon_id_key") Jargon_id_key
  | @as("jargon_name_key") Jargon_name_key
  | @as("jargon_pkey") Jargon_pkey


@live @unboxed
type enum_jargon_select_column = 
  | @as("author_id") Author_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("name") Name
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_jargon_select_column_input = 
  | @as("author_id") Author_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("name") Name
  | @as("updated_at") Updated_at


@live @unboxed
type enum_jargon_update_column = 
  | @as("author_id") Author_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("name") Name
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_jargon_update_column_input = 
  | @as("author_id") Author_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("name") Name
  | @as("updated_at") Updated_at


@live @unboxed
type enum_order_by = 
  | @as("asc") Asc
  | @as("asc_nulls_first") Asc_nulls_first
  | @as("asc_nulls_last") Asc_nulls_last
  | @as("desc") Desc
  | @as("desc_nulls_first") Desc_nulls_first
  | @as("desc_nulls_last") Desc_nulls_last
  | FutureAddedValue(string)


@live @unboxed
type enum_order_by_input = 
  | @as("asc") Asc
  | @as("asc_nulls_first") Asc_nulls_first
  | @as("asc_nulls_last") Asc_nulls_last
  | @as("desc") Desc
  | @as("desc_nulls_first") Desc_nulls_first
  | @as("desc_nulls_last") Desc_nulls_last


@live @unboxed
type enum_translation_constraint = 
  | @as("translation_comment_id_new_key") Translation_comment_id_new_key
  | @as("translation_id_key") Translation_id_key
  | @as("translation_pkey") Translation_pkey
  | FutureAddedValue(string)


@live @unboxed
type enum_translation_constraint_input = 
  | @as("translation_comment_id_new_key") Translation_comment_id_new_key
  | @as("translation_id_key") Translation_id_key
  | @as("translation_pkey") Translation_pkey


@live @unboxed
type enum_translation_select_column = 
  | @as("author_id") Author_id
  | @as("comment_id") Comment_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("name") Name
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_translation_select_column_input = 
  | @as("author_id") Author_id
  | @as("comment_id") Comment_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("name") Name
  | @as("updated_at") Updated_at


@live @unboxed
type enum_translation_update_column = 
  | @as("author_id") Author_id
  | @as("comment_id") Comment_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("name") Name
  | @as("updated_at") Updated_at
  | FutureAddedValue(string)


@live @unboxed
type enum_translation_update_column_input = 
  | @as("author_id") Author_id
  | @as("comment_id") Comment_id
  | @as("created_at") Created_at
  | @as("id") Id
  | @as("jargon_id") Jargon_id
  | @as("name") Name
  | @as("updated_at") Updated_at


@live @unboxed
type enum_user_constraint = 
  | @as("user_email_key") User_email_key
  | @as("user_photo_url_key") User_photo_url_key
  | @as("user_pkey") User_pkey
  | FutureAddedValue(string)


@live @unboxed
type enum_user_constraint_input = 
  | @as("user_email_key") User_email_key
  | @as("user_photo_url_key") User_photo_url_key
  | @as("user_pkey") User_pkey


@live @unboxed
type enum_user_select_column = 
  | @as("display_name") Display_name
  | @as("email") Email
  | @as("id") Id
  | @as("last_seen") Last_seen
  | @as("photo_url") Photo_url
  | FutureAddedValue(string)


@live @unboxed
type enum_user_select_column_input = 
  | @as("display_name") Display_name
  | @as("email") Email
  | @as("id") Id
  | @as("last_seen") Last_seen
  | @as("photo_url") Photo_url


@live @unboxed
type enum_user_update_column = 
  | @as("display_name") Display_name
  | @as("email") Email
  | @as("id") Id
  | @as("last_seen") Last_seen
  | @as("photo_url") Photo_url
  | FutureAddedValue(string)


@live @unboxed
type enum_user_update_column_input = 
  | @as("display_name") Display_name
  | @as("email") Email
  | @as("id") Id
  | @as("last_seen") Last_seen
  | @as("photo_url") Photo_url


@live @unboxed
type enum_RequiredFieldAction = 
  | NONE
  | LOG
  | THROW
  | FutureAddedValue(string)


@live @unboxed
type enum_RequiredFieldAction_input = 
  | NONE
  | LOG
  | THROW


@live @unboxed
type enum_CatchFieldTo = 
  | NULL
  | RESULT
  | FutureAddedValue(string)


@live @unboxed
type enum_CatchFieldTo_input = 
  | NULL
  | RESULT


@live
type rec input_Boolean_comparison_exp = {
  _eq?: bool,
  _gt?: bool,
  _gte?: bool,
  _in?: array<bool>,
  _is_null?: bool,
  _lt?: bool,
  _lte?: bool,
  _neq?: bool,
  _nin?: array<bool>,
}

@live
and input_Boolean_comparison_exp_nullable = {
  _eq?: Js.Null.t<bool>,
  _gt?: Js.Null.t<bool>,
  _gte?: Js.Null.t<bool>,
  _in?: Js.Null.t<array<bool>>,
  _is_null?: Js.Null.t<bool>,
  _lt?: Js.Null.t<bool>,
  _lte?: Js.Null.t<bool>,
  _neq?: Js.Null.t<bool>,
  _nin?: Js.Null.t<array<bool>>,
}

@live
and input_Int_comparison_exp = {
  _eq?: int,
  _gt?: int,
  _gte?: int,
  _in?: array<int>,
  _is_null?: bool,
  _lt?: int,
  _lte?: int,
  _neq?: int,
  _nin?: array<int>,
}

@live
and input_Int_comparison_exp_nullable = {
  _eq?: Js.Null.t<int>,
  _gt?: Js.Null.t<int>,
  _gte?: Js.Null.t<int>,
  _in?: Js.Null.t<array<int>>,
  _is_null?: Js.Null.t<bool>,
  _lt?: Js.Null.t<int>,
  _lte?: Js.Null.t<int>,
  _neq?: Js.Null.t<int>,
  _nin?: Js.Null.t<array<int>>,
}

@live
and input_String_comparison_exp = {
  _eq?: string,
  _gt?: string,
  _gte?: string,
  _ilike?: string,
  _in?: array<string>,
  _iregex?: string,
  _is_null?: bool,
  _like?: string,
  _lt?: string,
  _lte?: string,
  _neq?: string,
  _nilike?: string,
  _nin?: array<string>,
  _niregex?: string,
  _nlike?: string,
  _nregex?: string,
  _nsimilar?: string,
  _regex?: string,
  _similar?: string,
}

@live
and input_String_comparison_exp_nullable = {
  _eq?: Js.Null.t<string>,
  _gt?: Js.Null.t<string>,
  _gte?: Js.Null.t<string>,
  _ilike?: Js.Null.t<string>,
  _in?: Js.Null.t<array<string>>,
  _iregex?: Js.Null.t<string>,
  _is_null?: Js.Null.t<bool>,
  _like?: Js.Null.t<string>,
  _lt?: Js.Null.t<string>,
  _lte?: Js.Null.t<string>,
  _neq?: Js.Null.t<string>,
  _nilike?: Js.Null.t<string>,
  _nin?: Js.Null.t<array<string>>,
  _niregex?: Js.Null.t<string>,
  _nlike?: Js.Null.t<string>,
  _nregex?: Js.Null.t<string>,
  _nsimilar?: Js.Null.t<string>,
  _regex?: Js.Null.t<string>,
  _similar?: Js.Null.t<string>,
}

@live
and input_category_bool_exp = {
  _and?: array<input_category_bool_exp>,
  _not?: input_category_bool_exp,
  _or?: array<input_category_bool_exp>,
  acronym?: input_String_comparison_exp,
  id?: input_Int_comparison_exp,
  jargon_categories?: input_jargon_category_bool_exp,
  jargon_categories_aggregate?: input_jargon_category_aggregate_bool_exp,
  name?: input_String_comparison_exp,
}

@live
and input_category_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_category_bool_exp_nullable>>,
  _not?: Js.Null.t<input_category_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_category_bool_exp_nullable>>,
  acronym?: Js.Null.t<input_String_comparison_exp_nullable>,
  id?: Js.Null.t<input_Int_comparison_exp_nullable>,
  jargon_categories?: Js.Null.t<input_jargon_category_bool_exp_nullable>,
  jargon_categories_aggregate?: Js.Null.t<input_jargon_category_aggregate_bool_exp_nullable>,
  name?: Js.Null.t<input_String_comparison_exp_nullable>,
}

@live
and input_category_inc_input = {
  id?: int,
}

@live
and input_category_inc_input_nullable = {
  id?: Js.Null.t<int>,
}

@live
and input_category_insert_input = {
  acronym?: string,
  id?: int,
  jargon_categories?: input_jargon_category_arr_rel_insert_input,
  name?: string,
}

@live
and input_category_insert_input_nullable = {
  acronym?: Js.Null.t<string>,
  id?: Js.Null.t<int>,
  jargon_categories?: Js.Null.t<input_jargon_category_arr_rel_insert_input_nullable>,
  name?: Js.Null.t<string>,
}

@live
and input_category_obj_rel_insert_input = {
  data: input_category_insert_input,
  on_conflict?: input_category_on_conflict,
}

@live
and input_category_obj_rel_insert_input_nullable = {
  data: input_category_insert_input_nullable,
  on_conflict?: Js.Null.t<input_category_on_conflict_nullable>,
}

@live
and input_category_on_conflict = {
  @as("constraint") constraint_: enum_category_constraint_input,
  update_columns: array<enum_category_update_column_input>,
  where?: input_category_bool_exp,
}

@live
and input_category_on_conflict_nullable = {
  @as("constraint") constraint_: enum_category_constraint_input,
  update_columns: array<enum_category_update_column_input>,
  where?: Js.Null.t<input_category_bool_exp_nullable>,
}

@live
and input_category_order_by = {
  acronym?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_categories_aggregate?: input_jargon_category_aggregate_order_by,
  name?: enum_order_by_input,
}

@live
and input_category_order_by_nullable = {
  acronym?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_categories_aggregate?: Js.Null.t<input_jargon_category_aggregate_order_by_nullable>,
  name?: Js.Null.t<enum_order_by_input>,
}

@live
and input_category_pk_columns_input = {
  id: int,
}

@live
and input_category_pk_columns_input_nullable = {
  id: int,
}

@live
and input_category_set_input = {
  acronym?: string,
  id?: int,
  name?: string,
}

@live
and input_category_set_input_nullable = {
  acronym?: Js.Null.t<string>,
  id?: Js.Null.t<int>,
  name?: Js.Null.t<string>,
}

@live
and input_category_updates = {
  _inc?: input_category_inc_input,
  _set?: input_category_set_input,
  where: input_category_bool_exp,
}

@live
and input_category_updates_nullable = {
  _inc?: Js.Null.t<input_category_inc_input_nullable>,
  _set?: Js.Null.t<input_category_set_input_nullable>,
  where: input_category_bool_exp_nullable,
}

@live
and input_comment_aggregate_bool_exp = {
  bool_and?: input_comment_aggregate_bool_exp_bool_and,
  bool_or?: input_comment_aggregate_bool_exp_bool_or,
  count?: input_comment_aggregate_bool_exp_count,
}

@live
and input_comment_aggregate_bool_exp_nullable = {
  bool_and?: Js.Null.t<input_comment_aggregate_bool_exp_bool_and_nullable>,
  bool_or?: Js.Null.t<input_comment_aggregate_bool_exp_bool_or_nullable>,
  count?: Js.Null.t<input_comment_aggregate_bool_exp_count_nullable>,
}

@live
and input_comment_aggregate_bool_exp_bool_and = {
  arguments: enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input,
  distinct?: bool,
  filter?: input_comment_bool_exp,
  predicate: input_Boolean_comparison_exp,
}

@live
and input_comment_aggregate_bool_exp_bool_and_nullable = {
  arguments: enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_comment_bool_exp_nullable>,
  predicate: input_Boolean_comparison_exp_nullable,
}

@live
and input_comment_aggregate_bool_exp_bool_or = {
  arguments: enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input,
  distinct?: bool,
  filter?: input_comment_bool_exp,
  predicate: input_Boolean_comparison_exp,
}

@live
and input_comment_aggregate_bool_exp_bool_or_nullable = {
  arguments: enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_comment_bool_exp_nullable>,
  predicate: input_Boolean_comparison_exp_nullable,
}

@live
and input_comment_aggregate_bool_exp_count = {
  arguments?: array<enum_comment_select_column_input>,
  distinct?: bool,
  filter?: input_comment_bool_exp,
  predicate: input_Int_comparison_exp,
}

@live
and input_comment_aggregate_bool_exp_count_nullable = {
  arguments?: Js.Null.t<array<enum_comment_select_column_input>>,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_comment_bool_exp_nullable>,
  predicate: input_Int_comparison_exp_nullable,
}

@live
and input_comment_aggregate_order_by = {
  count?: enum_order_by_input,
  max?: input_comment_max_order_by,
  min?: input_comment_min_order_by,
}

@live
and input_comment_aggregate_order_by_nullable = {
  count?: Js.Null.t<enum_order_by_input>,
  max?: Js.Null.t<input_comment_max_order_by_nullable>,
  min?: Js.Null.t<input_comment_min_order_by_nullable>,
}

@live
and input_comment_arr_rel_insert_input = {
  data: array<input_comment_insert_input>,
  on_conflict?: input_comment_on_conflict,
}

@live
and input_comment_arr_rel_insert_input_nullable = {
  data: array<input_comment_insert_input_nullable>,
  on_conflict?: Js.Null.t<input_comment_on_conflict_nullable>,
}

@live
and input_comment_bool_exp = {
  _and?: array<input_comment_bool_exp>,
  _not?: input_comment_bool_exp,
  _or?: array<input_comment_bool_exp>,
  author?: input_user_bool_exp,
  author_id?: input_String_comparison_exp,
  children?: input_comment_bool_exp,
  children_aggregate?: input_comment_aggregate_bool_exp,
  content?: input_String_comparison_exp,
  created_at?: input_timestamptz_comparison_exp,
  id?: input_uuid_comparison_exp,
  jargon?: input_jargon_bool_exp,
  jargon_id?: input_uuid_comparison_exp,
  parent?: input_comment_bool_exp,
  parent_id?: input_uuid_comparison_exp,
  removed?: input_Boolean_comparison_exp,
  translation?: input_translation_bool_exp,
  translation_id?: input_uuid_comparison_exp,
  updated_at?: input_timestamptz_comparison_exp,
}

@live
and input_comment_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_comment_bool_exp_nullable>>,
  _not?: Js.Null.t<input_comment_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_comment_bool_exp_nullable>>,
  author?: Js.Null.t<input_user_bool_exp_nullable>,
  author_id?: Js.Null.t<input_String_comparison_exp_nullable>,
  children?: Js.Null.t<input_comment_bool_exp_nullable>,
  children_aggregate?: Js.Null.t<input_comment_aggregate_bool_exp_nullable>,
  content?: Js.Null.t<input_String_comparison_exp_nullable>,
  created_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
  id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  jargon?: Js.Null.t<input_jargon_bool_exp_nullable>,
  jargon_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  parent?: Js.Null.t<input_comment_bool_exp_nullable>,
  parent_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  removed?: Js.Null.t<input_Boolean_comparison_exp_nullable>,
  translation?: Js.Null.t<input_translation_bool_exp_nullable>,
  translation_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  updated_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
}

@live
and input_comment_insert_input = {
  author?: input_user_obj_rel_insert_input,
  author_id?: string,
  children?: input_comment_arr_rel_insert_input,
  content?: string,
  created_at?: string,
  id?: string,
  jargon?: input_jargon_obj_rel_insert_input,
  jargon_id?: string,
  parent?: input_comment_obj_rel_insert_input,
  parent_id?: string,
  removed?: bool,
  translation?: input_translation_obj_rel_insert_input,
  translation_id?: string,
  updated_at?: string,
}

@live
and input_comment_insert_input_nullable = {
  author?: Js.Null.t<input_user_obj_rel_insert_input_nullable>,
  author_id?: Js.Null.t<string>,
  children?: Js.Null.t<input_comment_arr_rel_insert_input_nullable>,
  content?: Js.Null.t<string>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargon?: Js.Null.t<input_jargon_obj_rel_insert_input_nullable>,
  jargon_id?: Js.Null.t<string>,
  parent?: Js.Null.t<input_comment_obj_rel_insert_input_nullable>,
  parent_id?: Js.Null.t<string>,
  removed?: Js.Null.t<bool>,
  translation?: Js.Null.t<input_translation_obj_rel_insert_input_nullable>,
  translation_id?: Js.Null.t<string>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_comment_max_order_by = {
  author_id?: enum_order_by_input,
  content?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
  parent_id?: enum_order_by_input,
  translation_id?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_comment_max_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  content?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  parent_id?: Js.Null.t<enum_order_by_input>,
  translation_id?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_comment_min_order_by = {
  author_id?: enum_order_by_input,
  content?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
  parent_id?: enum_order_by_input,
  translation_id?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_comment_min_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  content?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  parent_id?: Js.Null.t<enum_order_by_input>,
  translation_id?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_comment_obj_rel_insert_input = {
  data: input_comment_insert_input,
  on_conflict?: input_comment_on_conflict,
}

@live
and input_comment_obj_rel_insert_input_nullable = {
  data: input_comment_insert_input_nullable,
  on_conflict?: Js.Null.t<input_comment_on_conflict_nullable>,
}

@live
and input_comment_on_conflict = {
  @as("constraint") constraint_: enum_comment_constraint_input,
  update_columns: array<enum_comment_update_column_input>,
  where?: input_comment_bool_exp,
}

@live
and input_comment_on_conflict_nullable = {
  @as("constraint") constraint_: enum_comment_constraint_input,
  update_columns: array<enum_comment_update_column_input>,
  where?: Js.Null.t<input_comment_bool_exp_nullable>,
}

@live
and input_comment_order_by = {
  author?: input_user_order_by,
  author_id?: enum_order_by_input,
  children_aggregate?: input_comment_aggregate_order_by,
  content?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon?: input_jargon_order_by,
  jargon_id?: enum_order_by_input,
  parent?: input_comment_order_by,
  parent_id?: enum_order_by_input,
  removed?: enum_order_by_input,
  translation?: input_translation_order_by,
  translation_id?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_comment_order_by_nullable = {
  author?: Js.Null.t<input_user_order_by_nullable>,
  author_id?: Js.Null.t<enum_order_by_input>,
  children_aggregate?: Js.Null.t<input_comment_aggregate_order_by_nullable>,
  content?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon?: Js.Null.t<input_jargon_order_by_nullable>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  parent?: Js.Null.t<input_comment_order_by_nullable>,
  parent_id?: Js.Null.t<enum_order_by_input>,
  removed?: Js.Null.t<enum_order_by_input>,
  translation?: Js.Null.t<input_translation_order_by_nullable>,
  translation_id?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_comment_pk_columns_input = {
  id: string,
}

@live
and input_comment_pk_columns_input_nullable = {
  id: string,
}

@live
and input_comment_set_input = {
  author_id?: string,
  content?: string,
  created_at?: string,
  id?: string,
  jargon_id?: string,
  parent_id?: string,
  removed?: bool,
  translation_id?: string,
  updated_at?: string,
}

@live
and input_comment_set_input_nullable = {
  author_id?: Js.Null.t<string>,
  content?: Js.Null.t<string>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargon_id?: Js.Null.t<string>,
  parent_id?: Js.Null.t<string>,
  removed?: Js.Null.t<bool>,
  translation_id?: Js.Null.t<string>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_comment_updates = {
  _set?: input_comment_set_input,
  where: input_comment_bool_exp,
}

@live
and input_comment_updates_nullable = {
  _set?: Js.Null.t<input_comment_set_input_nullable>,
  where: input_comment_bool_exp_nullable,
}

@live
and input_html_bool_exp = {
  _and?: array<input_html_bool_exp>,
  _not?: input_html_bool_exp,
  _or?: array<input_html_bool_exp>,
  created_at?: input_timestamptz_comparison_exp,
  data?: input_String_comparison_exp,
  id?: input_Int_comparison_exp,
  updated_at?: input_timestamptz_comparison_exp,
}

@live
and input_html_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_html_bool_exp_nullable>>,
  _not?: Js.Null.t<input_html_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_html_bool_exp_nullable>>,
  created_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
  data?: Js.Null.t<input_String_comparison_exp_nullable>,
  id?: Js.Null.t<input_Int_comparison_exp_nullable>,
  updated_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
}

@live
and input_html_inc_input = {
  id?: int,
}

@live
and input_html_inc_input_nullable = {
  id?: Js.Null.t<int>,
}

@live
and input_html_insert_input = {
  created_at?: string,
  data?: string,
  id?: int,
  updated_at?: string,
}

@live
and input_html_insert_input_nullable = {
  created_at?: Js.Null.t<string>,
  data?: Js.Null.t<string>,
  id?: Js.Null.t<int>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_html_on_conflict = {
  @as("constraint") constraint_: enum_html_constraint_input,
  update_columns: array<enum_html_update_column_input>,
  where?: input_html_bool_exp,
}

@live
and input_html_on_conflict_nullable = {
  @as("constraint") constraint_: enum_html_constraint_input,
  update_columns: array<enum_html_update_column_input>,
  where?: Js.Null.t<input_html_bool_exp_nullable>,
}

@live
and input_html_order_by = {
  created_at?: enum_order_by_input,
  data?: enum_order_by_input,
  id?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_html_order_by_nullable = {
  created_at?: Js.Null.t<enum_order_by_input>,
  data?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_html_pk_columns_input = {
  id: int,
}

@live
and input_html_pk_columns_input_nullable = {
  id: int,
}

@live
and input_html_set_input = {
  created_at?: string,
  data?: string,
  id?: int,
  updated_at?: string,
}

@live
and input_html_set_input_nullable = {
  created_at?: Js.Null.t<string>,
  data?: Js.Null.t<string>,
  id?: Js.Null.t<int>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_html_updates = {
  _inc?: input_html_inc_input,
  _set?: input_html_set_input,
  where: input_html_bool_exp,
}

@live
and input_html_updates_nullable = {
  _inc?: Js.Null.t<input_html_inc_input_nullable>,
  _set?: Js.Null.t<input_html_set_input_nullable>,
  where: input_html_bool_exp_nullable,
}

@live
and input_jargon_aggregate_bool_exp = {
  count?: input_jargon_aggregate_bool_exp_count,
}

@live
and input_jargon_aggregate_bool_exp_nullable = {
  count?: Js.Null.t<input_jargon_aggregate_bool_exp_count_nullable>,
}

@live
and input_jargon_aggregate_bool_exp_count = {
  arguments?: array<enum_jargon_select_column_input>,
  distinct?: bool,
  filter?: input_jargon_bool_exp,
  predicate: input_Int_comparison_exp,
}

@live
and input_jargon_aggregate_bool_exp_count_nullable = {
  arguments?: Js.Null.t<array<enum_jargon_select_column_input>>,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_jargon_bool_exp_nullable>,
  predicate: input_Int_comparison_exp_nullable,
}

@live
and input_jargon_aggregate_order_by = {
  count?: enum_order_by_input,
  max?: input_jargon_max_order_by,
  min?: input_jargon_min_order_by,
}

@live
and input_jargon_aggregate_order_by_nullable = {
  count?: Js.Null.t<enum_order_by_input>,
  max?: Js.Null.t<input_jargon_max_order_by_nullable>,
  min?: Js.Null.t<input_jargon_min_order_by_nullable>,
}

@live
and input_jargon_arr_rel_insert_input = {
  data: array<input_jargon_insert_input>,
  on_conflict?: input_jargon_on_conflict,
}

@live
and input_jargon_arr_rel_insert_input_nullable = {
  data: array<input_jargon_insert_input_nullable>,
  on_conflict?: Js.Null.t<input_jargon_on_conflict_nullable>,
}

@live
and input_jargon_bool_exp = {
  _and?: array<input_jargon_bool_exp>,
  _not?: input_jargon_bool_exp,
  _or?: array<input_jargon_bool_exp>,
  author?: input_user_bool_exp,
  author_id?: input_String_comparison_exp,
  comments?: input_comment_bool_exp,
  comments_aggregate?: input_comment_aggregate_bool_exp,
  created_at?: input_timestamptz_comparison_exp,
  id?: input_uuid_comparison_exp,
  jargon_categories?: input_jargon_category_bool_exp,
  jargon_categories_aggregate?: input_jargon_category_aggregate_bool_exp,
  name?: input_String_comparison_exp,
  name_lower?: input_String_comparison_exp,
  name_lower_no_spaces?: input_String_comparison_exp,
  translations?: input_translation_bool_exp,
  translations_aggregate?: input_translation_aggregate_bool_exp,
  updated_at?: input_timestamptz_comparison_exp,
}

@live
and input_jargon_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_jargon_bool_exp_nullable>>,
  _not?: Js.Null.t<input_jargon_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_jargon_bool_exp_nullable>>,
  author?: Js.Null.t<input_user_bool_exp_nullable>,
  author_id?: Js.Null.t<input_String_comparison_exp_nullable>,
  comments?: Js.Null.t<input_comment_bool_exp_nullable>,
  comments_aggregate?: Js.Null.t<input_comment_aggregate_bool_exp_nullable>,
  created_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
  id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  jargon_categories?: Js.Null.t<input_jargon_category_bool_exp_nullable>,
  jargon_categories_aggregate?: Js.Null.t<input_jargon_category_aggregate_bool_exp_nullable>,
  name?: Js.Null.t<input_String_comparison_exp_nullable>,
  name_lower?: Js.Null.t<input_String_comparison_exp_nullable>,
  name_lower_no_spaces?: Js.Null.t<input_String_comparison_exp_nullable>,
  translations?: Js.Null.t<input_translation_bool_exp_nullable>,
  translations_aggregate?: Js.Null.t<input_translation_aggregate_bool_exp_nullable>,
  updated_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
}

@live
and input_jargon_category_aggregate_bool_exp = {
  count?: input_jargon_category_aggregate_bool_exp_count,
}

@live
and input_jargon_category_aggregate_bool_exp_nullable = {
  count?: Js.Null.t<input_jargon_category_aggregate_bool_exp_count_nullable>,
}

@live
and input_jargon_category_aggregate_bool_exp_count = {
  arguments?: array<enum_jargon_category_select_column_input>,
  distinct?: bool,
  filter?: input_jargon_category_bool_exp,
  predicate: input_Int_comparison_exp,
}

@live
and input_jargon_category_aggregate_bool_exp_count_nullable = {
  arguments?: Js.Null.t<array<enum_jargon_category_select_column_input>>,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_jargon_category_bool_exp_nullable>,
  predicate: input_Int_comparison_exp_nullable,
}

@live
and input_jargon_category_aggregate_order_by = {
  avg?: input_jargon_category_avg_order_by,
  count?: enum_order_by_input,
  max?: input_jargon_category_max_order_by,
  min?: input_jargon_category_min_order_by,
  stddev?: input_jargon_category_stddev_order_by,
  stddev_pop?: input_jargon_category_stddev_pop_order_by,
  stddev_samp?: input_jargon_category_stddev_samp_order_by,
  sum?: input_jargon_category_sum_order_by,
  var_pop?: input_jargon_category_var_pop_order_by,
  var_samp?: input_jargon_category_var_samp_order_by,
  variance?: input_jargon_category_variance_order_by,
}

@live
and input_jargon_category_aggregate_order_by_nullable = {
  avg?: Js.Null.t<input_jargon_category_avg_order_by_nullable>,
  count?: Js.Null.t<enum_order_by_input>,
  max?: Js.Null.t<input_jargon_category_max_order_by_nullable>,
  min?: Js.Null.t<input_jargon_category_min_order_by_nullable>,
  stddev?: Js.Null.t<input_jargon_category_stddev_order_by_nullable>,
  stddev_pop?: Js.Null.t<input_jargon_category_stddev_pop_order_by_nullable>,
  stddev_samp?: Js.Null.t<input_jargon_category_stddev_samp_order_by_nullable>,
  sum?: Js.Null.t<input_jargon_category_sum_order_by_nullable>,
  var_pop?: Js.Null.t<input_jargon_category_var_pop_order_by_nullable>,
  var_samp?: Js.Null.t<input_jargon_category_var_samp_order_by_nullable>,
  variance?: Js.Null.t<input_jargon_category_variance_order_by_nullable>,
}

@live
and input_jargon_category_arr_rel_insert_input = {
  data: array<input_jargon_category_insert_input>,
  on_conflict?: input_jargon_category_on_conflict,
}

@live
and input_jargon_category_arr_rel_insert_input_nullable = {
  data: array<input_jargon_category_insert_input_nullable>,
  on_conflict?: Js.Null.t<input_jargon_category_on_conflict_nullable>,
}

@live
and input_jargon_category_avg_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_avg_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_bool_exp = {
  _and?: array<input_jargon_category_bool_exp>,
  _not?: input_jargon_category_bool_exp,
  _or?: array<input_jargon_category_bool_exp>,
  category?: input_category_bool_exp,
  category_id?: input_Int_comparison_exp,
  jargon?: input_jargon_bool_exp,
  jargon_id?: input_uuid_comparison_exp,
}

@live
and input_jargon_category_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_jargon_category_bool_exp_nullable>>,
  _not?: Js.Null.t<input_jargon_category_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_jargon_category_bool_exp_nullable>>,
  category?: Js.Null.t<input_category_bool_exp_nullable>,
  category_id?: Js.Null.t<input_Int_comparison_exp_nullable>,
  jargon?: Js.Null.t<input_jargon_bool_exp_nullable>,
  jargon_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
}

@live
and input_jargon_category_inc_input = {
  category_id?: int,
}

@live
and input_jargon_category_inc_input_nullable = {
  category_id?: Js.Null.t<int>,
}

@live
and input_jargon_category_insert_input = {
  category?: input_category_obj_rel_insert_input,
  category_id?: int,
  jargon?: input_jargon_obj_rel_insert_input,
  jargon_id?: string,
}

@live
and input_jargon_category_insert_input_nullable = {
  category?: Js.Null.t<input_category_obj_rel_insert_input_nullable>,
  category_id?: Js.Null.t<int>,
  jargon?: Js.Null.t<input_jargon_obj_rel_insert_input_nullable>,
  jargon_id?: Js.Null.t<string>,
}

@live
and input_jargon_category_max_order_by = {
  category_id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
}

@live
and input_jargon_category_max_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_min_order_by = {
  category_id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
}

@live
and input_jargon_category_min_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_on_conflict = {
  @as("constraint") constraint_: enum_jargon_category_constraint_input,
  update_columns: array<enum_jargon_category_update_column_input>,
  where?: input_jargon_category_bool_exp,
}

@live
and input_jargon_category_on_conflict_nullable = {
  @as("constraint") constraint_: enum_jargon_category_constraint_input,
  update_columns: array<enum_jargon_category_update_column_input>,
  where?: Js.Null.t<input_jargon_category_bool_exp_nullable>,
}

@live
and input_jargon_category_order_by = {
  category?: input_category_order_by,
  category_id?: enum_order_by_input,
  jargon?: input_jargon_order_by,
  jargon_id?: enum_order_by_input,
}

@live
and input_jargon_category_order_by_nullable = {
  category?: Js.Null.t<input_category_order_by_nullable>,
  category_id?: Js.Null.t<enum_order_by_input>,
  jargon?: Js.Null.t<input_jargon_order_by_nullable>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_pk_columns_input = {
  category_id: int,
  jargon_id: string,
}

@live
and input_jargon_category_pk_columns_input_nullable = {
  category_id: int,
  jargon_id: string,
}

@live
and input_jargon_category_set_input = {
  category_id?: int,
  jargon_id?: string,
}

@live
and input_jargon_category_set_input_nullable = {
  category_id?: Js.Null.t<int>,
  jargon_id?: Js.Null.t<string>,
}

@live
and input_jargon_category_stddev_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_stddev_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_stddev_pop_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_stddev_pop_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_stddev_samp_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_stddev_samp_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_sum_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_sum_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_updates = {
  _inc?: input_jargon_category_inc_input,
  _set?: input_jargon_category_set_input,
  where: input_jargon_category_bool_exp,
}

@live
and input_jargon_category_updates_nullable = {
  _inc?: Js.Null.t<input_jargon_category_inc_input_nullable>,
  _set?: Js.Null.t<input_jargon_category_set_input_nullable>,
  where: input_jargon_category_bool_exp_nullable,
}

@live
and input_jargon_category_var_pop_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_var_pop_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_var_samp_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_var_samp_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_category_variance_order_by = {
  category_id?: enum_order_by_input,
}

@live
and input_jargon_category_variance_order_by_nullable = {
  category_id?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_insert_input = {
  author?: input_user_obj_rel_insert_input,
  author_id?: string,
  comments?: input_comment_arr_rel_insert_input,
  created_at?: string,
  id?: string,
  jargon_categories?: input_jargon_category_arr_rel_insert_input,
  name?: string,
  translations?: input_translation_arr_rel_insert_input,
  updated_at?: string,
}

@live
and input_jargon_insert_input_nullable = {
  author?: Js.Null.t<input_user_obj_rel_insert_input_nullable>,
  author_id?: Js.Null.t<string>,
  comments?: Js.Null.t<input_comment_arr_rel_insert_input_nullable>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargon_categories?: Js.Null.t<input_jargon_category_arr_rel_insert_input_nullable>,
  name?: Js.Null.t<string>,
  translations?: Js.Null.t<input_translation_arr_rel_insert_input_nullable>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_jargon_max_order_by = {
  author_id?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  name?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_jargon_max_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  name?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_min_order_by = {
  author_id?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  name?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_jargon_min_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  name?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_obj_rel_insert_input = {
  data: input_jargon_insert_input,
  on_conflict?: input_jargon_on_conflict,
}

@live
and input_jargon_obj_rel_insert_input_nullable = {
  data: input_jargon_insert_input_nullable,
  on_conflict?: Js.Null.t<input_jargon_on_conflict_nullable>,
}

@live
and input_jargon_on_conflict = {
  @as("constraint") constraint_: enum_jargon_constraint_input,
  update_columns: array<enum_jargon_update_column_input>,
  where?: input_jargon_bool_exp,
}

@live
and input_jargon_on_conflict_nullable = {
  @as("constraint") constraint_: enum_jargon_constraint_input,
  update_columns: array<enum_jargon_update_column_input>,
  where?: Js.Null.t<input_jargon_bool_exp_nullable>,
}

@live
and input_jargon_order_by = {
  author?: input_user_order_by,
  author_id?: enum_order_by_input,
  comments_aggregate?: input_comment_aggregate_order_by,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_categories_aggregate?: input_jargon_category_aggregate_order_by,
  name?: enum_order_by_input,
  name_lower?: enum_order_by_input,
  name_lower_no_spaces?: enum_order_by_input,
  translations_aggregate?: input_translation_aggregate_order_by,
  updated_at?: enum_order_by_input,
}

@live
and input_jargon_order_by_nullable = {
  author?: Js.Null.t<input_user_order_by_nullable>,
  author_id?: Js.Null.t<enum_order_by_input>,
  comments_aggregate?: Js.Null.t<input_comment_aggregate_order_by_nullable>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_categories_aggregate?: Js.Null.t<input_jargon_category_aggregate_order_by_nullable>,
  name?: Js.Null.t<enum_order_by_input>,
  name_lower?: Js.Null.t<enum_order_by_input>,
  name_lower_no_spaces?: Js.Null.t<enum_order_by_input>,
  translations_aggregate?: Js.Null.t<input_translation_aggregate_order_by_nullable>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_jargon_pk_columns_input = {
  id: string,
}

@live
and input_jargon_pk_columns_input_nullable = {
  id: string,
}

@live
and input_jargon_set_input = {
  author_id?: string,
  created_at?: string,
  id?: string,
  name?: string,
  updated_at?: string,
}

@live
and input_jargon_set_input_nullable = {
  author_id?: Js.Null.t<string>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  name?: Js.Null.t<string>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_jargon_updates = {
  _set?: input_jargon_set_input,
  where: input_jargon_bool_exp,
}

@live
and input_jargon_updates_nullable = {
  _set?: Js.Null.t<input_jargon_set_input_nullable>,
  where: input_jargon_bool_exp_nullable,
}

@live
and input_list_jargon_random_args = {
  seed?: string,
}

@live
and input_list_jargon_random_args_nullable = {
  seed?: Js.Null.t<string>,
}

@live
and input_timestamptz_comparison_exp = {
  _eq?: string,
  _gt?: string,
  _gte?: string,
  _in?: array<string>,
  _is_null?: bool,
  _lt?: string,
  _lte?: string,
  _neq?: string,
  _nin?: array<string>,
}

@live
and input_timestamptz_comparison_exp_nullable = {
  _eq?: Js.Null.t<string>,
  _gt?: Js.Null.t<string>,
  _gte?: Js.Null.t<string>,
  _in?: Js.Null.t<array<string>>,
  _is_null?: Js.Null.t<bool>,
  _lt?: Js.Null.t<string>,
  _lte?: Js.Null.t<string>,
  _neq?: Js.Null.t<string>,
  _nin?: Js.Null.t<array<string>>,
}

@live
and input_translation_aggregate_bool_exp = {
  count?: input_translation_aggregate_bool_exp_count,
}

@live
and input_translation_aggregate_bool_exp_nullable = {
  count?: Js.Null.t<input_translation_aggregate_bool_exp_count_nullable>,
}

@live
and input_translation_aggregate_bool_exp_count = {
  arguments?: array<enum_translation_select_column_input>,
  distinct?: bool,
  filter?: input_translation_bool_exp,
  predicate: input_Int_comparison_exp,
}

@live
and input_translation_aggregate_bool_exp_count_nullable = {
  arguments?: Js.Null.t<array<enum_translation_select_column_input>>,
  distinct?: Js.Null.t<bool>,
  filter?: Js.Null.t<input_translation_bool_exp_nullable>,
  predicate: input_Int_comparison_exp_nullable,
}

@live
and input_translation_aggregate_order_by = {
  count?: enum_order_by_input,
  max?: input_translation_max_order_by,
  min?: input_translation_min_order_by,
}

@live
and input_translation_aggregate_order_by_nullable = {
  count?: Js.Null.t<enum_order_by_input>,
  max?: Js.Null.t<input_translation_max_order_by_nullable>,
  min?: Js.Null.t<input_translation_min_order_by_nullable>,
}

@live
and input_translation_arr_rel_insert_input = {
  data: array<input_translation_insert_input>,
  on_conflict?: input_translation_on_conflict,
}

@live
and input_translation_arr_rel_insert_input_nullable = {
  data: array<input_translation_insert_input_nullable>,
  on_conflict?: Js.Null.t<input_translation_on_conflict_nullable>,
}

@live
and input_translation_bool_exp = {
  _and?: array<input_translation_bool_exp>,
  _not?: input_translation_bool_exp,
  _or?: array<input_translation_bool_exp>,
  author?: input_user_bool_exp,
  author_id?: input_String_comparison_exp,
  comment?: input_comment_bool_exp,
  comment_id?: input_uuid_comparison_exp,
  created_at?: input_timestamptz_comparison_exp,
  id?: input_uuid_comparison_exp,
  jargon?: input_jargon_bool_exp,
  jargon_id?: input_uuid_comparison_exp,
  name?: input_String_comparison_exp,
  name_lower_no_spaces?: input_String_comparison_exp,
  updated_at?: input_timestamptz_comparison_exp,
}

@live
and input_translation_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_translation_bool_exp_nullable>>,
  _not?: Js.Null.t<input_translation_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_translation_bool_exp_nullable>>,
  author?: Js.Null.t<input_user_bool_exp_nullable>,
  author_id?: Js.Null.t<input_String_comparison_exp_nullable>,
  comment?: Js.Null.t<input_comment_bool_exp_nullable>,
  comment_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  created_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
  id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  jargon?: Js.Null.t<input_jargon_bool_exp_nullable>,
  jargon_id?: Js.Null.t<input_uuid_comparison_exp_nullable>,
  name?: Js.Null.t<input_String_comparison_exp_nullable>,
  name_lower_no_spaces?: Js.Null.t<input_String_comparison_exp_nullable>,
  updated_at?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
}

@live
and input_translation_insert_input = {
  author?: input_user_obj_rel_insert_input,
  author_id?: string,
  comment?: input_comment_obj_rel_insert_input,
  comment_id?: string,
  created_at?: string,
  id?: string,
  jargon?: input_jargon_obj_rel_insert_input,
  jargon_id?: string,
  name?: string,
  updated_at?: string,
}

@live
and input_translation_insert_input_nullable = {
  author?: Js.Null.t<input_user_obj_rel_insert_input_nullable>,
  author_id?: Js.Null.t<string>,
  comment?: Js.Null.t<input_comment_obj_rel_insert_input_nullable>,
  comment_id?: Js.Null.t<string>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargon?: Js.Null.t<input_jargon_obj_rel_insert_input_nullable>,
  jargon_id?: Js.Null.t<string>,
  name?: Js.Null.t<string>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_translation_max_order_by = {
  author_id?: enum_order_by_input,
  comment_id?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
  name?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_translation_max_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  comment_id?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  name?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_translation_min_order_by = {
  author_id?: enum_order_by_input,
  comment_id?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon_id?: enum_order_by_input,
  name?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_translation_min_order_by_nullable = {
  author_id?: Js.Null.t<enum_order_by_input>,
  comment_id?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  name?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_translation_obj_rel_insert_input = {
  data: input_translation_insert_input,
  on_conflict?: input_translation_on_conflict,
}

@live
and input_translation_obj_rel_insert_input_nullable = {
  data: input_translation_insert_input_nullable,
  on_conflict?: Js.Null.t<input_translation_on_conflict_nullable>,
}

@live
and input_translation_on_conflict = {
  @as("constraint") constraint_: enum_translation_constraint_input,
  update_columns: array<enum_translation_update_column_input>,
  where?: input_translation_bool_exp,
}

@live
and input_translation_on_conflict_nullable = {
  @as("constraint") constraint_: enum_translation_constraint_input,
  update_columns: array<enum_translation_update_column_input>,
  where?: Js.Null.t<input_translation_bool_exp_nullable>,
}

@live
and input_translation_order_by = {
  author?: input_user_order_by,
  author_id?: enum_order_by_input,
  comment?: input_comment_order_by,
  comment_id?: enum_order_by_input,
  created_at?: enum_order_by_input,
  id?: enum_order_by_input,
  jargon?: input_jargon_order_by,
  jargon_id?: enum_order_by_input,
  name?: enum_order_by_input,
  name_lower_no_spaces?: enum_order_by_input,
  updated_at?: enum_order_by_input,
}

@live
and input_translation_order_by_nullable = {
  author?: Js.Null.t<input_user_order_by_nullable>,
  author_id?: Js.Null.t<enum_order_by_input>,
  comment?: Js.Null.t<input_comment_order_by_nullable>,
  comment_id?: Js.Null.t<enum_order_by_input>,
  created_at?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargon?: Js.Null.t<input_jargon_order_by_nullable>,
  jargon_id?: Js.Null.t<enum_order_by_input>,
  name?: Js.Null.t<enum_order_by_input>,
  name_lower_no_spaces?: Js.Null.t<enum_order_by_input>,
  updated_at?: Js.Null.t<enum_order_by_input>,
}

@live
and input_translation_pk_columns_input = {
  id: string,
}

@live
and input_translation_pk_columns_input_nullable = {
  id: string,
}

@live
and input_translation_set_input = {
  author_id?: string,
  comment_id?: string,
  created_at?: string,
  id?: string,
  jargon_id?: string,
  name?: string,
  updated_at?: string,
}

@live
and input_translation_set_input_nullable = {
  author_id?: Js.Null.t<string>,
  comment_id?: Js.Null.t<string>,
  created_at?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargon_id?: Js.Null.t<string>,
  name?: Js.Null.t<string>,
  updated_at?: Js.Null.t<string>,
}

@live
and input_translation_updates = {
  _set?: input_translation_set_input,
  where: input_translation_bool_exp,
}

@live
and input_translation_updates_nullable = {
  _set?: Js.Null.t<input_translation_set_input_nullable>,
  where: input_translation_bool_exp_nullable,
}

@live
and input_user_bool_exp = {
  _and?: array<input_user_bool_exp>,
  _not?: input_user_bool_exp,
  _or?: array<input_user_bool_exp>,
  comments?: input_comment_bool_exp,
  comments_aggregate?: input_comment_aggregate_bool_exp,
  display_name?: input_String_comparison_exp,
  email?: input_String_comparison_exp,
  id?: input_String_comparison_exp,
  jargons?: input_jargon_bool_exp,
  jargons_aggregate?: input_jargon_aggregate_bool_exp,
  last_seen?: input_timestamptz_comparison_exp,
  photo_url?: input_String_comparison_exp,
  translations?: input_translation_bool_exp,
  translations_aggregate?: input_translation_aggregate_bool_exp,
}

@live
and input_user_bool_exp_nullable = {
  _and?: Js.Null.t<array<input_user_bool_exp_nullable>>,
  _not?: Js.Null.t<input_user_bool_exp_nullable>,
  _or?: Js.Null.t<array<input_user_bool_exp_nullable>>,
  comments?: Js.Null.t<input_comment_bool_exp_nullable>,
  comments_aggregate?: Js.Null.t<input_comment_aggregate_bool_exp_nullable>,
  display_name?: Js.Null.t<input_String_comparison_exp_nullable>,
  email?: Js.Null.t<input_String_comparison_exp_nullable>,
  id?: Js.Null.t<input_String_comparison_exp_nullable>,
  jargons?: Js.Null.t<input_jargon_bool_exp_nullable>,
  jargons_aggregate?: Js.Null.t<input_jargon_aggregate_bool_exp_nullable>,
  last_seen?: Js.Null.t<input_timestamptz_comparison_exp_nullable>,
  photo_url?: Js.Null.t<input_String_comparison_exp_nullable>,
  translations?: Js.Null.t<input_translation_bool_exp_nullable>,
  translations_aggregate?: Js.Null.t<input_translation_aggregate_bool_exp_nullable>,
}

@live
and input_user_insert_input = {
  comments?: input_comment_arr_rel_insert_input,
  display_name?: string,
  email?: string,
  id?: string,
  jargons?: input_jargon_arr_rel_insert_input,
  last_seen?: string,
  photo_url?: string,
  translations?: input_translation_arr_rel_insert_input,
}

@live
and input_user_insert_input_nullable = {
  comments?: Js.Null.t<input_comment_arr_rel_insert_input_nullable>,
  display_name?: Js.Null.t<string>,
  email?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  jargons?: Js.Null.t<input_jargon_arr_rel_insert_input_nullable>,
  last_seen?: Js.Null.t<string>,
  photo_url?: Js.Null.t<string>,
  translations?: Js.Null.t<input_translation_arr_rel_insert_input_nullable>,
}

@live
and input_user_obj_rel_insert_input = {
  data: input_user_insert_input,
  on_conflict?: input_user_on_conflict,
}

@live
and input_user_obj_rel_insert_input_nullable = {
  data: input_user_insert_input_nullable,
  on_conflict?: Js.Null.t<input_user_on_conflict_nullable>,
}

@live
and input_user_on_conflict = {
  @as("constraint") constraint_: enum_user_constraint_input,
  update_columns: array<enum_user_update_column_input>,
  where?: input_user_bool_exp,
}

@live
and input_user_on_conflict_nullable = {
  @as("constraint") constraint_: enum_user_constraint_input,
  update_columns: array<enum_user_update_column_input>,
  where?: Js.Null.t<input_user_bool_exp_nullable>,
}

@live
and input_user_order_by = {
  comments_aggregate?: input_comment_aggregate_order_by,
  display_name?: enum_order_by_input,
  email?: enum_order_by_input,
  id?: enum_order_by_input,
  jargons_aggregate?: input_jargon_aggregate_order_by,
  last_seen?: enum_order_by_input,
  photo_url?: enum_order_by_input,
  translations_aggregate?: input_translation_aggregate_order_by,
}

@live
and input_user_order_by_nullable = {
  comments_aggregate?: Js.Null.t<input_comment_aggregate_order_by_nullable>,
  display_name?: Js.Null.t<enum_order_by_input>,
  email?: Js.Null.t<enum_order_by_input>,
  id?: Js.Null.t<enum_order_by_input>,
  jargons_aggregate?: Js.Null.t<input_jargon_aggregate_order_by_nullable>,
  last_seen?: Js.Null.t<enum_order_by_input>,
  photo_url?: Js.Null.t<enum_order_by_input>,
  translations_aggregate?: Js.Null.t<input_translation_aggregate_order_by_nullable>,
}

@live
and input_user_pk_columns_input = {
  id: string,
}

@live
and input_user_pk_columns_input_nullable = {
  id: string,
}

@live
and input_user_set_input = {
  display_name?: string,
  email?: string,
  id?: string,
  last_seen?: string,
  photo_url?: string,
}

@live
and input_user_set_input_nullable = {
  display_name?: Js.Null.t<string>,
  email?: Js.Null.t<string>,
  id?: Js.Null.t<string>,
  last_seen?: Js.Null.t<string>,
  photo_url?: Js.Null.t<string>,
}

@live
and input_user_updates = {
  _set?: input_user_set_input,
  where: input_user_bool_exp,
}

@live
and input_user_updates_nullable = {
  _set?: Js.Null.t<input_user_set_input_nullable>,
  where: input_user_bool_exp_nullable,
}

@live
and input_uuid_comparison_exp = {
  _eq?: string,
  _gt?: string,
  _gte?: string,
  _in?: array<string>,
  _is_null?: bool,
  _lt?: string,
  _lte?: string,
  _neq?: string,
  _nin?: array<string>,
}

@live
and input_uuid_comparison_exp_nullable = {
  _eq?: Js.Null.t<string>,
  _gt?: Js.Null.t<string>,
  _gte?: Js.Null.t<string>,
  _in?: Js.Null.t<array<string>>,
  _is_null?: Js.Null.t<bool>,
  _lt?: Js.Null.t<string>,
  _lte?: Js.Null.t<string>,
  _neq?: Js.Null.t<string>,
  _nin?: Js.Null.t<array<string>>,
}
