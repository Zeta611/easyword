module CommentMutation = %relay(`
  mutation CommentInputMutation(
    $authorID: String!
    $content: String!
    $jargonID: uuid!
  ) {
    insert_comment_one(
      object: { author_id: $authorID, content: $content, jargon_id: $jargonID }
    ) {
      id
    }
  }
`)

@react.component
let make = (~jargonID) => {
  let {user} = React.useContext(SignInContext.context)

  // For handling the comment textarea
  let (content, setContent) = React.Uncurried.useState(() => "")
  let handleInputChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setContent(_ => value)
  }

  let (mutate, isMutating) = CommentMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if content->String.length < 5 {
      Window.alert("댓글은 다섯 글자 이상이어야 해요")
    } else {
      let jargonID = jargonID->Base64.retrieveOriginalID
      switch (user->Js.Nullable.toOption, jargonID) {
      | (Some(user), Some(jargonID)) => {
          Js.log(`commenting ${user.uid} on ${jargonID} with ${content}`)
          mutate(
            ~variables={
              authorID: user.uid,
              content,
              jargonID,
            },
            ~onError=error => {
              Js.log(error)
            },
            ~onCompleted=(_response, _errors) => {
              // TODO: Make relay understand the update
              %raw(`window.location.reload()`)
            },
          )->ignore
        }
      | (Some(_), _) => Window.alert("현재 댓글을 달 수 없어요")
      | (None, _) => Window.alert("You need to be signed in to comment!")
      }
    }
  }

  <form onSubmit={handleSubmit}>
    <div className="gap-1 grid grid-cols-1 place-items-start">
      <textarea
        name="comment"
        id="comment"
        value={content}
        onChange={handleInputChange}
        placeholder="여러분의 생각은 어떠신가요?"
        className="textarea textarea-bordered textarea-md rounded-lg place-self-stretch"
      />
      <input
        type_="submit"
        value="댓글"
        disabled={isMutating}
        className="btn btn-primary btn-xs btn-outline"
      />
    </div>
  </form>
}
