open React

let context = createContext((None: option<string>))

module Provider = {
  let make = Context.provider(context)
}
