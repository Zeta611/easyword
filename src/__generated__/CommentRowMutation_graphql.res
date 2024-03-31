/* @sourceLoc CommentRow.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live
  type rec response_insert_comment_one = {
    @live id: string,
  }
  @live
  type response = {
    insert_comment_one: option<response_insert_comment_one>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    authorID: string,
    content: string,
    jargonID: int,
    parentID: int,
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
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "authorID"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "content"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "jargonID"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "parentID"
  }
],
v1 = [
  {
    "alias": null,
    "args": [
      {
        "fields": [
          {
            "kind": "Variable",
            "name": "author_id",
            "variableName": "authorID"
          },
          {
            "kind": "Variable",
            "name": "content",
            "variableName": "content"
          },
          {
            "kind": "Variable",
            "name": "jargon_id",
            "variableName": "jargonID"
          },
          {
            "kind": "Variable",
            "name": "parent_id",
            "variableName": "parentID"
          }
        ],
        "kind": "ObjectValue",
        "name": "object"
      }
    ],
    "concreteType": "comment",
    "kind": "LinkedField",
    "name": "insert_comment_one",
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
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "CommentRowMutation",
    "selections": (v1/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "CommentRowMutation",
    "selections": (v1/*: any*/)
  },
  "params": {
    "cacheID": "7b186093a97740cd6d674309700bc7d6",
    "id": null,
    "metadata": {},
    "name": "CommentRowMutation",
    "operationKind": "mutation",
    "text": "mutation CommentRowMutation(\n  $authorID: String!\n  $content: String!\n  $jargonID: Int!\n  $parentID: Int!\n) {\n  insert_comment_one(object: {author_id: $authorID, content: $content, jargon_id: $jargonID, parent_id: $parentID}) {\n    id\n  }\n}\n"
  }
};
})() `)


