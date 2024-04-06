module HomeJargonListSectionQuery = %relay(`
  query HomeJargonListSectionQuery(
    $searchTerm: String!
    $directions: [jargon_order_by!]!
  ) {
    ...JargonListOrderQuery
  }
`)

@react.component
let make = (~searchTerm, ~axis, ~direction) => {
  let {fragmentRefs: query} = HomeJargonListSectionQuery.use(
    ~variables={
      searchTerm,
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
        }
      },
    },
  )

  <React.Suspense
    fallback={<div className="h-screen grid justify-center content-center">
      <Loader />
    </div>}>
    <JargonList query />
  </React.Suspense>
}
