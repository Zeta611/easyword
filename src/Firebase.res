type firebaseConfig
@module("./firebaseConfig")
external firebaseConfig: firebaseConfig = "firebaseConfig"

type firebaseApp
@module("firebase/app")
external initializeApp: firebaseConfig => firebaseApp = "initializeApp"

type analytics
@module("firebase/analytics")
external getAnalytics: firebaseApp => analytics = "getAnalytics"

type firestore
@module("firebase/firestore")
external getFirestore: firebaseApp => firestore = "getFirestore"

type collectionReference
@module("firebase/firestore")
external collection: (firestore, ~path: string) => collectionReference = "collection"

type query
type queryConstraint
@module("firebase/firestore")
external query: (collectionReference, queryConstraint) => query = "query"

@module("firebase/firestore")
external orderBy: (string, ~order: string=?, unit) => queryConstraint = "orderBy"

module DocSnapshot = {
  type t

  @get external exists: t => bool = "exists"
  @get external id: t => string = "id"
  @send external data: (t, unit) => 'a = "data"
}

module QuerySnapshot = {
  type t

  @get external docs: t => array<DocSnapshot.t> = "docs"
  @get external size: t => int = "size"
}

type unsubscribe = unit => unit
@module("firebase/firestore")
external onSnapshot: (query, QuerySnapshot.t => unit) => unsubscribe = "onSnapshot"

@module("firebase/firestore")
external addDoc: (collectionReference, 'a) => Js.Promise.t<'b> = "addDoc"

type auth
@module("firebase/auth")
external getAuth: firebaseApp => auth = "getAuth"

type firebaseServices = {
  firebaseApp: firebaseApp,
  analytics: analytics,
  firestore: firestore,
  auth: auth,
}

let initializeServices = () => {
  let firebaseApp = firebaseConfig->initializeApp
  let analytics = firebaseApp->getAnalytics
  let firestore = firebaseApp->getFirestore
  let auth = firebaseApp->getAuth
  {firebaseApp: firebaseApp, analytics: analytics, firestore: firestore, auth: auth}
}

let getFirebase = initializeServices
