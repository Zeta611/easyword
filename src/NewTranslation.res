module JargonQuery = %relay(`
  query NewTranslationJargonQuery($id: ID!) {
    node(id: $id) {
      ... on jargon {
        name
      }
    }
  }
`)

module NewCommentMutation = %relay(`
  mutation NewTranslationNewCommentMutation($authorID: String!, $content: String!, $jargonID: Int!) {
    insert_comment_one(object: {author_id: $authorID, content: $content, jargon_id: $jargonID}) {
      id
    }
  }
`)

module TranslationMutation = %relay(`
  mutation NewTranslationMutation($authorID: String!, $name: String!, $jargonID: Int!, $commentID: Int!) {
    insert_translation_one(object: {author_id: $authorID, name: $name, jargon_id: $jargonID, comment_id: $commentID}) {
      id
    }
  }
`)

module CommentMutation = %relay(`
  mutation NewTranslationCommentMutation($commentID: Int!, $translationID: Int!) {
    update_comment_by_pk(pk_columns: {id: $commentID}, _set: {translation_id: $translationID}) {
      id
    }
  }
`)

@react.component
let make = (~jargonID: string) => {
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

  let (korean, setKorean) = React.Uncurried.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(_ => value)
  }

  let (comment, setComment) = React.Uncurried.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(_ => value)
  }

  let (newCommentMutate, isNewCommentMutating) = NewCommentMutation.use()
  let (translationMutate, isTranslationMutating) = TranslationMutation.use()
  let (commentMutate, isCommentMutating) = CommentMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if korean->String.length < 1 {
      Window.alert("번역을 입력해주세요")
    } else if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(user) =>
        let comment = switch comment {
        | "" => `${korean->Util.eulLeul} 제안합니다.`
        | _ => comment
        }
        let (id, jargonID) = (jargonID, jargonID->Base64.retrieveOriginalID)
        switch jargonID {
        | Some(jargonID) =>
          newCommentMutate(
            ~variables={authorID: user.uid, content: comment, jargonID},
            ~onError=error => Js.Console.error(error),
            ~onCompleted=({insert_comment_one}, _errors) => {
              switch insert_comment_one {
              | Some({id: commentID}) => {
                  let commentID = commentID->Base64.retrieveOriginalID
                  switch commentID {
                  | Some(commentID) =>
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
                      Js.Console.error("Comment mutation failed")
                      RescriptReactRouter.replace(`/jargon/${id}`)
                    }
                  }
                }
              | None => ()
              }
            },
          )->ignore
        | None => ()
        }

      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
  }

  let {node} = JargonQuery.use(~variables={id: jargonID})
  switch node {
  | Some(Jargon({name: english})) =>
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
            <input
              type_="submit"
              value="제안하기"
              disabled={isNewCommentMutating || isTranslationMutating || isCommentMutating}
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    } else {
      React.null
    }
  | _ => React.null
  }
}
