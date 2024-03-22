@react.component
let make = (~children: React.element) => {
  open Firebase

  let {status, data: signInData} = Firebase.useSigninCheck()
  let firestore = useFirestore()
  let auth = useAuth()
  let (_token, setToken) = React.Uncurried.useState(() => None)

  React.useEffect(() => {
    let userDocUnsub = ref(None)

    let authStateChangeUnsub = auth->Auth.onAuthStateChanged(async user => {
      switch user->Js.Nullable.toOption {
      | Some(user) => {
          let token = await user->Auth.AuthUser.getIdToken(~forceRefresh=false)
          // Js.log(`Initial token: ${token}`)

          let {claims} = await user->Auth.AuthUser.getIdTokenResult(~forceRefresh=false)
          let hasuraClaim = claims->Js.Dict.get("https://hasura.io/jwt/claims")
          // Js.log(`hasuraClaim: ${hasuraClaim->Option.getWithDefault("None")}`)
          switch hasuraClaim {
          | Some(_hasuraClaim) =>
            // Js.log(
            //   `Claim found! ${_hasuraClaim->Js.Json.stringifyAny->Option.getWithDefault("None")}`,
            // )
            setToken(. _ => Some(token))

          | None => {
              let userDocRef = firestore->doc(~path=`users/${user.uid}`)
              // Js.log(`uid: ${user.uid}`)
              userDocUnsub :=
                userDocRef->onSnapshot(
                  async userDoc => {
                    switch userDoc.data(.)->Js.Dict.get("refreshTime") {
                    | Some(_) => {
                        let token = await user->Auth.AuthUser.getIdToken(~forceRefresh=true)
                        // Js.log(`New token: ${token}`)
                        setToken(. _ => Some(token))
                      }
                    | None => () // Js.log("refreshTime not yet found")
                    }
                  },
                )
            }
          }
        }
      | None => setToken(. _ => None)
      }
    })

    Some(
      () => {
        let () = authStateChangeUnsub()

        switch userDocUnsub.contents {
        | None => ()
        | Some(unsub) => unsub()
        }
      },
    )
  })

  switch status {
  | #loading =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>
  | #success =>
    <SignInContext.Provider value={signInData->Option.getExn}> children </SignInContext.Provider>
  }
}
