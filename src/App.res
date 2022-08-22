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

  let component = (appCheck, auth, firestore) => {
    <AppCheckProvider sdk=appCheck>
      <AuthProvider sdk=auth>
        {switch url.path {
        | list{} => <Home />
        | list{"jargon"} =>
          <FirestoreProvider sdk=firestore>
            <Jargon />
          </FirestoreProvider>
        | _ => React.string("404")
        }}
      </AuthProvider>
    </AppCheckProvider>
  }

  if %raw(`iOS()`) {
    component(appCheck, auth, app->getFirestore)
  } else {
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
      component(appCheck, auth, firestore)
    }
  }
}
