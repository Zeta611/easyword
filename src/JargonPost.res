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
  commentNodeTable->HashMap.String.forEach((_, {comment, _} as node) => {
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
  let make = (~id, ~signInData: option<Firebase.signInCheckResult>) => {
    // For handling the comment textarea
    let (content, setContent) = React.useState(() => "")
    let handleInputChange = event => {
      let value = ReactEvent.Form.currentTarget(event)["value"]
      setContent(_ => value)
    }

    // Write comment to the Firestore on submit
    let commentsCollection = {
      open Firebase
      let firestore = useFirestore()
      firestore->collection(~path=`jargons/${id}/comments`)
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
            ~parent="",
            (),
          ),
        )
      | _ => Window.alert("You need to be signed in to comment!")
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
          className="h-24 p-1 border place-self-stretch"
        />
        <input
          type_="submit" value="Comment" className="px-1 rounded-md bg-zinc-200 hover:bg-zinc-300"
        />
      </div>
    </form>
  }
}

@react.component
let make = (~id) => {
  open Firebase

  let firestore = useFirestore()
  let jargonDoc = firestore->doc(~path=`jargons/${id}`)
  let {status: docStatus, data: jargons} = jargonDoc->useFirestoreDocData

  let commentsCollection = firestore->collection(~path=`jargons/${id}/comments`)
  let {status: collectionStatus, data: comments} =
    commentsCollection
    ->query(orderBy("timestamp", ~direction="asc"))
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  let {status: signInStatus, data: signInData} = useSigninCheck()

  switch (docStatus, collectionStatus, signInStatus) {
  | (#success, #success, #success) =>
    switch (jargons, comments) {
    | (None, _) | (_, None) => React.null
    | (Some({korean, english}: Jargon.t), Some(comments)) => {
        let (roots, commentNodeTable) = constructForest(comments)
        <div>
          {switch signInData {
          | None | Some({signedIn: false}) => <Navbar signedIn=false />
          | Some({signedIn: true}) => <Navbar signedIn=true />
          }}
          <main className="grid p-5 gap-3 dark:text-white">
            <h1 className="grid gap-1">
              <div className="text-3xl font-bold"> {React.string(english)} </div>
              <div className="text-2xl font-medium"> {React.string(korean)} </div>
            </h1>
            <CommentInput id signInData />
            <div>
              <CommentRow jargonID=id siblings=roots.contents />
            </div>
          </main>
        </div>
      }
    }
  | _ =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>
  }
}
