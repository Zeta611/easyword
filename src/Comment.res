type t = {
  id: string,
  content: string,
  userDisplayName: string,
  userPhotoURL: option<string>,
  timestamp: Date.t,
  parent: option<string>,
}

type rec node = {
  comment: t,
  mutable parent: option<node>,
  mutable children: list<node>,
}

type write = {
  jargonID: string,
  content: string,
  parent: string,
}

let constructForest = comments => {
  let roots: ref<list<node>> = ref(list{})
  let commentNodeTable = Map.make()

  // Store comments in the lookupComment hash map & add roots as well
  comments->Array.forEach(comment => {
    let node = {comment, parent: None, children: list{}}
    commentNodeTable->Map.set(comment.id, node)
    if comment.parent->Option.isNone {
      roots.contents = roots.contents->List.add(node)
    }
  })

  // Iterate through the array and link the nodes
  commentNodeTable->Map.forEach(({comment} as node) => {
    switch comment.parent {
    | Some(parent) => {
        let parentNode = commentNodeTable->Map.get(parent)->Option.getExn
        parentNode.children = parentNode.children->List.add(node)
        node.parent = Some(parentNode)
      }
    | None => ()
    }
  })

  roots
}

let rec countDescendents = children => {
  switch children {
  | list{} => 0
  | list{{children}, ...tl} => 1 + countDescendents(children) + countDescendents(tl)
  }
}
