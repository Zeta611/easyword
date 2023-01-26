open React

let context = createContext({Firebase.signedIn: false, user: Js.Nullable.null})

module Provider = {
  let make = Context.provider(context)
}
