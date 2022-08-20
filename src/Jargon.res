type jargon = {id: string, english: string, korean: string}
type jargonStream = (array<jargon> => unit) => Firebase.unsubscribe

type direction = Ascending | Descending
type order = English(direction) | Korean(direction)

let streamJargons = (~order) => {
  open Firebase
  let {firestore} = getFirebase()
  let jargonsCol = collection(firestore, ~path="jargons")
  let queryConstraint = switch order {
  | English(Ascending) => orderBy("english", ())
  | English(Descending) => orderBy("english", ~order="desc", ())
  | Korean(Ascending) => orderBy("korean", ())
  | Korean(Descending) => orderBy("korean", ~order="desc", ())
  }
  let jargonsQuery = query(jargonsCol, queryConstraint)
  callback =>
    onSnapshot(jargonsQuery, snapshot => {
      let jargons =
        snapshot
        ->QuerySnapshot.docs
        ->Array.map(doc => {
          open DocSnapshot
          {...doc->data(), id: doc->id}
        })
      callback(jargons)
    })
}

let addJargon = (english, korean) => {
  open Firebase
  let {firestore} = getFirebase()
  addDoc(collection(firestore, ~path="jargons"), {"english": english, "korean": korean})
}

module Dictionary = {
  let header =
    <thead>
      <tr> <th> {React.string(`영어`)} </th> <th> {React.string(`한국어`)} </th> </tr>
    </thead>

  let makeRow = ({id, english, korean}) => {
    <tr key=id> <td> {React.string(english)} </td> <td> {React.string(korean)} </td> </tr>
  }

  @react.component
  let make = (~query) => {
    let (jargons, setJargons) = React.useState(_ => [])
    let (order, setOrder) = React.useState(_ => English(Ascending))

    React.useEffect0(() => {
      let stream = streamJargons(~order)
      let unsubscribe = stream(jargons => {
        setJargons(_ => jargons)
      })

      // cleanup
      Some(() => {unsubscribe()})
    })

    let regex = {
      let matchAll = %re("/.*/")
      try Js.Re.fromString(query) catch {
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
