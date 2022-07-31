@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{} => <Home />
  | list{"jargon"} => <Jargon />
  | _ => React.string("404")
  }
}
