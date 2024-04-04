open React

let context = createContext({Firebase.signedIn: false, user: Nullable.null})

module Provider = {
  let make = Context.provider(context)
}
