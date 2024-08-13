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
    searchTerm?: string,
  }
  @live
  type refetchVariables = {
    categoryIDs: option<option<array<int>>>,
    count: option<option<int>>,
    cursor: option<option<string>>,
    directions: option<option<array<jargon_order_by>>>,
    searchTerm: option<option<string>>,
  }
  @live let makeRefetchVariables = (
    ~categoryIDs=?,
    ~count=?,
    ~cursor=?,
    ~directions=?,
    ~searchTerm=?,
  ): refetchVariables => {
    categoryIDs: categoryIDs,
    count: count,
    cursor: cursor,
    directions: directions,
    searchTerm: searchTerm
  }

}


type queryRef

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"jargon_category_aggregate_order_by":{"variance":{"r":"jargon_category_variance_order_by"},"var_samp":{"r":"jargon_category_var_samp_order_by"},"var_pop":{"r":"jargon_category_var_pop_order_by"},"sum":{"r":"jargon_category_sum_order_by"},"stddev_samp":{"r":"jargon_category_stddev_samp_order_by"},"stddev_pop":{"r":"jargon_category_stddev_pop_order_by"},"stddev":{"r":"jargon_category_stddev_order_by"},"min":{"r":"jargon_category_min_order_by"},"max":{"r":"jargon_category_max_order_by"},"avg":{"r":"jargon_category_avg_order_by"}},"jargon_category_variance_order_by":{},"translation_max_order_by":{},"comment_aggregate_order_by":{"min":{"r":"comment_min_order_by"},"max":{"r":"comment_max_order_by"}},"translation_min_order_by":{},"jargon_category_stddev_samp_order_by":{},"jargon_category_var_pop_order_by":{},"jargon_max_order_by":{},"translation_aggregate_order_by":{"min":{"r":"translation_min_order_by"},"max":{"r":"translation_max_order_by"}},"jargon_category_sum_order_by":{},"user_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"jargons_aggregate":{"r":"jargon_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"}},"comment_max_order_by":{},"jargon_category_min_order_by":{},"jargon_category_stddev_order_by":{},"jargon_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"jargon_categories_aggregate":{"r":"jargon_category_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"},"author":{"r":"user_order_by"}},"jargon_aggregate_order_by":{"min":{"r":"jargon_min_order_by"},"max":{"r":"jargon_max_order_by"}},"jargon_category_var_samp_order_by":{},"jargon_category_avg_order_by":{},"comment_min_order_by":{},"jargon_category_max_order_by":{},"jargon_category_stddev_pop_order_by":{},"jargon_min_order_by":{},"__root":{"directions":{"r":"jargon_order_by"}}}`
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
    "cacheID": "c6825e770bd4b7f4e97d1de84c4cc529",
    "id": null,
    "metadata": {},
    "name": "JargonListOrderRefetchQuery",
    "operationKind": "query",
    "text": "query JargonListOrderRefetchQuery(\n  $categoryIDs: [Int!]\n  $count: Int = 40\n  $cursor: String\n  $directions: [jargon_order_by!]\n  $searchTerm: String\n) {\n  ...JargonListOrderQuery_1G22uz\n}\n\nfragment JargonCard_jargon on jargon {\n  id\n  name\n  updated_at\n  jargon_categories(order_by: {category: {name: asc}}) {\n    category {\n      acronym\n      id\n    }\n    id\n  }\n  translations(order_by: {name: asc}, limit: 20) {\n    id\n    name\n  }\n  comments_aggregate {\n    aggregate {\n      count\n    }\n  }\n}\n\nfragment JargonListOrderQuery_1G22uz on query_root {\n  jargon_connection(order_by: $directions, first: $count, after: $cursor, where: {_and: [{_or: [{name_lower_no_spaces: {_iregex: $searchTerm}}, {translations: {name_lower_no_spaces: {_iregex: $searchTerm}}}]}, {_or: [{jargon_categories: {category_id: {_in: $categoryIDs}}}, {_not: {jargon_categories: {_and: []}}}]}]}) {\n    edges {\n      node {\n        id\n        ...JargonCard_jargon\n        __typename\n      }\n      cursor\n    }\n    pageInfo {\n      endCursor\n      hasNextPage\n    }\n  }\n}\n"
  }
};
})() `)

let load: (
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
  
let queryRefToObservable = token => {
  let raw = token->Internal.tokenToRaw
  raw.source->Js.Nullable.toOption
}
  
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
