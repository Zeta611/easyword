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
    (English, Ascending)
  })

  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(._ => value)
  }

  <div className="grid gap-4 p-5">
    <div className="flex items-center space-x-2">
      <div className="flex-auto">
        <SearchBar query onChange />
      </div>
      <div className="flex-none">
        <Filter order setOrder />
      </div>
    </div>
    <JargonList order query />
  </div>
}
