/* @sourceLoc JargonList.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec fragment_jargon_connection_edges_node = {
    @live id: string,
    fragmentRefs: RescriptRelay.fragmentRefs<[ | #JargonCard_jargon]>,
  }
  and fragment_jargon_connection_edges = {
    node: fragment_jargon_connection_edges_node,
  }
  and fragment_jargon_connection = {
    edges: array<fragment_jargon_connection_edges>,
  }
  type fragment = {
    jargon_connection: fragment_jargon_connection,
  }
}

module Internal = {
  @live
  type fragmentRaw
  @live
  let fragmentConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"jargon_connection_edges_node":{"f":""}}}`
  )
  @live
  let fragmentConverterMap = ()
  @live
  let convertFragment = v => v->RescriptRelay.convertObj(
    fragmentConverter,
    fragmentConverterMap,
    Js.undefined
  )
}

type t
type fragmentRef
external getFragmentRef:
  RescriptRelay.fragmentRefs<[> | #JargonListOrderQuery]> => fragmentRef = "%identity"

@live
@inline
let connectionKey = "JargonListOrderQuery_jargon_connection"

%%private(
  @live @module("relay-runtime") @scope("ConnectionHandler")
  external internal_makeConnectionId: (RescriptRelay.dataId, @as("JargonListOrderQuery_jargon_connection") _, 'arguments) => RescriptRelay.dataId = "getConnectionID"
)

@live
let makeConnectionId = (connectionParentDataId: RescriptRelay.dataId, ~directions: option<array<RelaySchemaAssets_graphql.input_jargon_order_by>>=?, ~searchTerm: option<string>=?, ~categoryIDs: option<array<int>>=?) => {
  let args = {"order_by": directions, "where": {"_and": [RescriptRelay_Internal.Arg({"_or": [RescriptRelay_Internal.Arg({"name_lower_no_spaces": {"_iregex": searchTerm}}), RescriptRelay_Internal.Arg({"translations": {"name_lower_no_spaces": {"_iregex": searchTerm}}})]}), RescriptRelay_Internal.Arg({"_or": [RescriptRelay_Internal.Arg({"jargon_categories": {"category_id": {"_in": categoryIDs}}}), RescriptRelay_Internal.Arg(Some({"_not": Some({"jargon_categories": Some({"_and": Some([])})})}))]})]}}
  internal_makeConnectionId(connectionParentDataId, args)
}
module Utils = {
  @@warning("-33")
  open Types

  @live
  let getConnectionNodes: Types.fragment_jargon_connection => array<Types.fragment_jargon_connection_edges_node> = connection => 
  connection.edges
    ->Belt.Array.keepMap(edge => 
Some(edge.node)
    )


}

type relayOperationNode
type operationType = RescriptRelay.fragmentNode<relayOperationNode>


%%private(let makeNode = (rescript_graphql_node_JargonListOrderRefetchQuery): operationType => {
  ignore(rescript_graphql_node_JargonListOrderRefetchQuery)
  %raw(json`(function(){
var v0 = [
  "jargon_connection"
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
];
return {
  "argumentDefinitions": [
    {
      "kind": "RootArgument",
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
      "kind": "RootArgument",
      "name": "directions"
    },
    {
      "kind": "RootArgument",
      "name": "searchTerm"
    }
  ],
  "kind": "Fragment",
  "metadata": {
    "connection": [
      {
        "count": "count",
        "cursor": "cursor",
        "direction": "forward",
        "path": (v0/*: any*/)
      }
    ],
    "refetch": {
      "connection": {
        "forward": {
          "count": "count",
          "cursor": "cursor"
        },
        "backward": null,
        "path": (v0/*: any*/)
      },
      "fragmentPathInResult": [],
      "operation": rescript_graphql_node_JargonListOrderRefetchQuery
    }
  },
  "name": "JargonListOrderQuery",
  "selections": [
    {
      "alias": "jargon_connection",
      "args": [
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
                                "_and": []
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
      "concreteType": "jargonConnection",
      "kind": "LinkedField",
      "name": "__JargonListOrderQuery_jargon_connection_connection",
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
                {
                  "alias": null,
                  "args": null,
                  "kind": "ScalarField",
                  "name": "id",
                  "storageKey": null
                },
                {
                  "args": null,
                  "kind": "FragmentSpread",
                  "name": "JargonCard_jargon"
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
    }
  ],
  "type": "query_root",
  "abstractKey": null
};
})()`)
})
let node: operationType = makeNode(JargonListOrderRefetchQuery_graphql.node)

