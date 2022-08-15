// TODO: Refine types
@module("./firestore.js") external streamJargons: unit => 'stream = "streamJargons"
@module("./firestore.js") external addJargon: (string, string) => 'a = "addJargon"
type jargon = {id: string, english: string, korean: string}

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

    React.useEffect0(() => {
      let stream = streamJargons()
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
