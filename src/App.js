// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Home from "./Home.js";
import * as React from "react";
import * as Js_exn from "../node_modules/rescript/lib/es6/js_exn.js";
import * as Loader from "./Loader.js";
import * as SignIn from "./SignIn.js";
import * as SignOut from "./SignOut.js";
import * as Firebase from "./Firebase.js";
import * as Reactfire from "reactfire";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as RelayWrapper from "./RelayWrapper.js";
import * as SignInWrapper from "./SignInWrapper.js";
import * as Auth from "firebase/auth";
import * as LazyComponents from "./LazyComponents.js";
import * as NavbarContainer from "./NavbarContainer.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as Caml_js_exceptions from "../node_modules/rescript/lib/es6/caml_js_exceptions.js";
import * as AppCheck from "firebase/app-check";
import * as Firestore from "firebase/firestore";
import * as RescriptReactRouter from "../node_modules/@rescript/react/src/RescriptReactRouter.js";
import * as BetterReactMathjax from "better-react-mathjax";
import * as ReactErrorBoundary from "react-error-boundary";

function App(props) {
  var app = Reactfire.useFirebaseApp();
  var auth = Auth.getAuth(app);
  var appCheck = AppCheck.initializeAppCheck(app, {
        provider: new AppCheck.ReCaptchaV3Provider(Firebase.appCheckToken),
        isTokenAutoRefreshEnabled: true
      });
  var match = Reactfire.useInitFirestore(async function (app) {
        var firestore = Firestore.getFirestore(app);
        try {
          await Firestore.enableMultiTabIndexedDbPersistence(firestore);
        }
        catch (raw_err){
          var err = Caml_js_exceptions.internalToOCamlException(raw_err);
          if (err.RE_EXN_ID === Js_exn.$$Error) {
            console.error(err._1);
          } else {
            throw err;
          }
        }
        return firestore;
      });
  var firestore = match.data;
  var mathJaxConfig = {
    loader: {
      load: ["[tex]/bussproofs"]
    },
    tex: {
      packages: {
        "[+]": ["bussproofs"]
      },
      inlineMath: [
        [
          "$",
          "$"
        ],
        [
          "\\(",
          "\\)"
        ]
      ],
      displayMath: [
        [
          "$$",
          "$$"
        ],
        [
          "\\[",
          "\\]"
        ]
      ]
    }
  };
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  if (match.status !== "success") {
    return JsxRuntime.jsx("div", {
                children: JsxRuntime.jsx(Loader.make, {}),
                className: "h-screen grid justify-center content-center"
              });
  }
  if (firestore === undefined) {
    return null;
  }
  var path = url.path;
  var tmp;
  var exit = 0;
  if (path) {
    switch (path.hd) {
      case "login" :
          if (path.tl) {
            exit = 1;
          } else {
            tmp = JsxRuntime.jsx(SignIn.make, {});
          }
          break;
      case "logout" :
          if (path.tl) {
            exit = 1;
          } else {
            tmp = JsxRuntime.jsx(SignOut.make, {});
          }
          break;
      default:
        exit = 1;
    }
  } else {
    exit = 1;
  }
  if (exit === 1) {
    var tmp$1;
    if (path) {
      switch (path.hd) {
        case "colophon" :
            tmp$1 = path.tl ? "404" : JsxRuntime.jsx(LazyComponents.Colophon.make, {});
            break;
        case "jargon" :
            var match$1 = path.tl;
            tmp$1 = match$1 && !match$1.tl ? JsxRuntime.jsx(ReactErrorBoundary.ErrorBoundary, {
                    children: JsxRuntime.jsx(LazyComponents.JargonPost.make, {
                          jargonID: match$1.hd
                        }),
                    fallbackRender: (function (param) {
                        return JsxRuntime.jsx("div", {
                                    children: "앗! 404",
                                    className: "text-3xl px-5 py-5"
                                  });
                      })
                  }) : "404";
            break;
        case "new-jargon" :
            tmp$1 = path.tl ? "404" : JsxRuntime.jsx(LazyComponents.NewJargon.make, {});
            break;
        case "new-translation" :
            var match$2 = path.tl;
            tmp$1 = match$2 && !match$2.tl ? JsxRuntime.jsx(LazyComponents.NewTranslation.make, {
                    jargonID: match$2.hd
                  }) : "404";
            break;
        case "profile" :
            tmp$1 = path.tl ? "404" : JsxRuntime.jsx(LazyComponents.Profile.make, {});
            break;
        case "why" :
            tmp$1 = path.tl ? "404" : JsxRuntime.jsx(LazyComponents.Why.make, {});
            break;
        default:
          tmp$1 = "404";
      }
    } else {
      tmp$1 = JsxRuntime.jsx(ReactErrorBoundary.ErrorBoundary, {
            children: JsxRuntime.jsx(React.Suspense, {
                  children: Caml_option.some(JsxRuntime.jsx(Home.make, {})),
                  fallback: Caml_option.some(JsxRuntime.jsx("div", {
                            children: JsxRuntime.jsx(Loader.make, {}),
                            className: "h-screen grid justify-center content-center"
                          }))
                }),
            fallbackRender: (function (param) {
                console.error(param.error);
                return null;
              })
          });
    }
    tmp = JsxRuntime.jsx(React.Suspense, {
          children: Caml_option.some(JsxRuntime.jsx(NavbarContainer.make, {
                    children: tmp$1
                  })),
          fallback: Caml_option.some(JsxRuntime.jsx("div", {
                    children: JsxRuntime.jsx(Loader.make, {}),
                    className: "h-screen grid justify-center content-center"
                  }))
        });
  }
  return JsxRuntime.jsx(BetterReactMathjax.MathJaxContext, {
              config: mathJaxConfig,
              children: JsxRuntime.jsx(Reactfire.AppCheckProvider, {
                    sdk: appCheck,
                    children: JsxRuntime.jsx(Reactfire.AuthProvider, {
                          sdk: auth,
                          children: JsxRuntime.jsx(Reactfire.FirestoreProvider, {
                                sdk: Caml_option.valFromOption(firestore),
                                children: JsxRuntime.jsx(SignInWrapper.make, {
                                      children: JsxRuntime.jsx(RelayWrapper.make, {
                                            children: tmp
                                          })
                                    })
                              })
                        })
                  })
            });
}

var make = App;

export {
  make ,
}
/* Home Not a pure module */
