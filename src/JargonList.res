open Jargon

type language = English | Korean
type direction = Ascending | Descending
type order = (language, direction)

let makeRow = ({id, english, korean}, language) => {
  let (primary, secondary) = switch language {
  | English => (english, korean)
  | Korean => (korean, english)
  }

  <div
    key={id}
    className="group cursor-pointer p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
    onClick={_ => RescriptReactRouter.push(`/jargon/${id}`)}>
    <div
      className="font-semibold group-hover:text-teal-700 dark:group-hover:text-teal-200 dark:text-white">
      {primary->React.string}
    </div>
    <div
      className="font-regular text-right text-zinc-500 group-hover:text-teal-600 dark:text-zinc-400 dark:group-hover:text-teal-300">
      {secondary->React.string}
    </div>
  </div>
}

@react.component
let make = (~enKo, ~query as regexQuery) => {
  let language = enKo ? English : Korean
  let direction = Ascending

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
        | _ => Some(makeRow(jargon, language))
        }
      })

      <div className="grid sm:grid-cols-2 xl:grid-cols-3 gap-x-6 gap-y-2">
        {rows->React.array}
      </div>
    }
  }
}
