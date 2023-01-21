open Jargon

@react.component
let make = (~order, ~query as regexQuery) => {
  let (language, direction) = order

  open Firebase

  let jargonsCollection = useFirestore()->collection(~path="jargons")
  let queryConstraint = {
    let language = switch language {
    | English => "english"
    | Korean => "korean"
    }
    let direction = switch direction {
    | Ascending => "asc"
    | Descending => "desc"
    }
    orderBy(language, ~direction)
  }
  let jargonsQuery = jargonsCollection->query(queryConstraint)
  let {status, data: jargons} =
    jargonsQuery->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  switch status {
  | #loading =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>

  | #success =>
    switch jargons {
    | None => React.null
    | Some(jargons) =>
      let regex = {
        let matchAll = %re("/.*/")
        try Js.Re.fromString(regexQuery) catch {
        | Js.Exn.Error(obj) => {
            obj->Js.Exn.message->Option.forEach(Js.log)
            matchAll
          }
        }
      }
      let rows = jargons->Array.keepMap(({english, korean} as jargon) => {
        switch (english->Js.String2.match_(regex), korean->Js.String2.match_(regex)) {
        | (None, None) => None
        | _ => Some(<JargonCard jargon language key={jargon.id} />)
        }
      })

      <div className="grid sm:grid-cols-2 xl:grid-cols-3 gap-x-6 gap-y-2">
        {rows->React.array}
      </div>
    }
  }
}
