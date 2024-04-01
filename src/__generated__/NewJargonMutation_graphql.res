/* @sourceLoc NewJargon.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live
  type rec response_insert_jargon_one_comments = {
    @live id: string,
  }
  @live
  and response_insert_jargon_one = {
    comments: array<response_insert_jargon_one_comments>,
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
    commentContent: string,
    name: string,
  }
}

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
  "name": "commentContent"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "name"
},
v3 = {
  "kind": "Variable",
  "name": "author_id",
  "variableName": "authorID"
},
v4 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v5 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          (v3/*: any*/),
          {
            "fields": [
              {
                "fields": [
                  (v3/*: any*/),
                  {
                    "kind": "Variable",
                    "name": "content",
                    "variableName": "commentContent"
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
      (v4/*: any*/),
      {
        "alias": null,
        "args": null,
        "concreteType": "comment",
        "kind": "LinkedField",
        "name": "comments",
        "plural": true,
        "selections": [
          (v4/*: any*/)
        ],
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
      (v2/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "NewJargonMutation",
    "selections": (v5/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v2/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Operation",
    "name": "NewJargonMutation",
    "selections": (v5/*: any*/)
  },
  "params": {
    "cacheID": "6c05766065fc630b85a0bd2cc43f206e",
    "id": null,
    "metadata": {},
    "name": "NewJargonMutation",
    "operationKind": "mutation",
    "text": "mutation NewJargonMutation(\n  $authorID: String!\n  $name: String!\n  $commentContent: String!\n) {\n  insert_jargon_one(object: {author_id: $authorID, name: $name, comments: {data: {author_id: $authorID, content: $commentContent}}}) {\n    id\n    comments {\n      id\n    }\n  }\n}\n"
  }
};
})() `)


