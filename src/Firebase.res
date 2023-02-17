type firebaseConfig
@module("./firebaseConfig")
external firebaseConfig: firebaseConfig = "firebaseConfig"

module FirebaseAppProvider = {
  @react.component @module("reactfire")
  external make: (~firebaseConfig: firebaseConfig, ~children: React.element) => React.element =
    "FirebaseAppProvider"
}

module FirebaseOptions = {
  type t
}

module FirebaseApp = {
  type t = {options: FirebaseOptions.t}
}

@module("reactfire")
external useFirebaseApp: unit => FirebaseApp.t = "useFirebaseApp"

// @module("firebase/app")
// external initializeApp: firebaseConfig => firebaseApp = "initializeApp"

// type analytics
// @module("firebase/analytics")
// external getAnalytics: firebaseApp => analytics = "getAnalytics"

type firestore
@module("firebase/firestore")
external getFirestore: FirebaseApp.t => firestore = "getFirestore"

module FirestoreProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: firestore, ~children: React.element) => React.element = "FirestoreProvider"
}

// TODO: Bind TS string union `status`
type observableStatus<'a> = {status: @string [#loading | #success], data: option<'a>}
@module("reactfire")
external useInitFirestore: (FirebaseApp.t => promise<firestore>) => observableStatus<_> =
  "useInitFirestore"

@module("reactfire")
external useFirestore: unit => firestore = "useFirestore"

@module("firebase/firestore")
external enableIndexedDbPersistence: firestore => promise<unit> = "enableIndexedDbPersistence"

@module("firebase/firestore")
external enableMultiTabIndexedDbPersistence: firestore => promise<unit> =
  "enableMultiTabIndexedDbPersistence"

type documentReference
@module("firebase/firestore")
external doc: (firestore, ~path: string) => documentReference = "doc"

type collectionReference
@module("firebase/firestore")
external collection: (firestore, ~path: string) => collectionReference = "collection"

type query
type queryConstraint
@module("firebase/firestore")
external query: (collectionReference, queryConstraint) => query = "query"

@module("firebase/firestore")
external orderBy: (string, ~direction: [#asc | #desc]) => queryConstraint = "orderBy"

type documentSnapshot<'a> = {exists: (. unit) => bool, data: (. unit) => 'a}
@module("firebase/firestore")
external getDoc: documentReference => promise<documentSnapshot<'a>> = "getDoc"

@module("firebase/firestore")
external setDoc: (documentReference, 'a) => promise<unit> = "setDoc"

@module("firebase/firestore")
external updateDoc: (documentReference, 'a) => promise<unit> = "updateDoc"

@module("firebase/firestore")
external addDoc: (collectionReference, 'a) => promise<documentReference> = "addDoc"

type aggregateSpecData = {count: int}
type aggregateQuerySnapshot = {data: (. unit) => aggregateSpecData}
@module("firebase/firestore")
external getCountFromServer: collectionReference => promise<aggregateQuerySnapshot> =
  "getCountFromServer"

@deriving(abstract)
type reactFireOptions<'a> = {
  @optional idField: string,
  @optional initialData: 'a,
  @optional suspense: bool,
}

@module("reactfire")
external useFirestoreDocData: documentReference => observableStatus<_> = "useFirestoreDocData"

@module("reactfire")
external useFirestoreCollectionData: (
  query,
  ~options: reactFireOptions<_>=?,
  unit,
) => observableStatus<_> = "useFirestoreCollectionData"

module User = {
  @deriving(accessors)
  type info = {
    uid: string,
    providerId: string,
    displayName: option<string>,
    email: option<string>,
  }
  type t = {
    uid: string,
    displayName: option<string>,
    email: option<string>,
    emailVerified: bool,
    providerData: array<info>,
  }
}

module Auth = {
  type t = {app: FirebaseApp.t}
  type update = {displayName?: string, photoURL?: string}

  @send
  external onAuthStateChanged: (t, 'user) => 'unsubscribe = "onAuthStateChanged"

  @module("firebase/auth")
  external signOut: t => promise<unit> = "signOut"

  @module("firebase/auth")
  external updateProfile: (User.t, update) => promise<unit> = "updateProfile"

  module EmailAuthProvider = {
    let providerID = "password"
  }
  module GithubAuthProvider = {
    let providerID = "github.com"
  }
  module GoogleAuthProvider = {
    let providerID = "google.com"
  }
}

@module("firebase/auth")
external getAuth: FirebaseApp.t => Auth.t = "getAuth"

module AuthProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: Auth.t, ~children: React.element) => React.element = "AuthProvider"
}

@module("reactfire")
external useAuth: unit => Auth.t = "useAuth"

// TODO: The domain modeling seems a bit off--what does it mean when signedIn is false and there is a user?
type signInCheckResult = {signedIn: bool, user: Js.Nullable.t<User.t>}
@module("reactfire")
external useSigninCheck: unit => observableStatus<signInCheckResult> = "useSigninCheck"

type appCheckToken
@module("./firebaseConfig")
external appCheckToken: appCheckToken = "APP_CHECK_TOKEN"

type reCaptchaV3Provider
@new @module("firebase/app-check")
external createReCaptchaV3Provider: appCheckToken => reCaptchaV3Provider = "ReCaptchaV3Provider"

type appCheck
type appCheckConfig = {provider: reCaptchaV3Provider, isTokenAutoRefreshEnabled: bool}
@module("firebase/app-check")
external initializeAppCheck: (FirebaseApp.t, appCheckConfig) => appCheck = "initializeAppCheck"

module AppCheckProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: appCheck, ~children: React.element) => React.element = "AppCheckProvider"
}

module Timestamp = {
  type t
  @new @module("firebase/firestore")
  external make: unit => t = "Timestamp"
  @send
  external toDate: t => Js.Date.t = "toDate"
  @module("firebase/firestore") @scope("Timestamp")
  external fromDate: Js.Date.t => t = "fromDate"
}

module StyledFirebaseAuth = {
  @react.component @module("react-firebaseui")
  external make: (~uiConfig: 'uiConfig, ~firebaseAuth: 'a) => React.element = "StyledFirebaseAuth"
}

module FirebaseCompat = {
  type firebase

  @module("firebase/compat/app")
  external firebase: firebase = "default"

  @send
  external initializeApp: (firebase, FirebaseOptions.t) => FirebaseApp.t = "initializeApp"
}

type functions
@module("firebase/functions")
external getFunctions: (FirebaseApp.t, @as("asia-northeast3") _) => functions = "getFunctions"

type callResult<'a> = {data: 'a}
@module("firebase/functions")
external httpsCallable: (functions, string) => (. 'a) => promise<callResult<'b>> = "httpsCallable"
