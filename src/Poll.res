@val
external window: 'a = "window"

let getVotesRatio = (votes, allVotes) =>
  votes->Int.toFloat /.
    if allVotes > 0 {
      allVotes
    } else {
      0
    }->Int.toFloat

module PollRow = {
  @react.component
  let make = (
    ~translation: Jargon.translation,
    ~allVotes,
    ~checkedItemHandler,
    ~checkedItems,
    ~votes,
  ) => {
    let (checked, setChecked) = React.Uncurried.useState(() => false)
    let checkHandler = () => {
      setChecked(._ => !checked)
      checkedItemHandler(translation.id, !checked)
    }

    React.useEffect(() => {
      if checkedItems->Set.String.has(translation.id) {
        setChecked(._ => true)
      }
      None
    })

    <tr className="active">
      <th className="w-10">
        <label>
          <input
            type_="checkbox"
            checked
            onChange={_ => checkHandler()}
            className="checkbox checkbox-primary"
          />
        </label>
      </th>
      <td>
        <a href={`#${translation.associatedComment}`}> {translation.korean->React.string} </a>
        <br />
        <progress
          className="progress progress-primary w-full"
          value={getVotesRatio(votes, allVotes)->Float.toString}
          max="1"
        />
      </td>
      <th className="w-10"> {(votes->Int.toString ++ "표")->React.string} </th>
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
    ->query(orderBy("korean", ~direction=#asc))
    ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

  let (checkedItems, setCheckedItems) = React.Uncurried.useState(() => Set.String.empty)
  let checkedItemHandler = (id, isChecked) => {
    open Set.String
    if isChecked {
      setCheckedItems(._ => checkedItems->add(id))
    } else if checkedItems->has(id) {
      setCheckedItems(._ => checkedItems->remove(id))
    }
  }

  let (votesCount, setVotesCount) = React.Uncurried.useState(() => Map.String.empty)
  React.useEffect1(() => {
    switch translations {
    | Some(translations) =>
      translations->Array.forEach((translation: Jargon.translation) => {
        let votesCollection =
          firestore->collection(~path=`jargons/${jargonID}/translations/${translation.id}/votes`)

        (
          async () => {
            let snapshot = await getCountFromServer(votesCollection)
            let count = snapshot.data(.).count

            setVotesCount(.
              votesCount => votesCount->Map.String.update(translation.id, _ => Some(count)),
            )
            Js.Console.log2(translation.korean, votesCount->Map.String.getUndefined(translation.id))
          }
        )()->ignore
      })

    | None => ()
    }

    None
  }, [translations])

  let {signedIn, user} = React.useContext(SignInContext.context)

  if signedIn {
    switch user->Js.Nullable.toOption {
    | Some({uid}) =>
      let votesDocRef = firestore->doc(~path=`jargons/${jargonID}/votes/${uid}`)
      React.useEffect0(() => {
        (
          async () => {
            let votesDoc = await votesDocRef->getDoc
            if votesDoc.exists(.) {
              setCheckedItems(._ => votesDoc.data(.)["translations"]->Set.String.fromArray)
            }
          }
        )()->ignore

        None
      })
    | None => ()
    }
  }

  let onVoteButtonTapped = () => {
    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some({uid}) =>
        let votesDocRef = firestore->doc(~path=`jargons/${jargonID}/votes/${uid}`)

        (
          async () => {
            await votesDocRef->setDoc({"translations": checkedItems->Set.String.toArray})
            window["location"]["reload"](.)
          }
        )()->ignore
      | None => ()
      }
    }
  }

  switch (translationsStatus, translations) {
  | (#success, Some(translations)) =>
    let allVotes =
      translations->Array.reduce(0, (cnt, t: Jargon.translation) =>
        votesCount->Map.String.getWithDefault(t.id, 0) + cnt
      )

    <div className="overflow-x-auto">
      <table className="table w-full">
        <tbody>
          {translations
          ->Array.map((translation: Jargon.translation) =>
            <PollRow
              key={translation.id}
              translation
              allVotes
              checkedItemHandler
              checkedItems
              votes={votesCount->Map.String.getWithDefault(translation.id, 0)}
            />
          )
          ->React.array}
        </tbody>
      </table>
      <button className="btn btn-primary w-full" onClick={_ => onVoteButtonTapped()}>
        {"투표하기"->React.string}
      </button>
    </div>
  | _ => React.null
  }
}
