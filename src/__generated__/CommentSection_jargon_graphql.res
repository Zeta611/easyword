/* @sourceLoc CommentSection.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec fragment_comments_connection_edges_node_author = {
    display_name: string,
    photo_url: option<string>,
  }
  and fragment_comments_connection_edges_node_parent = {
    @live id: string,
  }
  and fragment_comments_connection_edges_node_translation = {
    @live id: string,
    name: string,
  }
  and fragment_comments_connection_edges_node = {
    author: fragment_comments_connection_edges_node_author,
    content: string,
    created_at: string,
    @live id: string,
    parent: option<fragment_comments_connection_edges_node_parent>,
    translation: option<fragment_comments_connection_edges_node_translation>,
  }
  and fragment_comments_connection_edges = {
    node: fragment_comments_connection_edges_node,
  }
  and fragment_comments_connection = {
    edges: array<fragment_comments_connection_edges>,
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

module Utils = {
  @@warning("-33")
  open Types
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
  "metadata": null,
  "name": "CommentSection_jargon",
  "selections": [
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
                    }
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
                    (v0/*: any*/),
                    {
                      "alias": null,
                      "args": null,
                      "kind": "ScalarField",
                      "name": "name",
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

