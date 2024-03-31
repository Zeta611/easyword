module JargonCardFragment = %relay(`
  fragment JargonCard_jargon on jargon {
    id
    name
    updated_at
    translations(order_by: {name: asc}, limit: 20) {
      id
      name
    }
    comments_aggregate {
      aggregate {
        count
      }
    }
  }
`)

@react.component
let make = (~jargon) => {
  let {id, name, updated_at, translations, comments_aggregate} = JargonCardFragment.use(jargon)

  <div
    className="flex flex-col gap-y-2 group cursor-pointer p-4 bg-white hover:bg-teal-50 rounded-xl shadow-md dark:bg-zinc-900 dark:hover:bg-teal-900"
    onClick={_ => RescriptReactRouter.push(`/jargon/${id}`)}>
    // first row
    <div className="flex-none">
      {<div className="text-xs dark:text-zinc-500">
        {`최근 활동 ${updated_at->Js.Date.fromString->DateFormat.timeAgo}`->React.string}
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
          ->Array.map(({id, name}) => <li key={id}> {name->React.string} </li>)
          ->React.array}
        </ol>
      </div>
    </div>
    // third row
    <div className="flex-none text-xs dark:text-zinc-400">
      {`댓글 ${comments_aggregate.aggregate
        ->Option.flatMap(x => Some(x.count))
        ->Option.getWithDefault(0)
        ->Int.toString}개`->React.string}
    </div>
  </div>
}
