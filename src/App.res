@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  open Firebase

  let app = useFirebaseApp()
  let auth = app->getAuth

  let appCheck = initializeAppCheck(
    app,
    {
      provider: createReCaptchaV3Provider(appCheckToken),
      isTokenAutoRefreshEnabled: true,
    },
  )

  // let (firestore, setFirestore) = React.useState(_ => None)
  // React.useEffect0(() => {
  //   let firestore = app->getFirestore
  //   firestore->enableMultiTabIndexedDbPersistence->Js.Promise.then_(() => {
  //     setFirestore(_ => Some(firestore))
  //     Js.Promise.resolve()
  //   }, _)->ignore
  //   setFirestore(_ => Some(firestore))

  //   None
  // })

  let {status, data: firestore} = useInitFirestore(app => {
    // let firestore = app->initializeFirestore()
    let firestore = app->getFirestore
    firestore->enableIndexedDbPersistence->Js.Promise.catch(err => {
      Js.log(err)
      Js.Promise.resolve()
    }, _)->Js.Promise.then_(_ => {
      Js.Promise.resolve(firestore)
    }, _)
  })

  {
    switch url.path {
    | list{} => <Home />
    | list{"jargon"} =>
      if status == "loading" {
        React.string("loading...")
      } else {
        <AppCheckProvider sdk=appCheck>
          <AuthProvider sdk=auth>
            <FirestoreProvider sdk=firestore> <Jargon /> </FirestoreProvider>
          </AuthProvider>
        </AppCheckProvider>
      }
    | _ => React.string("404")
    }
  }
}
