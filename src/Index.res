%%raw("import './main.css'")

open Firebase

switch ReactDOM.querySelector("#root") {
| Some(rootElement) =>
  let root = ReactDOM.Client.createRoot(rootElement)
  ReactDOM.Client.Root.render(
    root,
    <FirebaseAppProvider firebaseConfig>
      <App />
    </FirebaseAppProvider>,
  )
| None => failwith("DOM root is missing")
}
