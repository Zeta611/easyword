module SearchBar = {
  @react.component
  let make = (~query, ~onChange) => {
    <form>
      <div className="relative">
        <input
          type_="search"
          value=query
          onChange
          className="input input-bordered w-full rounded-lg"
          placeholder="정규식: syntax$"
        />
      </div>
    </form>
  }
}

@react.component
let make = () => {
  // query is set from SearchBar via onChange and passed into Dictionary
  let (query, setQuery) = React.Uncurried.useState(() => "")
  let (order, setOrder) = React.Uncurried.useState(() => {
    open Jargon
    (English, #asc)
  })

  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(._ => value)
  }

  open Heroicons
  <div className="grid gap-4 p-5">
    <div className="flex items-center space-x-2">
      <div className="flex-auto">
        <SearchBar query onChange />
      </div>
      <div className="dropdown dropdown-end">
        <label tabIndex={0} className="btn">
          {switch order {
          | (_, #asc) =>
            <Solid.ArrowUpIcon className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100" />
          | (_, #desc) =>
            <Solid.ArrowDownIcon className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100" />
          }}
          {switch order {
          | (English, _) => "영한"->React.string
          | (Korean, _) => "한영"->React.string
          }}
          <Solid.ChevronDownIcon className="ml-2 -mr-1 h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu dropdown-content p-2 shadow bg-base-100 rounded-box w-52 mt-4">
          <li>
            <button
              onClick={_ =>
                setOrder(.order => {
                  switch order {
                  | (English, _) | (Korean, #desc) => (Korean, #asc)
                  | (Korean, #asc) => (Korean, #desc)
                  }
                })}>
              {"한영"->React.string}
              {switch order {
              | (Korean, #asc) =>
                <Solid.ArrowUpIcon
                  className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100"
                />
              | (Korean, #desc) =>
                <Solid.ArrowDownIcon
                  className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100"
                />
              | _ => React.null
              }}
            </button>
          </li>
          <li>
            <button
              onClick={_ =>
                setOrder(.order => {
                  switch order {
                  | (Korean, _) | (English, #desc) => (English, #asc)
                  | (English, #asc) => (English, #desc)
                  }
                })}>
              {"영한"->React.string}
              {switch order {
              | (English, #asc) =>
                <Solid.ArrowUpIcon
                  className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100"
                />
              | (English, #desc) =>
                <Solid.ArrowDownIcon
                  className="-ml-2 mr-1 h-5 w-5 text-teal-200 hover:text-teal-100"
                />
              | _ => React.null
              }}
            </button>
          </li>
        </ul>
      </div>
    </div>
    <JargonList order query />
  </div>
}
