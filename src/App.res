@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  open Firebase

  let {status, data: firestoreInstance} = useInitFirestore(firebaseApp => {
    let db = firebaseApp->getFirestore
    db
    ->enableMultiTabIndexedDbPersistence
    ->Js.Promise.then_(_ => Js.Promise.resolve(db), _)
    ->Js.Promise.catch(err => {
      Js.log(err)
      Js.Promise.resolve(db)
    }, _)
  })

  if status == "loading" {
    React.string("loading...")
  } else {
    switch url.path {
    | list{} => <Home />
    | list{"jargon"} => <FirestoreProvider sdk=firestoreInstance> <Jargon /> </FirestoreProvider>
    | _ => React.string("404")
    }
  }
}
