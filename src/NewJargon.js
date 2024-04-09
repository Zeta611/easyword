// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Util from "./Util.js";
import * as Uuid from "uuid";
import * as React from "react";
import * as SignInContext from "./SignInContext.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptReactRouter from "../node_modules/@rescript/react/src/RescriptReactRouter.js";
import * as RescriptRelay_Mutation from "../node_modules/rescript-relay/src/RescriptRelay_Mutation.js";
import * as NewJargonMutation_graphql from "./__generated__/NewJargonMutation_graphql.js";
import * as NewJargonWithoutTranslationMutation_graphql from "./__generated__/NewJargonWithoutTranslationMutation_graphql.js";

var convertVariables = NewJargonMutation_graphql.Internal.convertVariables;

var convertResponse = NewJargonMutation_graphql.Internal.convertResponse;

var convertWrapRawResponse = NewJargonMutation_graphql.Internal.convertWrapRawResponse;

var commitMutation = RescriptRelay_Mutation.commitMutation(convertVariables, NewJargonMutation_graphql.node, convertResponse, convertWrapRawResponse);

var use = RescriptRelay_Mutation.useMutation(convertVariables, NewJargonMutation_graphql.node, convertResponse, convertWrapRawResponse);

var NewJargonMutation = {
  Operation: undefined,
  Types: undefined,
  convertVariables: convertVariables,
  convertResponse: convertResponse,
  convertWrapRawResponse: convertWrapRawResponse,
  commitMutation: commitMutation,
  use: use
};

var convertVariables$1 = NewJargonWithoutTranslationMutation_graphql.Internal.convertVariables;

var convertResponse$1 = NewJargonWithoutTranslationMutation_graphql.Internal.convertResponse;

var convertWrapRawResponse$1 = NewJargonWithoutTranslationMutation_graphql.Internal.convertWrapRawResponse;

var commitMutation$1 = RescriptRelay_Mutation.commitMutation(convertVariables$1, NewJargonWithoutTranslationMutation_graphql.node, convertResponse$1, convertWrapRawResponse$1);

var use$1 = RescriptRelay_Mutation.useMutation(convertVariables$1, NewJargonWithoutTranslationMutation_graphql.node, convertResponse$1, convertWrapRawResponse$1);

var NewJargonWithoutTranslationMutation = {
  Operation: undefined,
  Types: undefined,
  convertVariables: convertVariables$1,
  convertResponse: convertResponse$1,
  convertWrapRawResponse: convertWrapRawResponse$1,
  commitMutation: commitMutation$1,
  use: use$1
};

