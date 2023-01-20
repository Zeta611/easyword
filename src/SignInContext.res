open React

let context = createContext({Firebase.signedIn: false, user: None})

module Provider = {
  let make = Context.provider(context)
}
