@react.component
let make = () => {
  // query is set from SearchBar via onChange and passed into Dictionary
  let (query, setQuery) = React.Uncurried.useState(() => "")
  let (axis, setAxis) = React.Uncurried.useState(() => Jargon.Chrono)
  let (direction, setDirection) = React.Uncurried.useState(() => #desc)

  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(_ => value)
  }

  open Heroicons
  <div className="grid p-5 text-sm">
    <div
      className="flex items-center space-x-2 sticky top-[4rem] md:top-[5.75rem] -mt-5 mb-5 z-40 bg-base-100">
      <div className="flex-auto">
        <SearchBar query onChange />
      </div>
      <div className="dropdown dropdown-hover dropdown-end shadow-lg rounded-lg">
        <label
          tabIndex={0}
          className="btn btn-primary"
          onClick={_ => {
            switch (axis, direction) {
            | (Chrono, _) => setDirection(_ => #desc)
            | (_, #asc) => setDirection(_ => #desc)
            | (_, #desc) => setDirection(_ => #asc)
            }
          }}>
          {switch (axis, direction) {
          | (Chrono, _) => React.null
          | (_, #asc) => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          | (_, #desc) => <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          }}
          {switch (axis, direction) {
          | (English, _) => "ABC순"->React.string
          | (Chrono, _) => "최근순"->React.string
          }}
          <Solid.ChevronDownIcon className="ml-2 -mr-1 h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button
              onClick={_ => {
                setAxis(_ => Chrono)
                setDirection(_ => #desc)
              }}>
              {"최근순"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ => {
                setAxis(_ => English)
                setDirection(direction => {
                  // If axis was Chrono, the direction was always #desc
                  switch direction {
                  | #asc => #desc
                  | #desc => #asc
                  }
                })
              }}>
              {"ABC순"->React.string}
              {switch direction {
              | #asc => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | #desc => <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              }}
            </button>
          </li>
        </ul>
      </div>
    </div>
    <React.Suspense
      fallback={<div className="h-screen grid justify-center content-center">
        <Loader />
      </div>}>
      <JargonList axis direction={direction->Obj.magic} query />
    </React.Suspense>
  </div>
}
