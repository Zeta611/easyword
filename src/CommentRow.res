open Comment

module rec CommentNode: {
  @react.component
  let make: (~jargonID: string, ~commentNode: node) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~commentNode as {comment, children}: node) => {
    let {user} = React.useContext(SignInContext.context)
    let id = comment->id->Option.getExn

    let (showReply, setShowReply) = React.Uncurried.useState(() => false)
    let (showChildren, setShowChildren) = React.Uncurried.useState(() => true)

    // For handling the comment textarea
    let (content, setContent) = React.Uncurried.useState(() => "")
    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setContent(._ => value)
    }

    let commentsCollection = {
      open Firebase
      let firestore = useFirestore()
      firestore->collection(~path=`jargons/${jargonID}/comments`)
    }

    let handleSubmit = event => {
      // Prevent a page refresh, we are already listening for updates
      ReactEvent.Form.preventDefault(event)

      switch user->Js.Nullable.toOption {
      | Some({uid, email, providerData}) =>
        // Hide reply after submit
        setShowReply(._ => false)

        open Firebase
        let email = {
          open Option
          // email doesn't contain data when using other providers (https://stackoverflow.com/a/48815576)
          // In such case, access it from providerData
          // If it is absent there, fall back to uid
          email->getWithDefault(providerData[0]->flatMap(User.email)->getWithDefault(uid))
        }

        let _ = addDoc(
          commentsCollection,
          Comment.t(
            ~content,
            ~user=email /* TODO: use displayName */,
            ~timestamp=Js.Date.make()->Timestamp.fromDate,
            ~parent=id,
            (),
          ),
        )
      | None => Window.alert("You need to be signed in to comment!")
      }
    }

    <>
      <div className="flex flex-col gap-y-1">
        <div className="flex gap-x-3">
          <div> {comment->Comment.user->React.string} </div>
          <div>
            {comment->timestamp->Firebase.Timestamp.toDate->Js.Date.toDateString->React.string}
          </div>
        </div>
        <div> {comment->Comment.content->React.string} </div>
        <div>
          <button className="btn btn-xs" onClick={_ => setShowReply(.show => !show)}>
            {"답글"->React.string}
          </button>
        </div>
      </div>
      {if showReply {
        <form onSubmit=handleSubmit>
          <div className="p-2 gap-3 grid grid-cols-1 place-items-end">
            <textarea
              name={"comment" ++ id}
              id={"comment" ++ id}
              value=content
              onChange=handleInputChange
              placeholder="여러분의 생각은 어떠신가요?"
              className="textarea textarea-primary textarea-sm rounded-lg place-self-stretch"
            />
            <input type_="submit" value="답글" className="btn btn-outline btn-xs" />
          </div>
        </form>
      } else {
        React.null
      }}
      {if showChildren {
        <div className="flex">
          <button
            className="flex-none mr-3 w-3 border-r-[2px] border-zinc-300 hover:border-zinc-600"
            onClick={_ => setShowChildren(.show => !show)}
          />
          <div className="flex-initial w-full">
            <CommentSiblings jargonID siblings=children />
          </div>
        </div>
      } else {
        <div className="flex">
          <button
            className="flex-none mr-3 w-3 border-r-[2px] border-zinc-300 hover:border-zinc-600"
            onClick={_ => setShowChildren(.show => !show)}
          />
          <div className="flex-initial w-full"> {"Expand"->React.string} </div>
        </div>
      }}
    </>
  }
}
and CommentSiblings: {
  @react.component
  let make: (~jargonID: string, ~siblings: list<node>) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~siblings: list<node>) => {
    siblings
    ->List.toArray
    ->Array.map(commentNode =>
      <div key={commentNode.comment->id->Option.getExn} className="flex flex-col gap-y-2">
        <CommentNode jargonID commentNode />
      </div>
    )
    ->React.array
  }
}

@react.component
let make = (~jargonID, ~siblings: list<node>) => {
  <CommentSiblings jargonID siblings />
}
