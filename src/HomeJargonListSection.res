module HomeJargonListSectionQuery = %relay(`
  query HomeJargonListSectionQuery(
    $searchTerm: String!
    $directions: [jargon_order_by!]!
    $seed: seed_float!
  ) {
    ...JargonListOrderQuery
    ...JargonListRandomOrderQuery
  }
`)

@react.component
let make = (~searchTerm, ~axis, ~direction) => {
  let searchTerm = searchTerm->String.replaceRegExp(%re(`/\s/g`), "")
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
        | Random(_) => []
        }
      },
      seed: switch axis {
      | Random(seed) => seed->Float.toString
      | _ => "0.0"
      },
    },
  )

  <React.Suspense
    fallback={<div className="h-screen grid justify-center content-center">
      <Loader />
    </div>}>
    <JargonList
      query
      random={switch axis {
      | Random(_) => true
      | _ => false
      }}
    />
  </React.Suspense>
}
