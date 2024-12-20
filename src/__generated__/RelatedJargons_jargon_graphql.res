/* @sourceLoc RelatedJargons.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  type rec fragment_related_jargons_jargon = {
    @live id: string,
    name: string,
  }
  and fragment_related_jargons = {
    jargon: fragment_related_jargons_jargon,
  }
  type fragment = {
    related_jargons: array<fragment_related_jargons>,
  }
}

module Internal = {
  @live
  type fragmentRaw
  @live
  let fragmentConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
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
  RescriptRelay.fragmentRefs<[> | #RelatedJargons_jargon]> => fragmentRef = "%identity"

module Utils = {
  @@warning("-33")
  open Types
}

type relayOperationNode
type operationType = RescriptRelay.fragmentNode<relayOperationNode>


let node: operationType = %raw(json` {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "RelatedJargons_jargon",
  "selections": [
    {
      "alias": null,
      "args": null,
      "concreteType": "related_jargon",
      "kind": "LinkedField",
      "name": "related_jargons",
      "plural": true,
      "selections": [
        {
          "alias": null,
          "args": null,
          "concreteType": "jargon",
          "kind": "LinkedField",
          "name": "jargon",
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
  "type": "jargon",
  "abstractKey": null
} `)

