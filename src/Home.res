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
    switch axis {
    | Random(_) => setAxis(_ => Chrono)
    | _ => ()
    }
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
    <HideUs>
      <i className="fa-solid fa-arrow-down-a-z" />
      <i className="fa-solid fa-arrow-up-a-z" />
      <i className="fa-solid fa-dice" />
    </HideUs>
    <div
      className="flex items-center space-x-2 sticky top-[4rem] lg:top-[5.25rem] pt-1 -mt-5 mb-5 z-40 bg-base-100">
      <div className="flex-auto">
        <SearchBar searchTerm onChange />
      </div>
      <button
        className="btn btn-square btn-primary btn-outline text-lg"
        onClick={_ => {
          switch (axis, direction) {
          | (Chrono, _) => ()
          | (English, #asc) => setDirection(_ => #desc)
          | (English, #desc) => setDirection(_ => #asc)
          | (Random(_), _) => {
              setAxis(_ => Random(seed()))
              setSearchTerm(_ => "")
            }
          }
          closeDropdown()
        }}>
        {switch (axis, direction) {
        | (English, #asc) => <i className="fa-solid fa-arrow-down-a-z" />
        | (English, #desc) => <i className="fa-solid fa-arrow-up-a-z" />
        | (Chrono, _) => <Outline.ClockIcon className="h-5 w-5" />
        | (Random(_), _) => <i className="fa-solid fa-dice" />
        }}
      </button>
      <details id="sort-dropdown-btn" className="dropdown dropdown-hover dropdown-end text-xs">
        <summary className="btn btn-square btn-ghost">
          <Outline.ListBulletIcon className="h-5 w-5" />
        </summary>
        <ul
          className="menu menu-compact dropdown-content text-xs p-1 m-1 w-[6.5rem] shadow bg-zinc-50 dark:bg-zinc-800 rounded-box">
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
                setDirection(_ => #asc)
                closeDropdown()
              }}>
              {"알파벳순"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ => {
                setAxis(_ => Random(seed()))
                setSearchTerm(_ => "")
              }}>
              {"무작위순"->React.string}
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
