// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Loader from "./Loader.js";
import * as Firebase from "./Firebase.js";
import * as Belt_List from "../node_modules/rescript/lib/es6/belt_List.js";
import * as Reactfire from "reactfire";
import * as Belt_Array from "../node_modules/rescript/lib/es6/belt_Array.js";
import * as CommentRow from "./CommentRow.js";
import * as Belt_Option from "../node_modules/rescript/lib/es6/belt_Option.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as SignInContext from "./SignInContext.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as Belt_HashMapString from "../node_modules/rescript/lib/es6/belt_HashMapString.js";
import * as Firestore from "firebase/firestore";

function constructForest(comments) {
  var roots = {
    contents: /* [] */0
  };
  var commentNodeTable = Belt_HashMapString.make(10);
  Belt_Array.forEach(comments, (function (comment) {
          var id = Belt_Option.getExn(Caml_option.undefined_to_opt(comment.id));
          var parent = comment.parent;
          var node = {
            comment: comment,
            parent: undefined,
            children: /* [] */0
          };
          Belt_HashMapString.set(commentNodeTable, id, node);
          if (parent === "") {
            roots.contents = Belt_List.add(roots.contents, node);
            return ;
          }
          
        }));
  Belt_HashMapString.forEach(commentNodeTable, (function (param, node) {
          var parent = node.comment.parent;
          if (parent === "") {
            return ;
          }
          var parentNode = Belt_Option.getExn(Belt_HashMapString.get(commentNodeTable, parent));
          parentNode.children = Belt_List.add(parentNode.children, node);
          node.parent = parentNode;
        }));
  return [
          roots,
          commentNodeTable
        ];
}

function JargonPost$CommentInput(props) {
  var match = React.useContext(SignInContext.context);
  var user = match.user;
  var match$1 = React.useState(function () {
        return "";
      });
  var setContent = match$1[1];
  var content = match$1[0];
  var handleInputChange = function ($$event) {
    var value = $$event.currentTarget.value;
    setContent(function (param) {
          return value;
        });
  };
  var firestore = Reactfire.useFirestore();
  var commentsCollection = Firestore.collection(firestore, "jargons/" + props.id + "/comments");
  var handleSubmit = function ($$event) {
    $$event.preventDefault();
    if (user == null) {
      window.alert("You need to be signed in to comment!");
      return ;
    }
    var email = Belt_Option.getWithDefault(user.email, Belt_Option.getWithDefault(Belt_Option.flatMap(Belt_Array.get(user.providerData, 0), Firebase.User.email), user.uid));
    Firestore.addDoc(commentsCollection, {
          content: content,
          user: email,
          timestamp: Firestore.Timestamp.fromDate(new Date()),
          parent: ""
        });
  };
  return JsxRuntime.jsx("form", {
              children: JsxRuntime.jsxs("div", {
                    children: [
                      JsxRuntime.jsx("textarea", {
                            className: "textarea textarea-bordered textarea-md rounded-lg place-self-stretch",
                            id: "comment",
                            name: "comment",
                            placeholder: "여러분의 생각은 어떠신가요?",
                            value: content,
                            onChange: handleInputChange
                          }),
                      JsxRuntime.jsx("input", {
                            className: "btn btn-primary btn-sm btn-outline",
                            type: "submit",
                            value: "댓글"
                          })
                    ],
                    className: "p-2 gap-3 grid grid-cols-1 place-items-end"
                  }),
              onSubmit: handleSubmit
            });
}

var CommentInput = {
  make: JargonPost$CommentInput
};

function JargonPost(props) {
  var id = props.id;
  var firestore = Reactfire.useFirestore();
  var jargonDoc = Firestore.doc(firestore, "jargons/" + id + "");
  var match = Reactfire.useFirestoreDocData(jargonDoc);
  var jargons = match.data;
  var commentsCollection = Firestore.collection(firestore, "jargons/" + id + "/comments");
  var match$1 = Reactfire.useFirestoreCollectionData(Firestore.query(commentsCollection, Firestore.orderBy("timestamp", "asc")), {
        idField: "id"
      });
  var comments = match$1.data;
  if (match.status === "success" && match$1.status === "success") {
    if (jargons === undefined) {
      return null;
    }
    if (comments === undefined) {
      return null;
    }
    var match$2 = constructForest(Caml_option.valFromOption(comments));
    return JsxRuntime.jsxs("main", {
                children: [
                  JsxRuntime.jsxs("h1", {
                        children: [
                          JsxRuntime.jsx("div", {
                                children: jargons.english,
                                className: "text-3xl font-bold"
                              }),
                          JsxRuntime.jsx("div", {
                                children: jargons.korean,
                                className: "text-2xl font-medium"
                              })
                        ],
                        className: "grid gap-1"
                      }),
                  JsxRuntime.jsx("div", {
                        children: JsxRuntime.jsx("table", {
                              children: JsxRuntime.jsxs("tbody", {
                                    children: [
                                      JsxRuntime.jsxs("tr", {
                                            children: [
                                              JsxRuntime.jsx("th", {
                                                    children: JsxRuntime.jsx("label", {
                                                          children: JsxRuntime.jsx("input", {
                                                                className: "radio radio-primary",
                                                                name: "radio",
                                                                type: "radio"
                                                              })
                                                        }),
                                                    className: "w-10"
                                                  }),
                                              JsxRuntime.jsxs("td", {
                                                    children: [
                                                      "시험 단어",
                                                      JsxRuntime.jsx("br", {}),
                                                      JsxRuntime.jsx("progress", {
                                                            className: "progress progress-primary w-full",
                                                            max: "100",
                                                            value: "99"
                                                          })
                                                    ]
                                                  }),
                                              JsxRuntime.jsx("th", {
                                                    children: "99%",
                                                    className: "w-10"
                                                  })
                                            ],
                                            className: "active"
                                          }),
                                      JsxRuntime.jsxs("tr", {
                                            children: [
                                              JsxRuntime.jsx("th", {
                                                    children: JsxRuntime.jsx("label", {
                                                          children: JsxRuntime.jsx("input", {
                                                                className: "radio radio-primary",
                                                                name: "radio",
                                                                type: "radio"
                                                              })
                                                        })
                                                  }),
                                              JsxRuntime.jsxs("td", {
                                                    children: [
                                                      "연습 단어",
                                                      JsxRuntime.jsx("br", {}),
                                                      JsxRuntime.jsx("progress", {
                                                            className: "progress progress-primary w-full",
                                                            max: "100",
                                                            value: "1"
                                                          })
                                                    ]
                                                  }),
                                              JsxRuntime.jsx("th", {
                                                    children: "1%"
                                                  })
                                            ]
                                          })
                                    ]
                                  }),
                              className: "table w-full"
                            }),
                        className: "overflow-x-auto"
                      }),
                  JsxRuntime.jsx(JargonPost$CommentInput, {
                        id: id
                      }),
                  JsxRuntime.jsx("div", {
                        children: JsxRuntime.jsx(CommentRow.make, {
                              jargonID: id,
                              siblings: match$2[0].contents
                            })
                      })
                ],
                className: "grid p-5 gap-3 dark:text-white"
              });
  }
  return JsxRuntime.jsx("div", {
              children: JsxRuntime.jsx(Loader.make, {}),
              className: "h-screen grid justify-center content-center"
            });
}

var make = JargonPost;

export {
  constructForest ,
  CommentInput ,
  make ,
}
/* react Not a pure module */
