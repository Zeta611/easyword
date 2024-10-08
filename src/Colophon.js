// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Core__Option from "@rescript/core/src/Core__Option.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptRelay_Query from "rescript-relay/src/RescriptRelay_Query.js";
import * as ColophonQuery_graphql from "./__generated__/ColophonQuery_graphql.js";

var convertVariables = ColophonQuery_graphql.Internal.convertVariables;

var convertResponse = ColophonQuery_graphql.Internal.convertResponse;

var convertWrapRawResponse = ColophonQuery_graphql.Internal.convertWrapRawResponse;

var use = RescriptRelay_Query.useQuery(convertVariables, ColophonQuery_graphql.node, convertResponse);

var useLoader = RescriptRelay_Query.useLoader(convertVariables, ColophonQuery_graphql.node, (function (prim) {
        return prim;
      }));

var usePreloaded = RescriptRelay_Query.usePreloaded(ColophonQuery_graphql.node, convertResponse, (function (prim) {
        return prim;
      }));

var $$fetch = RescriptRelay_Query.$$fetch(ColophonQuery_graphql.node, convertResponse, convertVariables);

var fetchPromised = RescriptRelay_Query.fetchPromised(ColophonQuery_graphql.node, convertResponse, convertVariables);

var retain = RescriptRelay_Query.retain(ColophonQuery_graphql.node, convertVariables);

var ColophonQuery = {
  Operation: undefined,
  Types: undefined,
  convertVariables: convertVariables,
  convertResponse: convertResponse,
  convertWrapRawResponse: convertWrapRawResponse,
  use: use,
  useLoader: useLoader,
  usePreloaded: usePreloaded,
  $$fetch: $$fetch,
  fetchPromised: fetchPromised,
  retain: retain
};

function Colophon(props) {
  var match = use(undefined, undefined, undefined, undefined);
  var data = Core__Option.map(match.html_connection.edges[0], (function (edge) {
          return edge.node.data;
        }));
  if (data !== undefined) {
    return JsxRuntime.jsxs("article", {
                children: [
                  JsxRuntime.jsx("h1", {
                        children: "제작기"
                      }),
                  JsxRuntime.jsx("div", {
                        children: JsxRuntime.jsx("a", {
                              children: "서울대학교 프로그래밍 연구실 이재호",
                              href: "http://ropas.snu.ac.kr/~jhlee/"
                            }),
                        className: "text-right text-sm"
                      }),
                  JsxRuntime.jsx("div", {
                        className: "divider"
                      }),
                  JsxRuntime.jsx("div", {
                        dangerouslySetInnerHTML: {
                          __html: data
                        }
                      })
                ],
                className: "px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose"
              });
  } else {
    return null;
  }
}

var make = Colophon;

export {
  ColophonQuery ,
  make ,
}
/* use Not a pure module */
