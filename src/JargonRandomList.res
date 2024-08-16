module JargonRandomListOrderQuery = %relay(`
  query JargonRandomListOrderQuery(
    $seed: seed_float!
    $categoryIDs: [Int!]!
    $onlyWithoutTranslationFilter: [jargon_bool_exp!]!
  ) {
    list_jargon_random_connection(
      args: { seed: $seed }
      where: {
        _and: [
          {
            _or: [
              { jargon_categories: { category_id: { _in: $categoryIDs } } }
              { _not: { jargon_categories: { _and: [] } } }
            ]
          }
          { _and: $onlyWithoutTranslationFilter }
        ]
      }
      first: 40
    ) {
      edges {
        node {
          id
          ...JargonCard_jargon
        }
      }
    }
  }
`)

@react.component
let make = (~seed, ~categoryIDs, ~onlyWithoutTranslation) => {
  let {list_jargon_random_connection: {edges}} = JargonRandomListOrderQuery.use(
    ~variables={
      seed: seed->Float.toString,
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
    },
  )
  let rows = edges->Array.map(({node}) => (node.id, node.fragmentRefs))

  <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2 pb-10">
    {rows
    ->Array.map(((key, jargonCardRef)) =>
      <li
        key
        className="flex flex-col gap-y-2 group cursor-pointer bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900">
        <JargonCard jargonCardRef />
      </li>
    )
    ->React.array}
  </div>
}
