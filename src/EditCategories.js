// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Base64 from "./Base64.js";
import ReactSelect from "react-select";
import * as SignInContext from "./SignInContext.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.js";
import * as RescriptRelay_Query from "rescript-relay/src/RescriptRelay_Query.js";
import * as RescriptRelay_Mutation from "rescript-relay/src/RescriptRelay_Mutation.js";
import * as EditCategoriesMutation_graphql from "./__generated__/EditCategoriesMutation_graphql.js";
import * as EditCategoriesJargonQuery_graphql from "./__generated__/EditCategoriesJargonQuery_graphql.js";
import * as EditCategoriesCategoryQuery_graphql from "./__generated__/EditCategoriesCategoryQuery_graphql.js";

var convertVariables = EditCategoriesJargonQuery_graphql.Internal.convertVariables;

var convertResponse = EditCategoriesJargonQuery_graphql.Internal.convertResponse;

var convertWrapRawResponse = EditCategoriesJargonQuery_graphql.Internal.convertWrapRawResponse;

var use = RescriptRelay_Query.useQuery(convertVariables, EditCategoriesJargonQuery_graphql.node, convertResponse);

var useLoader = RescriptRelay_Query.useLoader(convertVariables, EditCategoriesJargonQuery_graphql.node, (function (prim) {
        return prim;
      }));

var usePreloaded = RescriptRelay_Query.usePreloaded(EditCategoriesJargonQuery_graphql.node, convertResponse, (function (prim) {
        return prim;
      }));

var $$fetch = RescriptRelay_Query.$$fetch(EditCategoriesJargonQuery_graphql.node, convertResponse, convertVariables);

var fetchPromised = RescriptRelay_Query.fetchPromised(EditCategoriesJargonQuery_graphql.node, convertResponse, convertVariables);

var retain = RescriptRelay_Query.retain(EditCategoriesJargonQuery_graphql.node, convertVariables);

