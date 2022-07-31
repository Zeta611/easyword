exception RootMissing

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => raise(RootMissing)
}
