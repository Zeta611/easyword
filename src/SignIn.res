open Firebase

let uiConfig = {
  "signInFlow": "popup",
  "signInOptions": [Auth.EmailAuthProvider.providerID, Auth.GithubAuthProvider.providerID],
  "callbacks": {
    "signInSuccessWithAuthResult": () => false,
  },
}

@react.component
let make = () => {
  let {status, data: {signedIn}} = useSigninCheck()

  // This uses a v8 auth instance
  // See https://github.com/FirebaseExtended/reactfire/discussions/474
  let app = FirebaseCompat.firebase->FirebaseCompat.initializeApp(useAuth().app.options)
  let firebaseAuth = app->getAuth

  if status == "loading" {
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>
  } else if signedIn {
    RescriptReactRouter.push(`/`)
    React.null
  } else {
    <div
      className="h-screen bg-cover bg-center bg-[url('/assets/layered-waves.svg')] justify-self-stretch grid justify-center content-center">
      <div
        className="h-96 w-96 bg-zinc-50 bg-opacity-30 backdrop-blur-lg drop-shadow-lg rounded-xl grid content-center gap-3 text-zinc-800 dark:text-zinc-50">
        <div className="text-3xl font-medium text-center"> {React.string(`로그인`)} </div>
        <StyledFirebaseAuth uiConfig firebaseAuth />
      </div>
    </div>
  }
}
