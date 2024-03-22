open Firebase

@react.component
let make = () => {
  let auth = useAuth()

  React.useEffect(() => {
    let signOut = async () => {
      await auth->Auth.signOut
      RescriptReactRouter.replace("/")
    }
    let _ = signOut()
    None
  })

  React.null
}
