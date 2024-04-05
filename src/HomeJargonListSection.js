// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Loader from "./Loader.js";
import * as JargonList from "./JargonList.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptRelay_Query from "../node_modules/rescript-relay/src/RescriptRelay_Query.js";
import * as HomeJargonListSectionQuery_graphql from "./__generated__/HomeJargonListSectionQuery_graphql.js";

var convertVariables = HomeJargonListSectionQuery_graphql.Internal.convertVariables;

var convertResponse = HomeJargonListSectionQuery_graphql.Internal.convertResponse;

var convertWrapRawResponse = HomeJargonListSectionQuery_graphql.Internal.convertWrapRawResponse;

var use = RescriptRelay_Query.useQuery(convertVariables, HomeJargonListSectionQuery_graphql.node, convertResponse);

var useLoader = RescriptRelay_Query.useLoader(convertVariables, HomeJargonListSectionQuery_graphql.node, (function (prim) {
        return prim;
      }));

var usePreloaded = RescriptRelay_Query.usePreloaded(HomeJargonListSectionQuery_graphql.node, convertResponse, (function (prim) {
        return prim;
      }));

var $$fetch = RescriptRelay_Query.$$fetch(HomeJargonListSectionQuery_graphql.node, convertResponse, convertVariables);

var fetchPromised = RescriptRelay_Query.fetchPromised(HomeJargonListSectionQuery_graphql.node, convertResponse, convertVariables);

var retain = RescriptRelay_Query.retain(HomeJargonListSectionQuery_graphql.node, convertVariables);

var HomeJargonListSectionQuery_order_by_decode = HomeJargonListSectionQuery_graphql.Utils.order_by_decode;

var HomeJargonListSectionQuery_order_by_fromString = HomeJargonListSectionQuery_graphql.Utils.order_by_fromString;

var HomeJargonListSectionQuery = {
  order_by_decode: HomeJargonListSectionQuery_order_by_decode,
  order_by_fromString: HomeJargonListSectionQuery_order_by_fromString,
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

function HomeJargonListSection(props) {
  var tmp;
  tmp = props.axis === "English" ? [
      {
        name_lower: props.direction === "asc" ? "asc" : "desc"
      },
      {
        created_at: "desc"
      }
    ] : [
      {
        created_at: "desc"
      },
      {
        name_lower: "asc"
      }
    ];
  var match = use({
        directions: tmp,
        searchTerm: props.searchTerm
      }, undefined, undefined, undefined);
  return JsxRuntime.jsx(React.Suspense, {
              children: Caml_option.some(JsxRuntime.jsx(JargonList.make, {
                        query: match.fragmentRefs
                      })),
              fallback: Caml_option.some(JsxRuntime.jsx("div", {
                        children: JsxRuntime.jsx(Loader.make, {}),
                        className: "h-screen grid justify-center content-center"
                      }))
            });
}

var make = HomeJargonListSection;

export {
  HomeJargonListSectionQuery ,
  make ,
}
/* use Not a pure module */
