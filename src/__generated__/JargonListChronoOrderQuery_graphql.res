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
  RescriptRelay.fragmentRefs<[> | #JargonListChronoOrderQuery]> => fragmentRef = "%identity"

@live
@inline
let connectionKey = "JargonListChronoOrderQuery_jargon_connection"

%%private(
  @live @module("relay-runtime") @scope("ConnectionHandler")
  external internal_makeConnectionId: (RescriptRelay.dataId, @as("JargonListChronoOrderQuery_jargon_connection") _, 'arguments) => RescriptRelay.dataId = "getConnectionID"
)

@live
let makeConnectionId = (connectionParentDataId: RescriptRelay.dataId, ~direction: option<RelaySchemaAssets_graphql.enum_order_by>=?) => {
  let args = {"order_by": [RescriptRelay_Internal.Arg({"updated_at": direction}), RescriptRelay_Internal.Arg(Some({"name": Some("asc")}))]}
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


%%private(let makeNode = (rescript_graphql_node_JargonListChronoOrderRefetchQuery): operationType => {
  ignore(rescript_graphql_node_JargonListChronoOrderRefetchQuery)
  %raw(json`(function(){
var v0 = [
  "jargon_connection"
];
return {
  "argumentDefinitions": [
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
      "name": "direction"
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
      "operation": rescript_graphql_node_JargonListChronoOrderRefetchQuery
    }
  },
  "name": "JargonListChronoOrderQuery",
  "selections": [
    {
      "alias": "jargon_connection",
      "args": [
        {
          "items": [
            {
              "fields": [
                {
                  "kind": "Variable",
                  "name": "updated_at",
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
                "name": "asc"
              }
            }
          ],
          "kind": "ListValue",
          "name": "order_by"
        }
      ],
      "concreteType": "jargonConnection",
      "kind": "LinkedField",
      "name": "__JargonListChronoOrderQuery_jargon_connection_connection",
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
let node: operationType = makeNode(JargonListChronoOrderRefetchQuery_graphql.node)

