module DisplayNameMutation = %relay(`
  mutation ProfileDisplayNameMutation($uid: String!, $displayName: String!) {
    update_user_by_pk(
      pk_columns: { id: $uid }
      _set: { display_name: $displayName }
    ) {
      id
    }
  }
`)

module SignedInProfile = {
  @react.component
  let make = (~user: Firebase.User.t) => {
    open Firebase
    let firestore = useFirestore()

    let (mutate, _isMutating) = DisplayNameMutation.use()

    let (displayName, setDisplayName) = React.Uncurried.useState(() =>
      user.displayName->Option.getWithDefault("")
    )
    let handleDisplayNameChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setDisplayName(_ => value)
    }

    let (disabled, setDisabled) = React.Uncurried.useState(() => false)

    let handleSubmit = event => {
      // Prevent a page refresh, we are already listening for updates
      ReactEvent.Form.preventDefault(event)

      if displayName->String.length <= 0 {
        Window.alert("필명을 입력해주세요")
      } else {
        setDisabled(_ => true)

        (
          async () => {
            try {
              let authUpdate = user->Auth.updateProfile({displayName: displayName})

              let docUpdate = {
                async () => {
                  let userDocRef = firestore->doc(~path=`users/${user.uid}`)
                  let userDoc = await userDocRef->getDoc
                  if !userDoc.exists() {
                    Js.Console.warn("User document does not exist!")
                    await userDocRef->setDoc({"displayName": displayName, "email": user.email})
                  } else {
                    await userDocRef->updateDoc({"displayName": displayName})
                  }
                }
              }()

              mutate(~variables={uid: user.uid, displayName})->ignore

              (await Js.Promise2.all([authUpdate, docUpdate]))->ignore
            } catch {
            | e => Js.Console.warn(e)
            }
            setDisabled(_ => false)
          }
        )()->ignore
      }
    }

    <div className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"내 정보"->React.string} </h1>
      <form className="mt-8 max-w-md" onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 gap-6">
          <label className="block">
            <label className="label">
              <span className="label-text"> {"필명"->React.string} </span>
            </label>
            <input
              type_="text"
              value={displayName}
              onChange={handleDisplayNameChange}
              className="input input-bordered w-full"
            />
          </label>
          <label className="block">
            <label className="label">
              <span className="label-text"> {"이메일"->React.string} </span>
            </label>
            <input
              type_="email"
              value={user.email->Option.getWithDefault("")}
              readOnly={true}
              className="input input-bordered input-disabled w-full"
            />
          </label>
          <input type_="submit" value="저장" disabled className="btn btn-primary" />
        </div>
      </form>
    </div>
  }
}

@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)
  switch (signedIn, user->Js.Nullable.toOption) {
  | (false, _) | (_, None) => {
      RescriptReactRouter.replace("/login")
      React.null
    }
  | (true, Some(user)) => <SignedInProfile user />
  }
}
