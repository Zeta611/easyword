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

  let (english, setJargon) = React.Uncurried.useState(() => "")
  let handleJargonChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setJargon(._ => value)
  }

  let (korean, setTranslation) = React.Uncurried.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setTranslation(._ => value)
  }

  let (comment, setComment) = React.Uncurried.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(._ => value)
  }

  let addJargon = {
    open Firebase
    let functions = useFirebaseApp()->getFunctions
    functions->httpsCallable("addJargon")
  }

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(_) =>
        setDisabled(._ => true)

        (
          async () => {
            try {
              let result = await addJargon(. ({english, korean, comment}: Jargon.add))
              RescriptReactRouter.replace(`/jargon/${result.data["jargonID"]}`)
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
              value={english}
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
              value={korean}
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
              value={comment}
              onChange={handleCommentChange}
              placeholder="첫 댓글로 달려요"
              className="textarea textarea-bordered w-full"
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
