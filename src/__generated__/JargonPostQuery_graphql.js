// Generated by ReScript, PLEASE EDIT WITH CARE
/* @generated */

import * as Caml_option from "../../node_modules/rescript/lib/es6/caml_option.js";
import * as ReactRelay from "react-relay";
import * as RescriptRelay from "../../node_modules/rescript-relay/src/RescriptRelay.js";
import * as RescriptRelay_Internal from "../../node_modules/rescript-relay/src/RescriptRelay_Internal.js";

function makeRefetchVariables(id) {
  return {
          id: id
        };
}

var Types = {
  makeRefetchVariables: makeRefetchVariables
};

function unwrap_response_node(__x) {
  return RescriptRelay_Internal.unwrapUnion(__x, ["jargon"]);
}

var variablesConverter = {};

function convertVariables(v) {
  return RescriptRelay.convertObj(v, variablesConverter, undefined, undefined);
}

var wrapResponseConverter = {"__root":{"node_jargon":{"f":""},"node":{"u":"response_node"}}};

var wrapResponseConverterMap = {
  response_node: RescriptRelay_Internal.wrapUnion
};

function convertWrapResponse(v) {
  return RescriptRelay.convertObj(v, wrapResponseConverter, wrapResponseConverterMap, null);
}

var responseConverter = {"__root":{"node_jargon":{"f":""},"node":{"u":"response_node"}}};

var responseConverterMap = {
  response_node: unwrap_response_node
};

function convertResponse(v) {
  return RescriptRelay.convertObj(v, responseConverter, responseConverterMap, undefined);
}

var Internal = {
  variablesConverter: variablesConverter,
  variablesConverterMap: undefined,
  convertVariables: convertVariables,
  wrapResponseConverter: wrapResponseConverter,
  wrapResponseConverterMap: wrapResponseConverterMap,
  convertWrapResponse: convertWrapResponse,
  responseConverter: responseConverter,
  responseConverterMap: responseConverterMap,
  convertResponse: convertResponse,
  convertWrapRawResponse: convertWrapResponse,
  convertRawResponse: convertResponse
};

var Utils = {};

var node = ((function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "id"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "id",
    "variableName": "id"
  }
],
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v4 = {
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
},
v5 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v6 = [
  (v5/*: any*/)
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "JargonPostQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v3/*: any*/),
              (v4/*: any*/),
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "Translation_jargon"
              },
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "CommentSection_jargon"
              }
            ],
            "type": "jargon",
            "abstractKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "type": "query_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "JargonPostQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v3/*: any*/),
              (v4/*: any*/),
              {
                "alias": null,
                "args": [
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
                  (v5/*: any*/),
                  (v3/*: any*/),
                  {
                    "alias": null,
                    "args": null,
                    "concreteType": "comment",
                    "kind": "LinkedField",
                    "name": "comment",
                    "plural": false,
                    "selections": (v6/*: any*/),
                    "storageKey": null
                  }
                ],
                "storageKey": "translations(order_by:{\"name\":\"asc\"})"
              },
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
                          (v5/*: any*/),
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
                            "selections": (v6/*: any*/),
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
                              },
                              (v5/*: any*/)
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
                              (v5/*: any*/),
                              (v3/*: any*/)
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
          },
          (v5/*: any*/)
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "adbe0b1a300a8863ecef969f7a186f05",
    "id": null,
    "metadata": {},
    "name": "JargonPostQuery",
    "operationKind": "query",
    "text": "query JargonPostQuery(\n  $id: ID!\n) {\n  node(id: $id) {\n    __typename\n    ... on jargon {\n      name\n      comments_aggregate {\n        aggregate {\n          count\n        }\n      }\n      ...Translation_jargon\n      ...CommentSection_jargon\n    }\n    id\n  }\n}\n\nfragment CommentSection_jargon on jargon {\n  comments_connection {\n    edges {\n      node {\n        id\n        content\n        created_at\n        parent {\n          id\n        }\n        author {\n          photo_url\n          display_name\n          id\n        }\n        translation {\n          id\n          name\n        }\n      }\n    }\n  }\n}\n\nfragment Translation_jargon on jargon {\n  translations(order_by: {name: asc}) {\n    id\n    name\n    comment {\n      id\n    }\n  }\n}\n"
  }
};
})());

function load(environment, variables, fetchPolicy, fetchKey, networkCacheConfig) {
  return ReactRelay.loadQuery(environment, node, convertVariables(variables), {
              fetchKey: fetchKey,
              fetchPolicy: fetchPolicy,
              networkCacheConfig: networkCacheConfig
            });
}

function queryRefToObservable(token) {
  return Caml_option.nullable_to_opt(token.source);
}

function queryRefToPromise(token) {
  return new Promise((function (resolve, param) {
                var o = queryRefToObservable(token);
                if (o !== undefined) {
                  Caml_option.valFromOption(o).subscribe({
                        complete: (function () {
                            resolve({
                                  TAG: "Ok",
                                  _0: undefined
                                });
                          })
                      });
                  return ;
                } else {
                  return resolve({
                              TAG: "Error",
                              _0: undefined
                            });
                }
              }));
}

var wrap_response_node = RescriptRelay_Internal.wrapUnion;

export {
  Types ,
  unwrap_response_node ,
  wrap_response_node ,
  Internal ,
  Utils ,
  node ,
  load ,
  queryRefToObservable ,
  queryRefToPromise ,
}
/* node Not a pure module */
