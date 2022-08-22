%%raw(`
function iOS() {
  return [
    'iPad Simulator',
    'iPhone Simulator',
    'iPod Simulator',
    'iPad',
    'iPhone',
    'iPod'
  ].includes(navigator.platform)
  // iPad on iOS 13 detection
  || (navigator.userAgent.includes("Mac") && "ontouchend" in document)
}`)

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

  if %raw(`iOS()`) {
    let firestore = app->getFirestore
    <AppCheckProvider sdk=appCheck>
      <AuthProvider sdk=auth>
        {switch url.path {
        | list{} => <Home />
        | list{"jargon"} => <FirestoreProvider sdk=firestore> <Jargon /> </FirestoreProvider>
        | _ => React.string("404")
        }}
      </AuthProvider>
    </AppCheckProvider>
  } else {
    let {status, data: firestore} = useInitFirestore(app => {
      let firestore = app->getFirestore
      firestore->enableIndexedDbPersistence->Js.Promise.catch(err => {
        Js.log(err)
        Js.Promise.resolve()
      }, _)->Js.Promise.then_(_ => {
        Js.Promise.resolve(firestore)
      }, _)
    })

    if status == "loading" {
      React.string("loading...")
    } else {
      <AppCheckProvider sdk=appCheck>
        <AuthProvider sdk=auth>
          {switch url.path {
          | list{} => <Home />
          | list{"jargon"} => <FirestoreProvider sdk=firestore> <Jargon /> </FirestoreProvider>
          | _ => React.string("404")
          }}
        </AuthProvider>
      </AppCheckProvider>
    }
  }
}
