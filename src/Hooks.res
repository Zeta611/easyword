let useDebounce = (value, delay) => {
  let (debouncedValue, setDebouncedValue) = React.useState(_ => value)

  React.useEffect(() => {
    let handler = setTimeout(() => setDebouncedValue(_ => value), delay)

    Some(() => clearTimeout(handler))
  }, (value, delay))

  debouncedValue
}

let useClosingDropdown = id => {
  open! Webapi.Dom

  let close = dropdown => {
    if dropdown->Element.hasAttribute("open") {
      dropdown->Element.removeAttribute("open")
    }
  }

  let closeDropdown = () =>
    switch document->Document.getElementById(id) {
    | Some(dropdown) => dropdown->close
    | None => ()
    }

  React.useEffect0(() => {
    switch document->Document.getElementById(id) {
    | Some(dropdown) => {
        document->Document.addEventListener("click", event => {
          if !(dropdown->Element.contains(~child=event->Event.target->Obj.magic)) {
            dropdown->close
          }
        })
        window->Window.addEventListenerWithOptions(
          "scroll",
          _ => dropdown->close,
          {"capture": false, "once": false, "passive": true},
        )
      }
    | None => ()
    }

    None
  })

  closeDropdown
}
