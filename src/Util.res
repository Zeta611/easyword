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

let useDebounce = (value, delay) => {
  let (debouncedValue, setDebouncedValue) = React.useState(_ => value)

  React.useEffect(() => {
    let handler = setTimeout(() => setDebouncedValue(_ => value), delay)

    Some(() => clearTimeout(handler))
  }, (value, delay))

  debouncedValue
}
