// Firestore comment entity
type comment = {
  id: string,
  comment: string,
  user: string,
  timestamp: Firebase.timestamp,
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
  <div className="ml-4" key=id>
    <div className="grid grid-cols-2">
      <div> {React.string(user)} </div>
      <div> {React.string(timestamp->Firebase.toDate->Js.Date.toDateString)} </div>
      <div> {React.string(comment)} </div>
    </div>
    <div> {makeSiblings(children)} </div>
  </div>
}
and makeSiblings = (siblings: commentList) => {
  <div> {React.array(siblings->List.toArray->Array.map(makeComment))} </div>
}

@react.component
let make = (~id) => {
  open Firebase

  let firestore = useFirestore()
  let jargonDoc = firestore->doc(~path=`jargons/${id}`)
  let {status: docStatus, data: ({korean, english, _}: Home.jargon)} =
    jargonDoc->useFirestoreDocData

  let commentsCollection = firestore->collection(~path=`jargons/${id}/comments`)
  let {status: collectionStatus, data: comments} =
    commentsCollection
    ->query(orderBy("timestamp", ~direction="asc"))
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  if docStatus == "loading" || collectionStatus == "loading" {
    React.string("loading")
  } else {
    let (roots, commentNodeTable) = constructForest(comments)
    <div className="dark:text-white">
      <div className="flex gap-3">
        <div className="flex-none"> {React.string(english)} </div>
        <div className="flex-none"> {React.string(korean)} </div>
      </div>
      {makeSiblings(roots.contents)}
    </div>
  }
}
