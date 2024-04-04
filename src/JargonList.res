module JargonListChronoOrderQuery = %relay(`
  fragment JargonListChronoOrderQuery on query_root
    @refetchable(queryName: "JargonListChronoOrderRefetchQuery")
    @argumentDefinitions(
      count: {type: "Int", defaultValue: 40},
      cursor: {type: "String"}
    ) {
    jargon_connection(order_by: [{updated_at: $direction}, {name: asc}], first: $count, after: $cursor)
      @connection(key: "JargonListChronoOrderQuery_jargon_connection")
    {
      edges {
        node {
          id
          ...JargonCard_jargon
        }
      }
    }
  }
`)
// module JargonListABCOrderQuery = %relay(`
//   fragment JargonListABCOrderQuery on query_root {
//     jargon_connection(order_by: [{name: $abcDirection}, {updated_at: desc}], first: 40) {
//       edges {
//         node {
//           id
//           ...JargonCard_jargon
//         }
//       }
//     }
//   }
// `)

let handleScroll = (event, onLoadMore) => {
  let currentTarget = event->ReactEvent.Synthetic.currentTarget
  Js.log3(currentTarget["scrollTop"], currentTarget["clientHeight"], currentTarget["scrollHeight"])
  if currentTarget["scrollTop"] + currentTarget["clientHeight"] >= currentTarget["scrollHeight"] {
    onLoadMore()
  }
}

@react.component
let make = (~axis, ~query) => {
  open Jargon

  let (rows, hasMore, loadNext) = switch axis {
  | Chrono => {
      let {
        data: {jargon_connection: jargonConnection},
        hasNext,
        loadNext,
      } = JargonListChronoOrderQuery.usePagination(query)
      (
        jargonConnection
        ->JargonListChronoOrderQuery.getConnectionNodes
        ->Array.map(node => (node.id, node.fragmentRefs)),
        hasNext,
        loadNext,
      )
    }
  | English => {
      let {
        data: {jargon_connection: jargonConnection},
        hasNext,
        loadNext,
      } = JargonListChronoOrderQuery.usePagination(query)
      (
        jargonConnection
        ->JargonListChronoOrderQuery.getConnectionNodes
        ->Array.map(node => (node.id, node.fragmentRefs)),
        hasNext,
        loadNext,
      )
    }
  }

  <InfiniteScroll
    className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2"
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
