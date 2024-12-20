let getCode = c => c->String.charCodeAt(0)->Float.toInt

let endsWithJong = korean => {
  let c = korean->String.charAt(korean->String.length - 1)
  if "가" <= c && c <= "힣" {
    mod(c->getCode - "가"->getCode, 28) > 0
  } else {
    false
  }
}

let eulLeul = korean => {
  korean ++ if korean->endsWithJong {
    "을"
  } else {
    "를"
  }
}

let sanitize = word => word->String.replaceRegExp(%re(`/\s+/g`), " ")->String.trim

let badgify = (~onClick=_ => (), text) =>
  <button key={text} onClick className="badge badge-md font-semibold">
    {text->React.string}
  </button>

@val external htmlDialogElement: 'a = "HTMLDialogElement"
let asHtmlDialogElement: Webapi.Dom.Element.t => option<'htmlDialogElement> = %raw(`
    function(element) {
      if ((window.constructor.name !== undefined && /^HTMLDialogElement$/.test(element.constructor.name))
          || (/^\[object HTMLDialogElement\]$/.test(element.constructor.toString()))) {
        return element;
      }
    }
  `)