function NewJargon(props) {
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
        return "";
      });
  var setEnglish = match$1[1];
  var english = match$1[0];
  var handleJargonChange = function ($$event) {
    var value = $$event.currentTarget.value;
    setEnglish(function (param) {
          return value;
        });
  };
  var match$2 = React.useState(function () {
        return "";
      });
  var setKorean = match$2[1];
  var korean = match$2[0];
  var handleTranslationChange = function ($$event) {
    var value = $$event.currentTarget.value;
    setKorean(function (param) {
          return value;
        });
  };
  var match$3 = React.useState(function () {
        return false;
      });
  var setWithoutKorean = match$3[1];
  var withoutKorean = match$3[0];
  var match$4 = React.useState(function () {
        return "";
      });
  var setComment = match$4[1];
  var comment = match$4[0];
  var handleCommentChange = function ($$event) {
    var value = $$event.currentTarget.value;
    setComment(function (param) {
          return value;
        });
  };
  var match$5 = use();
  var newJargonMutate = match$5[0];
  var match$6 = use$1();
  var newJargonWithoutTranslationMutate = match$6[0];
  var handleSubmit = function ($$event) {
    $$event.preventDefault();
    if (english.length < 3) {
      window.alert("용어는 세 글자 이상이어야 해요");
      return ;
    }
    if (!withoutKorean && korean.length < 1) {
      window.alert("번역을 입력해주세요");
      return ;
    }
    if (!signedIn) {
      return RescriptReactRouter.replace("/login");
    }
    if (user == null) {
      return RescriptReactRouter.replace("/logout");
    }
    var comment$1 = comment === "" ? (
        withoutKorean ? "\"" + english + "\" 용어의 번역이 필요합니다." : Util.eulLeul(korean) + " 제안합니다."
      ) : comment;
    var jargonID = Uuid.v4();
    var translationID = Uuid.v4();
    var commentID = Uuid.v4();
    if (withoutKorean) {
      newJargonWithoutTranslationMutate({
            authorID: user.uid,
            comment: comment$1,
            commentID: commentID,
            id: jargonID,
            name: english
          }, undefined, undefined, undefined, (function (param, _errors) {
              var insert_jargon_one = param.insert_jargon_one;
              if (insert_jargon_one !== undefined) {
                return RescriptReactRouter.replace("/jargon/" + insert_jargon_one.id);
              }
              
            }), (function (error) {
              console.error(error);
            }), undefined);
    } else {
      newJargonMutate({
            authorID: user.uid,
            comment: comment$1,
            commentID: commentID,
            id: jargonID,
            name: english,
            translation: korean,
            translationID: translationID
          }, undefined, undefined, undefined, (function (param, _errors) {
              var insert_jargon_one = param.insert_jargon_one;
              if (insert_jargon_one !== undefined) {
                return RescriptReactRouter.replace("/jargon/" + insert_jargon_one.id);
              }
              
            }), (function (error) {
              console.error(error);
            }), undefined);
    }
  };
  if (signedIn) {
    return JsxRuntime.jsxs("div", {
                children: [
                  JsxRuntime.jsx("h1", {
                        children: "쉬운 전문용어 제안하기"
                      }),
                  JsxRuntime.jsx("form", {
                        children: JsxRuntime.jsxs("div", {
                              children: [
                                JsxRuntime.jsxs("label", {
                                      children: [
                                        JsxRuntime.jsx("label", {
                                              children: JsxRuntime.jsx("span", {
                                                    children: "원어",
                                                    className: "label-text"
                                                  }),
                                              className: "label"
                                            }),
                                        JsxRuntime.jsx("input", {
                                              className: "input input-bordered w-full",
                                              placeholder: "separated sum",
                                              type: "text",
                                              value: english,
                                              onChange: handleJargonChange
                                            })
                                      ],
                                      className: "block"
                                    }),
                                JsxRuntime.jsxs("label", {
                                      children: [
                                        JsxRuntime.jsxs("label", {
                                              children: [
                                                JsxRuntime.jsx("span", {
                                                      children: "번역",
                                                      className: "label-text"
                                                    }),
                                                React.cloneElement(JsxRuntime.jsxs("div", {
                                                          children: [
                                                            JsxRuntime.jsx("input", {
                                                                  className: "checkbox checkbox-secondary",
                                                                  checked: withoutKorean,
                                                                  type: "checkbox",
                                                                  onChange: (function (param) {
                                                                      setWithoutKorean(function (v) {
                                                                            return !v;
                                                                          });
                                                                    })
                                                                }),
                                                            "번역 없이 제안하기"
                                                          ],
                                                          className: "flex gap-1 text-xs place-items-center tooltip tooltip-bottom"
                                                        }), {
                                                      "data-tip": "번역을 제안하지 않고 용어를 추가해보세요"
                                                    })
                                              ],
                                              className: "label"
                                            }),
                                        JsxRuntime.jsx("input", {
                                              className: "input input-bordered w-full",
                                              disabled: withoutKorean,
                                              placeholder: "출신을 기억하는 합",
                                              type: "text",
                                              value: korean,
                                              onChange: handleTranslationChange
                                            })
                                      ],
                                      className: "block"
                                    }),
                                JsxRuntime.jsxs("label", {
                                      children: [
                                        JsxRuntime.jsx("label", {
                                              children: JsxRuntime.jsx("span", {
                                                    children: "의견",
                                                    className: "label-text"
                                                  }),
                                              className: "label"
                                            }),
                                        JsxRuntime.jsx("textarea", {
                                              className: "textarea textarea-bordered w-full",
                                              placeholder: "첫 댓글로 달려요",
                                              value: comment,
                                              onChange: handleCommentChange
                                            })
                                      ],
                                      className: "block"
                                    }),
                                JsxRuntime.jsx("input", {
                                      className: "btn btn-primary",
                                      disabled: match$5[1] || match$6[1],
                                      type: "submit",
                                      value: "제안하기"
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

var make = NewJargon;

export {
  NewJargonMutation ,
  NewJargonWithoutTranslationMutation ,
  make ,
}
/* commitMutation Not a pure module */
