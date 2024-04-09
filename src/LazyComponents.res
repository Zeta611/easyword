module SignIn = {
  let make = React.lazy_(() => Js.import(SignIn.make))
}

module SignOut = {
  let make = React.lazy_(() => Js.import(SignOut.make))
}

module Profile = {
  let make = React.lazy_(() => Js.import(Profile.make))
}

module NewJargon = {
  let make = React.lazy_(() => Js.import(NewJargon.make))
}

module NewTranslation = {
  let make = React.lazy_(() => Js.import(NewTranslation.make))
}

module JargonPost = {
  let make = React.lazy_(() => Js.import(JargonPost.make))
}

module Why = {
  let make = React.lazy_(() => Js.import(Why.make))
}

module Colophon = {
  let make = React.lazy_(() => Js.import(Colophon.make))
}
