@react.component
let make = () => {
  open Firebase

  let app = useFirebaseApp()
  let auth = app->Auth.getAuth

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
              <RelayWrapper>
                {switch url.path {
                | list{"login"} => <SignIn />
                | list{"logout"} => <SignOut />

                | path =>
                  <React.Suspense
                    fallback={<div className="h-screen grid justify-center content-center">
                      <Loader />
                    </div>}>
                    <NavbarContainer>
                      {switch path {
                      | list{} =>
                        <React.Suspense
                          fallback={<div className="h-screen grid justify-center content-center">
                            <Loader />
                          </div>}>
                          <Home />
                        </React.Suspense>
                      | list{"profile"} => <Profile />
                      | list{"new-jargon"} => <NewJargon />
                      | list{"new-translation", jargonID} => <NewTranslation jargonID />
                      | list{"jargon", jargonID} =>
                        <ErrorBoundary
                          fallbackRender={_e => {
                            <div className="text-3xl px-5 py-5"> {"앗! 404"->React.string} </div>
                          }}>
                          <JargonPost jargonID />
                        </ErrorBoundary>

                      | list{"why"} => <Why />
                      | list{"colophon"} => <Colophon />

                      | _ => React.string("404")
                      }}
                    </NavbarContainer>
                  </React.Suspense>
                }}
              </RelayWrapper>
            </SignInWrapper>
          </FirestoreProvider>
        </AuthProvider>
      </AppCheckProvider>
    }
  }
}
