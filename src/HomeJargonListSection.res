module HomeJargonListSectionQuery = %relay(`
  query HomeJargonListSectionQuery(
    $searchTerm: String!
    $categoryIDs: [Int!]!
    $onlyWithoutTranslationFilter: [jargon_bool_exp!]!
    $directions: [jargon_order_by!]!
  ) {
    ...JargonListOrderQuery
  }
`)

@react.component
let make = (~searchTerm, ~categoryIDs, ~onlyWithoutTranslation, ~axis, ~direction) => {
  let searchTerm = searchTerm->String.replaceRegExp(%re(`/\s+/g`), "")
  let {fragmentRefs: query} = HomeJargonListSectionQuery.use(
    ~variables={
      searchTerm,
      categoryIDs,
      onlyWithoutTranslationFilter: if onlyWithoutTranslation {
        [
          {
            _not: {translations: {}},
          },
        ]
      } else {
        []
      },
      directions: {
        switch axis {
        | Jargon.English => [
            {
              name_lower: switch direction {
              | #asc => Asc
              | #desc => Desc
              },
            },
            {updated_at: Desc},
          ]
        | Chrono => [{updated_at: Desc}, {name_lower: Asc}]
        | Random(_) => []
        }
      },
    },
  )

  <React.Suspense
    fallback={<div className="h-screen grid justify-center content-center">
      <Loader />
    </div>}>
    {switch axis {
    | Random(seed) => <JargonRandomList seed categoryIDs onlyWithoutTranslation />
    | _ => <JargonList query />
    }}
  </React.Suspense>
}
