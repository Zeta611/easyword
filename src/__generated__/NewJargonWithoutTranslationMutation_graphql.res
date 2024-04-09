/* @sourceLoc NewJargon.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live
  type rec response_insert_jargon_one = {
    @live id: string,
  }
  @live
  type response = {
    insert_jargon_one: option<response_insert_jargon_one>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    authorID: string,
    comment: string,
    commentID: string,
    @live id: string,
    name: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"id":{"b":""},"commentID":{"b":""}}}`
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
    json`{}`
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
    json`{}`
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
}
module Utils = {
  @@warning("-33")
  open Types
}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "authorID"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "comment"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "commentID"
},
v3 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "id"
},
v4 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "name"
},
v5 = {
  "kind": "Variable",
  "name": "author_id",
  "variableName": "authorID"
},
v6 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          (v5/*: any*/),
          {
            "fields": [
              {
                "fields": [
                  (v5/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "content",
                    "variableName": "comment"
                  },
                  {
                    "kind": "Variable",
                    "name": "id",
                    "variableName": "commentID"
                  }
                ],
                "kind": "ObjectValue",
                "name": "data"
              }
            ],
            "kind": "ObjectValue",
            "name": "comments"
          },
          {
            "kind": "Variable",
            "name": "id",
            "variableName": "id"
          },
          {
            "kind": "Variable",
            "name": "name",
            "variableName": "name"
          }
        ],
        "kind": "ObjectValue",
        "name": "object"
      }
    ],
    "concreteType": "jargon",
    "kind": "LinkedField",
    "name": "insert_jargon_one",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "id",
        "storageKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/),
      (v2/*: any*/),
      (v3/*: any*/),
      (v4/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewJargonWithoutTranslationMutation",
    "selections": (v6/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v3/*: any*/),
      (v0/*: any*/),
      (v4/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "NewJargonWithoutTranslationMutation",
    "selections": (v6/*: any*/)
  },
  "params": {
    "cacheID": "5ff7db89164a849973f0d2ec468bbd64",
    "id": null,
    "metadata": {},
    "name": "NewJargonWithoutTranslationMutation",
    "operationKind": "mutation",
    "text": "mutation NewJargonWithoutTranslationMutation(\n  $id: uuid!\n  $authorID: String!\n  $name: String!\n  $commentID: uuid!\n  $comment: String!\n) {\n  insert_jargon_one(object: {id: $id, author_id: $authorID, name: $name, comments: {data: {id: $commentID, author_id: $authorID, content: $comment}}}) {\n    id\n  }\n}\n"
  }
};
})() `)


