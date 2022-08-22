type jargon = {id: string, english: string, korean: string}

type language = English | Korean
type direction = Ascending | Descending
type order = (language, direction)

module Dictionary = {
  let makeRow = ({id, english, korean}) => {
    <div
      key={id}
      className="group p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900">
      <div
        className="font-semibold group-hover:text-teal-700 dark:group-hover:text-teal-200 dark:text-white">
        {React.string(english)}
      </div>
      <div
        className="font-regular text-right text-zinc-500 group-hover:text-teal-600 dark:text-zinc-400 dark:group-hover:text-teal-300">
        {React.string(korean)}
      </div>
    </div>
  }

  @react.component
  let make = (~query as regexQuery) => {
    let ((language, direction), setOrder) = React.useState(_ => (English, Ascending))

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
      jargonsQuery->useFirestoreCollectionData(reactFireOptions(~idField="id", ()))

    if status == "loading" {
      React.string("loading")
    } else {
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
        | _ => Some(makeRow(jargon))
        }
      })

      <div className="grid sm:grid-cols-2 xl:grid-cols-3 gap-x-6 gap-y-2">
        {React.array(rows)}
      </div>
    }
  }
}

module InputForm = {
  @react.component
  let make = (~query, ~onChange) => {
    <form>
      <div className="relative">
        <input
          type_="search"
          value=query
          onChange
          className="block p-4 w-full text-base text-zinc-900 bg-zinc-50 rounded-lg border border-solid border-zinc-200 hover:bg-zinc-200 dark:text-zinc-50 dark:bg-zinc-800 dark:border-zinc-700 dark:hover:bg-zinc-700"
          placeholder="정규식: syntax$"
        />
      </div>
    </form>
  }
}

@react.component
let make = () => {
  // query is set from InputForm via onChange and passed into Dictionary
  let (query, setQuery) = React.useState(() => "")
  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(_ => value)
  }

  <div className="grid gap-4 p-5">
    <InputForm query onChange />
    <Dictionary query />
  </div>
}
