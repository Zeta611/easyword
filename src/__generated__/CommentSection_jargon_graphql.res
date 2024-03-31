/* @sourceLoc CommentSection.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec fragment_comments_connection_edges_node_parent = {
    @live id: string,
  }
  and fragment_comments_connection_edges_node_user = {
    display_name: string,
    photo_url: option<string>,
  }
  and fragment_comments_connection_edges_node = {
    content: string,
    created_at: string,
    @live id: string,
    parent: option<fragment_comments_connection_edges_node_parent>,
    user: fragment_comments_connection_edges_node_user,
  }
  and fragment_comments_connection_edges = {
    node: fragment_comments_connection_edges_node,
  }
  and fragment_comments_connection_pageInfo = {
    endCursor: string,
    hasNextPage: bool,
  }
  and fragment_comments_connection = {
    edges: array<fragment_comments_connection_edges>,
    pageInfo: fragment_comments_connection_pageInfo,
  }
  type fragment = {
    @live __id: RescriptRelay.dataId,
    comments_connection: fragment_comments_connection,
  }
}

module Internal = {
  @live
  type fragmentRaw
  @live
  let fragmentConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"comments_connection_edges_node_created_at":{"b":""}}}`
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
  RescriptRelay.fragmentRefs<[> | #CommentSection_jargon]> => fragmentRef = "%identity"

@live
@inline
let connectionKey = "CommentSection_jargon_comments_connection"

%%private(
  @live @module("relay-runtime") @scope("ConnectionHandler")
  external internal_makeConnectionId: (RescriptRelay.dataId, @as("CommentSection_jargon_comments_connection") _, 'arguments) => RescriptRelay.dataId = "getConnectionID"
)

@live
let makeConnectionId = (connectionParentDataId: RescriptRelay.dataId, ) => {
  let args = ()
  internal_makeConnectionId(connectionParentDataId, args)
}
module Utils = {
  @@warning("-33")
  open Types

  @live
  let getConnectionNodes: Types.fragment_comments_connection => array<Types.fragment_comments_connection_edges_node> = connection => 
  connection.edges
    ->Belt.Array.keepMap(edge => 
Some(edge.node)
    )


}

type relayOperationNode
type operationType = RescriptRelay.fragmentNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
};
return {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": {
    "connection": [
      {
        "count": null,
        "cursor": null,
        "direction": "forward",
        "path": [
          "comments_connection"
        ]
      }
    ]
  },
  "name": "CommentSection_jargon",
  "selections": [
    {
      "alias": "comments_connection",
      "args": null,
      "concreteType": "commentConnection",
      "kind": "LinkedField",
      "name": "__CommentSection_jargon_comments_connection_connection",
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
                (v0/*: any*/),
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
                  "selections": [
                    (v0/*: any*/)
                  ],
                  "storageKey": null
                },
                {
                  "alias": null,
                  "args": null,
                  "concreteType": "user",
                  "kind": "LinkedField",
                  "name": "user",
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
              "name": "hasNextPage",
              "storageKey": null
            },
            {
              "alias": null,
              "args": null,
              "kind": "ScalarField",
              "name": "endCursor",
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
};
})() `)

