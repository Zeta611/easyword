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

  let {status, data: firestore} = useInitFirestore(async (app) => {
    let firestore = app->getFirestore
    try {
      await (firestore->enableMultiTabIndexedDbPersistence)
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
            {switch url.path {
            | list{} => <Home />
            | list{"jargon", id} => <JargonPost id />
            | list{"login"} => <SignIn />
            | _ => React.string("404")
            }}
          </FirestoreProvider>
        </AuthProvider>
      </AppCheckProvider>
    }
  }
}
