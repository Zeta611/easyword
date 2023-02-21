open Firebase

@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)

  let (displayName, setDisplayName) = React.Uncurried.useState(() => "")
  let handleDisplayNameChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setDisplayName(._ => value)
  }

  let (email, setEmail) = React.Uncurried.useState(() => "")

  let (disabled, setDisabled) = React.Uncurried.useState(() => false)

  let firestore = useFirestore()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if displayName->String.length < 3 {
      Window.alert("필명은 세 글자 이상이어야 해요")
    } else if signedIn {
      switch user->Js.Nullable.toOption {
      | Some({uid, email} as user) =>
        setDisabled(._ => true)

        (
          async () => {
            try {
              let authUpdate = user->Auth.updateProfile({displayName: displayName})

              let docUpdate = {
                async () => {
                  let userDocRef = firestore->doc(~path=`users/${uid}`)
                  let userDoc = await userDocRef->getDoc
                  if !userDoc.exists(.) {
                    await userDocRef->setDoc({"displayName": displayName, "email": email})
                  } else {
                    await userDocRef->updateDoc({"displayName": displayName})
                  }
                }
              }()

              (await Js.Promise2.all([authUpdate, docUpdate]))->ignore

              setDisabled(._ => false)
            } catch {
            | e => Js.log(e)
            }
          }
        )()->ignore
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
  }

  React.useEffect0(() => {
    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some({displayName, email}) =>
        setDisplayName(._ => displayName->Option.getWithDefault(""))
        setEmail(._ => email->Option.getWithDefault(""))

      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }

    None
  })

  if signedIn {
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
              value={email}
              readOnly={true}
              className="input input-bordered input-disabled w-full"
            />
          </label>
          <input type_="submit" value="저장" disabled className="btn btn-primary" />
        </div>
      </form>
    </div>
  } else {
    React.null
  }
}
