// Generated by ReScript, PLEASE EDIT WITH CARE
/* @generated */

import * as Caml_option from "../../node_modules/rescript/lib/es6/caml_option.js";
import * as ReactRelay from "react-relay";
import * as RescriptRelay from "../../node_modules/rescript-relay/src/RescriptRelay.js";

function makeRefetchVariables(directions, searchTerm) {
  return {
          directions: directions,
          searchTerm: searchTerm
        };
}

var Types = {
  makeRefetchVariables: makeRefetchVariables
};

var variablesConverter = {"translation_max_order_by":{},"comment_aggregate_order_by":{"min":{"r":"comment_min_order_by"},"max":{"r":"comment_max_order_by"}},"translation_min_order_by":{},"jargon_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"},"author":{"r":"user_order_by"}},"jargon_aggregate_order_by":{"min":{"r":"jargon_min_order_by"},"max":{"r":"jargon_max_order_by"}},"jargon_max_order_by":{},"translation_aggregate_order_by":{"min":{"r":"translation_min_order_by"},"max":{"r":"translation_max_order_by"}},"comment_min_order_by":{},"user_order_by":{"translations_aggregate":{"r":"translation_aggregate_order_by"},"jargons_aggregate":{"r":"jargon_aggregate_order_by"},"comments_aggregate":{"r":"comment_aggregate_order_by"}},"comment_max_order_by":{},"jargon_min_order_by":{},"__root":{"directions":{"r":"jargon_order_by"}}};

function convertVariables(v) {
  return RescriptRelay.convertObj(v, variablesConverter, undefined, undefined);
}

var wrapResponseConverter = {"__root":{"":{"f":""}}};

function convertWrapResponse(v) {
  return RescriptRelay.convertObj(v, wrapResponseConverter, undefined, null);
}

var responseConverter = {"__root":{"":{"f":""}}};

function convertResponse(v) {
  return RescriptRelay.convertObj(v, responseConverter, undefined, undefined);
}

var Internal = {
  variablesConverter: variablesConverter,
  variablesConverterMap: undefined,
  convertVariables: convertVariables,
  wrapResponseConverter: wrapResponseConverter,
  wrapResponseConverterMap: undefined,
  convertWrapResponse: convertWrapResponse,
  responseConverter: responseConverter,
  responseConverterMap: undefined,
  convertResponse: convertResponse,
  convertWrapRawResponse: convertWrapResponse,
  convertRawResponse: convertResponse
};

function order_by_decode($$enum) {
  if ($$enum === "desc_nulls_first" || $$enum === "desc" || $$enum === "asc_nulls_last" || $$enum === "asc_nulls_first" || $$enum === "asc" || $$enum === "desc_nulls_last") {
    return $$enum;
  }
  
}

function order_by_fromString(str) {
  return order_by_decode(str);
}

var Utils = {
  order_by_decode: order_by_decode,
  order_by_fromString: order_by_fromString
};

var node = ((function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "directions"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "searchTerm"
},
v2 = [
  {
    "kind": "Literal",
    "name": "first",
    "value": 40
  },
  {
    "kind": "Variable",
    "name": "order_by",
    "variableName": "directions"
  },
  {
    "fields": [
      {
        "fields": [
          {
            "kind": "Variable",
            "name": "_iregex",
            "variableName": "searchTerm"
          }
        ],
        "kind": "ObjectValue",
        "name": "name"
      }
    ],
    "kind": "ObjectValue",
    "name": "where"
  }
],
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v4 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "HomeQuery",
    "selections": [
      {
        "args": null,
        "kind": "FragmentSpread",
        "name": "JargonListOrderQuery"
      }
    ],
    "type": "query_root",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v1/*: any*/),
      (v0/*: any*/)
    ],
    "kind": "Operation",
    "name": "HomeQuery",
    "selections": [
      {
        "alias": null,
        "args": (v2/*: any*/),
        "concreteType": "jargonConnection",
        "kind": "LinkedField",
        "name": "jargon_connection",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "jargonEdge",
            "kind": "LinkedField",
            "name": "edges",
            "plural": true,
            "selections": [
              {
                "alias": null,
                "args": null,
                "concreteType": "jargon",
                "kind": "LinkedField",
                "name": "node",
                "plural": false,
                "selections": [
                  (v3/*: any*/),
                  (v4/*: any*/),
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
                      (v3/*: any*/),
                      (v4/*: any*/)
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
                  },
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "__typename",
                    "storageKey": null
                  }
                ],
                "storageKey": null
              },
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "cursor",
                "storageKey": null
              }
            ],
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "concreteType": "PageInfo",
            "kind": "LinkedField",
            "name": "pageInfo",
            "plural": false,
            "selections": [
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "endCursor",
                "storageKey": null
              },
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "hasNextPage",
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      },
      {
        "alias": null,
        "args": (v2/*: any*/),
        "filters": [
          "order_by",
          "where"
        ],
        "handle": "connection",
        "key": "JargonListOrderQuery_jargon_connection",
        "kind": "LinkedHandle",
        "name": "jargon_connection"
      }
    ]
  },
  "params": {
    "cacheID": "5db767d8783b87c0f335afe6b6bc23f0",
    "id": null,
    "metadata": {},
    "name": "HomeQuery",
    "operationKind": "query",
    "text": "query HomeQuery(\n  $searchTerm: String!\n  $directions: [jargon_order_by!]!\n) {\n  ...JargonListOrderQuery\n}\n\nfragment JargonCard_jargon on jargon {\n  id\n  name\n  updated_at\n  translations(order_by: {name: asc}, limit: 20) {\n    id\n    name\n  }\n  comments_aggregate {\n    aggregate {\n      count\n    }\n  }\n}\n\nfragment JargonListOrderQuery on query_root {\n  jargon_connection(order_by: $directions, first: 40, where: {name: {_iregex: $searchTerm}}) {\n    edges {\n      node {\n        id\n        ...JargonCard_jargon\n        __typename\n      }\n      cursor\n    }\n    pageInfo {\n      endCursor\n      hasNextPage\n    }\n  }\n}\n"
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

export {
  Types ,
  Internal ,
  Utils ,
  node ,
  load ,
  queryRefToObservable ,
  queryRefToPromise ,
}
/* node Not a pure module */
