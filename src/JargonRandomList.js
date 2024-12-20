// Generated by ReScript, PLEASE EDIT WITH CARE

import * as JargonCard from "./JargonCard.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptRelay_Query from "rescript-relay/src/RescriptRelay_Query.js";
import * as JargonRandomListOrderQuery_graphql from "./__generated__/JargonRandomListOrderQuery_graphql.js";

var convertVariables = JargonRandomListOrderQuery_graphql.Internal.convertVariables;

var convertResponse = JargonRandomListOrderQuery_graphql.Internal.convertResponse;

var convertWrapRawResponse = JargonRandomListOrderQuery_graphql.Internal.convertWrapRawResponse;

var use = RescriptRelay_Query.useQuery(convertVariables, JargonRandomListOrderQuery_graphql.node, convertResponse);

var useLoader = RescriptRelay_Query.useLoader(convertVariables, JargonRandomListOrderQuery_graphql.node, (function (prim) {
        return prim;
      }));

var usePreloaded = RescriptRelay_Query.usePreloaded(JargonRandomListOrderQuery_graphql.node, convertResponse, (function (prim) {
        return prim;
      }));

var $$fetch = RescriptRelay_Query.$$fetch(JargonRandomListOrderQuery_graphql.node, convertResponse, convertVariables);

var fetchPromised = RescriptRelay_Query.fetchPromised(JargonRandomListOrderQuery_graphql.node, convertResponse, convertVariables);

var retain = RescriptRelay_Query.retain(JargonRandomListOrderQuery_graphql.node, convertVariables);

var JargonRandomListOrderQuery_comment_select_column_decode = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_decode;

var JargonRandomListOrderQuery_comment_select_column_fromString = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_fromString;

var JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode;

var JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString;

var JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode;

var JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString = JargonRandomListOrderQuery_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString;

var JargonRandomListOrderQuery_jargon_category_select_column_decode = JargonRandomListOrderQuery_graphql.Utils.jargon_category_select_column_decode;

var JargonRandomListOrderQuery_jargon_category_select_column_fromString = JargonRandomListOrderQuery_graphql.Utils.jargon_category_select_column_fromString;

var JargonRandomListOrderQuery_jargon_select_column_decode = JargonRandomListOrderQuery_graphql.Utils.jargon_select_column_decode;

var JargonRandomListOrderQuery_jargon_select_column_fromString = JargonRandomListOrderQuery_graphql.Utils.jargon_select_column_fromString;

var JargonRandomListOrderQuery_related_jargon_select_column_decode = JargonRandomListOrderQuery_graphql.Utils.related_jargon_select_column_decode;

var JargonRandomListOrderQuery_related_jargon_select_column_fromString = JargonRandomListOrderQuery_graphql.Utils.related_jargon_select_column_fromString;

var JargonRandomListOrderQuery_translation_select_column_decode = JargonRandomListOrderQuery_graphql.Utils.translation_select_column_decode;

var JargonRandomListOrderQuery_translation_select_column_fromString = JargonRandomListOrderQuery_graphql.Utils.translation_select_column_fromString;

var JargonRandomListOrderQuery = {
  comment_select_column_decode: JargonRandomListOrderQuery_comment_select_column_decode,
  comment_select_column_fromString: JargonRandomListOrderQuery_comment_select_column_fromString,
  comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode: JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode,
  comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString: JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString,
  comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode: JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode,
  comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString: JargonRandomListOrderQuery_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString,
  jargon_category_select_column_decode: JargonRandomListOrderQuery_jargon_category_select_column_decode,
  jargon_category_select_column_fromString: JargonRandomListOrderQuery_jargon_category_select_column_fromString,
  jargon_select_column_decode: JargonRandomListOrderQuery_jargon_select_column_decode,
  jargon_select_column_fromString: JargonRandomListOrderQuery_jargon_select_column_fromString,
  related_jargon_select_column_decode: JargonRandomListOrderQuery_related_jargon_select_column_decode,
  related_jargon_select_column_fromString: JargonRandomListOrderQuery_related_jargon_select_column_fromString,
  translation_select_column_decode: JargonRandomListOrderQuery_translation_select_column_decode,
  translation_select_column_fromString: JargonRandomListOrderQuery_translation_select_column_fromString,
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

function JargonRandomList(props) {
  var match = use({
        categoryIDs: props.categoryIDs,
        onlyWithoutTranslationFilter: props.onlyWithoutTranslation ? [{
              _not: {
                translations: {}
              }
            }] : [],
        seed: props.seed.toString()
      }, undefined, undefined, undefined);
  var rows = match.list_jargon_random_connection.edges.map(function (param) {
        var node = param.node;
        return [
                node.id,
                node.fragmentRefs
              ];
      });
  return JsxRuntime.jsx("div", {
              children: rows.map(function (param) {
                    return JsxRuntime.jsx("li", {
                                children: JsxRuntime.jsx(JargonCard.make, {
                                      jargonCardRef: param[1]
                                    }),
                                className: "flex flex-col gap-y-2 group cursor-pointer bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
                              }, param[0]);
                  }),
              className: "grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2 pb-10"
            });
}

var make = JargonRandomList;

export {
  JargonRandomListOrderQuery ,
  make ,
}
/* use Not a pure module */
