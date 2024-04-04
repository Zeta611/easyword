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
    translation: string,
    translationID: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"translationID":{"b":""},"id":{"b":""},"commentID":{"b":""}}}`
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
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "translation"
},
v6 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "translationID"
},
v7 = {
  "kind": "Variable",
  "name": "author_id",
  "variableName": "authorID"
},
v8 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          (v7/*: any*/),
          {
            "fields": [
              {
                "fields": [
                  (v7/*: any*/),
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
                  {
                    "kind": "Variable",
                    "name": "translation_id",
                    "variableName": "translationID"
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
          },
          {
            "fields": [
              {
                "fields": [
                  (v7/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "comment_id",
                    "variableName": "commentID"
                  },
                  {
                    "kind": "Variable",
                    "name": "id",
                    "variableName": "translationID"
                  },
                  {
                    "kind": "Variable",
                    "name": "name",
                    "variableName": "translation"
                  }
                ],
                "kind": "ObjectValue",
                "name": "data"
              }
            ],
            "kind": "ObjectValue",
            "name": "translations"
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
      (v4/*: any*/),
      (v5/*: any*/),
      (v6/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewJargonMutation",
    "selections": (v8/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v3/*: any*/),
      (v0/*: any*/),
      (v4/*: any*/),
      (v6/*: any*/),
      (v5/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "NewJargonMutation",
    "selections": (v8/*: any*/)
  },
  "params": {
    "cacheID": "a43c526da42b2fa6d6551f6f76c7db4d",
    "id": null,
    "metadata": {},
    "name": "NewJargonMutation",
    "operationKind": "mutation",
    "text": "mutation NewJargonMutation(\n  $id: uuid!\n  $authorID: String!\n  $name: String!\n  $translationID: uuid!\n  $translation: String!\n  $commentID: uuid!\n  $comment: String!\n) {\n  insert_jargon_one(object: {id: $id, author_id: $authorID, name: $name, comments: {data: {id: $commentID, author_id: $authorID, translation_id: $translationID, content: $comment}}, translations: {data: {id: $translationID, comment_id: $commentID, author_id: $authorID, name: $translation}}}) {\n    id\n  }\n}\n"
  }
};
})() `)


