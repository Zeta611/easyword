// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Jargon from "./Jargon.js";
import * as Js_exn from "../node_modules/rescript/lib/es6/js_exn.js";
import * as Loader from "./Loader.js";
import * as Reactfire from "reactfire";
import * as Belt_Array from "../node_modules/rescript/lib/es6/belt_Array.js";
import * as JargonCard from "./JargonCard.js";
import * as Belt_Option from "../node_modules/rescript/lib/es6/belt_Option.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as JsxRuntime from "react/jsx-runtime";
import * as Caml_js_exceptions from "../node_modules/rescript/lib/es6/caml_js_exceptions.js";
import * as Firestore from "firebase/firestore";

function JargonList(props) {
  var order = props.order;
  var axis = order[0];
  var jargonsCollection = Firestore.collection(Reactfire.useFirestore(), "jargons");
  var language;
  switch (axis) {
    case /* English */0 :
        language = "english";
        break;
    case /* Korean */1 :
        language = "korean";
        break;
    case /* Chrono */2 :
        language = "timestamp";
        break;
    
  }
  var queryConstraint = Firestore.orderBy(language, order[1]);
  var jargonsQuery = Firestore.query(jargonsCollection, queryConstraint);
  var match = Reactfire.useFirestoreCollectionData(jargonsQuery, {
        idField: "id"
      });
  if (match.status !== "success") {
    return JsxRuntime.jsx("div", {
                children: JsxRuntime.jsx(Loader.make, {}),
                className: "h-screen grid justify-center content-center"
              });
  }
  var jargons = match.data;
  if (jargons === undefined) {
    return null;
  }
  var matchAll = /.*/;
  var regex;
  try {
    regex = new RegExp(props.query, props.caseSensitivity ? "i" : "");
  }
  catch (raw_obj){
    var obj = Caml_js_exceptions.internalToOCamlException(raw_obj);
    if (obj.RE_EXN_ID === Js_exn.$$Error) {
      Belt_Option.forEach(obj._1.message, (function (prim) {
              console.log(prim);
            }));
      regex = matchAll;
    } else {
      throw obj;
    }
  }
  var rows = Belt_Array.keepMap(Caml_option.valFromOption(jargons), (function (jargon) {
          var translations = Jargon.convertTranslations(jargon.translations);
          var match = jargon.english.match(regex);
          var match$1 = translations.match(regex);
          if (match === null && match$1 === null) {
            return ;
          }
          return Caml_option.some(JsxRuntime.jsx(JargonCard.make, {
                          jargon: jargon,
                          axis: axis
                        }, jargon.id));
        }));
  return JsxRuntime.jsx("div", {
              children: rows,
              className: "grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2"
            });
}

var make = JargonList;

export {
  make ,
}
/* Loader Not a pure module */
