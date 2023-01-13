open Comment

module rec CommentNode: {
  @react.component
  let make: (~jargonID: string, ~commentNode: node) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~commentNode as {comment, children, _}: node) => {
    let id = comment->id->Option.getExn

    let (show, setShow) = React.useState(() => false)
    // For handling the comment textarea
    let (content, setContent) = React.useState(() => "")
    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setContent(_ => value)
    }

    let {status: signInStatus, data: signInData} = Firebase.useSigninCheck()

    let commentsCollection = {
      open Firebase
      let firestore = useFirestore()
      firestore->collection(~path=`jargons/${jargonID}/comments`)
    }

    let handleSubmit = event => {
      // Prevent a page refresh, we are already listening for updates
      ReactEvent.Form.preventDefault(event)

      switch signInData {
      | Some({signedIn: true, user: {uid, email, providerData}}) =>
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
      | _ => Window.alert("You need to be signed in to comment!")
      }
    }

    <>
      <div className="grid grid-cols-2">
        <div> {comment->user->React.string} </div>
        <div>
          {comment->timestamp->Firebase.Timestamp.toDate->Js.Date.toDateString->React.string}
        </div>
        <div> {comment->Comment.content->React.string} </div>
        <div>
          <button
            className="px-1 rounded-md bg-zinc-200 hover:bg-zinc-300"
            onClick={_ => setShow(show => !show)}>
            {"Reply"->React.string}
          </button>
        </div>
      </div>
      {if show {
        <form onSubmit={handleSubmit}>
          <div className="p-2 gap-3 grid grid-cols-1 place-items-end">
            <textarea
              name={"comment" ++ id}
              id={"comment" ++ id}
              value={content}
              onChange={handleInputChange}
              placeholder="여러분의 생각은 어떠신가요?"
              className="h-24 p-1 border place-self-stretch"
            />
            <input
              type_="submit" value="Reply" className="px-1 rounded-md bg-zinc-200 hover:bg-zinc-300"
            />
          </div>
        </form>
      } else {
        React.null
      }}
      <div className="ml-6">
        <CommentSiblings jargonID siblings=children />
      </div>
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
      <div key={commentNode.comment->id->Option.getExn}>
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
