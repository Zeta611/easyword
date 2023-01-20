@react.component
let make = (~children: React.element) => {
  let {signedIn} = React.useContext(SignInContext.context)
  <div>
    <Navbar signedIn />
    children
  </div>
}
