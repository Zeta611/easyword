module CommentFragment = %relay(`
  fragment CommentSection_jargon on jargon {
    __id
    comments_connection(first: 100)
      @connection(key: "CommentSection_jargon_comments_connection") {
      edges {
        node {
          id
          content
          created_at
          parent {
            id
          }
          author {
            photo_url
            display_name
          }
        }
      }
    }
  }
`)

@react.component
let make = (~jargonID, ~commentRefs) => {
  let {comments_connection: {edges: comments}, __id} = CommentFragment.use(commentRefs)

  let roots = Comment.constructForest(
    comments->Array.map(({node: x}) => {
      Comment.id: x.id,
      content: x.content,
      userDisplayName: x.author.display_name,
      userPhotoURL: x.author.photo_url,
      timestamp: x.created_at->Js.Date.fromString,
      parent: x.parent->Option.map(x => x.id),
    }),
  )

  <CommentRow jargonID siblings={roots.contents} />
}
