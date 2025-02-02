module CommentMutation = %relay(`
  mutation CommentInputMutation(
    $authorID: String!
    $content: String!
    $jargonID: uuid!
    $now: timestamptz!
  ) {
    insert_comment_one(
      object: { author_id: $authorID, content: $content, jargon_id: $jargonID }
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
let make = (~jargonID) => {
  let {user} = React.useContext(SignInContext.context)

  // For handling the comment textarea
  let (content, setContent) = React.useState(() => "")
  let handleInputChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setContent(_ => value)
  }

  let (mutate, isMutating) = CommentMutation.use()

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if content->String.length < 3 {
      Window.alert("댓글은 세 글자 이상이어야 해요")
    } else {
      let jargonID = jargonID->Base64.retrieveOriginalIDString
      switch (user->Nullable.toOption, jargonID) {
      | (Some(user), Some(jargonID)) =>
        mutate(
          ~variables={
            authorID: user.uid,
            content,
            jargonID,
            now: Date.make()->Date.toISOString,
          },
          ~onError=error => {
            Console.error(error)
          },
          ~onCompleted=(_response, _errors) => {
            // TODO: Make relay understand the update
            %raw(`window.location.reload()`)
          },
        )->ignore
      | (Some(_), _) => Window.alert("현재 댓글을 달 수 없어요")
      | (None, _) => Window.alert("로그인해야 합니다")
      }
    }
  }

  <form onSubmit=handleSubmit>
    <div
      className="rounded-lg border-2 border-zinc-300 focus-within:border-zinc-400 bg-white gap-1 grid grid-cols-1 place-items-start">
      <textarea
        name="comment"
        id="comment"
        value=content
        onChange=handleInputChange
        placeholder="여러분의 생각은 어떠신가요?"
        className="textarea textarea-ghost textarea-sm focus:outline-0 focus:border-transparent place-self-stretch"
      />
      <input
        type_="submit"
        value="댓글"
        disabled=isMutating
        className="btn btn-neutral btn-sm ml-1 mb-1 disabled:loading"
      />
    </div>
  </form>
}
