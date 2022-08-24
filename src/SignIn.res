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
  } else {
    <div className="h-screen grid justify-center content-center dark:text-white">
      {if !signedIn {
        <StyledFirebaseAuth uiConfig firebaseAuth />
      } else {
        React.string("Already signed in!")
      }}
    </div>
  }
}
