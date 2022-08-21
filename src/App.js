// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Home from "./Home.js";
import * as React from "react";
import * as Jargon from "./Jargon.js";
import * as Firebase from "./Firebase.js";
import * as Reactfire from "reactfire";
import * as Auth from "firebase/auth";
import * as AppCheck from "firebase/app-check";
import * as Firestore from "firebase/firestore";
import * as RescriptReactRouter from "../node_modules/@rescript/react/src/RescriptReactRouter.js";

function App(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var app = Reactfire.useFirebaseApp();
  var auth = Auth.getAuth(app);
  var appCheck = AppCheck.initializeAppCheck(app, {
        provider: new AppCheck.ReCaptchaV3Provider(Firebase.appCheckToken),
        isTokenAutoRefreshEnabled: true
      });
  var match = Reactfire.useInitFirestore(function (app) {
        return Promise.resolve(Firestore.getFirestore(app));
      });
  var match$1 = url.path;
  var tmp;
  tmp = match$1 ? (
      match$1.hd === "jargon" && !match$1.tl ? (
          match.status === "loading" ? "loading..." : React.createElement(Reactfire.FirestoreProvider, {
                  sdk: match.data,
                  children: React.createElement(Jargon.make, {})
                })
        ) : "404"
    ) : React.createElement(Home.make, {});
  return React.createElement(Reactfire.AppCheckProvider, {
              sdk: appCheck,
              children: React.createElement(Reactfire.AuthProvider, {
                    sdk: auth,
                    children: tmp
                  })
            });
}

var make = App;

export {
  make ,
  
}
/* Home Not a pure module */
