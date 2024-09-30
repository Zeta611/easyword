open Firebase
open ReactSocialLoginButtons

let uiConfig = {
  "signInFlow": "popup",
  "signInOptions": [Auth.GoogleAuthProvider.providerID],
  "callbacks": {
    "signInSuccessWithAuthResult": () => false,
  },
}

@react.component
let make = () => {
  let {status, data} = useSigninCheck()

  let firestore = useFirestore()

  React.useEffect1(() => {
    // Js.Console.log(data)
    switch data {
    | None => ()
    | Some({signedIn, user}) =>
      if signedIn {
        switch user->Nullable.toOption {
        | Some({uid, displayName, email, photoURL}) =>
          // Set uid. This is safe due to the security rule:
          // allow write: if request.auth.uid == uid;

          (
            async () => {
              let userDocRef = firestore->doc(~path=`users/${uid}`)
              await userDocRef->setDoc2(
                {
                  "displayName": displayName,
                  "email": email,
                  "photoURL": photoURL,
                },
                {"merge": true},
              )

              switch displayName {
              | Some(_) => RescriptReactRouter.replace("/")
              | None => RescriptReactRouter.replace("/profile")
              }
            }
          )()->ignore

        | None => () // Something went wrong
        }
      }
    }
    None
  }, [data])

  let auth = useAuth()

  switch status {
  | #loading =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>

  | #success =>
    switch data {
    | None | Some({signedIn: true}) => React.null
    | Some({signedIn: false}) =>
      <div
        className="h-screen bg-cover bg-center bg-[url('/layered-waves.svg')] justify-self-stretch grid justify-center content-center">
        <div
          className="h-96 w-96 place-content-center bg-zinc-50 bg-opacity-30 backdrop-blur-lg drop-shadow-lg rounded-xl grid content-center gap-3 text-zinc-800 dark:text-zinc-50">
          <div className="text-3xl font-normal text-center"> {React.string(`로그인`)} </div>
          <GoogleLoginButton
            onClick={() => {
              open Auth
              signInWithPopup(auth, FederatedAuthProvider.googleAuthProvider())->ignore
            }}>
            <div className="text-sm"> {"Sign in with Google"->React.string} </div>
          </GoogleLoginButton>
        </div>
      </div>
    }
  }
}
