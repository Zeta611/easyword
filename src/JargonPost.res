module JargonPostQuery = %relay(`
  query JargonPostQuery($id: ID!) {
    node(id: $id) {
      ... on jargon {
        name
        ...Translation_jargon
        ...CommentSection_jargon
      }
    }
  }
`)

@react.component
let make = (~jargonID) => {
  let {node} = JargonPostQuery.use(~variables={id: jargonID})

  switch node {
  | None => React.null
  | Some(node) =>
    switch node {
    | Jargon(jargon) =>
      <div className="px-3 max-w-xl mx-auto md:max-w-4xl text-sm">
        <main className="flex flex-col p-5 gap-4 bg-zinc-100 dark:bg-zinc-900 rounded-lg">
          // Jargon
          <div className="flex flex-col gap-1">
            <div className="text-2xl font-bold"> {jargon.name->React.string} </div>
            // <div className="text-2xl font-medium"> {korean->React.string} </div>
          </div>
          // Translation
          <Translation translationRefs={jargon.fragmentRefs} />
          // New translation
          <button
            className="btn btn-primary"
            onClick={_ => RescriptReactRouter.replace(`/new-translation/${jargonID}`)}>
            {"새 번역 제안하기"->React.string}
          </button>
          // New comment
          <CommentInput jargonID />
          <div className="divider -my-2" />
          // Comments
          <CommentSection jargonID commentRefs={jargon.fragmentRefs} />
        </main>
      </div>

    | UnselectedUnionMember(resp) => raise(Exc.HTTPError(404, resp))
    }
  }
}
