/* @sourceLoc NewTranslation.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live
  type rec response_insert_translation_one = {
    @live id: string,
  }
  @live
  type response = {
    insert_translation_one: option<response_insert_translation_one>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    authorID: string,
    comment: string,
    commentID: string,
    @live id: string,
    jargonID: string,
    name: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"jargonID":{"b":""},"id":{"b":""},"commentID":{"b":""}}}`
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
  "name": "jargonID"
},
v5 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "name"
},
v6 = {
  "kind": "Variable",
  "name": "author_id",
  "variableName": "authorID"
},
v7 = {
  "kind": "Variable",
  "name": "jargon_id",
  "variableName": "jargonID"
},
v8 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          (v6/*: any*/),
          {
            "fields": [
              {
                "fields": [
                  (v6/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "content",
                    "variableName": "comment"
                  },
                  {
                    "kind": "Variable",
                    "name": "id",
                    "variableName": "commentID"
                  },
                  (v7/*: any*/)
                ],
                "kind": "ObjectValue",
                "name": "data"
              }
            ],
            "kind": "ObjectValue",
            "name": "comment"
          },
          {
            "kind": "Variable",
            "name": "comment_id",
            "variableName": "commentID"
          },
          {
            "kind": "Variable",
            "name": "id",
            "variableName": "id"
          },
          (v7/*: any*/),
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
    "concreteType": "translation",
    "kind": "LinkedField",
    "name": "insert_translation_one",
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
      (v4/*: any*/),
      (v5/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewTranslationMutation",
    "selections": (v8/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v3/*: any*/),
      (v4/*: any*/),
      (v0/*: any*/),
      (v5/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "NewTranslationMutation",
    "selections": (v8/*: any*/)
  },
  "params": {
    "cacheID": "e049aef1333f794217834529753a5c57",
    "id": null,
    "metadata": {},
    "name": "NewTranslationMutation",
    "operationKind": "mutation",
    "text": "mutation NewTranslationMutation(\n  $id: uuid!\n  $jargonID: uuid!\n  $authorID: String!\n  $name: String!\n  $commentID: uuid!\n  $comment: String!\n) {\n  insert_translation_one(object: {id: $id, jargon_id: $jargonID, author_id: $authorID, name: $name, comment_id: $commentID, comment: {data: {id: $commentID, jargon_id: $jargonID, author_id: $authorID, content: $comment}}}) {\n    id\n  }\n}\n"
  }
};
})() `)


