/* @sourceLoc NewJargon.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live type jargon_category_insert_input = RelaySchemaAssets_graphql.input_jargon_category_insert_input
  @live type category_obj_rel_insert_input = RelaySchemaAssets_graphql.input_category_obj_rel_insert_input
  @live type category_insert_input = RelaySchemaAssets_graphql.input_category_insert_input
  @live type jargon_category_arr_rel_insert_input = RelaySchemaAssets_graphql.input_jargon_category_arr_rel_insert_input
  @live type jargon_category_on_conflict = RelaySchemaAssets_graphql.input_jargon_category_on_conflict
  @live type jargon_category_bool_exp = RelaySchemaAssets_graphql.input_jargon_category_bool_exp
  @live type category_bool_exp = RelaySchemaAssets_graphql.input_category_bool_exp
  @live type string_comparison_exp = RelaySchemaAssets_graphql.input_String_comparison_exp
  @live type int_comparison_exp = RelaySchemaAssets_graphql.input_Int_comparison_exp
  @live type jargon_category_aggregate_bool_exp = RelaySchemaAssets_graphql.input_jargon_category_aggregate_bool_exp
  @live type jargon_category_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_jargon_category_aggregate_bool_exp_count
  @live type jargon_bool_exp = RelaySchemaAssets_graphql.input_jargon_bool_exp
  @live type user_bool_exp = RelaySchemaAssets_graphql.input_user_bool_exp
  @live type comment_bool_exp = RelaySchemaAssets_graphql.input_comment_bool_exp
  @live type comment_aggregate_bool_exp = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp
  @live type comment_aggregate_bool_exp_bool_and = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_bool_and
  @live type boolean_comparison_exp = RelaySchemaAssets_graphql.input_Boolean_comparison_exp
  @live type comment_aggregate_bool_exp_bool_or = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_bool_or
  @live type comment_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_count
  @live type timestamptz_comparison_exp = RelaySchemaAssets_graphql.input_timestamptz_comparison_exp
  @live type uuid_comparison_exp = RelaySchemaAssets_graphql.input_uuid_comparison_exp
  @live type translation_bool_exp = RelaySchemaAssets_graphql.input_translation_bool_exp
  @live type jargon_aggregate_bool_exp = RelaySchemaAssets_graphql.input_jargon_aggregate_bool_exp
  @live type jargon_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_jargon_aggregate_bool_exp_count
  @live type translation_aggregate_bool_exp = RelaySchemaAssets_graphql.input_translation_aggregate_bool_exp
  @live type translation_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_translation_aggregate_bool_exp_count
  @live type related_jargon_bool_exp = RelaySchemaAssets_graphql.input_related_jargon_bool_exp
  @live type related_jargon_aggregate_bool_exp = RelaySchemaAssets_graphql.input_related_jargon_aggregate_bool_exp
  @live type related_jargon_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_related_jargon_aggregate_bool_exp_count
  @live type category_on_conflict = RelaySchemaAssets_graphql.input_category_on_conflict
  @live type jargon_obj_rel_insert_input = RelaySchemaAssets_graphql.input_jargon_obj_rel_insert_input
  @live type jargon_insert_input = RelaySchemaAssets_graphql.input_jargon_insert_input
  @live type user_obj_rel_insert_input = RelaySchemaAssets_graphql.input_user_obj_rel_insert_input
  @live type user_insert_input = RelaySchemaAssets_graphql.input_user_insert_input
  @live type comment_arr_rel_insert_input = RelaySchemaAssets_graphql.input_comment_arr_rel_insert_input
  @live type comment_insert_input = RelaySchemaAssets_graphql.input_comment_insert_input
  @live type comment_obj_rel_insert_input = RelaySchemaAssets_graphql.input_comment_obj_rel_insert_input
  @live type comment_on_conflict = RelaySchemaAssets_graphql.input_comment_on_conflict
  @live type translation_obj_rel_insert_input = RelaySchemaAssets_graphql.input_translation_obj_rel_insert_input
  @live type translation_insert_input = RelaySchemaAssets_graphql.input_translation_insert_input
  @live type translation_on_conflict = RelaySchemaAssets_graphql.input_translation_on_conflict
  @live type jargon_arr_rel_insert_input = RelaySchemaAssets_graphql.input_jargon_arr_rel_insert_input
  @live type jargon_on_conflict = RelaySchemaAssets_graphql.input_jargon_on_conflict
  @live type translation_arr_rel_insert_input = RelaySchemaAssets_graphql.input_translation_arr_rel_insert_input
  @live type user_on_conflict = RelaySchemaAssets_graphql.input_user_on_conflict
  @live type related_jargon_arr_rel_insert_input = RelaySchemaAssets_graphql.input_related_jargon_arr_rel_insert_input
  @live type related_jargon_insert_input = RelaySchemaAssets_graphql.input_related_jargon_insert_input
  @live type related_jargon_on_conflict = RelaySchemaAssets_graphql.input_related_jargon_on_conflict
  @live
  type rec response_insert_jargon_category = {
    affected_rows: int,
  }
  @live
  and response_insert_jargon_one = {
    @live id: string,
  }
  @live
  type response = {
    insert_jargon_category: option<response_insert_jargon_category>,
    insert_jargon_one: option<response_insert_jargon_one>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    authorID: string,
    comment: string,
    commentID: string,
    @live id: string,
    jargon_categories: array<jargon_category_insert_input>,
    name: string,
    translation: string,
    translationID: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"category_obj_rel_insert_input":{"on_conflict":{"r":"category_on_conflict"},"data":{"r":"category_insert_input"}},"user_on_conflict":{"where":{"r":"user_bool_exp"}},"jargon_insert_input":{"updated_at":{"b":""},"translations":{"r":"translation_arr_rel_insert_input"},"related_jargons":{"r":"related_jargon_arr_rel_insert_input"},"jargon_categories":{"r":"jargon_category_arr_rel_insert_input"},"id":{"b":""},"created_at":{"b":""},"comments":{"r":"comment_arr_rel_insert_input"},"author":{"r":"user_obj_rel_insert_input"}},"comment_on_conflict":{"where":{"r":"comment_bool_exp"}},"category_insert_input":{"jargon_categories":{"r":"jargon_category_arr_rel_insert_input"}},"comment_aggregate_bool_exp_bool_or":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"jargon_category_arr_rel_insert_input":{"on_conflict":{"r":"jargon_category_on_conflict"},"data":{"r":"jargon_category_insert_input"}},"category_bool_exp":{"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"int_comparison_exp"},"acronym":{"r":"string_comparison_exp"},"_or":{"r":"category_bool_exp"},"_not":{"r":"category_bool_exp"},"_and":{"r":"category_bool_exp"}},"jargon_category_on_conflict":{"where":{"r":"jargon_category_bool_exp"}},"jargon_category_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_category_bool_exp"}},"timestamptz_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"jargon_category_aggregate_bool_exp":{"count":{"r":"jargon_category_aggregate_bool_exp_count"}},"comment_obj_rel_insert_input":{"on_conflict":{"r":"comment_on_conflict"},"data":{"r":"comment_insert_input"}},"related_jargon_arr_rel_insert_input":{"on_conflict":{"r":"related_jargon_on_conflict"},"data":{"r":"related_jargon_insert_input"}},"translation_on_conflict":{"where":{"r":"translation_bool_exp"}},"jargon_on_conflict":{"where":{"r":"jargon_bool_exp"}},"uuid_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"comment_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translation_id":{"r":"uuid_comparison_exp"},"translation":{"r":"translation_bool_exp"},"removed":{"r":"boolean_comparison_exp"},"parent_id":{"r":"uuid_comparison_exp"},"parent":{"r":"comment_bool_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"content":{"r":"string_comparison_exp"},"children_aggregate":{"r":"comment_aggregate_bool_exp"},"children":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"comment_bool_exp"},"_not":{"r":"comment_bool_exp"},"_and":{"r":"comment_bool_exp"}},"related_jargon_aggregate_bool_exp":{"count":{"r":"related_jargon_aggregate_bool_exp_count"}},"jargon_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_bool_exp"}},"user_insert_input":{"translations":{"r":"translation_arr_rel_insert_input"},"last_seen":{"b":""},"jargons":{"r":"jargon_arr_rel_insert_input"},"comments":{"r":"comment_arr_rel_insert_input"}},"jargon_obj_rel_insert_input":{"on_conflict":{"r":"jargon_on_conflict"},"data":{"r":"jargon_insert_input"}},"related_jargon_bool_exp":{"jargon2":{"r":"uuid_comparison_exp"},"jargon1":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"_or":{"r":"related_jargon_bool_exp"},"_not":{"r":"related_jargon_bool_exp"},"_and":{"r":"related_jargon_bool_exp"}},"translation_arr_rel_insert_input":{"on_conflict":{"r":"translation_on_conflict"},"data":{"r":"translation_insert_input"}},"translation_insert_input":{"updated_at":{"b":""},"jargon_id":{"b":""},"jargon":{"r":"jargon_obj_rel_insert_input"},"id":{"b":""},"created_at":{"b":""},"comment_id":{"b":""},"comment":{"r":"comment_obj_rel_insert_input"},"author":{"r":"user_obj_rel_insert_input"}},"string_comparison_exp":{},"related_jargon_insert_input":{"jargon2":{"b":""},"jargon1":{"b":""},"jargon":{"r":"jargon_obj_rel_insert_input"}},"int_comparison_exp":{},"comment_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"user_obj_rel_insert_input":{"on_conflict":{"r":"user_on_conflict"},"data":{"r":"user_insert_input"}},"jargon_category_bool_exp":{"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"category_id":{"r":"int_comparison_exp"},"category":{"r":"category_bool_exp"},"_or":{"r":"jargon_category_bool_exp"},"_not":{"r":"jargon_category_bool_exp"},"_and":{"r":"jargon_category_bool_exp"}},"comment_aggregate_bool_exp":{"count":{"r":"comment_aggregate_bool_exp_count"},"bool_or":{"r":"comment_aggregate_bool_exp_bool_or"},"bool_and":{"r":"comment_aggregate_bool_exp_bool_and"}},"translation_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comment_id":{"r":"uuid_comparison_exp"},"comment":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"translation_bool_exp"},"_not":{"r":"translation_bool_exp"},"_and":{"r":"translation_bool_exp"}},"translation_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"translation_bool_exp"}},"comment_insert_input":{"updated_at":{"b":""},"translation_id":{"b":""},"translation":{"r":"translation_obj_rel_insert_input"},"parent_id":{"b":""},"parent":{"r":"comment_obj_rel_insert_input"},"jargon_id":{"b":""},"jargon":{"r":"jargon_obj_rel_insert_input"},"id":{"b":""},"created_at":{"b":""},"children":{"r":"comment_arr_rel_insert_input"},"author":{"r":"user_obj_rel_insert_input"}},"jargon_arr_rel_insert_input":{"on_conflict":{"r":"jargon_on_conflict"},"data":{"r":"jargon_insert_input"}},"category_on_conflict":{"where":{"r":"category_bool_exp"}},"jargon_category_insert_input":{"jargon_id":{"b":""},"jargon":{"r":"jargon_obj_rel_insert_input"},"category":{"r":"category_obj_rel_insert_input"}},"user_bool_exp":{"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"photo_url":{"r":"string_comparison_exp"},"last_seen":{"r":"timestamptz_comparison_exp"},"jargons_aggregate":{"r":"jargon_aggregate_bool_exp"},"jargons":{"r":"jargon_bool_exp"},"id":{"r":"string_comparison_exp"},"email":{"r":"string_comparison_exp"},"display_name":{"r":"string_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"_or":{"r":"user_bool_exp"},"_not":{"r":"user_bool_exp"},"_and":{"r":"user_bool_exp"}},"translation_aggregate_bool_exp":{"count":{"r":"translation_aggregate_bool_exp_count"}},"boolean_comparison_exp":{},"jargon_aggregate_bool_exp":{"count":{"r":"jargon_aggregate_bool_exp_count"}},"related_jargon_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"related_jargon_bool_exp"}},"translation_obj_rel_insert_input":{"on_conflict":{"r":"translation_on_conflict"},"data":{"r":"translation_insert_input"}},"related_jargon_on_conflict":{"where":{"r":"related_jargon_bool_exp"}},"jargon_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"related_jargons_aggregate":{"r":"related_jargon_aggregate_bool_exp"},"related_jargons":{"r":"related_jargon_bool_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name_lower":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"jargon_bool_exp"},"_not":{"r":"jargon_bool_exp"},"_and":{"r":"jargon_bool_exp"}},"comment_arr_rel_insert_input":{"on_conflict":{"r":"comment_on_conflict"},"data":{"r":"comment_insert_input"}},"comment_aggregate_bool_exp_bool_and":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"__root":{"translationID":{"b":""},"jargon_categories":{"r":"jargon_category_insert_input"},"id":{"b":""},"commentID":{"b":""}}}`
  )
  @live
  let variablesConverterMap = ()
  @live
  let convertVariables = v => v->RescriptRelay.convertObj(
    variablesConverter,
    variablesConverterMap,
    Js.undefined
  )
  @live
  type wrapResponseRaw
  @live
  let wrapResponseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
  )
  @live
  let wrapResponseConverterMap = ()
  @live
  let convertWrapResponse = v => v->RescriptRelay.convertObj(
    wrapResponseConverter,
    wrapResponseConverterMap,
    Js.null
  )
  @live
  type responseRaw
  @live
  let responseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
  )
  @live
  let responseConverterMap = ()
  @live
  let convertResponse = v => v->RescriptRelay.convertObj(
    responseConverter,
    responseConverterMap,
    Js.undefined
  )
  type wrapRawResponseRaw = wrapResponseRaw
  @live
  let convertWrapRawResponse = convertWrapResponse
  type rawResponseRaw = responseRaw
  @live
  let convertRawResponse = convertResponse
}
module Utils = {
  @@warning("-33")
  open Types
  @live
  external category_constraint_toString: RelaySchemaAssets_graphql.enum_category_constraint => string = "%identity"
  @live
  external category_constraint_input_toString: RelaySchemaAssets_graphql.enum_category_constraint_input => string = "%identity"
  @live
  let category_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_category_constraint): option<RelaySchemaAssets_graphql.enum_category_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let category_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_category_constraint_input> => {
    category_constraint_decode(Obj.magic(str))
  }
  @live
  external category_update_column_toString: RelaySchemaAssets_graphql.enum_category_update_column => string = "%identity"
  @live
  external category_update_column_input_toString: RelaySchemaAssets_graphql.enum_category_update_column_input => string = "%identity"
  @live
  let category_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_category_update_column): option<RelaySchemaAssets_graphql.enum_category_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let category_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_category_update_column_input> => {
    category_update_column_decode(Obj.magic(str))
  }
  @live
  external comment_constraint_toString: RelaySchemaAssets_graphql.enum_comment_constraint => string = "%identity"
  @live
  external comment_constraint_input_toString: RelaySchemaAssets_graphql.enum_comment_constraint_input => string = "%identity"
  @live
  let comment_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_comment_constraint): option<RelaySchemaAssets_graphql.enum_comment_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let comment_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_comment_constraint_input> => {
    comment_constraint_decode(Obj.magic(str))
  }
  @live
  external comment_select_column_toString: RelaySchemaAssets_graphql.enum_comment_select_column => string = "%identity"
  @live
  external comment_select_column_input_toString: RelaySchemaAssets_graphql.enum_comment_select_column_input => string = "%identity"
  @live
  let comment_select_column_decode = (enum: RelaySchemaAssets_graphql.enum_comment_select_column): option<RelaySchemaAssets_graphql.enum_comment_select_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let comment_select_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_comment_select_column_input> => {
    comment_select_column_decode(Obj.magic(str))
  }
  @live
  external comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_toString: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns => string = "%identity"
  @live
  external comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input_toString: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input => string = "%identity"
  @live
  let comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode = (enum: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns): option<RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_input> => {
    comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode(Obj.magic(str))
  }
  @live
  external comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_toString: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns => string = "%identity"
  @live
  external comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input_toString: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input => string = "%identity"
  @live
  let comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode = (enum: RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns): option<RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_input> => {
    comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode(Obj.magic(str))
  }
  @live
  external comment_update_column_toString: RelaySchemaAssets_graphql.enum_comment_update_column => string = "%identity"
  @live
  external comment_update_column_input_toString: RelaySchemaAssets_graphql.enum_comment_update_column_input => string = "%identity"
  @live
  let comment_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_comment_update_column): option<RelaySchemaAssets_graphql.enum_comment_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let comment_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_comment_update_column_input> => {
    comment_update_column_decode(Obj.magic(str))
  }
  @live
  external jargon_category_constraint_toString: RelaySchemaAssets_graphql.enum_jargon_category_constraint => string = "%identity"
  @live
  external jargon_category_constraint_input_toString: RelaySchemaAssets_graphql.enum_jargon_category_constraint_input => string = "%identity"
  @live
  let jargon_category_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_category_constraint): option<RelaySchemaAssets_graphql.enum_jargon_category_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_category_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_category_constraint_input> => {
    jargon_category_constraint_decode(Obj.magic(str))
  }
  @live
  external jargon_category_select_column_toString: RelaySchemaAssets_graphql.enum_jargon_category_select_column => string = "%identity"
  @live
  external jargon_category_select_column_input_toString: RelaySchemaAssets_graphql.enum_jargon_category_select_column_input => string = "%identity"
  @live
  let jargon_category_select_column_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_category_select_column): option<RelaySchemaAssets_graphql.enum_jargon_category_select_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_category_select_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_category_select_column_input> => {
    jargon_category_select_column_decode(Obj.magic(str))
  }
  @live
  external jargon_category_update_column_toString: RelaySchemaAssets_graphql.enum_jargon_category_update_column => string = "%identity"
  @live
  external jargon_category_update_column_input_toString: RelaySchemaAssets_graphql.enum_jargon_category_update_column_input => string = "%identity"
  @live
  let jargon_category_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_category_update_column): option<RelaySchemaAssets_graphql.enum_jargon_category_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_category_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_category_update_column_input> => {
    jargon_category_update_column_decode(Obj.magic(str))
  }
  @live
  external jargon_constraint_toString: RelaySchemaAssets_graphql.enum_jargon_constraint => string = "%identity"
  @live
  external jargon_constraint_input_toString: RelaySchemaAssets_graphql.enum_jargon_constraint_input => string = "%identity"
  @live
  let jargon_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_constraint): option<RelaySchemaAssets_graphql.enum_jargon_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_constraint_input> => {
    jargon_constraint_decode(Obj.magic(str))
  }
  @live
  external jargon_select_column_toString: RelaySchemaAssets_graphql.enum_jargon_select_column => string = "%identity"
  @live
  external jargon_select_column_input_toString: RelaySchemaAssets_graphql.enum_jargon_select_column_input => string = "%identity"
  @live
  let jargon_select_column_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_select_column): option<RelaySchemaAssets_graphql.enum_jargon_select_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_select_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_select_column_input> => {
    jargon_select_column_decode(Obj.magic(str))
  }
  @live
  external jargon_update_column_toString: RelaySchemaAssets_graphql.enum_jargon_update_column => string = "%identity"
  @live
  external jargon_update_column_input_toString: RelaySchemaAssets_graphql.enum_jargon_update_column_input => string = "%identity"
  @live
  let jargon_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_jargon_update_column): option<RelaySchemaAssets_graphql.enum_jargon_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let jargon_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_jargon_update_column_input> => {
    jargon_update_column_decode(Obj.magic(str))
  }
  @live
  external related_jargon_constraint_toString: RelaySchemaAssets_graphql.enum_related_jargon_constraint => string = "%identity"
  @live
  external related_jargon_constraint_input_toString: RelaySchemaAssets_graphql.enum_related_jargon_constraint_input => string = "%identity"
  @live
  let related_jargon_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_related_jargon_constraint): option<RelaySchemaAssets_graphql.enum_related_jargon_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let related_jargon_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_related_jargon_constraint_input> => {
    related_jargon_constraint_decode(Obj.magic(str))
  }
  @live
  external related_jargon_select_column_toString: RelaySchemaAssets_graphql.enum_related_jargon_select_column => string = "%identity"
  @live
  external related_jargon_select_column_input_toString: RelaySchemaAssets_graphql.enum_related_jargon_select_column_input => string = "%identity"
  @live
  let related_jargon_select_column_decode = (enum: RelaySchemaAssets_graphql.enum_related_jargon_select_column): option<RelaySchemaAssets_graphql.enum_related_jargon_select_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let related_jargon_select_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_related_jargon_select_column_input> => {
    related_jargon_select_column_decode(Obj.magic(str))
  }
  @live
  external related_jargon_update_column_toString: RelaySchemaAssets_graphql.enum_related_jargon_update_column => string = "%identity"
  @live
  external related_jargon_update_column_input_toString: RelaySchemaAssets_graphql.enum_related_jargon_update_column_input => string = "%identity"
  @live
  let related_jargon_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_related_jargon_update_column): option<RelaySchemaAssets_graphql.enum_related_jargon_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let related_jargon_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_related_jargon_update_column_input> => {
    related_jargon_update_column_decode(Obj.magic(str))
  }
  @live
  external translation_constraint_toString: RelaySchemaAssets_graphql.enum_translation_constraint => string = "%identity"
  @live
  external translation_constraint_input_toString: RelaySchemaAssets_graphql.enum_translation_constraint_input => string = "%identity"
  @live
  let translation_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_translation_constraint): option<RelaySchemaAssets_graphql.enum_translation_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let translation_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_translation_constraint_input> => {
    translation_constraint_decode(Obj.magic(str))
  }
  @live
  external translation_select_column_toString: RelaySchemaAssets_graphql.enum_translation_select_column => string = "%identity"
  @live
  external translation_select_column_input_toString: RelaySchemaAssets_graphql.enum_translation_select_column_input => string = "%identity"
  @live
  let translation_select_column_decode = (enum: RelaySchemaAssets_graphql.enum_translation_select_column): option<RelaySchemaAssets_graphql.enum_translation_select_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let translation_select_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_translation_select_column_input> => {
    translation_select_column_decode(Obj.magic(str))
  }
  @live
  external translation_update_column_toString: RelaySchemaAssets_graphql.enum_translation_update_column => string = "%identity"
  @live
  external translation_update_column_input_toString: RelaySchemaAssets_graphql.enum_translation_update_column_input => string = "%identity"
  @live
  let translation_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_translation_update_column): option<RelaySchemaAssets_graphql.enum_translation_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let translation_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_translation_update_column_input> => {
    translation_update_column_decode(Obj.magic(str))
  }
  @live
  external user_constraint_toString: RelaySchemaAssets_graphql.enum_user_constraint => string = "%identity"
  @live
  external user_constraint_input_toString: RelaySchemaAssets_graphql.enum_user_constraint_input => string = "%identity"
  @live
  let user_constraint_decode = (enum: RelaySchemaAssets_graphql.enum_user_constraint): option<RelaySchemaAssets_graphql.enum_user_constraint_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let user_constraint_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_user_constraint_input> => {
    user_constraint_decode(Obj.magic(str))
  }
  @live
  external user_update_column_toString: RelaySchemaAssets_graphql.enum_user_update_column => string = "%identity"
  @live
  external user_update_column_input_toString: RelaySchemaAssets_graphql.enum_user_update_column_input => string = "%identity"
  @live
  let user_update_column_decode = (enum: RelaySchemaAssets_graphql.enum_user_update_column): option<RelaySchemaAssets_graphql.enum_user_update_column_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let user_update_column_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_user_update_column_input> => {
    user_update_column_decode(Obj.magic(str))
  }
}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "authorID"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "comment"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "commentID"
},
v3 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "id"
},
v4 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "jargon_categories"
},
v5 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "name"
},
v6 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "translation"
},
v7 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "translationID"
},
v8 = {
  "kind": "Variable",
  "name": "author_id",
  "variableName": "authorID"
},
v9 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          (v8/*: any*/),
          {
            "fields": [
              {
                "fields": [
                  (v8/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "content",
                    "variableName": "comment"
                  },
                  {
                    "kind": "Variable",
                    "name": "id",
                    "variableName": "commentID"
                  },
                  {
                    "kind": "Variable",
                    "name": "translation_id",
                    "variableName": "translationID"
                  }
                ],
                "kind": "ObjectValue",
                "name": "data"
              }
            ],
            "kind": "ObjectValue",
            "name": "comments"
          },
          {
            "kind": "Variable",
            "name": "id",
            "variableName": "id"
          },
          {
            "kind": "Variable",
            "name": "name",
            "variableName": "name"
          },
          {
            "fields": [
              {
                "fields": [
                  (v8/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "comment_id",
                    "variableName": "commentID"
                  },
                  {
                    "kind": "Variable",
                    "name": "id",
                    "variableName": "translationID"
                  },
                  {
                    "kind": "Variable",
                    "name": "name",
                    "variableName": "translation"
                  }
                ],
                "kind": "ObjectValue",
                "name": "data"
              }
            ],
            "kind": "ObjectValue",
            "name": "translations"
          }
        ],
        "kind": "ObjectValue",
        "name": "object"
      }
    ],
    "concreteType": "jargon",
    "kind": "LinkedField",
    "name": "insert_jargon_one",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "id",
        "storageKey": null
      }
    ],
    "storageKey": null
  },
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "objects",
        "variableName": "jargon_categories"
      }
    ],
    "concreteType": "jargon_category_mutation_response",
    "kind": "LinkedField",
    "name": "insert_jargon_category",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "affected_rows",
        "storageKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/),
      (v2/*: any*/),
      (v3/*: any*/),
      (v4/*: any*/),
      (v5/*: any*/),
      (v6/*: any*/),
      (v7/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewJargonMutation",
    "selections": (v9/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v3/*: any*/),
      (v0/*: any*/),
      (v5/*: any*/),
      (v7/*: any*/),
      (v6/*: any*/),
      (v4/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "NewJargonMutation",
    "selections": (v9/*: any*/)
  },
  "params": {
    "cacheID": "b03080161277f097726413faf01826b4",
    "id": null,
    "metadata": {},
    "name": "NewJargonMutation",
    "operationKind": "mutation",
    "text": "mutation NewJargonMutation(\n  $id: uuid!\n  $authorID: String!\n  $name: String!\n  $translationID: uuid!\n  $translation: String!\n  $jargon_categories: [jargon_category_insert_input!]!\n  $commentID: uuid!\n  $comment: String!\n) {\n  insert_jargon_one(object: {id: $id, author_id: $authorID, name: $name, comments: {data: {id: $commentID, author_id: $authorID, translation_id: $translationID, content: $comment}}, translations: {data: {id: $translationID, comment_id: $commentID, author_id: $authorID, name: $translation}}}) {\n    id\n  }\n  insert_jargon_category(objects: $jargon_categories) {\n    affected_rows\n  }\n}\n"
  }
};
})() `)


