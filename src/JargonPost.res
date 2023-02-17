let constructForest = (comments: array<Comment.t>) => {
  open Comment

  let roots: ref<list<node>> = ref(list{})
  let commentNodeTable = HashMap.String.make(~hintSize=10)

  // Store comments in the lookupComment hash map & add roots as well
  comments->Array.forEach(comment => {
    let id = comment->id->Option.getExn
    let parent = comment->parent
    let node = {comment, parent: None, children: list{}}
    commentNodeTable->HashMap.String.set(id, node)
    if parent == "" {
      roots.contents = roots.contents->List.add(node)
    }
  })

  // Iterate through the array and link the nodes
  commentNodeTable->HashMap.String.forEach((_, {comment} as node) => {
    let parent = comment->parent
    if parent != "" {
      let parentNode = commentNodeTable->HashMap.String.get(parent)->Option.getExn
      parentNode.children = parentNode.children->List.add(node)
      node.parent = Some(parentNode)
    }
  })

  (roots, commentNodeTable)
}

module CommentInput = {
  @react.component
  let make = (~jargonID) => {
    let {user} = React.useContext(SignInContext.context)

    // For handling the comment textarea
    let (content, setContent) = React.Uncurried.useState(() => "")
    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setContent(._ => value)
    }

    let (disabled, setDisabled) = React.Uncurried.useState(() => false)

    let addComment = {
      open Firebase
      let functions = useFirebaseApp()->getFunctions
      functions->httpsCallable("addComment")
    }

    let handleSubmit = event => {
      // Prevent a page refresh, we are already listening for updates
      ReactEvent.Form.preventDefault(event)

      switch user->Js.Nullable.toOption {
      | Some(_) =>
        setDisabled(._ => true)

        (
          async () => {
            try {
              let result = await addComment(. ({jargonID, content, parent: ""}: Comment.write))
              Js.log(result)
              setDisabled(._ => false)
              setContent(._ => "")
            } catch {
            | e => Js.log(e)
            }
          }
        )()->ignore
      | None => Window.alert("You need to be signed in to comment!")
      }
    }

    <form onSubmit={handleSubmit}>
      <div className="p-2 gap-3 grid grid-cols-1 place-items-end">
        <textarea
          name="comment"
          id="comment"
          value={content}
          onChange={handleInputChange}
          placeholder="여러분의 생각은 어떠신가요?"
          className="textarea textarea-bordered textarea-md rounded-lg place-self-stretch"
        />
        <input
          type_="submit" value="댓글" disabled className="btn btn-primary btn-sm btn-outline"
        />
      </div>
    </form>
  }
}

@react.component
let make = (~jargonID) => {
  open Firebase

  let firestore = useFirestore()
  let jargonDoc = firestore->doc(~path=`jargons/${jargonID}`)
  let {status: docStatus, data: jargons} = jargonDoc->useFirestoreDocData

  let commentsCollection = firestore->collection(~path=`jargons/${jargonID}/comments`)
  let {status: collectionStatus, data: comments} =
    commentsCollection
    ->query(orderBy("timestamp", ~direction=#asc))
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  switch (docStatus, collectionStatus) {
  | (#success, #success) =>
    switch (jargons, comments) {
    | (None, _) | (_, None) => React.null
    | (Some({korean, english}: Jargon.t), Some(comments)) => {
        let (roots, commentNodeTable) = constructForest(comments)
        <main className="flex flex-col p-5 gap-3">
          <div className="flex flex-col gap-1">
            <div className="flex items-center gap-3">
              <div className="indicator">
                <span className="indicator-item indicator-start text-2xl">
                  {"🎓"->React.string}
                </span>
                <div className="text-3xl font-bold"> {english->React.string} </div>
              </div>
              <div className="badge badge-primary badge-outline badge-md">
                {"#PL"->React.string}
              </div>
            </div>
            <div className="text-2xl font-medium"> {korean->React.string} </div>
          </div>
          <Poll jargonID />
          <button
            className="btn btn-primary"
            onClick={_ => RescriptReactRouter.replace(`/new-translation/${jargonID}`)}>
            {"새 번역 제안하기"->React.string}
          </button>
          <CommentInput jargonID />
          <div className="divider -my-2" />
          <div>
            <CommentRow jargonID siblings=roots.contents />
          </div>
        </main>
      }
    }
  | _ =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>
  }
}
