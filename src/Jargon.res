type jargon = {id: string, english: string, korean: string}

type language = English | Korean
type direction = Ascending | Descending
type order = (language, direction)

module Dictionary = {
  let header =
    <thead>
      <tr> <th> {React.string(`영어`)} </th> <th> {React.string(`한국어`)} </th> </tr>
    </thead>

  let makeRow = ({id, english, korean}) => {
    <tr key=id> <td> {React.string(english)} </td> <td> {React.string(korean)} </td> </tr>
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
      <table className="content-table"> header <tbody> {React.array(rows)} </tbody> </table>
    }
  }
}

module InputForm = {
  @react.component
  let make = (~query, ~onChange) => {
    <form>
      <label> {React.string(`검색 (정규식)`)} </label>
      <input type_="text" value=query onChange />
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

  <div className="container"> <InputForm query onChange /> <Dictionary query /> </div>
}
