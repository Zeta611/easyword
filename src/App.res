@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  open Firebase

  let app = useFirebaseApp()
  let auth = app->getAuth
  let () = %raw(`self.FIREBASE_APPCHECK_DEBUG_TOKEN = true`)
  let appCheck = initializeAppCheck(
    app,
    {
      provider: createReCaptchaV3Provider(appCheckToken),
      isTokenAutoRefreshEnabled: true,
    },
  )

  // let (firestore, setFirestore) = React.useState(_ => None)
  // React.useEffect0(() => {
  let firestore = app->getFirestore
  //   firestore->enableMultiTabIndexedDbPersistence->Js.Promise.then_(() => {
  //     setFirestore(_ => Some(firestore))
  //     Js.Promise.resolve()
  //   }, _)->ignore
  //   setFirestore(_ => Some(firestore))

  //   None
  // })

  // let {status, data: firestore} = useInitFirestore(app => {
  //   // let firestore = app->initializeFirestore()
  //   let firestore = app->getFirestore
  //   firestore->enableIndexedDbPersistence->Js.Promise.catch(err => {
  //     Js.log(err)
  //     Js.Promise.resolve()
  //   }, _)->Js.Promise.then_(_ => {
  //     Js.Promise.resolve(firestore)
  //   }, _)
  // })

  // if status == "loading" {
  //   React.string("loading...")
  // } else {
  // switch firestore {
  // | None => React.string("loading...")
  // | Some(firestore) =>
  <AppCheckProvider sdk=appCheck>
    <AuthProvider sdk=auth>
      {switch url.path {
      | list{} => <Home />
      | list{"jargon"} => <FirestoreProvider sdk=firestore> <Jargon /> </FirestoreProvider>
      | _ => React.string("404")
      }}
    </AuthProvider>
  </AppCheckProvider>
  // }
  // }
}
