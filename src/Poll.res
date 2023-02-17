let getVotesRatio = (votes, allVotes) => votes->Int.toFloat /. allVotes->Int.toFloat

let makeRows = translations => {
  let allVotes = translations->Array.reduceU(0, (. cnt, t: Jargon.translation) => t.votes + cnt)
  translations
  ->Array.mapU((. translation: Jargon.translation) =>
    <tr className="active" key={translation.id}>
      <th className="w-10">
        <label>
          <input type_="radio" name="radio" className="radio radio-primary" />
        </label>
      </th>
      <td>
        <a href={`#${translation.associatedComment}`}> {translation.korean->React.string} </a>
        <br />
        <progress
          className="progress progress-primary w-full"
          value={getVotesRatio(translation.votes, allVotes)->Float.toString}
          max="1"
        />
      </td>
      <th className="w-10"> {(translation.votes->Int.toString ++ "표")->React.string} </th>
    </tr>
  )
  ->React.array
}

@react.component
let make = (~jargonID) => {
  open Firebase
  let firestore = useFirestore()
  let translationsCollection = firestore->collection(~path=`jargons/${jargonID}/translations`)
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
