open Comment

module rec CommentNode: {
  @react.component
  let make: (~jargonID: string, ~commentNode: node) => React.element
} = {
  @react.component
  let make = (~jargonID: string, ~commentNode as {comment, children}: node) => {
    let {user} = React.useContext(SignInContext.context)
    let id = comment->id->Option.getExn

    let (commentUser, setCommentUser) = React.Uncurried.useState(() =>
      {"displayName": "", "photoURL": None}
    )

    let (showReply, setShowReply) = React.Uncurried.useState(() => false)
    let (showChildren, setShowChildren) = React.Uncurried.useState(() => true)

    // For handling the comment textarea
    let (content, setContent) = React.Uncurried.useState(() => "")
    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setContent(._ => value)
    }

    let (isLoading, setIsLoading) = React.Uncurried.useState(() => false)

    let firestore = Firebase.useFirestore()
    React.useEffect0(() => {
      (
        async () => {
          open Firebase
          let commentUserDocRef = firestore->doc(~path=`users/${comment->Comment.user}`)
          let commentUserDoc = await commentUserDocRef->getDoc
          if commentUserDoc.exists(.) {
            setCommentUser(._ =>
              {
                "displayName": commentUserDoc.data(.)["displayName"],
                "photoURL": commentUserDoc.data(.)["photoURL"],
              }
            )
          } else {
            setCommentUser(._ =>
              {
                "displayName": "탈퇴한 회원",
                "photoURL": None,
              }
            )
          }
        }
      )()->ignore
      None
    })

    let addComment = {
      open Firebase
      let functions = useFirebaseApp()->getFunctions
      functions->httpsCallable("addComment")
    }

    let handleSubmit = event => {
      // Prevent a page refresh, we are already listening for updates
      ReactEvent.Form.preventDefault(event)

      if content->String.length < 5 {
        Window.alert("댓글은 다섯 글자 이상이어야 해요")
      } else {
        switch user->Js.Nullable.toOption {
        | Some(_) =>
          setIsLoading(._ => true)

          (
            async () => {
              try {
                let result = await addComment(. ({jargonID, content, parent: id}: Comment.write))
                Js.log(result)
                setIsLoading(._ => false)
                setShowReply(._ => false)
                setContent(._ => "")
              } catch {
              | e => Js.log(e)
              }
            }
          )()->ignore
        | None => Window.alert("You need to be signed in to comment!")
        }
      }
    }

    <>
      <div className="flex flex-col gap-y-1 place-items-start text-zinc-500">
        // header
        <div className="flex items-center gap-x-1 text-xs">
          <span>
            {switch commentUser["photoURL"] {
            | None => <Heroicons.Outline.UserCircleIcon className="h-4 w-4" />

            | Some(photoURL) => <img className="mask mask-squircle h-4 w-4" src={photoURL} />
            }}
          </span>
          <span
            id
            className="target:text-teal-600 dark:target:text-teal-300 target:underline decoration-2 text-base-content font-medium">
            {commentUser["displayName"]->React.string}
          </span>
          {"·"->React.string}
          <span title={comment->timestamp->Firebase.Timestamp.toDate->Js.Date.toDateString}>
            {comment->timestamp->Firebase.Timestamp.toDate->DateFormat.timeAgo->React.string}
          </span>
        </div>
        // comment
        <div className="text-base-content"> {comment->Comment.content->React.string} </div>
        // footer
        <button className="btn btn-ghost btn-xs gap-1" onClick={_ => setShowReply(.show => !show)}>
          <Heroicons.Outline.ChatBubbleLeftIcon className="h-5 w-5" />
          {"답글"->React.string}
        </button>
      </div>
      // reply
      {if showReply {
        <form onSubmit=handleSubmit>
          <div className="p-2 gap-1 grid grid-cols-1 place-items-start">
            <textarea
              name={"comment" ++ id}
              id={"comment" ++ id}
              value=content
              onChange=handleInputChange
              placeholder="여러분의 생각은 어떠신가요?"
              className="textarea textarea-bordered textarea-sm rounded-lg place-self-stretch"
            />
            <input
              type_="submit"
              value="답글"
              disabled={isLoading}
              className={`btn btn-primary btn-outline btn-xs ${if isLoading {
                  "loading"
                } else {
                  ""
                }}`}
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
            onClick={_ => setShowChildren(.show => !show)}
          />
          <div className="flex-initial w-full">
            <CommentSiblings jargonID siblings=children />
          </div>
        </div>
      } else {
        <div
          className="group flex cursor-pointer border-zinc-300"
          onClick={_ => setShowChildren(.show => !show)}>
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
