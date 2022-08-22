// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "../node_modules/rescript/lib/es6/curry.js";
import * as React from "react";
import * as Js_exn from "../node_modules/rescript/lib/es6/js_exn.js";
import * as Reactfire from "reactfire";
import * as Belt_Array from "../node_modules/rescript/lib/es6/belt_Array.js";
import * as Belt_Option from "../node_modules/rescript/lib/es6/belt_Option.js";
import * as Caml_option from "../node_modules/rescript/lib/es6/caml_option.js";
import * as Caml_js_exceptions from "../node_modules/rescript/lib/es6/caml_js_exceptions.js";
import * as Firestore from "firebase/firestore";

function makeRow(param) {
  return React.createElement("div", {
              key: param.id,
              className: "p-4 bg-white rounded-xl shadow-md"
            }, React.createElement("div", {
                  className: "font-semibold"
                }, param.english), React.createElement("div", {
                  className: "text-right text-slate-500 font-regular"
                }, param.korean));
}

function Jargon$Dictionary(Props) {
  var regexQuery = Props.query;
  var match = React.useState(function () {
        return [
                /* English */0,
                /* Ascending */0
              ];
      });
  var match$1 = match[0];
  var jargonsCollection = Firestore.collection(Reactfire.useFirestore(), "jargons");
  var language = match$1[0] ? "korean" : "english";
  var direction = match$1[1] ? "desc" : "asc";
  var queryConstraint = Firestore.orderBy(language, direction);
  var jargonsQuery = Firestore.query(jargonsCollection, queryConstraint);
  var match$2 = Reactfire.useFirestoreCollectionData(jargonsQuery, {
        idField: "id"
      });
  if (match$2.status === "loading") {
    return "loading";
  }
  var matchAll = /.*/;
  var regex;
  try {
    regex = new RegExp(regexQuery);
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
  var rows = Belt_Array.keepMap(match$2.data, (function (jargon) {
          var match = jargon.english.match(regex);
          var match$1 = jargon.korean.match(regex);
          if (match !== null || match$1 !== null) {
            return Caml_option.some(makeRow(jargon));
          }
          
        }));
  return React.createElement("div", {
              className: "grid sm:grid-cols-2 xl:grid-cols-3 gap-x-6 gap-y-2"
            }, rows);
}

var Dictionary = {
  makeRow: makeRow,
  make: Jargon$Dictionary
};

function Jargon$InputForm(Props) {
  var query = Props.query;
  var onChange = Props.onChange;
  return React.createElement("form", {
              className: "max-w-sm mx-auto flex space-x-2"
            }, React.createElement("label", undefined, "검색 (정규식)"), React.createElement("input", {
                  className: "border border-slate-300 rounded-md",
                  placeholder: "Regex: /abs.*[ ].*/",
                  type: "text",
                  value: query,
                  onChange: onChange
                }));
}

var InputForm = {
  make: Jargon$InputForm
};

function Jargon(Props) {
  var match = React.useState(function () {
        return "";
      });
  var setQuery = match[1];
  var query = match[0];
  var onChange = function ($$event) {
    var value = $$event.currentTarget.value;
    Curry._1(setQuery, (function (param) {
            return value;
          }));
  };
  return React.createElement("div", {
              className: "grid gap-4 p-5"
            }, React.createElement(Jargon$InputForm, {
                  query: query,
                  onChange: onChange
                }), React.createElement(Jargon$Dictionary, {
                  query: query
                }));
}

var make = Jargon;

export {
  Dictionary ,
  InputForm ,
  make ,
}
/* react Not a pure module */
