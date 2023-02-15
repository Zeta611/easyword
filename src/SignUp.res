open Firebase

@react.component
let make = () => {
  let {status, data} = useSigninCheck()

  React.useEffect1(() => {
    switch data {
    | None => ()
    | Some({signedIn, user}) =>
      if signedIn {
        switch user->Js.Nullable.toOption {
        | Some({displayName}) =>
          switch displayName {
          | Some(_) => RescriptReactRouter.replace("/")
          | None => ()
          }

        | None => () // Something went wrong
        }
      } else {
        RescriptReactRouter.replace("/login")
      }
    }
    None
  }, [data])

  <div> {"Sign Up"->React.string} </div>
}
