module TranslationRow = {
  @react.component
  let make = (~translation: Jargon.translation) => {
    <tr>
      <td>
        <a href={`#${translation.associatedComment}`}> {translation.korean->React.string} </a>
      </td>
    </tr>
  }
}

@react.component
let make = (~jargonID) => {
  open Firebase
  let firestore = useFirestore()
  let translationsCollection = firestore->collection(~path=`jargons/${jargonID}/translations`)
  let {status: translationsStatus, data: translations} =
    translationsCollection
    ->query([orderBy("korean", ~direction=#asc)])
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  switch (translationsStatus, translations) {
  | (#success, Some(translations)) =>
    if translations->Array.size > 0 {
      <div className="overflow-x-auto">
        <table className="table w-full">
          <tbody>
            {translations
            ->Array.map((translation: Jargon.translation) =>
              <TranslationRow key={translation.id} translation />
            )
            ->React.array}
          </tbody>
        </table>
      </div>
    } else {
      React.null
    }
  | _ => React.null
  }
}
