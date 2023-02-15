module SignInWrapper = {
  @react.component
  let make = (~children: React.element) => {
    let {status, data: signInData} = Firebase.useSigninCheck()

    switch status {
    | #loading =>
      <div className="h-screen grid justify-center content-center">
        <Loader />
      </div>
    | #success =>
      <SignInContext.Provider value={signInData->Option.getExn}> children </SignInContext.Provider>
    }
  }
}

@react.component
let make = () => {
  open Firebase

  let app = useFirebaseApp()
  let auth = app->getAuth

  // let () = %raw(`self.FIREBASE_APPCHECK_DEBUG_TOKEN = true`)

  let appCheck = initializeAppCheck(
    app,
    {
      provider: createReCaptchaV3Provider(appCheckToken),
      isTokenAutoRefreshEnabled: true,
    },
  )

  let {status, data: firestore} = useInitFirestore(async app => {
    let firestore = app->getFirestore
    try {
      await firestore->enableMultiTabIndexedDbPersistence
    } catch {
    | Js.Exn.Error(err) => Js.log(err)
    }
    firestore
  })

  let url = RescriptReactRouter.useUrl()

  switch status {
  | #loading =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>

  | #success =>
    switch firestore {
    | None => React.null
    | Some(firestore) =>
      <AppCheckProvider sdk=appCheck>
        <AuthProvider sdk=auth>
          <FirestoreProvider sdk=firestore>
            <SignInWrapper>
              {switch url.path {
              | list{"login"} => <SignIn />
              | list{"logout"} => <SignOut />
              | path =>
                <NavbarContainer>
                  {switch path {
                  | list{} => <Home />
                  | list{"profile"} => <Profile />
                  | list{"jargon", jargonID} => <JargonPost jargonID />

                  | _ => React.string("404")
                  }}
                </NavbarContainer>
              }}
            </SignInWrapper>
          </FirestoreProvider>
        </AuthProvider>
      </AppCheckProvider>
    }
  }
}
