module SearchBar = {
  @react.component
  let make = (~query, ~caseSensitivity, ~setCaseSensitivity, ~onChange) => {
    <div className="relative flex place-items-center gap-1">
      <input
        type_="search"
        value=query
        onChange
        className="input input-bordered w-full rounded-lg text-sm"
        placeholder="정규식으로 검색해보세요"
      />
      {React.cloneElement(
        <div className="flex flex-col text-xs place-items-center tooltip tooltip-bottom">
          {"/re/i"->React.string}
          <input
            type_="checkbox"
            className="checkbox checkbox-secondary"
            checked={caseSensitivity}
            onChange={_ => setCaseSensitivity(._ => !caseSensitivity)}
          />
        </div>,
        {"data-tip": "대소문자 구분 여부"},
      )}
    </div>
  }
}

@react.component
let make = () => {
  // query is set from SearchBar via onChange and passed into Dictionary
  let (query, setQuery) = React.Uncurried.useState(() => "")
  let (order, setOrder) = React.Uncurried.useState(() => {
    open Jargon
    (Chrono, #desc)
  })

  let (caseSensitivity, setCaseSensitivity) = React.Uncurried.useState(() => false)

  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(._ => value)
  }

  open Heroicons
  <div className="grid gap-4 p-5 text-sm">
    <div className="flex items-center space-x-2">
      <div className="flex-auto">
        <SearchBar query caseSensitivity setCaseSensitivity onChange />
      </div>
      <div className="dropdown dropdown-hover dropdown-end">
        <label
          tabIndex={0}
          className="btn btn-primary"
          onClick={_ => {
            switch order {
            | (Chrono, _) => setOrder(._ => (Chrono, #desc))
            | (lang, #asc) => setOrder(._ => (lang, #desc))
            | (lang, #desc) => setOrder(._ => (lang, #asc))
            }
          }}>
          {switch order {
          | (Chrono, _) => React.null
          | (_, #asc) => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          | (_, #desc) => <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-teal-100" />
          }}
          {switch order {
          | (English, _) => "영한"->React.string
          | (Korean, _) => "한영"->React.string
          | (Chrono, _) => "최근"->React.string
          }}
          <Solid.ChevronDownIcon className="ml-2 -mr-1 h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button onClick={_ => setOrder(._ => (Chrono, #desc))}>
              {"최근"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ =>
                setOrder(.order => {
                  switch order {
                  | (English, _) | (Chrono, _) | (Korean, #desc) => (Korean, #asc)
                  | (Korean, #asc) => (Korean, #desc)
                  }
                })}>
              {"한영"->React.string}
              {switch order {
              | (Korean, #asc) => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | (Korean, #desc) =>
                <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | _ => React.null
              }}
            </button>
          </li>
          <li>
            <button
              onClick={_ =>
                setOrder(.order => {
                  switch order {
                  | (Korean, _) | (Chrono, _) | (English, #desc) => (English, #asc)
                  | (English, #asc) => (English, #desc)
                  }
                })}>
              {"영한"->React.string}
              {switch order {
              | (English, #asc) => <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | (English, #desc) =>
                <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-primary" />
              | _ => React.null
              }}
            </button>
          </li>
        </ul>
      </div>
    </div>
    <JargonList order query caseSensitivity />
  </div>
}
