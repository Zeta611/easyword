/* @sourceLoc JargonRandomList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

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
  type rec response_list_jargon_random_connection_edges_node = {
    @live id: string,
    fragmentRefs: RescriptRelay.fragmentRefs<[ | #JargonCard_jargon]>,
  }
  and response_list_jargon_random_connection_edges = {
    node: response_list_jargon_random_connection_edges_node,
  }
  and response_list_jargon_random_connection = {
    edges: array<response_list_jargon_random_connection_edges>,
  }
  type response = {
    list_jargon_random_connection: response_list_jargon_random_connection,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    categoryIDs: array<int>,
    onlyWithoutTranslationFilter: array<jargon_bool_exp>,
    seed: string,
  }
  @live
  type refetchVariables = {
    categoryIDs: option<array<int>>,
    onlyWithoutTranslationFilter: option<array<jargon_bool_exp>>,
    seed: option<string>,
  }
  @live let makeRefetchVariables = (
    ~categoryIDs=?,
    ~onlyWithoutTranslationFilter=?,
    ~seed=?,
  ): refetchVariables => {
    categoryIDs: categoryIDs,
    onlyWithoutTranslationFilter: onlyWithoutTranslationFilter,
    seed: seed
  }

}


type queryRef

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"string_comparison_exp":{},"int_comparison_exp":{},"comment_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"comment_aggregate_bool_exp_bool_or":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"category_bool_exp":{"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"int_comparison_exp"},"acronym":{"r":"string_comparison_exp"},"_or":{"r":"category_bool_exp"},"_not":{"r":"category_bool_exp"},"_and":{"r":"category_bool_exp"}},"timestamptz_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"jargon_category_bool_exp":{"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"category_id":{"r":"int_comparison_exp"},"category":{"r":"category_bool_exp"},"_or":{"r":"jargon_category_bool_exp"},"_not":{"r":"jargon_category_bool_exp"},"_and":{"r":"jargon_category_bool_exp"}},"jargon_category_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_category_bool_exp"}},"comment_aggregate_bool_exp":{"count":{"r":"comment_aggregate_bool_exp_count"},"bool_or":{"r":"comment_aggregate_bool_exp_bool_or"},"bool_and":{"r":"comment_aggregate_bool_exp_bool_and"}},"jargon_category_aggregate_bool_exp":{"count":{"r":"jargon_category_aggregate_bool_exp_count"}},"translation_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comment_id":{"r":"uuid_comparison_exp"},"comment":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"translation_bool_exp"},"_not":{"r":"translation_bool_exp"},"_and":{"r":"translation_bool_exp"}},"translation_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"translation_bool_exp"}},"user_bool_exp":{"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"photo_url":{"r":"string_comparison_exp"},"last_seen":{"r":"timestamptz_comparison_exp"},"jargons_aggregate":{"r":"jargon_aggregate_bool_exp"},"jargons":{"r":"jargon_bool_exp"},"id":{"r":"string_comparison_exp"},"email":{"r":"string_comparison_exp"},"display_name":{"r":"string_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"_or":{"r":"user_bool_exp"},"_not":{"r":"user_bool_exp"},"_and":{"r":"user_bool_exp"}},"boolean_comparison_exp":{},"translation_aggregate_bool_exp":{"count":{"r":"translation_aggregate_bool_exp_count"}},"uuid_comparison_exp":{"_nin":{"b":"a"},"_neq":{"b":""},"_lte":{"b":""},"_lt":{"b":""},"_in":{"b":"a"},"_gte":{"b":""},"_gt":{"b":""},"_eq":{"b":""}},"comment_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translation_id":{"r":"uuid_comparison_exp"},"translation":{"r":"translation_bool_exp"},"removed":{"r":"boolean_comparison_exp"},"parent_id":{"r":"uuid_comparison_exp"},"parent":{"r":"comment_bool_exp"},"jargon_id":{"r":"uuid_comparison_exp"},"jargon":{"r":"jargon_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"content":{"r":"string_comparison_exp"},"children_aggregate":{"r":"comment_aggregate_bool_exp"},"children":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"comment_bool_exp"},"_not":{"r":"comment_bool_exp"},"_and":{"r":"comment_bool_exp"}},"jargon_aggregate_bool_exp":{"count":{"r":"jargon_aggregate_bool_exp_count"}},"jargon_aggregate_bool_exp_count":{"predicate":{"r":"int_comparison_exp"},"filter":{"r":"jargon_bool_exp"}},"jargon_bool_exp":{"updated_at":{"r":"timestamptz_comparison_exp"},"translations_aggregate":{"r":"translation_aggregate_bool_exp"},"translations":{"r":"translation_bool_exp"},"name_lower_no_spaces":{"r":"string_comparison_exp"},"name_lower":{"r":"string_comparison_exp"},"name":{"r":"string_comparison_exp"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_bool_exp"},"jargon_categories":{"r":"jargon_category_bool_exp"},"id":{"r":"uuid_comparison_exp"},"created_at":{"r":"timestamptz_comparison_exp"},"comments_aggregate":{"r":"comment_aggregate_bool_exp"},"comments":{"r":"comment_bool_exp"},"author_id":{"r":"string_comparison_exp"},"author":{"r":"user_bool_exp"},"_or":{"r":"jargon_bool_exp"},"_not":{"r":"jargon_bool_exp"},"_and":{"r":"jargon_bool_exp"}},"comment_aggregate_bool_exp_bool_and":{"predicate":{"r":"boolean_comparison_exp"},"filter":{"r":"comment_bool_exp"}},"__root":{"seed":{"b":""},"onlyWithoutTranslationFilter":{"r":"jargon_bool_exp"}}}`
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
    json`{"__root":{"list_jargon_random_connection_edges_node":{"f":""}}}`
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
    json`{"__root":{"list_jargon_random_connection_edges_node":{"f":""}}}`
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
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "categoryIDs"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "onlyWithoutTranslationFilter"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "seed"
},
v3 = [
  {
    "fields": [
      {
        "kind": "Variable",
        "name": "seed",
        "variableName": "seed"
      }
    ],
    "kind": "ObjectValue",
    "name": "args"
  },
  {
    "kind": "Literal",
    "name": "first",
    "value": 40
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
            "name": "_and.0"
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
            "name": "_and.1"
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
v4 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v5 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v6 = {
  "name": "asc"
};
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/),
      (v2/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "JargonRandomListOrderQuery",
    "selections": [
      {
        "alias": null,
        "args": (v3/*: any*/),
        "concreteType": "jargonConnection",
        "kind": "LinkedField",
        "name": "list_jargon_random_connection",
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
                  (v4/*: any*/),
                  {
                    "args": null,
                    "kind": "FragmentSpread",
                    "name": "JargonCard_jargon"
                  }
                ],
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "type": "query_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v2/*: any*/),
      (v0/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "JargonRandomListOrderQuery",
    "selections": [
      {
        "alias": null,
        "args": (v3/*: any*/),
        "concreteType": "jargonConnection",
        "kind": "LinkedField",
        "name": "list_jargon_random_connection",
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
                  (v4/*: any*/),
                  (v5/*: any*/),
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
                          "category": (v6/*: any*/)
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
                          (v4/*: any*/)
                        ],
                        "storageKey": null
                      },
                      (v4/*: any*/)
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
                        "value": (v6/*: any*/)
                      }
                    ],
                    "concreteType": "translation",
                    "kind": "LinkedField",
                    "name": "translations",
                    "plural": true,
                    "selections": [
                      (v4/*: any*/),
                      (v5/*: any*/)
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
                  }
                ],
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "058d2e69943871a0e6b1b832bfd93b6f",
    "id": null,
    "metadata": {},
    "name": "JargonRandomListOrderQuery",
    "operationKind": "query",
    "text": "query JargonRandomListOrderQuery(\n  $seed: seed_float!\n  $categoryIDs: [Int!]!\n  $onlyWithoutTranslationFilter: [jargon_bool_exp!]!\n) {\n  list_jargon_random_connection(args: {seed: $seed}, where: {_and: [{_or: [{jargon_categories: {category_id: {_in: $categoryIDs}}}, {_not: {jargon_categories: {_and: []}}}]}, {_and: $onlyWithoutTranslationFilter}]}, first: 40) {\n    edges {\n      node {\n        id\n        ...JargonCard_jargon\n      }\n    }\n  }\n}\n\nfragment JargonCard_jargon on jargon {\n  id\n  name\n  updated_at\n  jargon_categories(order_by: {category: {name: asc}}) {\n    category {\n      acronym\n      id\n    }\n    id\n  }\n  translations(order_by: {name: asc}, limit: 20) {\n    id\n    name\n  }\n  comments_aggregate {\n    aggregate {\n      count\n    }\n  }\n}\n"
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
