// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Exc from "./Exc.js";
import * as Hooks from "./Hooks.js";
import * as React from "react";
import * as Core__JSON from "../node_modules/@rescript/core/src/Core__JSON.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as Core__Option from "../node_modules/@rescript/core/src/Core__Option.js";
import * as SignInContext from "./SignInContext.js";
import * as Fa from "react-icons/fa";
import * as JsxRuntime from "react/jsx-runtime";
import * as RescriptReactRouter from "../node_modules/@rescript/react/src/RescriptReactRouter.js";
import * as Solid from "@heroicons/react/24/solid";
import * as Outline from "@heroicons/react/24/outline";

function unsafeGet(json, key) {
  return Core__Option.getExn(Core__JSON.Decode.object(json))[key];
}

function Navbar(props) {
  var match = React.useContext(SignInContext.context);
  var user = match.user;
  var photoURL = !(user == null) ? user.photoURL : undefined;
  var match$1 = React.useState(function () {
        
      });
  var setJargonsCount = match$1[1];
  var jargonsCount = match$1[0];
  var gitHubURL = "https://github.com/Zeta611/easyword";
  React.useEffect(function () {
        ((async function () {
                var resp = await fetch("https://easyword.hasura.app/api/rest/jargons-count", {
                      method: "GET",
                      headers: Caml_option.some(new Headers({
                                "content-type": "application/json"
                              }))
                    });
                var json;
                if (resp.ok) {
                  json = await resp.json();
                } else {
                  throw {
                        RE_EXN_ID: Exc.GraphQLError,
                        _1: "Failed to fetch jargons count",
                        Error: new Error()
                      };
                }
                var count = Core__Option.getExn(Core__JSON.Decode.$$float(unsafeGet(unsafeGet(unsafeGet(json, "jargon_aggregate"), "aggregate"), "count"))) | 0;
                return setJargonsCount(function (param) {
                            return count;
                          });
              })());
      });
  var closeMenu = Hooks.useClosingDropdown("menu-dropdown-btn");
  var closeProfile = Hooks.useClosingDropdown("profile-dropdown-btn");
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsxs("div", {
                      children: [
                        JsxRuntime.jsxs("details", {
                              children: [
                                JsxRuntime.jsx("summary", {
                                      children: JsxRuntime.jsx(Solid.Bars3Icon, {
                                            className: "h-5 w-5"
                                          }),
                                      className: "btn btn-ghost md:hidden"
                                    }),
                                JsxRuntime.jsxs("ul", {
                                      children: [
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsxs("button", {
                                                    children: [
                                                      JsxRuntime.jsx(Solid.StarIcon, {
                                                            className: "h-4 w-4"
                                                          }),
                                                      "배경/원칙"
                                                    ],
                                                    onClick: (function (param) {
                                                        RescriptReactRouter.push("/why");
                                                        closeMenu();
                                                      })
                                                  })
                                            }),
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsxs("button", {
                                                    children: [
                                                      JsxRuntime.jsx(Outline.PencilSquareIcon, {
                                                            className: "h-4 w-4"
                                                          }),
                                                      "용어제안"
                                                    ],
                                                    onClick: (function (param) {
                                                        RescriptReactRouter.push("/new-jargon");
                                                        closeMenu();
                                                      })
                                                  })
                                            }),
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsxs("button", {
                                                    children: [
                                                      JsxRuntime.jsx(Outline.WrenchIcon, {
                                                            className: "h-4 w-4"
                                                          }),
                                                      "제작기"
                                                    ],
                                                    onClick: (function (param) {
                                                        RescriptReactRouter.push("/colophon");
                                                        closeMenu();
                                                      })
                                                  })
                                            }),
                                        JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsxs("button", {
                                                    children: [
                                                      JsxRuntime.jsx(Fa.FaGithub, {
                                                            className: "h-4 w-4"
                                                          }),
                                                      "참여하기"
                                                    ],
                                                    onClick: (function (param) {
                                                        window.open(gitHubURL, "_blank", undefined);
                                                      })
                                                  })
                                            })
                                      ],
                                      className: "menu menu-compact dropdown-content p-2 w-[9rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box"
                                    })
                              ],
                              className: "dropdown",
                              id: "menu-dropdown-btn"
                            }),
                        JsxRuntime.jsx("button", {
                              children: JsxRuntime.jsxs("div", {
                                    children: [
                                      JsxRuntime.jsx("span", {
                                            children: "쉬운 전문용어"
                                          }),
                                      JsxRuntime.jsx("span", {
                                            children: "컴퓨터과학/컴퓨터공학",
                                            className: "text-xs"
                                          })
                                    ],
                                    className: "flex items-baseline gap-1"
                                  }),
                              className: "btn btn-ghost text-xl lg:hidden",
                              onClick: (function (param) {
                                  RescriptReactRouter.push("/");
                                })
                            }),
                        JsxRuntime.jsx("button", {
                              children: JsxRuntime.jsxs("div", {
                                    children: [
                                      JsxRuntime.jsx("span", {
                                            children: "쉬운 전문용어"
                                          }),
                                      JsxRuntime.jsx("span", {
                                            children: "컴퓨터과학/컴퓨터공학",
                                            className: "text-xs"
                                          })
                                    ],
                                    className: "flex items-baseline gap-1"
                                  }),
                              className: "btn btn-ghost text-xl hidden lg:flex",
                              onClick: (function (param) {
                                  RescriptReactRouter.push("/");
                                })
                            })
                      ],
                      className: "navbar-start"
                    }),
                JsxRuntime.jsx("div", {
                      children: JsxRuntime.jsxs("ul", {
                            children: [
                              JsxRuntime.jsx("li", {
                                    children: JsxRuntime.jsx("button", {
                                          children: JsxRuntime.jsxs("div", {
                                                children: [
                                                  JsxRuntime.jsx(Solid.StarIcon, {
                                                        className: "h-6 w-6 hidden sm:flex"
                                                      }),
                                                  "배경/원칙"
                                                ],
                                                className: "grid justify-items-center"
                                              }),
                                          onClick: (function (param) {
                                              RescriptReactRouter.push("/why");
                                            })
                                        })
                                  }),
                              JsxRuntime.jsx("li", {
                                    children: JsxRuntime.jsx("button", {
                                          children: JsxRuntime.jsxs("div", {
                                                children: [
                                                  JsxRuntime.jsx(Outline.PencilSquareIcon, {
                                                        className: "h-6 w-6 hidden sm:flex"
                                                      }),
                                                  "용어제안"
                                                ],
                                                className: "grid justify-items-center"
                                              }),
                                          onClick: (function (param) {
                                              RescriptReactRouter.push("/new-jargon");
                                            })
                                        })
                                  }),
                              JsxRuntime.jsx("li", {
                                    children: JsxRuntime.jsx("button", {
                                          children: JsxRuntime.jsxs("div", {
                                                children: [
                                                  JsxRuntime.jsx(Outline.WrenchIcon, {
                                                        className: "h-6 w-6 hidden sm:flex"
                                                      }),
                                                  "제작기"
                                                ],
                                                className: "grid justify-items-center"
                                              }),
                                          onClick: (function (param) {
                                              RescriptReactRouter.push("/colophon");
                                            })
                                        })
                                  }),
                              JsxRuntime.jsx("li", {
                                    children: JsxRuntime.jsx("button", {
                                          children: JsxRuntime.jsxs("div", {
                                                children: [
                                                  JsxRuntime.jsx(Fa.FaGithub, {
                                                        className: "h-6 w-6 hidden sm:flex"
                                                      }),
                                                  "참여하기"
                                                ],
                                                className: "grid justify-items-center"
                                              }),
                                          onClick: (function (param) {
                                              window.open(gitHubURL, "_blank", undefined);
                                            })
                                        })
                                  })
                            ],
                            className: "menu menu-horizontal px-1"
                          }),
                      className: "navbar-center hidden md:flex text-sm"
                    }),
                JsxRuntime.jsxs("div", {
                      children: [
                        jargonsCount !== undefined ? JsxRuntime.jsxs("div", {
                                children: [
                                  JsxRuntime.jsx(Outline.ChartBarSquareIcon, {
                                        className: "h-5 w-5"
                                      }),
                                  JsxRuntime.jsx("div", {
                                        children: "총 " + jargonsCount.toString() + "개",
                                        className: "ml-0"
                                      })
                                ],
                                className: "items-center sm:gap-1 text-xs text-teal-800 hidden sm:flex"
                              }) : null,
                        JsxRuntime.jsxs("details", {
                              children: [
                                photoURL !== undefined ? JsxRuntime.jsx("summary", {
                                        children: JsxRuntime.jsx("img", {
                                              className: "mask mask-squircle h-8 w-8 m-2 cursor-pointer",
                                              src: photoURL
                                            }),
                                        className: "flex"
                                      }) : JsxRuntime.jsx("summary", {
                                        children: JsxRuntime.jsx(Outline.UserCircleIcon, {
                                              className: "h-6 w-6"
                                            }),
                                        className: "btn btn-circle btn-ghost"
                                      }),
                                JsxRuntime.jsx("ul", {
                                      children: match.signedIn ? JsxRuntime.jsxs(JsxRuntime.Fragment, {
                                              children: [
                                                JsxRuntime.jsx("li", {
                                                      children: JsxRuntime.jsx("button", {
                                                            children: "내 프로필",
                                                            onClick: (function (param) {
                                                                RescriptReactRouter.push("/profile");
                                                                closeProfile();
                                                              })
                                                          })
                                                    }),
                                                JsxRuntime.jsx("li", {
                                                      children: JsxRuntime.jsx("button", {
                                                            children: "로그아웃",
                                                            onClick: (function (param) {
                                                                RescriptReactRouter.push("/logout");
                                                                closeProfile();
                                                              })
                                                          })
                                                    })
                                              ]
                                            }) : JsxRuntime.jsx("li", {
                                              children: JsxRuntime.jsx("button", {
                                                    children: "로그인",
                                                    onClick: (function (param) {
                                                        RescriptReactRouter.push("/login");
                                                      })
                                                  })
                                            }),
                                      className: "menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box"
                                    })
                              ],
                              className: "dropdown dropdown-end",
                              id: "profile-dropdown-btn"
                            })
                      ],
                      className: "navbar-end sm:gap-2"
                    })
              ],
              className: "navbar sticky top-0 z-50 bg-base-100"
            });
}

var make = Navbar;

export {
  unsafeGet ,
  make ,
}
/* Hooks Not a pure module */
