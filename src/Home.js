// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Loader from "./Loader.js";
import * as SearchBar from "./SearchBar.js";
import * as JargonList from "./JargonList.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as Solid from "@heroicons/react/24/solid";

function Home(props) {
  var match = React.useState(function () {
        return "";
      });
  var setQuery = match[1];
  var query = match[0];
  var match$1 = React.useState(function () {
        return "Chrono";
      });
  var setAxis = match$1[1];
  var axis = match$1[0];
  var match$2 = React.useState(function () {
        return "desc";
      });
  var setDirection = match$2[1];
  var direction = match$2[0];
  var onChange = function ($$event) {
    var value = $$event.currentTarget.value;
    setQuery(function (param) {
          return value;
        });
  };
  var tmp;
  tmp = axis === "English" ? (
      direction === "asc" ? JsxRuntime.jsx(Solid.ArrowUpIcon, {
              className: "-ml-2 mr-1 h-5 w-5 text-teal-100"
            }) : JsxRuntime.jsx(Solid.ArrowDownIcon, {
              className: "-ml-2 mr-1 h-5 w-5 text-teal-100"
            })
    ) : null;
  var tmp$1;
  tmp$1 = axis === "English" ? "ABC순" : "최근순";
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsxs("div", {
                      children: [
                        JsxRuntime.jsx("div", {
                              children: JsxRuntime.jsx(SearchBar.make, {
                                    query: query,
                                    onChange: onChange
                                  }),
                              className: "flex-auto"
                            }),
                        JsxRuntime.jsxs("div", {
                              children: [
                                JsxRuntime.jsxs("label", {
                                      children: [
                                        tmp,
                                        tmp$1,
                                        JsxRuntime.jsx(Solid.ChevronDownIcon, {
                                              className: "ml-2 -mr-1 h-5 w-5"
                                            })
                                      ],
                                      className: "btn btn-primary",
                                      tabIndex: 0,
                                      onClick: (function (param) {
                                          if (axis === "English") {
                                            if (direction === "asc") {
                                              return setDirection(function (param) {
                                                          return "desc";
                                                        });
                                            } else {
                                              return setDirection(function (param) {
                                                          return "asc";
                                                        });
                                            }
                                          } else {
                                            return setDirection(function (param) {
                                                        return "desc";
                                                      });
                                          }
                                        })
                                    }),
                                JsxRuntime.jsxs("ul", {
                                      children: [
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsx("button", {
                                                    children: "최근순",
                                                    onClick: (function (param) {
                                                        setAxis(function (param) {
                                                              return "Chrono";
                                                            });
                                                        setDirection(function (param) {
                                                              return "desc";
                                                            });
                                                      })
                                                  })
                                            }),
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsxs("button", {
                                                    children: [
                                                      "ABC순",
                                                      direction === "asc" ? JsxRuntime.jsx(Solid.ArrowUpIcon, {
                                                              className: "-ml-2 mr-1 h-5 w-5 text-primary"
                                                            }) : JsxRuntime.jsx(Solid.ArrowDownIcon, {
                                                              className: "-ml-2 mr-1 h-5 w-5 text-primary"
                                                            })
                                                    ],
                                                    onClick: (function (param) {
                                                        setAxis(function (param) {
                                                              return "English";
                                                            });
                                                        setDirection(function (direction) {
                                                              if (direction === "asc") {
                                                                return "desc";
                                                              } else {
                                                                return "asc";
                                                              }
                                                            });
                                                      })
                                                  })
                                            })
                                      ],
                                      className: "menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box",
                                      tabIndex: 0
                                    })
                              ],
                              className: "dropdown dropdown-hover dropdown-end shadow-lg rounded-lg"
                            })
                      ],
                      className: "flex items-center space-x-2 sticky top-[4rem] md:top-[5.75rem] -mt-5 mb-5 z-40 bg-base-100"
                    }),
                JsxRuntime.jsx(React.Suspense, {
                      children: Caml_option.some(JsxRuntime.jsx(JargonList.make, {
                                axis: axis,
                                direction: direction,
                                query: query
                              })),
                      fallback: Caml_option.some(JsxRuntime.jsx("div", {
                                children: JsxRuntime.jsx(Loader.make, {}),
                                className: "h-screen grid justify-center content-center"
                              }))
                    })
              ],
              className: "grid p-5 text-sm"
            });
}

var make = Home;

export {
  make ,
}
/* react Not a pure module */
