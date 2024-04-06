module CommentMutation = %relay(`
  mutation CommentRowMutation(
    $authorID: String!
    $content: String!
    $jargonID: uuid!
    $parentID: uuid!
    $now: timestamptz!
  ) {
    insert_comment_one(
      object: {
        author_id: $authorID
        content: $content
        jargon_id: $jargonID
        parent_id: $parentID
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

module rec CommentNode: {
  @react.component
  let make: (~jargonID: string, ~commentNode: Comment.node) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~commentNode as {comment, children}: Comment.node) => {
    let {user} = React.useContext(SignInContext.context)

    let (showChildren, setShowChildren) = React.useState(() => true)

    let (showReply, setShowReply) = React.useState(() => false)

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

      if content->String.length < 5 {
        Window.alert("댓글은 다섯 글자 이상이어야 해요")
      } else {
        let jargonID = jargonID->Base64.retrieveOriginalID
        let commentID = comment.id->Base64.retrieveOriginalID
        switch (user->Nullable.toOption, jargonID, commentID) {
        | (Some(user), Some(jargonID), Some(commentID)) =>
          mutate(
            ~variables={
              authorID: user.uid,
              content,
              jargonID,
              parentID: commentID,
              now: Date.make()->Date.toISOString,
            },
            ~onError=error => Console.error(error),
            ~onCompleted=(_response, _errors) => {
              // TODO: Make relay understand the update
              %raw(`window.location.reload()`)
            },
          )->ignore
        | (Some(_), _, _) => Window.alert("현재 댓글을 달 수 없어요")
        | (None, _, _) => Window.alert("You need to be signed in to comment!")
        }
      }
    }

    <>
      <div className="flex flex-col gap-y-1 place-items-start text-zinc-500">
        // header
        <div className="flex items-center pb-1 gap-x-1 text-xs">
          <span className="pr-1">
            {switch comment.userPhotoURL {
            | None => <Heroicons.Outline.UserCircleIcon className="h-7 w-7" />
            | Some(photoURL) => <img className="mask mask-squircle h-7 w-7" src={photoURL} />
            }}
          </span>
          <span
            id={comment.id}
            className="target:text-teal-600 dark:target:text-teal-300 target:underline decoration-2 text-base-content font-semibold">
            {comment.userDisplayName->React.string}
          </span>
          {switch comment.translation {
          | Some(translation) =>
            <>
              {"·"->React.string}
              <span className="text-teal-600 dark:target:text-teal-300 text-base-content">
                {translation->React.string}
              </span>
            </>
          | None => React.null
          }}
          {"·"->React.string}
          <span title={comment.timestamp->Date.toDateString}>
            {comment.timestamp->DateFormat.timeAgo->React.string}
          </span>
        </div>
        // comment
        <div className="pl-3 text-base-content">
          <MathJax> {comment.content->React.string} </MathJax>
        </div>
        // footer
        <button
          className="btn btn-ghost btn-sm text-xs gap-1" onClick={_ => setShowReply(show => !show)}>
          <Heroicons.Outline.ChatBubbleLeftIcon className="h-5 w-5" />
          {"답글"->React.string}
        </button>
      </div>
      // reply
      {if showReply {
        <form onSubmit=handleSubmit className="pb-1">
          <div
            className="rounded-lg border-2 border-zinc-300 focus-within:border-zinc-400 bg-white gap-1 grid grid-cols-1 place-items-start">
            <textarea
              name={"comment" ++ comment.id}
              id={"comment" ++ comment.id}
              value=content
              onChange=handleInputChange
              placeholder="여러분의 생각은 어떠신가요?"
              className="textarea textarea-ghost textarea-sm focus:outline-0 focus:border-transparent place-self-stretch"
            />
            <input
              type_="submit"
              value="답글"
              disabled={isMutating}
              className="btn btn-neutral btn-sm ml-1 mb-1 disabled:loading"
            />
          </div>
        </form>
      } else {
        React.null
      }}
      {if showChildren {
        <div className="flex">
          <button
            className="flex-none mr-3 w-3 border-r-[2px] border-zinc-300 hover:border-zinc-600"
            onClick={_ => setShowChildren(show => !show)}
          />
          <div className="flex-initial w-full">
            <CommentSiblings jargonID siblings=children />
          </div>
        </div>
      } else {
        <div
          className="group flex cursor-pointer border-zinc-300"
          onClick={_ => setShowChildren(show => !show)}>
          <div
            className="flex-none mr-3 w-3 border-r-[2px] border-zinc-300 group-hover:border-zinc-600"
          />
          <div className="flex-initial w-full text-zinc-500 group-hover:text-zinc-600">
            {`댓글 ${children->Comment.countDescendents->Int.toString}개 열기`->React.string}
          </div>
        </div>
      }}
    </>
  }
}
and CommentSiblings: {
  @react.component
  let make: (~jargonID: string, ~siblings: list<Comment.node>) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~siblings: list<Comment.node>) => {
    siblings
    ->List.toArray
    ->Array.toSorted((a, b) => Date.compare(b.comment.timestamp, a.comment.timestamp))
    ->Array.map(commentNode =>
      <div key={commentNode.comment.id} className="flex flex-col gap-y-2">
        <CommentNode jargonID commentNode />
      </div>
    )
    ->React.array
  }
}

@react.component
let make = (~jargonID, ~siblings: list<Comment.node>) => {
  <CommentSiblings jargonID siblings />
}
