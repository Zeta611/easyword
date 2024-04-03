// Insert comment first, and then insert a translation and modify the comment
module JargonMutation = %relay(`
  mutation NewJargonMutation($authorID: String!, $name: String!, $commentContent: String!) {
    insert_jargon_one(object: {author_id: $authorID, name: $name, comments: {data: {author_id: $authorID, content: $commentContent}}}) {
      id
      comments {
        id
      }
    }
  }
`)

module TranslationMutation = %relay(`
  mutation NewJargonTranslationMutation($authorID: String!, $name: String!, $jargonID: uuid!, $commentID: uuid!) {
    insert_translation_one(object: {author_id: $authorID, name: $name, jargon_id: $jargonID, comment_id: $commentID}) {
      id
    }
  }
`)

module CommentMutation = %relay(`
  mutation NewJargonCommentMutation($commentID: uuid!, $translationID: uuid!) {
    update_comment_by_pk(pk_columns: {id: $commentID}, _set: {translation_id: $translationID}) {
      id
    }
  }
`)

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

  let (english, setEnglish) = React.Uncurried.useState(() => "")
  let handleJargonChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setEnglish(_ => value)
  }

  let (korean, setKorean) = React.Uncurried.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(_ => value)
  }

  let (withoutKorean, setWithoutKorean) = React.Uncurried.useState(() => false)

  let (comment, setComment) = React.Uncurried.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(_ => value)
  }

  let (jargonMutate, isJargonMutating) = JargonMutation.use()
  let (translationMutate, isTranslationMutating) = TranslationMutation.use()
  let (commentMutate, isCommentMutating) = CommentMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if english->String.length < 3 {
      Window.alert("용어는 세 글자 이상이어야 해요")
    } else if !withoutKorean && korean->String.length < 1 {
      Window.alert("번역을 입력해주세요")
    } else if signedIn {
      switch user->Js.Nullable.toOption {
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

          jargonMutate(
            ~variables={authorID: user.uid, name: english, commentContent: comment},
            ~onError=error => Js.Console.error(error),
            ~onCompleted=({insert_jargon_one}, _errors) => {
              switch insert_jargon_one {
              | Some({id, comments}) => {
                  let jargonID = id->Base64.retrieveOriginalID
                  let commentID = comments[0]->Option.flatMap(x => x.id->Base64.retrieveOriginalID)
                  switch (jargonID, commentID) {
                  | (Some(jargonID), Some(commentID)) =>
                    translationMutate(
                      ~variables={authorID: user.uid, name: korean, jargonID, commentID},
                      ~onError=error => Js.Console.error(error),
                      ~onCompleted=({insert_translation_one}, _errors) => {
                        switch insert_translation_one {
                        | Some({id: translationID}) =>
                          let translationID = translationID->Base64.retrieveOriginalID
                          switch translationID {
                          | Some(translationID) =>
                            commentMutate(
                              ~variables={commentID, translationID},
                              ~onError=error => Js.Console.error(error),
                              ~onCompleted=(_response, _errors) =>
                                RescriptReactRouter.replace(`/jargon/${id}`),
                            )->ignore
                          | None => {
                              Js.Console.error("Translation mutation failed")
                              RescriptReactRouter.replace(`/jargon/${id}`)
                            }
                          }
                        | None => {
                            Js.Console.error("Translation mutation failed")
                            RescriptReactRouter.replace(`/jargon/${id}`)
                          }
                        }
                      },
                    )->ignore

                  | _ => {
                      Js.Console.error("Translation mutation failed")
                      RescriptReactRouter.replace(`/jargon/${id}`)
                    }
                  }
                }
              | None => ()
              }
            },
          )->ignore
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
            disabled={isJargonMutating || isTranslationMutating || isCommentMutating}
            className="btn btn-primary"
          />
        </div>
      </form>
    </div>
  } else {
    React.null
  }
}
