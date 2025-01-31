module JargonQuery = %relay(`
  query NewTranslationJargonQuery($id: ID!) {
    node(id: $id) {
      ... on jargon {
        name
      }
    }
  }
`)

module NewTranslationMutation = %relay(`
  mutation NewTranslationMutation(
    $id: uuid!
    $jargonID: uuid!
    $authorID: String!
    $name: String!
    $commentID: uuid!
    $comment: String!
    $now: timestamptz!
  ) {
    insert_translation_one(
      object: {
        id: $id
        jargon_id: $jargonID
        author_id: $authorID
        name: $name
        comment_id: $commentID
        comment: {
          data: {
            id: $commentID
            jargon_id: $jargonID
            author_id: $authorID
            content: $comment
          }
        }
      }
    ) {
      id
    }
    update_jargon_by_pk(
      pk_columns: { id: $jargonID }
      _set: { updated_at: $now }
    ) {
      id
    }
  }
`)

@react.component
let make = (~jargonID: string) => {
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

  let (korean, setKorean) = React.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(_ => value)
  }

  let sanitizedKorean = korean->Util.sanitize

  let (comment, setComment) = React.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(_ => value)
  }

  let (newTranslationMutate, isNewTranslationMutating) = NewTranslationMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if sanitizedKorean->String.length < 1 {
      Window.alert("번역을 입력해주세요")
    } else if signedIn {
      switch user->Nullable.toOption {
      | Some(user) =>
        let comment = switch comment {
        | "" => `${sanitizedKorean->Util.eulLeul} 제안합니다.`
        | _ => comment
        }

        let (id, jargonID) = (jargonID, jargonID->Base64.retrieveOriginalIDString)
        switch jargonID {
        | Some(jargonID) => {
            let (translationID, commentID) = (Uuid.v4(), Uuid.v4())
            newTranslationMutate(
              ~variables={
                id: translationID,
                jargonID,
                authorID: user.uid,
                name: sanitizedKorean,
                commentID,
                comment,
                now: Date.make()->Date.toISOString,
              },
              ~onError=error => Js.Console.error(error),
              ~onCompleted=({insert_translation_one}, _errors) => {
                switch insert_translation_one {
                | Some(_) => RescriptReactRouter.replace(`/jargon/${id}`)
                | None => {
                    Js.Console.error("Translation mutation failed")
                    RescriptReactRouter.replace(`/jargon/${id}`)
                  }
                }
              },
            )->ignore
          }
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
        <form className="mt-8 max-w-md" onSubmit=handleSubmit>
          <div className="grid grid-cols-1 gap-6">
            <label className="block">
              <label className="label">
                <span className="label-text"> {"번역"->React.string} </span>
              </label>
              <input
                type_="text"
                value=korean
                onChange=handleTranslationChange
                className="input input-bordered w-full"
              />
              <label className="label">
                <span className="label-text-alt" />
                <span className="label-text-alt text-zinc-700">
                  {"번역을 새로 제안할 때는 "->React.string}
                  <a href="https://claude.ai/" className="link text-zinc-700">
                    {"Claude"->React.string}
                  </a>
                  {"등의 LLM도 활용해보세요"->React.string}
                </span>
              </label>
            </label>
            <label className="block">
              <label className="label">
                <span className="label-text"> {"의견"->React.string} </span>
              </label>
              <textarea
                value=comment
                onChange=handleCommentChange
                placeholder="새 댓글로 달려요"
                className="textarea textarea-bordered w-full"
              />
            </label>
            <input
              type_="submit"
              value="제안하기"
              disabled=isNewTranslationMutating
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
