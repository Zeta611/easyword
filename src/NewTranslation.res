@react.component
let make = (~jargonID: string) => {
  let {signedIn, user} = React.useContext(SignInContext.context)

  let (english, setEnglish) = React.Uncurried.useState(() => "")

  let firestore = Firebase.useFirestore()

  React.useEffect0(() => {
    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(_) => ()
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }

    (
      async () => {
        open Firebase
        let jargonDocRef = firestore->doc(~path=`jargons/${jargonID}`)
        let jargonDoc = await jargonDocRef->getDoc
        if jargonDoc.exists(.) {
          setEnglish(._ => jargonDoc.data(.)["english"])
        }
      }
    )()->ignore

    None
  })

  let (disabled, setDisabled) = React.Uncurried.useState(() => false)

  let (korean, setKorean) = React.Uncurried.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(._ => value->Js.String2.trim)
  }

  let (comment, setComment) = React.Uncurried.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(._ => value->Js.String2.trim)
  }

  let addTranslation = {
    open Firebase
    let functions = useFirebaseApp()->getFunctions
    functions->httpsCallable("addTranslation")
  }

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if korean->String.length < 3 {
      Window.alert("용어는 세 글자 이상이어야 해요")
    } else if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(_) =>
        setDisabled(._ => true)

        (
          async () => {
            let comment = switch comment {
            | "" => `${korean->Util.eulLeul} 제안합니다.`
            | _ => comment
            }
            try {
              let _ = await addTranslation(.
                ({id: jargonID, korean, comment}: Jargon.addTranslation),
              )
              RescriptReactRouter.replace(`/jargon/${jargonID}`)
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
      <h2> {`${english}의 쉬운 전문용어 제안하기`->React.string} </h2>
      <form className="mt-8 max-w-md" onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 gap-6">
          <label className="block">
            <label className="label">
              <span className="label-text"> {"번역"->React.string} </span>
            </label>
            <input
              type_="text"
              value={korean}
              onChange={handleTranslationChange}
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
              placeholder="새 댓글로 달려요"
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
