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
    ~jargonID: string,
    ~translation: Jargon.translation,
    ~allVotes,
    ~checkedItemHandler,
    ~isChecked,
    ~votesCount,
    ~setVotesCount,
  ) => {
    let (checked, setChecked) = React.Uncurried.useState(() => false)
    let checkHandler = () => {
      setChecked(._ => !checked)
      checkedItemHandler(translation.id, !checked)
    }

    React.useEffect(() => {
      setChecked(._ => isChecked)
      None
    })

    let {signedIn, user} = React.useContext(SignInContext.context)
    open Firebase
    let firestore = useFirestore()
    let votesCollection =
      firestore->collection(~path=`jargons/${jargonID}/translations/${translation.id}/votes`)
    let {status, data: votes} =
      votesCollection
      ->query([])
      ->useFirestoreCollectionData(~options=reactFireOptions(~idField="id", ()), ())

    React.useEffect1(() => {
      switch votes {
      | None => ()
      | Some(votes) =>
        setVotesCount(.votesCount =>
          votesCount->Map.String.update(translation.id, _ => Some(votes->Array.size))
        )

        if signedIn {
          switch user->Js.Nullable.toOption {
          | Some({uid}) =>
            if votes->Js.Array2.find(x => x["id"] == uid)->Option.isSome {
              checkedItemHandler(translation.id, true)
            }

          | None => ()
          }
        }
      }
      None
    }, [votes])

    switch (status, votes) {
    | (#success, Some(votes)) =>
      let votes = votesCount->Map.String.getWithDefault(translation.id, votes->Array.size)
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
        <th className="w-10"> {`${votes->Int.toString}표`->React.string} </th>
      </tr>
    | _ => React.null
    }
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

  let (checkedItems, setCheckedItems) = React.Uncurried.useState(() => Set.String.empty)
  let checkedItemHandler = (id, isChecked) => {
    open Set.String
    if isChecked {
      setCheckedItems(.checkedItems => checkedItems->add(id))
    } else if checkedItems->has(id) {
      setCheckedItems(.checkedItems => checkedItems->remove(id))
    }
  }

  let (votesCount, setVotesCount) = React.Uncurried.useState(() => Map.String.empty)

  let (isLoading, setIsLoading) = React.Uncurried.useState(() => false)

  let {signedIn, user} = React.useContext(SignInContext.context)
  let functions = useFirebaseApp()->getFunctions
  let onVoteButtonTapped = () => {
    if signedIn {
      switch user->Js.Nullable.toOption {
      | Some(_) =>
        setIsLoading(._ => true)

        (
          async () => {
            let vote = functions->httpsCallable("vote")
            let result = await vote(.
              (
                {
                  jargonID,
                  translations: checkedItems->Set.String.toArray,
                }: Jargon.vote
              ),
            )

            result.data
            ->Js.Dict.entries
            ->Array.forEach(((translationID, diff)) =>
              setVotesCount(.votesCount =>
                votesCount->Map.String.update(
                  translationID,
                  cnt =>
                    switch cnt {
                    | None => Some(diff)
                    | Some(cnt) => Some(cnt + diff)
                    },
                )
              )
            )

            setIsLoading(._ => false)
          }
        )()->ignore
      | None => Window.alert("You need to be signed in to vote!")
      }
    } else {
      Window.alert("You need to be signed in to vote!")
    }
  }

  switch (translationsStatus, translations) {
  | (#success, Some(translations)) =>
    if translations->Array.size > 0 {
      <div className="overflow-x-auto">
        <table className="table w-full">
          <tbody>
            {translations
            ->Array.map((translation: Jargon.translation) =>
              <PollRow
                key={translation.id}
                jargonID
                translation
                allVotes={votesCount->Map.String.reduce(0, (prev, _, votes) => prev + votes)}
                checkedItemHandler
                isChecked={checkedItems->Set.String.has(translation.id)}
                votesCount
                setVotesCount
              />
            )
            ->React.array}
          </tbody>
        </table>
        <button
          className={`btn btn-primary w-full ${if isLoading {
              "loading"
            } else {
              ""
            }}`}
          onClick={_ => onVoteButtonTapped()}>
          {"투표하기"->React.string}
        </button>
      </div>
    } else {
      React.null
    }
  | _ => React.null
  }
}
