module JargonListChronoOrderQuery = %relay(`
  query JargonListChronoOrderQuery($direction: order_by!) @cached {
    jargon_connection(order_by: [{updated_at: $direction}, {name: asc}], first: 40) {
      edges {
        node {
          id
          ...JargonCard_jargon
        }
      }
    }
  }
`)
module JargonListABCOrderQuery = %relay(`
  query JargonListABCOrderQuery($direction: order_by!) @cached {
    jargon_connection(order_by: [{name: $direction}, {updated_at: desc}], first: 40) {
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
let make = (~axis, ~direction, ~query) => {
  open Jargon

  let rows = switch axis {
  | Chrono => {
      let {jargon_connection: {edges}} = JargonListChronoOrderQuery.use(
        ~variables={direction: direction},
      )
      edges->Array.map(({node}) => (node.id, node.fragmentRefs))
    }
  | English => {
      let {jargon_connection: {edges}} = JargonListABCOrderQuery.use(
        ~variables={direction: direction},
      )
      edges->Array.map(({node}) => (node.id, node.fragmentRefs))
    }
  }

  <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2">
    {rows->Array.map(((key, jargon)) => <JargonCard key jargon />)->React.array}
  </div>
}
