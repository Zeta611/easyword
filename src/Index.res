open Firebase

switch ReactDOM.querySelector("#root") {
| Some(root) =>
  ReactDOM.render(<FirebaseAppProvider firebaseConfig> <App /> </FirebaseAppProvider>, root)
| None => failwith("DOM root is missing")
}
