@react.component
let make = (~children: React.element) => {
  open Firebase

  let {status, data: signInData} = Firebase.useSigninCheck()
  let firestore = useFirestore()
  let auth = useAuth()
  let (token, setToken) = React.Uncurried.useState(() => None)
  // Console.log(`token: ${token->Option.getOr("None")}`)

  React.useEffectOnEveryRender(() => {
    let userDocUnsub = ref(None)

    let authStateChangeUnsub = auth->Auth.onAuthStateChanged(async user => {
      switch user->Nullable.toOption {
      | Some(user) => {
          let token = await user->Auth.AuthUser.getIdToken(~forceRefresh=false)
          // Console.log(`Initial token: ${token}`)

          let {claims} = await user->Auth.AuthUser.getIdTokenResult(~forceRefresh=false)
          let hasuraClaim = claims->Dict.get("https://hasura.io/jwt/claims")
          // Console.log(`hasuraClaim: ${hasuraClaim->Option.getOr("None")}`)
          switch hasuraClaim {
          | Some(_hasuraClaim) =>
            // Console.log(
            //   `Claim found! ${_hasuraClaim->JSON.Encode.stringifyAny->Option.getOr("None")}`,
            // )
            setToken(_ => Some(token))

          | None => {
              let userDocRef = firestore->doc(~path=`users/${user.uid}`)
              // Console.log(`uid: ${user.uid}`)
              userDocUnsub :=
                userDocRef->onSnapshot(
                  async userDoc => {
                    switch userDoc.data()->Dict.get("refreshTime") {
                    | Some(_) => {
                        let token = await user->Auth.AuthUser.getIdToken(~forceRefresh=true)
                        // Console.log(`New token: ${token}`)
                        setToken(_ => Some(token))
                      }
                    | None => () // Console.log("refreshTime not yet found")
                    }
                  },
                )
            }
          }
        }
      | None => setToken(_ => None)
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
    <SignInContext.Provider value={signInData->Option.getExn}>
      <TokenContext.Provider value={token}> children </TokenContext.Provider>
    </SignInContext.Provider>
  }
}
