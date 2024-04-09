module NewJargonMutation = %relay(`
  mutation NewJargonMutation(
    $id: uuid!
    $authorID: String!
    $name: String!
    $translationID: uuid!
    $translation: String!
    $commentID: uuid!
    $comment: String!
  ) {
    insert_jargon_one(
      object: {
        id: $id
        author_id: $authorID
        name: $name
        comments: {
          data: {
            id: $commentID
            author_id: $authorID
            translation_id: $translationID
            content: $comment
          }
        }
        translations: {
          data: {
            id: $translationID
            comment_id: $commentID
            author_id: $authorID
            name: $translation
          }
        }
      }
    ) {
      id
    }
  }
`)

module NewJargonWithoutTranslationMutation = %relay(`
  mutation NewJargonWithoutTranslationMutation(
    $id: uuid!
    $authorID: String!
    $name: String!
    $commentID: uuid!
    $comment: String!
  ) {
    insert_jargon_one(
      object: {
        id: $id
        author_id: $authorID
        name: $name
        comments: {
          data: {
            id: $commentID
            author_id: $authorID
            content: $comment
          }
        }
      }
    ) {
      id
    }
  }
`)

@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)

  React.useEffect0(() => {
    if signedIn {
      switch user->Nullable.toOption {
      | Some(_) => ()
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
    None
  })

  let (english, setEnglish) = React.useState(() => "")
  let handleJargonChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setEnglish(_ => value)
  }

  let (korean, setKorean) = React.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(_ => value)
  }

  let (withoutKorean, setWithoutKorean) = React.useState(() => false)

  let (comment, setComment) = React.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(_ => value)
  }

  let (newJargonMutate, isNewJargonMutating) = NewJargonMutation.use()
  let (
    newJargonWithoutTranslationMutate,
    isNewJargonWithoutTranslationMutating,
  ) = NewJargonWithoutTranslationMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if english->String.length < 1 {
      Window.alert("용어를 입력해주세요")
    } else if !withoutKorean && korean->String.length < 1 {
      Window.alert("번역을 입력해주세요")
    } else if signedIn {
      switch user->Nullable.toOption {
      | Some(user) => {
          let comment = switch comment {
          | "" =>
            if !withoutKorean {
              `${korean->Util.eulLeul} 제안합니다.`
            } else {
              `"${english}" 용어의 번역이 필요합니다.`
            }
          | _ => comment
          }

          let (jargonID, translationID, commentID) = (Uuid.v4(), Uuid.v4(), Uuid.v4())

          if withoutKorean {
            newJargonWithoutTranslationMutate(
              ~variables={
                id: jargonID,
                commentID,
                authorID: user.uid,
                name: english,
                comment,
              },
              ~onError=error => Js.Console.error(error),
              ~onCompleted=({insert_jargon_one}, _errors) => {
                switch insert_jargon_one {
                | Some({id}) => RescriptReactRouter.replace("/jargon/" ++ id)
                | None => ()
                }
              },
            )->ignore
          } else {
            newJargonMutate(
              ~variables={
                id: jargonID,
                translationID,
                commentID,
                authorID: user.uid,
                name: english,
                comment,
                translation: korean,
              },
              ~onError=error => Js.Console.error(error),
              ~onCompleted=({insert_jargon_one}, _errors) => {
                switch insert_jargon_one {
                | Some({id}) => RescriptReactRouter.replace("/jargon/" ++ id)
                | None => ()
                }
              },
            )->ignore
          }
        }
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
  }

  if signedIn {
    <div className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"쉬운 전문용어 제안하기"->React.string} </h1>
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
              {React.cloneElement(
                <div className="flex gap-1 text-xs place-items-center tooltip tooltip-bottom">
                  <input
                    type_="checkbox"
                    className="checkbox checkbox-secondary"
                    checked={withoutKorean}
                    onChange={_ => setWithoutKorean(v => !v)}
                  />
                  {"번역 없이 제안하기"->React.string}
                </div>,
                {"data-tip": "번역을 제안하지 않고 용어를 추가해보세요"},
              )}
            </label>
            <input
              type_="text"
              value={korean}
              disabled={withoutKorean}
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
          <input
            type_="submit"
            value="제안하기"
            disabled={isNewJargonMutating || isNewJargonWithoutTranslationMutating}
            className="btn btn-primary"
          />
        </div>
      </form>
    </div>
  } else {
    React.null
  }
}
