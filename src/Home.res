module InputForm = {
  @react.component
  let make = (~query, ~onChange) => {
    <form>
      <div className="relative">
        <input
          type_="search"
          value=query
          onChange
          className="block p-4 w-full text-base text-zinc-900 bg-zinc-50 rounded-lg border border-solid border-zinc-200 hover:bg-zinc-200 dark:text-zinc-50 dark:bg-zinc-800 dark:border-zinc-700 dark:hover:bg-zinc-700"
          placeholder="정규식: syntax$"
        />
      </div>
    </form>
  }
}

@react.component
let make = () => {
  // query is set from InputForm via onChange and passed into Dictionary
  let (query, setQuery) = React.useState(() => "")
  let onChange = event => {
    let value = (event->ReactEvent.Form.currentTarget)["value"]
    setQuery(_ => value)
  }

  let {status: signInStatus, data: signedIn} = Firebase.useSigninCheck()

  switch signInStatus {
  | #loading =>
    <div className="h-screen grid justify-center content-center">
      <Loader />
    </div>
  | #success =>
    <div>
      {switch signedIn {
      | None | Some({signedIn: false}) => <Navbar signedIn=false />
      | Some({signedIn: true}) => <Navbar signedIn=true />
      }}
      <div className="grid gap-4 p-5">
        <InputForm query onChange />
        <JargonList query />
      </div>
    </div>
  }
}
