// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Home from "./Home.js";
import * as React from "react";
import * as Jargon from "./Jargon.js";
import * as Firebase from "./Firebase.js";
import * as Reactfire from "reactfire";
import * as Auth from "firebase/auth";
import * as AppCheck from "firebase/app-check";
import * as Firestore from "firebase/firestore";
import * as RescriptReactRouter from "../node_modules/@rescript/react/src/RescriptReactRouter.mjs";

function iOS() {
  return [
    'iPad Simulator',
    'iPhone Simulator',
    'iPod Simulator',
    'iPad',
    'iPhone',
    'iPod'
  ].includes(navigator.platform)
  // iPad on iOS 13 detection
  || (navigator.userAgent.includes("Mac") && "ontouchend" in document)
}
;

function App(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var app = Reactfire.useFirebaseApp();
  var auth = Auth.getAuth(app);
  var appCheck = AppCheck.initializeAppCheck(app, {
        provider: new AppCheck.ReCaptchaV3Provider(Firebase.appCheckToken),
        isTokenAutoRefreshEnabled: true
      });
  if ((iOS())) {
    var firestore = Firestore.getFirestore(app);
    var match = url.path;
    var tmp;
    tmp = match ? (
        match.hd === "jargon" && !match.tl ? React.createElement(Reactfire.FirestoreProvider, {
                sdk: firestore,
                children: React.createElement(Jargon.make, {})
              }) : "404"
      ) : React.createElement(Home.make, {});
    return React.createElement(Reactfire.AppCheckProvider, {
                sdk: appCheck,
                children: React.createElement(Reactfire.AuthProvider, {
                      sdk: auth,
                      children: tmp
                    })
              });
  }
  var match$1 = Reactfire.useInitFirestore(function (app) {
        var firestore = Firestore.getFirestore(app);
        var __x = Firestore.enableIndexedDbPersistence(firestore);
        var __x$1 = __x.catch(function (err) {
              console.log(err);
              return Promise.resolve(undefined);
            });
        return __x$1.then(function (param) {
                    return Promise.resolve(firestore);
                  });
      });
  if (match$1.status === "loading") {
    return "loading...";
  }
  var match$2 = url.path;
  var tmp$1;
  tmp$1 = match$2 ? (
      match$2.hd === "jargon" && !match$2.tl ? React.createElement(Reactfire.FirestoreProvider, {
              sdk: match$1.data,
              children: React.createElement(Jargon.make, {})
            }) : "404"
    ) : React.createElement(Home.make, {});
  return React.createElement(Reactfire.AppCheckProvider, {
              sdk: appCheck,
              children: React.createElement(Reactfire.AuthProvider, {
                    sdk: auth,
                    children: tmp$1
                  })
            });
}

var make = App;

export {
  make ,
  
}
/*  Not a pure module */
