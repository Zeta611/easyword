module JargonListQuery = %graphql(`
  query ChronoOrder ($direction: order_by!) @cached {
    jargon(order_by: [{updated_at: $direction}, {name: asc}], limit: 40) {
      id
      name
      updated_at
      translations(order_by: [{name: asc}], limit: 20) {
        id
        name
      }
    }
  }
  query ABCOrder ($direction: order_by!) @cached {
    jargon(order_by: [{name: $direction}, {updated_at: desc}], limit: 40) {
      id
      name
      updated_at
      translations(order_by: [{name: asc}], limit: 20) {
        id
        name
      }
    }
  }
`)

type jargon = {
  id: string,
  name: string,
  updated_at: string,
  // translations: array<translation>,
}

@react.component
let make = (~order, ~query) => {
  // open Jargon

  // open Firebase

  // let (axis, direction) = order

  // let jargonListResult = JargonListQuery.ChronoOrder.use({direction: direction})
  // let _ = switch jargonListResult {
  // | {data: Some(jargonList)} => Some(jargonList.jargon)
  // | {loading: true} => None
  // | _ => None
  // }

  // let jargonList = switch axis {
  // | Chrono => {
  //     let jargonListResult = JargonListQuery.ChronoOrder.use({direction: direction})
  //     switch jargonListResult {
  //     | {data: Some(jargonList)} => Some(jargonList.jargon->Obj.magic)
  //     | {loading: true} => None
  //     | _ => None
  //     }
  //   }
  // | English => {
  //     let jargonListResult = JargonListQuery.ABCOrder.use({direction: direction})
  //     switch jargonListResult {
  //     | {data: Some(jargonList)} => Some(jargonList.jargon->Obj.magic)
  //     | {loading: true} => None
  //     | _ => None
  //     }
  //   }
  // }

  React.null

  // let jargonsCollection = useFirestore()->collection(~path="jargons")
  // let queryConstraint = {
  //   let language = switch axis {
  //   | English => "english"
  //   | Chrono => "timestamp"
  //   }
  //   orderBy(language, ~direction)
  // }

  // switch status {
  // | #success =>
  //   switch jargons {
  //   | None => React.null
  //   | Some(jargons) =>
  //     let regex = {
  //       let matchAll = %re("/.*/")
  //       try Js.Re.fromStringWithFlags(regexQuery, ~flags="i") catch {
  //       | Js.Exn.Error(obj) => {
  //           obj->Js.Exn.message->Option.forEach(Js.log)
  //           matchAll
  //         }
  //       }
  //     }
  //     let rows = jargons->Array.keepMap(({english, translations} as jargon: Jargon.t) => {
  //       let translations = translations->Jargon.joinTranslations
  //       switch (english->Js.String2.match_(regex), translations->Js.String2.match_(regex)) {
  //       | (None, None) => None
  //       | _ => Some(<JargonCard jargon axis key={jargon.id} />)
  //       }
  //     })
  //
  //     <div className="grid sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 gap-x-6 gap-y-2">
  //       {rows->React.array}
  //     </div>
  //   }
  // }
}
