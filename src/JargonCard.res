open Jargon

@react.component
let make = (~jargon as {id, english, korean}, ~language) => {
  let (primary, secondary) = switch language {
  | English => (english, korean)
  | Korean => (korean, english)
  }

  let (commentsCount, setCommentsCount) = React.Uncurried.useState(() => None)

  let firestore = Firebase.useFirestore()
  let commentsCollection = firestore->Firebase.collection(~path=`jargons/${id}/comments`)

  React.useEffect(() => {
    let countComments = async (. ()) => {
      let snapshot = await Firebase.getCountFromServer(commentsCollection)
      let count = snapshot["data"](.)["count"]
      setCommentsCount(._ => Some(count))
    }
    let _ = countComments(.)
    None
  })

  <div
    className="flex flex-col gap-y-2 group cursor-pointer p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
    onClick={_ => RescriptReactRouter.push(`/jargon/${id}`)}>
    // first row
    <div className="flex-none inline-grid grid-cols-2">
      <div className="flex gap-x-2">
        <div className="text-sm"> {"🔥"->React.string} </div>
        <div className="badge badge-primary badge-outline badge-md"> {"#PL"->React.string} </div>
      </div>
      <div className="text-right text-xs dark:text-zinc-500">
        {"최근 활동 0분 전"->React.string}
      </div>
    </div>
    // second row
    <div className="flex-none inline-grid grid-cols-2">
      <div
        className="w-full font-semibold group-hover:text-teal-700 dark:group-hover:text-teal-200 dark:text-white">
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
      <div className="flex-none dark:text-zinc-400">
        {`댓글 ${count->Int.toString}개`->React.string}
      </div>
    }}
  </div>
}
