@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)

  React.useEffect0(() => {
    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(_) => ()
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
    None
  })

  let (disabled, setDisabled) = React.Uncurried.useState(() => false)

  let (jargon, setJargon) = React.Uncurried.useState(() => "")
  let handleJargonChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setJargon(._ => value)
  }

  let (translation, setTranslation) = React.Uncurried.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setTranslation(._ => value)
  }

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(user) =>
        setDisabled(._ => true)

        (
          async () => {
            try {
              // await user->Auth.updateProfile({displayName: displayName})
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

  if signedIn {
    <div className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"쉬운 번역 제안하기"->React.string} </h1>
      <form className="mt-8 max-w-md" onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 gap-6">
          <label className="block">
            <label className="label">
              <span className="label-text"> {"원어"->React.string} </span>
            </label>
            <input
              type_="text"
              value={jargon}
              onChange={handleJargonChange}
              placeholder="separated sum"
              className="input input-bordered w-full"
            />
          </label>
          <label className="block">
            <label className="label">
              <span className="label-text"> {"번역"->React.string} </span>
            </label>
            <input
              type_="text"
              value={translation}
              onChange={handleTranslationChange}
              placeholder="출신을 기억하는 합"
              className="input input-bordered w-full"
            />
          </label>
          <label className="block">
            <label className="label">
              <span className="label-text"> {"의견"->React.string} </span>
            </label>
            <textarea
              placeholder="첫 댓글로 달려요" className="textarea textarea-bordered w-full"
            />
          </label>
          <input type_="submit" value="제안하기" disabled className="btn btn-primary" />
        </div>
      </form>
    </div>
  } else {
    React.null
  }
}
