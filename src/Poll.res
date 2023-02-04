let getVotesRatio = (votes, allVotes) => votes->Int.toFloat /. allVotes->Int.toFloat

let makeRows = translations => {
  let allVotes = translations->Array.reduceU(0, (. cnt, x: Jargon.translation) => x.votes + cnt)
  translations
  ->Array.mapU((. x: Jargon.translation) =>
    <tr className="active" key={x.id}>
      <th className="w-10">
        <label>
          <input type_="radio" name="radio" className="radio radio-primary" />
        </label>
      </th>
      <td>
        {x.korean->React.string}
        <br />
        <progress
          className="progress progress-primary w-full"
          value={getVotesRatio(x.votes, allVotes)->Float.toString}
          max="1"
        />
      </td>
      <th className="w-10"> {(x.votes->Int.toString ++ "표")->React.string} </th>
    </tr>
  )
  ->React.array
}

@react.component
let make = (~id) => {
  open Firebase
  let firestore = useFirestore()
  let translationsCollection = firestore->collection(~path=`jargons/${id}/translations`)
  let {status, data: translations} =
    translationsCollection
    ->query(orderBy("votes", ~direction=#desc))
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  switch (status, translations) {
  | (#success, Some(translations)) =>
    <div className="overflow-x-auto">
      <table className="table w-full">
        <tbody> {translations->makeRows} </tbody>
      </table>
    </div>
  | _ => React.null
  }
}
