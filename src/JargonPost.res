module JargonPostQuery = %relay(`
  query JargonPostQuery($id: ID!) {
    node(id: $id) {
      ... on jargon {
        name
        comments_aggregate {
          aggregate {
            count
          }
        }
        jargon_categories(order_by: { category: { name: asc } }) {
          category {
            acronym
          }
        }
        ...RelatedJargons_jargon
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
      <div className="px-3 pb-10 max-w-xl mx-auto md:max-w-4xl text-sm">
        <main className="flex flex-col p-5 gap-4 bg-zinc-100 dark:bg-zinc-900 rounded-lg">
          // Jargon
          <div className="flex flex-col gap-2">
            <div className="flex gap-1">
              {jargon.jargon_categories
              ->Array.map(r => r.category.acronym->Util.badgify)
              ->React.array}
              {"+"->Util.badgify(~onClick=_ =>
                RescriptReactRouter.replace(`/edit-categories/${jargonID}`)
              )}
            </div>
            <div className="text-2xl font-bold"> {jargon.name->React.string} </div>
          </div>
          // Translation
          <Translation translationRefs={jargon.fragmentRefs} />
          // New translation
          <button
            className="btn btn-primary"
            onClick={_ => RescriptReactRouter.replace(`/new-translation/${jargonID}`)}>
            {"새 번역 제안하기"->React.string}
          </button>
          // Related Jargons
          <RelatedJargons relatedJargonsRef={jargon.fragmentRefs} />
          <div className="divider -mb-2" />
          <div className="flex gap-1 text-teal-600">
            <Heroicons.Outline.ChatBubbleLeftRightIcon className="w-6 h-6" />
            {jargon.comments_aggregate.aggregate
            ->Option.map(x => x.count)
            ->Option.getOr(0)
            ->Int.toString
            ->React.string}
          </div>
          // New comment
          <CommentInput jargonID />
          // Comments
          <CommentSection jargonID commentRefs={jargon.fragmentRefs} />
        </main>
      </div>

    | UnselectedUnionMember(resp) => raise(Exc.HTTPError(404, resp))
    }
  }
}
