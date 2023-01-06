// Firestore comment entity
type comment = {
  id: string,
  comment: string,
  user: string,
  timestamp: Firebase.Timestamp.t,
  parent: string,
}

type rec commentList = list<commentNode>
and commentNode = {
  comment: comment,
  mutable parent: option<commentNode>,
  mutable children: commentList,
}

let constructForest = (comments: array<comment>) => {
  let roots: ref<commentList> = ref(list{})
  let commentNodeTable = HashMap.String.make(~hintSize=10)

  // Store comments in the lookupComment hash map & add roots as well
  comments->Array.forEach(({id, parent} as comment) => {
    let node = {comment, parent: None, children: list{}}
    commentNodeTable->HashMap.String.set(id, node)
    if parent == "" {
      roots.contents = roots.contents->List.add(node)
    }
  })

  // Iterate through the array and link the nodes
  commentNodeTable->HashMap.String.forEach((_, {comment: {parent, _}, _} as node) => {
    if parent != "" {
      let parentNode = commentNodeTable->HashMap.String.get(parent)->Option.getExn
      parentNode.children = parentNode.children->List.add(node)
      node.parent = Some(parentNode)
    }
  })

  (roots, commentNodeTable)
}

let rec makeComment = ({comment: {id, comment, user, timestamp, _}, children, _}) => {
  <div key=id>
    <div className="grid grid-cols-2">
      <div> {React.string(user)} </div>
      <div> {React.string(timestamp->Firebase.Timestamp.toDate->Js.Date.toDateString)} </div>
      <div> {React.string(comment)} </div>
    </div>
    <div className="ml-4"> {makeSiblings(children)} </div>
  </div>
}
and makeSiblings = (siblings: commentList) => {
  <div> {React.array(siblings->List.toArray->Array.map(makeComment))} </div>
}

module CommentInput = {
  @react.component
  let make = () => {
    <form>
      <div className="p-2 gap-3 grid grid-cols-1 place-items-end">
        <textarea
          name="comment"
          id="comment"
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

  let {status: signInStatus, data: signedIn} = Firebase.useSigninCheck()

  switch (docStatus, collectionStatus, signInStatus) {
  | (#success, #success, #success) =>
    switch (jargons, comments) {
    | (None, _) | (_, None) => React.null
    | (Some({korean, english}: Home.jargon), Some(comments)) => {
        let (roots, commentNodeTable) = constructForest(comments)
        <div>
          {switch signedIn {
          | None | Some({signedIn: false}) => <Navbar signedIn=false />
          | Some({signedIn: true}) => <Navbar signedIn=true />
          }}
          <main className="grid p-5 gap-3 dark:text-white">
            <h1 className="grid gap-1">
              <div className="text-3xl font-bold"> {React.string(english)} </div>
              <div className="text-2xl font-medium"> {React.string(korean)} </div>
            </h1>
            <CommentInput />
            <div> {makeSiblings(roots.contents)} </div>
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
