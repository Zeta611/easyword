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
  and response_update_jargon_by_pk = {
    @live id: string,
  }
  @live
  type response = {
    insert_comment_one: option<response_insert_comment_one>,
    update_jargon_by_pk: option<response_update_jargon_by_pk>,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    authorID: string,
    content: string,
    jargonID: string,
    now: string,
    parentID: string,
  }
}

module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"parentID":{"b":""},"now":{"b":""},"jargonID":{"b":""}}}`
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
  "name": "content"
},
v2 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "jargonID"
},
v3 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "now"
},
v4 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "parentID"
},
v5 = [
  {
    "alias": null,
    "args": null,
    "kind": "ScalarField",
    "name": "id",
    "storageKey": null
  }
],
v6 = [
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
    "selections": (v5/*: any*/),
    "storageKey": null
  },
  {
    "alias": null,
    "args": [
      {
        "fields": [
          {
            "kind": "Variable",
            "name": "updated_at",
            "variableName": "now"
          }
        ],
        "kind": "ObjectValue",
        "name": "_set"
      },
      {
        "fields": [
          {
            "kind": "Variable",
            "name": "id",
            "variableName": "jargonID"
          }
        ],
        "kind": "ObjectValue",
        "name": "pk_columns"
      }
    ],
    "concreteType": "jargon",
    "kind": "LinkedField",
    "name": "update_jargon_by_pk",
    "plural": false,
    "selections": (v5/*: any*/),
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
    "name": "CommentRowMutation",
    "selections": (v6/*: any*/),
    "type": "mutation_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/),
      (v2/*: any*/),
      (v4/*: any*/),
      (v3/*: any*/)
    ],
    "kind": "Operation",
    "name": "CommentRowMutation",
    "selections": (v6/*: any*/)
  },
  "params": {
    "cacheID": "80aa57994b6dbbafbc93308d75b9f2ee",
    "id": null,
    "metadata": {},
    "name": "CommentRowMutation",
    "operationKind": "mutation",
    "text": "mutation CommentRowMutation(\n  $authorID: String!\n  $content: String!\n  $jargonID: uuid!\n  $parentID: uuid!\n  $now: timestamptz!\n) {\n  insert_comment_one(object: {author_id: $authorID, content: $content, jargon_id: $jargonID, parent_id: $parentID}) {\n    id\n  }\n  update_jargon_by_pk(pk_columns: {id: $jargonID}, _set: {updated_at: $now}) {\n    id\n  }\n}\n"
  }
};
})() `)


