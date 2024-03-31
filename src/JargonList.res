module JargonListChronoOrderQuery = %relay(`
  query JargonListChronoOrderQuery($direction: order_by!) @cached {
    jargon_connection(order_by: [{updated_at: $direction}, {name: asc}], first: 40) {
      edges {
        node {
          id
          name
          updated_at
          translations(order_by: {name: asc}, limit: 20) {
            id
            name
          }
          comments_aggregate {
            aggregate {
              count
            }
          }
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
          name
          updated_at
          translations(order_by: {name: asc}, limit: 20) {
            id
            name
          }
          comments_aggregate {
            aggregate {
              count
            }
          }
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
      edges
      ->Array.map(({node: jargon}) => {
        id: jargon.id,
        name: jargon.name,
        updated_at: jargon.updated_at->Js.Date.fromString,
        translations: jargon.translations->Array.map(translation => (
          translation.id,
          translation.name,
        )),
        commentsCount: jargon.comments_aggregate.aggregate
        ->Option.flatMap(x => Some(x.count))
        ->Option.getWithDefault(0),
      })
      ->Array.map(jargon => <JargonCard key={jargon.id} jargon />)
    }
  | English => {
      let {jargon_connection: {edges}} = JargonListABCOrderQuery.use(
        ~variables={direction: direction},
      )
      edges
      ->Array.map(({node: jargon}) => {
        id: jargon.id,
        name: jargon.name,
        updated_at: jargon.updated_at->Js.Date.fromString,
        translations: jargon.translations->Array.map(translation => (
          translation.id,
          translation.name,
        )),
        commentsCount: jargon.comments_aggregate.aggregate
        ->Option.flatMap(x => Some(x.count))
        ->Option.getWithDefault(0),
      })
      ->Array.map(jargon => <JargonCard key={jargon.id} jargon />)
    }
  }

  <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2">
    {rows->React.array}
  </div>
}
