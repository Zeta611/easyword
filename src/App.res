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

  let {status, data: firestore} = useInitFirestore(async app => app->getFirestore)

  let mathJaxConfig = {
    "loader": {"load": ["[tex]/bussproofs"]},
    "tex": {
      "packages": {"[+]": ["bussproofs"]},
      "inlineMath": [["$", "$"], ["\\(", "\\)"]],
      "displayMath": [["$$", "$$"], ["\\[", "\\]"]],
    },
  }

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
                <React.Suspense
                  fallback={<div className="h-screen grid justify-center content-center">
                    <Loader />
                  </div>}>
                  {
                    open LazyComponents
                    switch url.path {
                    | list{"login"} => <SignIn />
                    | list{"logout"} => <SignOut />

                    | path =>
                      <NavbarContainer>
                        <FooterContainer>
                          {switch path {
                          | list{} =>
                            <ErrorBoundary
                              fallbackRender={({error}) => {
                                Console.error(error)
                                React.null
                              }}>
                              <React.Suspense
                                fallback={<div
                                  className="h-screen grid justify-center content-center">
                                  <Loader />
                                </div>}>
                                <Home />
                              </React.Suspense>
                            </ErrorBoundary>
                          | list{"profile"} => <Profile />
                          | list{"new-jargon"} => <NewJargon />
                          | list{"new-translation", jargonID} => <NewTranslation jargonID />
                          | list{"edit-categories", jargonID} => <EditCategories jargonID />
                          | list{"jargon", jargonID} =>
                            <ErrorBoundary
                              fallbackRender={_ => {
                                <div className="text-3xl px-5 py-5">
                                  {"앗! 404"->React.string}
                                </div>
                              }}>
                              <MathJaxContext config=mathJaxConfig>
                                <JargonPost jargonID />
                              </MathJaxContext>
                            </ErrorBoundary>

                          | list{"trans"} => <Translator />
                          | list{"tips"} => <Tips />
                          | list{"why"} => <Why />
                          | list{"colophon"} => <Colophon />

                          | _ => React.string("404")
                          }}
                        </FooterContainer>
                      </NavbarContainer>
                    }
                  }
                </React.Suspense>
              </RelayWrapper>
            </SignInWrapper>
          </FirestoreProvider>
        </AuthProvider>
      </AppCheckProvider>
    }
  }
}
