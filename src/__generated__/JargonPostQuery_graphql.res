/* @sourceLoc JargonPost.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec response_node_jargon_comments_aggregate_aggregate = {
    count: int,
  }
  and response_node_jargon_comments_aggregate = {
    aggregate: option<response_node_jargon_comments_aggregate_aggregate>,
  }
  and response_node_jargon_jargon_categories_category = {
    acronym: string,
  }
  and response_node_jargon_jargon_categories = {
    category: response_node_jargon_jargon_categories_category,
  }
  @tag("__typename") and response_node = 
    | @live @as("jargon") Jargon(
      {
        @live __typename: [ | #jargon],
        comments_aggregate: response_node_jargon_comments_aggregate,
        jargon_categories: array<response_node_jargon_jargon_categories>,
        name: string,
        fragmentRefs: RescriptRelay.fragmentRefs<[ | #CommentSection_jargon | #Translation_jargon]>,
      }
    )
    | @live @as("__unselected") UnselectedUnionMember(string)

  type response = {
    node: option<response_node>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    @live id: string,
  }
  @live
  type refetchVariables = {
    @live id: option<string>,
  }
  @live let makeRefetchVariables = (
    ~id=?,
  ): refetchVariables => {
    id: id
  }

}

@live
let unwrap_response_node: Types.response_node => Types.response_node = RescriptRelay_Internal.unwrapUnion(_, ["jargon"])
@live
let wrap_response_node: Types.response_node => Types.response_node = RescriptRelay_Internal.wrapUnion

type queryRef

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
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
    json`{"__root":{"node_jargon":{"f":""},"node":{"u":"response_node"}}}`
  )
  @live
  let wrapResponseConverterMap = {
    "response_node": wrap_response_node,
  }
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
    json`{"__root":{"node_jargon":{"f":""},"node":{"u":"response_node"}}}`
  )
  @live
  let responseConverterMap = {
    "response_node": unwrap_response_node,
  }
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
}

type relayOperationNode
type operationType = RescriptRelay.queryNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "id"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "id",
    "variableName": "id"
  }
],
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v4 = {
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
v5 = {
  "name": "asc"
},
v6 = [
  {
    "kind": "Literal",
    "name": "order_by",
    "value": {
      "category": (v5/*: any*/)
    }
  }
],
v7 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "acronym",
  "storageKey": null
},
v8 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v9 = [
  (v8/*: any*/)
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "JargonPostQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v3/*: any*/),
              (v4/*: any*/),
              {
                "alias": null,
                "args": (v6/*: any*/),
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
                      (v7/*: any*/)
                    ],
                    "storageKey": null
                  }
                ],
                "storageKey": "jargon_categories(order_by:{\"category\":{\"name\":\"asc\"}})"
              },
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "Translation_jargon"
              },
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "CommentSection_jargon"
              }
            ],
            "type": "jargon",
            "abstractKey": null
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
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "JargonPostQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v3/*: any*/),
              (v4/*: any*/),
              {
                "alias": null,
                "args": (v6/*: any*/),
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
                      (v7/*: any*/),
                      (v8/*: any*/)
                    ],
                    "storageKey": null
                  },
                  (v8/*: any*/)
                ],
                "storageKey": "jargon_categories(order_by:{\"category\":{\"name\":\"asc\"}})"
              },
              {
                "alias": null,
                "args": [
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
                  (v8/*: any*/),
                  (v3/*: any*/),
                  {
                    "alias": null,
                    "args": null,
                    "concreteType": "comment",
                    "kind": "LinkedField",
                    "name": "comment",
                    "plural": false,
                    "selections": (v9/*: any*/),
                    "storageKey": null
                  }
                ],
                "storageKey": "translations(order_by:{\"name\":\"asc\"})"
              },
              {
                "alias": null,
                "args": null,
                "concreteType": "commentConnection",
                "kind": "LinkedField",
                "name": "comments_connection",
                "plural": false,
                "selections": [
                  {
                    "alias": null,
                    "args": null,
                    "concreteType": "commentEdge",
                    "kind": "LinkedField",
                    "name": "edges",
                    "plural": true,
                    "selections": [
                      {
                        "alias": null,
                        "args": null,
                        "concreteType": "comment",
                        "kind": "LinkedField",
                        "name": "node",
                        "plural": false,
                        "selections": [
                          (v8/*: any*/),
                          {
                            "alias": null,
                            "args": null,
                            "kind": "ScalarField",
                            "name": "content",
                            "storageKey": null
                          },
                          {
                            "alias": null,
                            "args": null,
                            "kind": "ScalarField",
                            "name": "created_at",
                            "storageKey": null
                          },
                          {
                            "alias": null,
                            "args": null,
                            "concreteType": "comment",
                            "kind": "LinkedField",
                            "name": "parent",
                            "plural": false,
                            "selections": (v9/*: any*/),
                            "storageKey": null
                          },
                          {
                            "alias": null,
                            "args": null,
                            "concreteType": "user",
                            "kind": "LinkedField",
                            "name": "author",
                            "plural": false,
                            "selections": [
                              {
                                "alias": null,
                                "args": null,
                                "kind": "ScalarField",
                                "name": "photo_url",
                                "storageKey": null
                              },
                              {
                                "alias": null,
                                "args": null,
                                "kind": "ScalarField",
                                "name": "display_name",
                                "storageKey": null
                              },
                              (v8/*: any*/)
                            ],
                            "storageKey": null
                          },
                          {
                            "alias": null,
                            "args": null,
                            "concreteType": "translation",
                            "kind": "LinkedField",
                            "name": "translation",
                            "plural": false,
                            "selections": [
                              (v8/*: any*/),
                              (v3/*: any*/)
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
              },
              {
                "kind": "ClientExtension",
                "selections": [
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "__id",
                    "storageKey": null
                  }
                ]
              }
            ],
            "type": "jargon",
            "abstractKey": null
          },
          (v8/*: any*/)
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "48cfe7294454cf4024c5a38dcf762e7d",
    "id": null,
    "metadata": {},
    "name": "JargonPostQuery",
    "operationKind": "query",
    "text": "query JargonPostQuery(\n  $id: ID!\n) {\n  node(id: $id) {\n    __typename\n    ... on jargon {\n      name\n      comments_aggregate {\n        aggregate {\n          count\n        }\n      }\n      jargon_categories(order_by: {category: {name: asc}}) {\n        category {\n          acronym\n          id\n        }\n        id\n      }\n      ...Translation_jargon\n      ...CommentSection_jargon\n    }\n    id\n  }\n}\n\nfragment CommentSection_jargon on jargon {\n  comments_connection {\n    edges {\n      node {\n        id\n        content\n        created_at\n        parent {\n          id\n        }\n        author {\n          photo_url\n          display_name\n          id\n        }\n        translation {\n          id\n          name\n        }\n      }\n    }\n  }\n}\n\nfragment Translation_jargon on jargon {\n  translations(order_by: {name: asc}) {\n    id\n    name\n    comment {\n      id\n    }\n  }\n}\n"
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
