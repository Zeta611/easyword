/* @sourceLoc JargonList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec response_jargon_connection_edges_node_comments_aggregate_aggregate = {
    count: int,
  }
  and response_jargon_connection_edges_node_comments_aggregate = {
    aggregate: option<response_jargon_connection_edges_node_comments_aggregate_aggregate>,
  }
  and response_jargon_connection_edges_node_translations = {
    @live id: string,
    name: string,
  }
  and response_jargon_connection_edges_node = {
    comments_aggregate: response_jargon_connection_edges_node_comments_aggregate,
    @live id: string,
    name: string,
    translations: array<response_jargon_connection_edges_node_translations>,
    updated_at: string,
  }
  and response_jargon_connection_edges = {
    node: response_jargon_connection_edges_node,
  }
  and response_jargon_connection = {
    edges: array<response_jargon_connection_edges>,
  }
  type response = {
    jargon_connection: response_jargon_connection,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    direction: RelaySchemaAssets_graphql.enum_order_by_input,
  }
  @live
  type refetchVariables = {
    direction: option<RelaySchemaAssets_graphql.enum_order_by_input>,
  }
  @live let makeRefetchVariables = (
    ~direction=?,
  ): refetchVariables => {
    direction: direction
  }

}


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
    json`{"__root":{"jargon_connection_edges_node_updated_at":{"b":""}}}`
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
    json`{"__root":{"jargon_connection_edges_node_updated_at":{"b":""}}}`
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
    "name": "direction"
  }
],
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v3 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Literal",
        "name": "first",
        "value": 40
      },
      {
        "items": [
          {
            "fields": [
              {
                "kind": "Variable",
                "name": "name",
                "variableName": "direction"
              }
            ],
            "kind": "ObjectValue",
            "name": "order_by.0"
          },
          {
            "kind": "Literal",
            "name": "order_by.1",
            "value": {
              "updated_at": "desc"
            }
          }
        ],
        "kind": "ListValue",
        "name": "order_by"
      }
    ],
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
              (v1/*: any*/),
              (v2/*: any*/),
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
                    "name": "limit",
                    "value": 20
                  },
                  {
                    "kind": "Literal",
                    "name": "order_by",
                    "value": {
                      "name": "asc"
                    }
                  }
                ],
                "concreteType": "translation",
                "kind": "LinkedField",
                "name": "translations",
                "plural": true,
                "selections": [
                  (v1/*: any*/),
                  (v2/*: any*/)
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
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "JargonListABCOrderQuery",
    "selections": (v3/*: any*/),
    "type": "query_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "JargonListABCOrderQuery",
    "selections": (v3/*: any*/)
  },
  "params": {
    "cacheID": "763281684efd22f79880b134dc640fbd",
    "id": null,
    "metadata": {},
    "name": "JargonListABCOrderQuery",
    "operationKind": "query",
    "text": "query JargonListABCOrderQuery(\n  $direction: order_by!\n) @cached {\n  jargon_connection(order_by: [{name: $direction}, {updated_at: desc}], first: 40) {\n    edges {\n      node {\n        id\n        name\n        updated_at\n        translations(order_by: {name: asc}, limit: 20) {\n          id\n          name\n        }\n        comments_aggregate {\n          aggregate {\n            count\n          }\n        }\n      }\n    }\n  }\n}\n"
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
