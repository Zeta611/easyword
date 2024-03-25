module JargonListQuery = %graphql(`
  query ChronoOrder ($direction: order_by!) @cached {
    jargon(order_by: [{updated_at: $direction}, {name: asc}]) {
      id
      name
      updated_at
      translations(order_by: [{name: asc}], limit: 20) {
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
  query ABCOrder ($direction: order_by!) @cached {
    jargon(order_by: [{name: $direction}, {updated_at: desc}]) {
      id
      name
      updated_at
      translations(order_by: [{name: asc}], limit: 20) {
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
`)

@react.component
let make = (~axis, ~direction, ~query) => {
  open Jargon

  switch axis {
  | Chrono => {
      let jargonListResult = JargonListQuery.ChronoOrder.use({direction: direction})
      switch jargonListResult {
      | {data: Some({jargon: jargonList})} => {
          let rows =
            jargonList
            ->Array.map(jargon => {
              id: jargon.id,
              name: jargon.name,
              updated_at: jargon.updated_at->Js.String2.make->Js.Date.fromString,
              translations: jargon.translations->Array.map(translation => (
                translation.id,
                translation.name,
              )),
              commentsCount: jargon.comments_aggregate.aggregate
              ->Option.flatMap(x => Some(x.count))
              ->Option.getWithDefault(0),
            })
            ->Array.map(jargon => <JargonCard key={jargon.id->Int.toString} jargon />)

          <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2">
            {rows->React.array}
          </div>
        }
      | {loading: true} =>
        <div className="h-screen grid justify-center content-center">
          <Loader />
        </div>

      | _ => React.null
      }
    }
  | English => {
      let jargonListResult = JargonListQuery.ABCOrder.use({direction: direction})
      switch jargonListResult {
      | {data: Some({jargon: jargonList})} => {
          let rows =
            jargonList
            ->Array.map(jargon => {
              id: jargon.id,
              name: jargon.name,
              updated_at: jargon.updated_at->Js.String2.make->Js.Date.fromString,
              translations: jargon.translations->Array.map(translation => (
                translation.id,
                translation.name,
              )),
              commentsCount: jargon.comments_aggregate.aggregate
              ->Option.flatMap(x => Some(x.count))
              ->Option.getWithDefault(0),
            })
            ->Array.map(jargon => <JargonCard key={jargon.id->Int.toString} jargon />)

          <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2">
            {rows->React.array}
          </div>
        }
      | {loading: true} =>
        <div className="h-screen grid justify-center content-center">
          <Loader />
        </div>

      | _ => React.null
      }
    }
  }
}
