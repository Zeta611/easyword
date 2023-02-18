open Jargon

@react.component
let make = (~jargon as {id, english, korean}, ~axis) => {
  let (primary, secondary) = switch axis {
  | Chrono | English => (english, korean)
  | Korean => (korean, english)
  }

  let (commentsCount, setCommentsCount) = React.Uncurried.useState(() => None)

  open Firebase
  let firestore = useFirestore()
  let jargonDoc = firestore->doc(~path=`jargons/${id}`)
  let {data: jargon} = jargonDoc->useFirestoreDocData

  let commentsCollection = firestore->collection(~path=`jargons/${id}/comments`)

  React.useEffect0(() => {
    let countComments = async (. ()) => {
      let snapshot = await getCountFromServer(commentsCollection)
      let count = snapshot.data(.).count
      setCommentsCount(._ => Some(count))
    }
    let _ = countComments(.)

    None
  })

  <div
    className="flex flex-col gap-y-2 group cursor-pointer p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
    onClick={_ => RescriptReactRouter.push(`/jargon/${id}`)}>
    // first row
    <div className="flex-none">
      {switch jargon {
      | Some({timestamp: Some(timestamp)}) =>
        <div className="text-xs dark:text-zinc-500">
          {`최근 활동 ${timestamp->Timestamp.toDate->DateFormat.timeAgo}`->React.string}
        </div>
      | _ => React.null
      }}
    </div>
    // second row
    <div className="flex-none inline-grid grid-cols-2">
      <div
        className="w-full font-semibold group-hover:text-teal-700 dark:group-hover:text-teal-200">
        {primary->React.string}
      </div>
      <div
        className="w-full overflow-hidden group-hover:overflow-visible whitespace-nowrap group-hover:whitespace-normal text-ellipsis font-regular text-zinc-500 group-hover:text-teal-600 dark:text-zinc-400 dark:group-hover:text-teal-300">
        {secondary->React.string}
      </div>
    </div>
    // third row
    {switch commentsCount {
    | None => React.null
    | Some(count) =>
      <div className="flex-none text-xs dark:text-zinc-400">
        {j`댓글 $count개`->React.string}
      </div>
    }}
  </div>
}
