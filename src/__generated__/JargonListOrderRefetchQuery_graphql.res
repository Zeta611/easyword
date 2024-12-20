/* @sourceLoc JargonList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live type jargon_order_by = RelaySchemaAssets_graphql.input_jargon_order_by
  @live type user_order_by = RelaySchemaAssets_graphql.input_user_order_by
  @live type comment_aggregate_order_by = RelaySchemaAssets_graphql.input_comment_aggregate_order_by
  @live type comment_max_order_by = RelaySchemaAssets_graphql.input_comment_max_order_by
  @live type comment_min_order_by = RelaySchemaAssets_graphql.input_comment_min_order_by
  @live type jargon_aggregate_order_by = RelaySchemaAssets_graphql.input_jargon_aggregate_order_by
  @live type jargon_max_order_by = RelaySchemaAssets_graphql.input_jargon_max_order_by
  @live type jargon_min_order_by = RelaySchemaAssets_graphql.input_jargon_min_order_by
  @live type translation_aggregate_order_by = RelaySchemaAssets_graphql.input_translation_aggregate_order_by
  @live type translation_max_order_by = RelaySchemaAssets_graphql.input_translation_max_order_by
  @live type translation_min_order_by = RelaySchemaAssets_graphql.input_translation_min_order_by
  @live type jargon_category_aggregate_order_by = RelaySchemaAssets_graphql.input_jargon_category_aggregate_order_by
  @live type jargon_category_avg_order_by = RelaySchemaAssets_graphql.input_jargon_category_avg_order_by
  @live type jargon_category_max_order_by = RelaySchemaAssets_graphql.input_jargon_category_max_order_by
  @live type jargon_category_min_order_by = RelaySchemaAssets_graphql.input_jargon_category_min_order_by
  @live type jargon_category_stddev_order_by = RelaySchemaAssets_graphql.input_jargon_category_stddev_order_by
  @live type jargon_category_stddev_pop_order_by = RelaySchemaAssets_graphql.input_jargon_category_stddev_pop_order_by
  @live type jargon_category_stddev_samp_order_by = RelaySchemaAssets_graphql.input_jargon_category_stddev_samp_order_by
  @live type jargon_category_sum_order_by = RelaySchemaAssets_graphql.input_jargon_category_sum_order_by
  @live type jargon_category_var_pop_order_by = RelaySchemaAssets_graphql.input_jargon_category_var_pop_order_by
  @live type jargon_category_var_samp_order_by = RelaySchemaAssets_graphql.input_jargon_category_var_samp_order_by
  @live type jargon_category_variance_order_by = RelaySchemaAssets_graphql.input_jargon_category_variance_order_by
  @live type related_jargon_aggregate_order_by = RelaySchemaAssets_graphql.input_related_jargon_aggregate_order_by
  @live type related_jargon_max_order_by = RelaySchemaAssets_graphql.input_related_jargon_max_order_by
  @live type related_jargon_min_order_by = RelaySchemaAssets_graphql.input_related_jargon_min_order_by
  @live type jargon_bool_exp = RelaySchemaAssets_graphql.input_jargon_bool_exp
  @live type user_bool_exp = RelaySchemaAssets_graphql.input_user_bool_exp
  @live type comment_bool_exp = RelaySchemaAssets_graphql.input_comment_bool_exp
  @live type string_comparison_exp = RelaySchemaAssets_graphql.input_String_comparison_exp
  @live type comment_aggregate_bool_exp = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp
  @live type comment_aggregate_bool_exp_bool_and = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_bool_and
  @live type boolean_comparison_exp = RelaySchemaAssets_graphql.input_Boolean_comparison_exp
  @live type comment_aggregate_bool_exp_bool_or = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_bool_or
  @live type comment_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_comment_aggregate_bool_exp_count
  @live type int_comparison_exp = RelaySchemaAssets_graphql.input_Int_comparison_exp
  @live type timestamptz_comparison_exp = RelaySchemaAssets_graphql.input_timestamptz_comparison_exp
  @live type uuid_comparison_exp = RelaySchemaAssets_graphql.input_uuid_comparison_exp
  @live type translation_bool_exp = RelaySchemaAssets_graphql.input_translation_bool_exp
  @live type jargon_aggregate_bool_exp = RelaySchemaAssets_graphql.input_jargon_aggregate_bool_exp
  @live type jargon_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_jargon_aggregate_bool_exp_count
  @live type translation_aggregate_bool_exp = RelaySchemaAssets_graphql.input_translation_aggregate_bool_exp
  @live type translation_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_translation_aggregate_bool_exp_count
  @live type jargon_category_bool_exp = RelaySchemaAssets_graphql.input_jargon_category_bool_exp
  @live type category_bool_exp = RelaySchemaAssets_graphql.input_category_bool_exp
  @live type jargon_category_aggregate_bool_exp = RelaySchemaAssets_graphql.input_jargon_category_aggregate_bool_exp
  @live type jargon_category_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_jargon_category_aggregate_bool_exp_count
  @live type related_jargon_bool_exp = RelaySchemaAssets_graphql.input_related_jargon_bool_exp
  @live type related_jargon_aggregate_bool_exp = RelaySchemaAssets_graphql.input_related_jargon_aggregate_bool_exp
  @live type related_jargon_aggregate_bool_exp_count = RelaySchemaAssets_graphql.input_related_jargon_aggregate_bool_exp_count
  @live
  type response = {
    fragmentRefs: RescriptRelay.fragmentRefs<[ | #JargonListOrderQuery]>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    categoryIDs?: array<int>,
    count?: int,
    cursor?: string,
    directions?: array<jargon_order_by>,
    onlyWithoutTranslationFilter?: array<jargon_bool_exp>,
    searchTerm?: string,
  }
  @live
  type refetchVariables = {
    categoryIDs: option<option<array<int>>>,
    count: option<option<int>>,
    cursor: option<option<string>>,
    directions: option<option<array<jargon_order_by>>>,
    onlyWithoutTranslationFilter: option<option<array<jargon_bool_exp>>>,
    searchTerm: option<option<string>>,
  }
  @live let makeRefetchVariables = (
    ~categoryIDs=?,
    ~count=?,
    ~cursor=?,
    ~directions=?,
    ~onlyWithoutTranslationFilter=?,
    ~searchTerm=?,
  ): refetchVariables => {
    categoryIDs: categoryIDs,
    count: count,
    cursor: cursor,
    directions: directions,
    onlyWithoutTranslationFilter: onlyWithoutTranslationFilter,
    searchTerm: searchTerm
  }

}


type queryRef

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"comment_aggregate_bool_exp_bool_and":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"jargon_category_aggregate_order_by":{"variance":{"r":"jargon_category_variance_order_by"},"var_samp":{"r":"jargon_category_var_samp_order_by"},"var_pop":{"r":"jargon_category_var_pop_order_by"},"sum":{"r":"jargon_category_sum_order_by"},"stddev_samp":{"r":"jargon_category_stddev_samp_order_by"},"stddev_pop":{"r":"jargon_category_stddev_pop_order_by"},"stddev":{"r":"jargon_category_stddev_order_by"},"min":{"r":"jargon_category_min_order_by"},"max":{"r":"jargon_category_max_order_by"},"avg":{"r":"jargon_category_avg_order_by"}},"jargon_category_variance_order_by":{},"jargon_category_var_pop_order_by":{},"comment_aggregate_bool_exp_bool_or":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"category_bool_exp":{"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"int_comparison_exp"},"acronym":{"r":"string_comparison_exp"},"_or":{"r":"category_bool_exp"},"_not":{"r":"category_bool_exp"},"_and":{"r":"category_bool_exp"}},"timestamptz_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"related_jargon_max_order_by":{},"jargon_category_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_category_bool_exp"}},"user_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"jargons_aggregate":{"r":"jargon_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"}},"comment_max_order_by":{},"jargon_category_aggregate_bool_exp":{"count":{"r":"jargon_category_aggregate_bool_exp_count"}},"jargon_category_stddev_order_by":{},"jargon_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"related_jargons_aggregate":{"r":"related_jargon_aggregate_order_by"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"},"author":{"r":"user_order_by"}},"uuid_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"comment_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translation_id":{"r":"uuid_comparison_exp"},"translation":{"r":"translation_bool_exp"},"removed":{"r":"boolean_comparison_exp"},"parent_id":{"r":"uuid_comparison_exp"},"parent":{"r":"comment_bool_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"content":{"r":"string_comparison_exp"},"children_aggregate":{"r":"comment_aggregate_bool_exp"},"children":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"comment_bool_exp"},"_not":{"r":"comment_bool_exp"},"_and":{"r":"comment_bool_exp"}},"related_jargon_aggregate_order_by":{"min":{"r":"related_jargon_min_order_by"},"max":{"r":"related_jargon_max_order_by"}},"jargon_category_var_samp_order_by":{},"comment_min_order_by":{},"related_jargon_bool_exp":{"jargon2":{"r":"uuid_comparison_exp"},"jargon1":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"_or":{"r":"related_jargon_bool_exp"},"_not":{"r":"related_jargon_bool_exp"},"_and":{"r":"related_jargon_bool_exp"}},"related_jargon_aggregate_bool_exp":{"count":{"r":"related_jargon_aggregate_bool_exp_count"}},"jargon_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_bool_exp"}},"related_jargon_min_order_by":{},"string_comparison_exp":{},"translation_max_order_by":{},"comment_aggregate_order_by":{"min":{"r":"comment_min_order_by"},"max":{"r":"comment_max_order_by"}},"translation_min_order_by":{},"jargon_category_stddev_samp_order_by":{},"comment_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"int_comparison_exp":{},"jargon_max_order_by":{},"translation_aggregate_order_by":{"min":{"r":"translation_min_order_by"},"max":{"r":"translation_max_order_by"}},"jargon_category_sum_order_by":{},"comment_aggregate_bool_exp":{"count":{"r":"comment_aggregate_bool_exp_count"},"bool_or":{"r":"comment_aggregate_bool_exp_bool_or"},"bool_and":{"r":"comment_aggregate_bool_exp_bool_and"}},"jargon_category_bool_exp":{"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"category_id":{"r":"int_comparison_exp"},"category":{"r":"category_bool_exp"},"_or":{"r":"jargon_category_bool_exp"},"_not":{"r":"jargon_category_bool_exp"},"_and":{"r":"jargon_category_bool_exp"}},"jargon_category_min_order_by":{},"translation_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comment_id":{"r":"uuid_comparison_exp"},"comment":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"translation_bool_exp"},"_not":{"r":"translation_bool_exp"},"_and":{"r":"translation_bool_exp"}},"translation_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"translation_bool_exp"}},"user_bool_exp":{"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"photo_url":{"r":"string_comparison_exp"},"last_seen":{"r":"timestamptz_comparison_exp"},"jargons_aggregate":{"r":"jargon_aggregate_bool_exp"},"jargons":{"r":"jargon_bool_exp"},"id":{"r":"string_comparison_exp"},"email":{"r":"string_comparison_exp"},"display_name":{"r":"string_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"_or":{"r":"user_bool_exp"},"_not":{"r":"user_bool_exp"},"_and":{"r":"user_bool_exp"}},"translation_aggregate_bool_exp":{"count":{"r":"translation_aggregate_bool_exp_count"}},"boolean_comparison_exp":{},"jargon_aggregate_order_by":{"min":{"r":"jargon_min_order_by"},"max":{"r":"jargon_max_order_by"}},"jargon_aggregate_bool_exp":{"count":{"r":"jargon_aggregate_bool_exp_count"}},"jargon_category_avg_order_by":{},"jargon_category_stddev_pop_order_by":{},"jargon_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"related_jargons_aggregate":{"r":"related_jargon_aggregate_bool_exp"},"related_jargons":{"r":"related_jargon_bool_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name_lower":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"jargon_bool_exp"},"_not":{"r":"jargon_bool_exp"},"_and":{"r":"jargon_bool_exp"}},"jargon_category_max_order_by":{},"related_jargon_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"related_jargon_bool_exp"}},"jargon_min_order_by":{},"__root":{"onlyWithoutTranslationFilter":{"r":"jargon_bool_exp"},"directions":{"r":"jargon_order_by"}}}`
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
    json`{"__root":{"":{"f":""}}}`
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
    json`{"__root":{"":{"f":""}}}`
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
  type rawPreloadToken<'response> = {source: Js.Nullable.t<RescriptRelay.Observable.t<'response>>}
  external tokenToRaw: queryRef => rawPreloadToken<Types.response> = "%identity"
}
module Utils = {
  @@warning("-33")
  open Types
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
  external order_by_toString: RelaySchemaAssets_graphql.enum_order_by => string = "%identity"
  @live
  external order_by_input_toString: RelaySchemaAssets_graphql.enum_order_by_input => string = "%identity"
  @live
  let order_by_decode = (enum: RelaySchemaAssets_graphql.enum_order_by): option<RelaySchemaAssets_graphql.enum_order_by_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let order_by_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_order_by_input> => {
    order_by_decode(Obj.magic(str))
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
}

type relayOperationNode
type operationType = RescriptRelay.queryNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "categoryIDs"
  },
  {
    "defaultValue": 40,
    "kind": "LocalArgument",
    "name": "count"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "cursor"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "directions"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "onlyWithoutTranslationFilter"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "searchTerm"
  }
],
v1 = [
  {
    "fields": [
      {
        "kind": "Variable",
        "name": "_iregex",
        "variableName": "searchTerm"
      }
    ],
    "kind": "ObjectValue",
    "name": "name_lower_no_spaces"
  }
],
v2 = [
  {
    "kind": "Variable",
    "name": "after",
    "variableName": "cursor"
  },
  {
    "kind": "Variable",
    "name": "first",
    "variableName": "count"
  },
  {
    "kind": "Variable",
    "name": "order_by",
    "variableName": "directions"
  },
  {
    "fields": [
      {
        "items": [
          {
            "fields": [
              {
                "items": [
                  {
                    "fields": (v1/*: any*/),
                    "kind": "ObjectValue",
                    "name": "_or.0"
                  },
                  {
                    "fields": [
                      {
                        "fields": (v1/*: any*/),
                        "kind": "ObjectValue",
                        "name": "translations"
                      }
                    ],
                    "kind": "ObjectValue",
                    "name": "_or.1"
                  }
                ],
                "kind": "ListValue",
                "name": "_or"
              }
            ],
            "kind": "ObjectValue",
            "name": "_and.0"
          },
          {
            "fields": [
              {
                "items": [
                  {
                    "fields": [
                      {
                        "fields": [
                          {
                            "fields": [
                              {
                                "kind": "Variable",
                                "name": "_in",
                                "variableName": "categoryIDs"
                              }
                            ],
                            "kind": "ObjectValue",
                            "name": "category_id"
                          }
                        ],
                        "kind": "ObjectValue",
                        "name": "jargon_categories"
                      }
                    ],
                    "kind": "ObjectValue",
                    "name": "_or.0"
                  },
                  {
                    "kind": "Literal",
                    "name": "_or.1",
                    "value": {
                      "_not": {
                        "jargon_categories": {
                          "_and": ([]/*: any*/)
                        }
                      }
                    }
                  }
                ],
                "kind": "ListValue",
                "name": "_or"
              }
            ],
            "kind": "ObjectValue",
            "name": "_and.1"
          },
          {
            "fields": [
              {
                "kind": "Variable",
                "name": "_and",
                "variableName": "onlyWithoutTranslationFilter"
              }
            ],
            "kind": "ObjectValue",
            "name": "_and.2"
          }
        ],
        "kind": "ListValue",
        "name": "_and"
      }
    ],
    "kind": "ObjectValue",
    "name": "where"
  }
],
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v4 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v5 = {
  "name": "asc"
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "JargonListOrderRefetchQuery",
    "selections": [
      {
        "args": [
          {
            "kind": "Variable",
            "name": "count",
            "variableName": "count"
          },
          {
            "kind": "Variable",
            "name": "cursor",
            "variableName": "cursor"
          }
        ],
        "kind": "FragmentSpread",
        "name": "JargonListOrderQuery"
      }
    ],
    "type": "query_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "JargonListOrderRefetchQuery",
    "selections": [
      {
        "alias": null,
        "args": (v2/*: any*/),
        "concreteType": "jargonConnection",
        "kind": "LinkedField",
        "name": "jargon_connection",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "jargonEdge",
            "kind": "LinkedField",
            "name": "edges",
            "plural": true,
            "selections": [
              {
                "alias": null,
                "args": null,
                "concreteType": "jargon",
                "kind": "LinkedField",
                "name": "node",
                "plural": false,
                "selections": [
                  (v3/*: any*/),
                  (v4/*: any*/),
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "updated_at",
                    "storageKey": null
                  },
                  {
                    "alias": null,
                    "args": [
                      {
                        "kind": "Literal",
                        "name": "order_by",
                        "value": {
                          "category": (v5/*: any*/)
                        }
                      }
                    ],
                    "concreteType": "jargon_category",
                    "kind": "LinkedField",
                    "name": "jargon_categories",
                    "plural": true,
                    "selections": [
                      {
                        "alias": null,
                        "args": null,
                        "concreteType": "category",
                        "kind": "LinkedField",
                        "name": "category",
                        "plural": false,
                        "selections": [
                          {
                            "alias": null,
                            "args": null,
                            "kind": "ScalarField",
                            "name": "acronym",
                            "storageKey": null
                          },
                          (v3/*: any*/)
                        ],
                        "storageKey": null
                      },
                      (v3/*: any*/)
                    ],
                    "storageKey": "jargon_categories(order_by:{\"category\":{\"name\":\"asc\"}})"
                  },
                  {
                    "alias": null,
                    "args": [
                      {
                        "kind": "Literal",
                        "name": "limit",
                        "value": 20
                      },
                      {
                        "kind": "Literal",
                        "name": "order_by",
                        "value": (v5/*: any*/)
                      }
                    ],
                    "concreteType": "translation",
                    "kind": "LinkedField",
                    "name": "translations",
                    "plural": true,
                    "selections": [
                      (v3/*: any*/),
                      (v4/*: any*/)
                    ],
                    "storageKey": "translations(limit:20,order_by:{\"name\":\"asc\"})"
                  },
                  {
                    "alias": null,
                    "args": null,
                    "concreteType": "comment_aggregate",
                    "kind": "LinkedField",
                    "name": "comments_aggregate",
                    "plural": false,
                    "selections": [
                      {
                        "alias": null,
                        "args": null,
                        "concreteType": "comment_aggregate_fields",
                        "kind": "LinkedField",
                        "name": "aggregate",
                        "plural": false,
                        "selections": [
                          {
                            "alias": null,
                            "args": null,
                            "kind": "ScalarField",
                            "name": "count",
                            "storageKey": null
                          }
                        ],
                        "storageKey": null
                      }
                    ],
                    "storageKey": null
                  },
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "__typename",
                    "storageKey": null
                  }
                ],
                "storageKey": null
              },
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "cursor",
                "storageKey": null
              }
            ],
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "concreteType": "PageInfo",
            "kind": "LinkedField",
            "name": "pageInfo",
            "plural": false,
            "selections": [
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "endCursor",
                "storageKey": null
              },
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "hasNextPage",
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      },
      {
        "alias": null,
        "args": (v2/*: any*/),
        "filters": [
          "order_by",
          "where"
        ],
        "handle": "connection",
        "key": "JargonListOrderQuery_jargon_connection",
        "kind": "LinkedHandle",
        "name": "jargon_connection"
      }
    ]
  },
  "params": {
    "cacheID": "70725791c5141f1dd3e456833e88eefb",
    "id": null,
    "metadata": {},
    "name": "JargonListOrderRefetchQuery",
    "operationKind": "query",
    "text": "query JargonListOrderRefetchQuery(\n  $categoryIDs: [Int!]\n  $count: Int = 40\n  $cursor: String\n  $directions: [jargon_order_by!]\n  $onlyWithoutTranslationFilter: [jargon_bool_exp!]\n  $searchTerm: String\n) {\n  ...JargonListOrderQuery_1G22uz\n}\n\nfragment JargonCard_jargon on jargon {\n  id\n  name\n  updated_at\n  jargon_categories(order_by: {category: {name: asc}}) {\n    category {\n      acronym\n      id\n    }\n    id\n  }\n  translations(order_by: {name: asc}, limit: 20) {\n    id\n    name\n  }\n  comments_aggregate {\n    aggregate {\n      count\n    }\n  }\n}\n\nfragment JargonListOrderQuery_1G22uz on query_root {\n  jargon_connection(order_by: $directions, first: $count, after: $cursor, where: {_and: [{_or: [{name_lower_no_spaces: {_iregex: $searchTerm}}, {translations: {name_lower_no_spaces: {_iregex: $searchTerm}}}]}, {_or: [{jargon_categories: {category_id: {_in: $categoryIDs}}}, {_not: {jargon_categories: {_and: []}}}]}, {_and: $onlyWithoutTranslationFilter}]}) {\n    edges {\n      node {\n        id\n        ...JargonCard_jargon\n        __typename\n      }\n      cursor\n    }\n    pageInfo {\n      endCursor\n      hasNextPage\n    }\n  }\n}\n"
  }
};
})() `)

@live let load: (
  ~environment: RescriptRelay.Environment.t,
  ~variables: Types.variables,
  ~fetchPolicy: RescriptRelay.fetchPolicy=?,
  ~fetchKey: string=?,
  ~networkCacheConfig: RescriptRelay.cacheConfig=?,
) => queryRef = (
  ~environment,
  ~variables,
  ~fetchPolicy=?,
  ~fetchKey=?,
  ~networkCacheConfig=?,
) =>
  RescriptRelay.loadQuery(
    environment,
    node,
    variables->Internal.convertVariables,
    {
      fetchKey,
      fetchPolicy,
      networkCacheConfig,
    },
  )

@live
let queryRefToObservable = token => {
  let raw = token->Internal.tokenToRaw
  raw.source->Js.Nullable.toOption
}
  
@live
let queryRefToPromise = token => {
  Js.Promise.make((~resolve, ~reject as _) => {
    switch token->queryRefToObservable {
    | None => resolve(Error())
    | Some(o) =>
      open RescriptRelay.Observable
      let _: subscription = o->subscribe(makeObserver(~complete=() => resolve(Ok())))
    }
  })
}
