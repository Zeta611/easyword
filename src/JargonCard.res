open Jargon

let reactListOfTranslations = translations => {
  <ol>
    {translations
    ->Js.Dict.entries
    ->Js.Array2.sortInPlaceWith(((k1, v1), (k2, v2)) => {
      if v2 - v1 != 0 {
        v2 - v1
      } else if k1 > k2 {
        1
      } else if k1 < k2 {
        -1
      } else {
        0
      }
    })
    ->Array.map(((k, _)) => <li key={k}> {k->React.string} </li>)
    ->React.array}
  </ol>
}

@react.component
let make = (~jargon as {id, name, updated_at, translations, commentsCount}) => {
  <div
    className="flex flex-col gap-y-2 group cursor-pointer p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
    onClick={_ => RescriptReactRouter.push(`/jargon/${id}`)}>
    // first row
    <div className="flex-none">
      {<div className="text-xs dark:text-zinc-500">
        {`최근 활동 ${updated_at->DateFormat.timeAgo}`->React.string}
      </div>}
    </div>
    // second row
    <div className="flex-none inline-grid grid-cols-1">
      <div className="font-semibold group-hover:text-teal-700 dark:group-hover:text-teal-200">
        {name->React.string}
      </div>
      <div
        className="overflow-hidden group-hover:overflow-visible whitespace-nowrap group-hover:whitespace-normal text-ellipsis font-regular text-zinc-500 group-hover:text-teal-600 dark:text-zinc-400 dark:group-hover:text-teal-300">
        <ol>
          {translations
          ->Array.map(((i, t)) => <li key={i}> {t->React.string} </li>)
          ->React.array}
        </ol>
      </div>
    </div>
    // third row
    <div className="flex-none text-xs dark:text-zinc-400">
      {`댓글 ${commentsCount->Int.toString}개`->React.string}
    </div>
  </div>
}