var JargonQuery = {
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

var convertVariables$1 = EditCategoriesMutation_graphql.Internal.convertVariables;

var convertResponse$1 = EditCategoriesMutation_graphql.Internal.convertResponse;

var convertWrapRawResponse$1 = EditCategoriesMutation_graphql.Internal.convertWrapRawResponse;

var commitMutation = RescriptRelay_Mutation.commitMutation(convertVariables$1, EditCategoriesMutation_graphql.node, convertResponse$1, convertWrapRawResponse$1);

var use$1 = RescriptRelay_Mutation.useMutation(convertVariables$1, EditCategoriesMutation_graphql.node, convertResponse$1, convertWrapRawResponse$1);

var EditCategoriesMutation_category_constraint_decode = EditCategoriesMutation_graphql.Utils.category_constraint_decode;

var EditCategoriesMutation_category_constraint_fromString = EditCategoriesMutation_graphql.Utils.category_constraint_fromString;

var EditCategoriesMutation_category_update_column_decode = EditCategoriesMutation_graphql.Utils.category_update_column_decode;

var EditCategoriesMutation_category_update_column_fromString = EditCategoriesMutation_graphql.Utils.category_update_column_fromString;

var EditCategoriesMutation_comment_constraint_decode = EditCategoriesMutation_graphql.Utils.comment_constraint_decode;

var EditCategoriesMutation_comment_constraint_fromString = EditCategoriesMutation_graphql.Utils.comment_constraint_fromString;

var EditCategoriesMutation_comment_select_column_decode = EditCategoriesMutation_graphql.Utils.comment_select_column_decode;

var EditCategoriesMutation_comment_select_column_fromString = EditCategoriesMutation_graphql.Utils.comment_select_column_fromString;

var EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode = EditCategoriesMutation_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode;

var EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString = EditCategoriesMutation_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString;

var EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode = EditCategoriesMutation_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode;

var EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString = EditCategoriesMutation_graphql.Utils.comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString;

var EditCategoriesMutation_comment_update_column_decode = EditCategoriesMutation_graphql.Utils.comment_update_column_decode;

var EditCategoriesMutation_comment_update_column_fromString = EditCategoriesMutation_graphql.Utils.comment_update_column_fromString;

var EditCategoriesMutation_jargon_category_constraint_decode = EditCategoriesMutation_graphql.Utils.jargon_category_constraint_decode;

var EditCategoriesMutation_jargon_category_constraint_fromString = EditCategoriesMutation_graphql.Utils.jargon_category_constraint_fromString;

var EditCategoriesMutation_jargon_category_select_column_decode = EditCategoriesMutation_graphql.Utils.jargon_category_select_column_decode;

var EditCategoriesMutation_jargon_category_select_column_fromString = EditCategoriesMutation_graphql.Utils.jargon_category_select_column_fromString;

var EditCategoriesMutation_jargon_category_update_column_decode = EditCategoriesMutation_graphql.Utils.jargon_category_update_column_decode;

var EditCategoriesMutation_jargon_category_update_column_fromString = EditCategoriesMutation_graphql.Utils.jargon_category_update_column_fromString;

var EditCategoriesMutation_jargon_constraint_decode = EditCategoriesMutation_graphql.Utils.jargon_constraint_decode;

var EditCategoriesMutation_jargon_constraint_fromString = EditCategoriesMutation_graphql.Utils.jargon_constraint_fromString;

var EditCategoriesMutation_jargon_select_column_decode = EditCategoriesMutation_graphql.Utils.jargon_select_column_decode;

var EditCategoriesMutation_jargon_select_column_fromString = EditCategoriesMutation_graphql.Utils.jargon_select_column_fromString;

var EditCategoriesMutation_jargon_update_column_decode = EditCategoriesMutation_graphql.Utils.jargon_update_column_decode;

var EditCategoriesMutation_jargon_update_column_fromString = EditCategoriesMutation_graphql.Utils.jargon_update_column_fromString;

var EditCategoriesMutation_related_jargon_constraint_decode = EditCategoriesMutation_graphql.Utils.related_jargon_constraint_decode;

var EditCategoriesMutation_related_jargon_constraint_fromString = EditCategoriesMutation_graphql.Utils.related_jargon_constraint_fromString;

var EditCategoriesMutation_related_jargon_select_column_decode = EditCategoriesMutation_graphql.Utils.related_jargon_select_column_decode;

var EditCategoriesMutation_related_jargon_select_column_fromString = EditCategoriesMutation_graphql.Utils.related_jargon_select_column_fromString;

var EditCategoriesMutation_related_jargon_update_column_decode = EditCategoriesMutation_graphql.Utils.related_jargon_update_column_decode;

var EditCategoriesMutation_related_jargon_update_column_fromString = EditCategoriesMutation_graphql.Utils.related_jargon_update_column_fromString;

var EditCategoriesMutation_translation_constraint_decode = EditCategoriesMutation_graphql.Utils.translation_constraint_decode;

var EditCategoriesMutation_translation_constraint_fromString = EditCategoriesMutation_graphql.Utils.translation_constraint_fromString;

var EditCategoriesMutation_translation_select_column_decode = EditCategoriesMutation_graphql.Utils.translation_select_column_decode;

var EditCategoriesMutation_translation_select_column_fromString = EditCategoriesMutation_graphql.Utils.translation_select_column_fromString;

var EditCategoriesMutation_translation_update_column_decode = EditCategoriesMutation_graphql.Utils.translation_update_column_decode;

var EditCategoriesMutation_translation_update_column_fromString = EditCategoriesMutation_graphql.Utils.translation_update_column_fromString;

var EditCategoriesMutation_user_constraint_decode = EditCategoriesMutation_graphql.Utils.user_constraint_decode;

var EditCategoriesMutation_user_constraint_fromString = EditCategoriesMutation_graphql.Utils.user_constraint_fromString;

var EditCategoriesMutation_user_update_column_decode = EditCategoriesMutation_graphql.Utils.user_update_column_decode;

var EditCategoriesMutation_user_update_column_fromString = EditCategoriesMutation_graphql.Utils.user_update_column_fromString;

var EditCategoriesMutation = {
  category_constraint_decode: EditCategoriesMutation_category_constraint_decode,
  category_constraint_fromString: EditCategoriesMutation_category_constraint_fromString,
  category_update_column_decode: EditCategoriesMutation_category_update_column_decode,
  category_update_column_fromString: EditCategoriesMutation_category_update_column_fromString,
  comment_constraint_decode: EditCategoriesMutation_comment_constraint_decode,
  comment_constraint_fromString: EditCategoriesMutation_comment_constraint_fromString,
  comment_select_column_decode: EditCategoriesMutation_comment_select_column_decode,
  comment_select_column_fromString: EditCategoriesMutation_comment_select_column_fromString,
  comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode: EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_decode,
  comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString: EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_and_arguments_columns_fromString,
  comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode: EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_decode,
  comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString: EditCategoriesMutation_comment_select_column_comment_aggregate_bool_exp_bool_or_arguments_columns_fromString,
  comment_update_column_decode: EditCategoriesMutation_comment_update_column_decode,
  comment_update_column_fromString: EditCategoriesMutation_comment_update_column_fromString,
  jargon_category_constraint_decode: EditCategoriesMutation_jargon_category_constraint_decode,
  jargon_category_constraint_fromString: EditCategoriesMutation_jargon_category_constraint_fromString,
  jargon_category_select_column_decode: EditCategoriesMutation_jargon_category_select_column_decode,
  jargon_category_select_column_fromString: EditCategoriesMutation_jargon_category_select_column_fromString,
  jargon_category_update_column_decode: EditCategoriesMutation_jargon_category_update_column_decode,
  jargon_category_update_column_fromString: EditCategoriesMutation_jargon_category_update_column_fromString,
  jargon_constraint_decode: EditCategoriesMutation_jargon_constraint_decode,
  jargon_constraint_fromString: EditCategoriesMutation_jargon_constraint_fromString,
  jargon_select_column_decode: EditCategoriesMutation_jargon_select_column_decode,
  jargon_select_column_fromString: EditCategoriesMutation_jargon_select_column_fromString,
  jargon_update_column_decode: EditCategoriesMutation_jargon_update_column_decode,
  jargon_update_column_fromString: EditCategoriesMutation_jargon_update_column_fromString,
  related_jargon_constraint_decode: EditCategoriesMutation_related_jargon_constraint_decode,
  related_jargon_constraint_fromString: EditCategoriesMutation_related_jargon_constraint_fromString,
  related_jargon_select_column_decode: EditCategoriesMutation_related_jargon_select_column_decode,
  related_jargon_select_column_fromString: EditCategoriesMutation_related_jargon_select_column_fromString,
  related_jargon_update_column_decode: EditCategoriesMutation_related_jargon_update_column_decode,
  related_jargon_update_column_fromString: EditCategoriesMutation_related_jargon_update_column_fromString,
  translation_constraint_decode: EditCategoriesMutation_translation_constraint_decode,
  translation_constraint_fromString: EditCategoriesMutation_translation_constraint_fromString,
  translation_select_column_decode: EditCategoriesMutation_translation_select_column_decode,
  translation_select_column_fromString: EditCategoriesMutation_translation_select_column_fromString,
  translation_update_column_decode: EditCategoriesMutation_translation_update_column_decode,
  translation_update_column_fromString: EditCategoriesMutation_translation_update_column_fromString,
  user_constraint_decode: EditCategoriesMutation_user_constraint_decode,
  user_constraint_fromString: EditCategoriesMutation_user_constraint_fromString,
  user_update_column_decode: EditCategoriesMutation_user_update_column_decode,
  user_update_column_fromString: EditCategoriesMutation_user_update_column_fromString,
  Operation: undefined,
  Types: undefined,
  convertVariables: convertVariables$1,
  convertResponse: convertResponse$1,
  convertWrapRawResponse: convertWrapRawResponse$1,
  commitMutation: commitMutation,
  use: use$1
};

var convertVariables$2 = EditCategoriesCategoryQuery_graphql.Internal.convertVariables;

var convertResponse$2 = EditCategoriesCategoryQuery_graphql.Internal.convertResponse;

var convertWrapRawResponse$2 = EditCategoriesCategoryQuery_graphql.Internal.convertWrapRawResponse;

var use$2 = RescriptRelay_Query.useQuery(convertVariables$2, EditCategoriesCategoryQuery_graphql.node, convertResponse$2);

var useLoader$1 = RescriptRelay_Query.useLoader(convertVariables$2, EditCategoriesCategoryQuery_graphql.node, (function (prim) {
        return prim;
      }));

var usePreloaded$1 = RescriptRelay_Query.usePreloaded(EditCategoriesCategoryQuery_graphql.node, convertResponse$2, (function (prim) {
        return prim;
      }));

var $$fetch$1 = RescriptRelay_Query.$$fetch(EditCategoriesCategoryQuery_graphql.node, convertResponse$2, convertVariables$2);

var fetchPromised$1 = RescriptRelay_Query.fetchPromised(EditCategoriesCategoryQuery_graphql.node, convertResponse$2, convertVariables$2);

var retain$1 = RescriptRelay_Query.retain(EditCategoriesCategoryQuery_graphql.node, convertVariables$2);

var CategoryQuery = {
  Operation: undefined,
  Types: undefined,
  convertVariables: convertVariables$2,
  convertResponse: convertResponse$2,
  convertWrapRawResponse: convertWrapRawResponse$2,
  use: use$2,
  useLoader: useLoader$1,
  usePreloaded: usePreloaded$1,
  $$fetch: $$fetch$1,
  fetchPromised: fetchPromised$1,
  retain: retain$1
};

function EditCategories$MultiValueLabel(props) {
  var acronym = props.children.split(" ")[0];
  return JsxRuntime.jsx("div", {
              children: acronym,
              className: "badge badge-md ml-1"
            });
}

var MultiValueLabel = {
  make: EditCategories$MultiValueLabel
};

function jargonAndCategoryIDToGraphQLInput(jargonID) {
  return function (categoryID) {
    return {
            category_id: categoryID,
            jargon_id: jargonID
          };
  };
}

function EditCategories(props) {
  var jargonID = props.jargonID;
  var match = React.useContext(SignInContext.context);
  var user = match.user;
  var signedIn = match.signedIn;
  React.useEffect((function () {
          if (signedIn) {
            if (user == null) {
              RescriptReactRouter.replace("/logout");
            }
            
          } else {
            RescriptReactRouter.replace("/login");
          }
        }), []);
  var match$1 = React.useState(function () {
        return [];
      });
  var setCategoryIDs = match$1[1];
  var categoryIDs = match$1[0];
  var match$2 = use$1();
  var newTranslationMutate = match$2[0];
  var match$3 = use$2(undefined, undefined, undefined, undefined);
  var options = match$3.category_connection.edges.map(function (edge) {
        var match = edge.node;
        return {
                label: match.acronym + " (" + match.name + ")",
                value: Base64.retrieveOriginalIDInt(match.id)
              };
      });
  var match$4 = use({
        id: jargonID
      }, undefined, undefined, undefined);
  var node = match$4.node;
  React.useEffect((function () {
          if (node !== undefined && node.__typename === "jargon") {
            var jargon_categories = node.jargon_categories;
            setCategoryIDs(function (param) {
                  return jargon_categories.map(function (param) {
                              return param.category_id;
                            });
                });
          }
          
        }), [node]);
  var oldCategoryIDs = node !== undefined ? (
      node.__typename === "jargon" ? node.jargon_categories.map(function (param) {
              return param.category_id;
            }) : []
    ) : [];
  var newCategoryIDs = categoryIDs.filter(function (id) {
        return !oldCategoryIDs.includes(id);
      });
  var dropCategoryIDs = oldCategoryIDs.filter(function (id) {
        return !categoryIDs.includes(id);
      });
  var handleSubmit = function ($$event) {
    $$event.preventDefault();
    if (!signedIn) {
      return RescriptReactRouter.replace("/login");
    }
    var jargonID$1 = Base64.retrieveOriginalIDString(jargonID);
    if (jargonID$1 !== undefined) {
      newTranslationMutate({
            drop_categories: dropCategoryIDs,
            jargon_id: jargonID$1,
            new_jargon_categories: newCategoryIDs.map(jargonAndCategoryIDToGraphQLInput(jargonID$1))
          }, undefined, undefined, undefined, (function (param, _errors) {
              if (param.insert_jargon_category !== undefined) {
                return RescriptReactRouter.replace("/jargon/" + jargonID);
              } else {
                console.error("Translation mutation failed");
                return RescriptReactRouter.replace("/jargon/" + jargonID);
              }
            }), (function (error) {
              console.error(error);
            }), undefined);
      return ;
    }
    
  };
  if (node !== undefined && node.__typename === "jargon" && signedIn) {
    return JsxRuntime.jsxs("div", {
                children: [
                  JsxRuntime.jsx("h2", {
                        children: node.name + "의 분야 수정하기"
                      }),
                  JsxRuntime.jsx("form", {
                        children: JsxRuntime.jsxs("div", {
                              children: [
                                JsxRuntime.jsxs("label", {
                                      children: [
                                        JsxRuntime.jsx("label", {
                                              children: JsxRuntime.jsx("span", {
                                                    children: "분야",
                                                    className: "label-text"
                                                  }),
                                              className: "label"
                                            }),
                                        JsxRuntime.jsx(ReactSelect, {
                                              classNames: {
                                                control: (function (param) {
                                                    return "rounded-btn border text-base border-base-content/20 px-4 py-2";
                                                  }),
                                                menuList: (function (param) {
                                                    return "grid grid-cols-1 menu bg-zinc-50 dark:bg-zinc-800 rounded-box px-2 py-2 mt-1 text-base shadow-lg";
                                                  }),
                                                option: (function (param) {
                                                    return "hover:bg-zinc-200 dark:hover:bg-zinc-600 px-2 py-1 rounded-box";
                                                  })
                                              },
                                              components: {
                                                MultiValueLabel: EditCategories$MultiValueLabel
                                              },
                                              value: options.filter(function (param) {
                                                    return categoryIDs.includes(param.value);
                                                  }),
                                              onChange: (function (options) {
                                                  setCategoryIDs(function (param) {
                                                        return options.map(function (param) {
                                                                    return param.value;
                                                                  });
                                                      });
                                                }),
                                              options: options,
                                              isSearchable: false,
                                              isClearable: false,
                                              isMulti: true,
                                              unstyled: true,
                                              placeholder: "분야를 선택해주세요",
                                              noOptionsMessage: (function (param) {
                                                  return "더 이상의 분야가 없어요";
                                                })
                                            }),
                                        JsxRuntime.jsxs("label", {
                                              children: [
                                                JsxRuntime.jsx("span", {
                                                      className: "label-text-alt"
                                                    }),
                                                JsxRuntime.jsxs("span", {
                                                      children: [
                                                        "원하는 분야가 없으면 '",
                                                        JsxRuntime.jsx("a", {
                                                              children: "제작참여",
                                                              className: "link text-zinc-700",
                                                              href: "https://github.com/Zeta611/easyword/discussions"
                                                            }),
                                                        "'에서 요청해주세요"
                                                      ],
                                                      className: "label-text-alt text-zinc-700"
                                                    })
                                              ],
                                              className: "label"
                                            })
                                      ],
                                      className: "block"
                                    }),
                                JsxRuntime.jsx("input", {
                                      className: "btn btn-primary",
                                      disabled: match$2[1],
                                      type: "submit",
                                      value: "수정하기"
                                    })
                              ],
                              className: "grid grid-cols-1 gap-6"
                            }),
                        className: "mt-8 max-w-md",
                        onSubmit: handleSubmit
                      })
                ],
                className: "px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose"
              });
  } else {
    return null;
  }
}

var make = EditCategories;

export {
  JargonQuery ,
  EditCategoriesMutation ,
  CategoryQuery ,
  MultiValueLabel ,
  jargonAndCategoryIDToGraphQLInput ,
  make ,
}
/* use Not a pure module */
