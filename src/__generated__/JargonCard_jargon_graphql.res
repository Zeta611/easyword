/* @sourceLoc JargonCard.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec fragment_comments_aggregate_aggregate = {
    count: int,
  }
  and fragment_comments_aggregate = {
    aggregate: option<fragment_comments_aggregate_aggregate>,
  }
  and fragment_translations = {
    @live id: string,
    name: string,
  }
  type fragment = {
    comments_aggregate: fragment_comments_aggregate,
    @live id: string,
    name: string,
    translations: array<fragment_translations>,
    updated_at: string,
  }
}

module Internal = {
  @live
  type fragmentRaw
  @live
  let fragmentConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"updated_at":{"b":""}}}`
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
  RescriptRelay.fragmentRefs<[> | #JargonCard_jargon]> => fragmentRef = "%identity"

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
},
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
};
return {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "JargonCard_jargon",
  "selections": [
    (v0/*: any*/),
    (v1/*: any*/),
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
        (v0/*: any*/),
        (v1/*: any*/)
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
  "type": "jargon",
  "abstractKey": null
};
})() `)

