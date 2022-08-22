@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

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

  if status == "loading" {
    React.string("loading...")
  } else {
    <AppCheckProvider sdk=appCheck>
      <AuthProvider sdk=auth>
        {switch url.path {
        | list{} =>
          <FirestoreProvider sdk=firestore>
            <Home />
          </FirestoreProvider>
        | list{"jargon", id} => <Jargon id />
        | _ => React.string("404")
        }}
      </AuthProvider>
    </AppCheckProvider>
  }
}
