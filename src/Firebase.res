type firebaseConfig
@module("./firebaseConfig")
external firebaseConfig: firebaseConfig = "firebaseConfig"

module FirebaseAppProvider = {
  @react.component @module("reactfire")
  external make: (~firebaseConfig: firebaseConfig, ~children: React.element) => React.element =
    "FirebaseAppProvider"
}

type firebaseApp
@module("reactfire")
external useFirebaseApp: unit => firebaseApp = "useFirebaseApp"

// @module("firebase/app")
// external initializeApp: firebaseConfig => firebaseApp = "initializeApp"

// type analytics
// @module("firebase/analytics")
// external getAnalytics: firebaseApp => analytics = "getAnalytics"

type firestore
@module("firebase/firestore")
external getFirestore: firebaseApp => firestore = "getFirestore"

module FirestoreProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: firestore, ~children: React.element) => React.element = "FirestoreProvider"
}

// TODO: Bind TS string union `status`
type observableStatus<'a> = {status: string, data: 'a}
@module("reactfire")
external useInitFirestore: (firebaseApp => Js.Promise.t<firestore>) => observableStatus<_> =
  "useInitFirestore"

@module("reactfire")
external useFirestore: unit => firestore = "useFirestore"

@module("firebase/firestore")
external enableIndexedDbPersistence: firestore => Js.Promise.t<unit> = "enableIndexedDbPersistence"

@module("firebase/firestore")
external enableMultiTabIndexedDbPersistence: firestore => Js.Promise.t<unit> =
  "enableMultiTabIndexedDbPersistence"

type collectionReference
@module("firebase/firestore")
external collection: (firestore, ~path: string) => collectionReference = "collection"

type query
type queryConstraint
@module("firebase/firestore")
external query: (collectionReference, queryConstraint) => query = "query"

@module("firebase/firestore")
external orderBy: (string, ~direction: string) => queryConstraint = "orderBy"

@deriving(abstract)
type reactFireOptions<'a> = {
  @optional idField: string,
  @optional initialData: 'a,
  @optional suspense: bool,
}

@module("reactfire")
external useFirestoreCollectionData: (query, reactFireOptions<_>) => observableStatus<_> =
  "useFirestoreCollectionData"

type auth
@module("firebase/auth")
external getAuth: firebaseApp => auth = "getAuth"

module AuthProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: auth, ~children: React.element) => React.element = "AuthProvider"
}

type appCheckToken
@module("./firebaseConfig")
external appCheckToken: appCheckToken = "APP_CHECK_TOKEN"

type reCaptchaV3Provider
@new @module("firebase/app-check")
external createReCaptchaV3Provider: appCheckToken => reCaptchaV3Provider = "ReCaptchaV3Provider"

type appCheck
type appCheckConfig = {provider: reCaptchaV3Provider, isTokenAutoRefreshEnabled: bool}
@module("firebase/app-check")
external initializeAppCheck: (firebaseApp, appCheckConfig) => appCheck = "initializeAppCheck"

module AppCheckProvider = {
  @react.component @module("reactfire")
  external make: (~sdk: appCheck, ~children: React.element) => React.element = "AppCheckProvider"
}
