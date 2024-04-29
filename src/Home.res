let seed = () => Math.random() *. 2. -. 1.

@react.component
let make = () => {
  // searchTerm is set from SearchBar via onChange and passed into Dictionary
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let debouncedSearchTerm = Hooks.useDebounce(searchTerm, 300)
  let (axis, setAxis) = React.useState(() => Jargon.Chrono)
  let (direction, setDirection) = React.useState(() => #desc)

  let (resetErrorBoundary, setResetErrorBoundary) = React.useState(() => None)
  let closeDropdown = Hooks.useClosingDropdown("sort-dropdown-btn")

  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setSearchTerm(_ => value)
    switch resetErrorBoundary {
    | Some(resetErrorBoundary) => {
        resetErrorBoundary()
        setResetErrorBoundary(_ => None)
      }
    | None => ()
    }
  }

  open Heroicons
  <div className="grid p-5 text-sm">
    <div
      className="flex items-center space-x-2 sticky top-[4rem] md:top-[5.25rem] -mt-5 mb-5 z-40 bg-base-100">
      <div className="flex-auto mt-1">
        <SearchBar searchTerm onChange />
      </div>
      <details
        id="sort-dropdown-btn"
        className="dropdown dropdown-hover dropdown-end shadow-lg rounded-lg mt-1">
        <summary className="btn btn-primary text-xs">
          {switch (axis, direction) {
          | (Chrono | Random(_), _) => React.null
          | (_, #asc) => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          | (_, #desc) => <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          }}
          {switch (axis, direction) {
          | (English, _) => "ABC순"->React.string
          | (Chrono, _) => "최근순"->React.string
          | (Random(_), _) => "무작위"->React.string
          }}
          <Solid.ChevronDownIcon className="ml-2 -mr-1 h-5 w-5" />
        </summary>
        <ul
          className="menu menu-compact dropdown-content text-xs p-1 m-1 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button
              onClick={_ => {
                setAxis(_ => Chrono)
                setDirection(_ => #desc)
                closeDropdown()
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
                closeDropdown()
              }}>
              {"ABC순"->React.string}
              {switch direction {
              | #asc => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | #desc => <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              }}
            </button>
          </li>
          <li>
            <button
              onClick={_ => {
                setAxis(_ => Random(seed()))
                setSearchTerm(_ => "")
              }}>
              {"무작위"->React.string}
            </button>
          </li>
        </ul>
      </details>
    </div>
    <ErrorBoundary
      fallbackRender={({error, resetErrorBoundary}) => {
        Console.error(error)
        setResetErrorBoundary(_ => Some(resetErrorBoundary))
        React.null
      }}>
      <HomeJargonListSection searchTerm=debouncedSearchTerm axis direction />
    </ErrorBoundary>
  </div>
}
