module JargonListOrderQuery = %relay(`
  fragment JargonListOrderQuery on query_root
  @refetchable(queryName: "JargonListOrderRefetchQuery")
  @argumentDefinitions(
    count: { type: "Int", defaultValue: 40 }
    cursor: { type: "String" }
  ) {
    jargon_connection(
      order_by: $directions
      first: $count
      after: $cursor
      where: {
        _and: [
          {
            _or: [
              { name_lower_no_spaces: { _iregex: $searchTerm } }
              { translations: { name_lower_no_spaces: { _iregex: $searchTerm } } }
            ]
          }
          { jargon_categories: { category_id: { _in: $categoryIDs } } }
        ]
      }
    ) @connection(key: "JargonListOrderQuery_jargon_connection") {
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
let make = (~query) => {
  let (rows, hasMore, loadNext) = {
    let {
      data: {jargon_connection: jargonConnection},
      hasNext,
      loadNext,
    } = JargonListOrderQuery.usePagination(query)
    (
      jargonConnection
      ->JargonListOrderQuery.getConnectionNodes
      ->Array.map(node => (node.id, node.fragmentRefs)),
      hasNext,
      loadNext,
    )
  }

  <InfiniteScroll
    className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2 pb-10"
    dataLength={rows->Array.length}
    next={() => loadNext(~count=40)->ignore}
    hasMore
    loader={<div className="grid justify-center content-center">
      <Loader />
    </div>}>
    {rows
    ->Array.map(((key, jargonCardRef)) =>
      <li
        key
        className="flex flex-col gap-y-2 group cursor-pointer bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900">
        <JargonCard jargonCardRef />
      </li>
    )
    ->React.array}
  </InfiniteScroll>
}
