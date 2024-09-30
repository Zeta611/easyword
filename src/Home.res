module CategoryQuery = %relay(`
  query HomeCategoryQuery {
    category_connection(order_by: { name: asc }) {
      edges {
        node {
          id
          name
          acronym
        }
      }
    }
  }
`)

type filter = {
  label: string,
  value: int,
}

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

  let filterModalId = "filter-modal"
  let (categoryIDs, setCategoryIDs) = React.useState(() => [])
  let {category_connection: {edges: categoryEdges}} = CategoryQuery.use(~variables=())
  let (categoryCnt, setCategoryCnt) = React.useState(() => 0)
  let options = categoryEdges->Array.map(edge => {
    let {node: {id, name, acronym}} = edge
    {
      label: `${acronym} (${name})`,
      value: id->Base64.retrieveOriginalIDInt->Option.getUnsafe,
    }
  })
  if options->Array.length > 0 && categoryCnt == 0 {
    // Only on the first render
    setCategoryCnt(_ => options->Array.length)
    setCategoryIDs(_ => options->Array.map(({value}) => value))
  }

  let (onlyWithoutTranslation, setOnlyWithoutTranslation) = React.useState(() => false)

  open Heroicons
  <div className="grid p-5 text-sm">
    <HideUs>
      <i className="fa-solid fa-arrow-down-a-z" />
      <i className="fa-solid fa-arrow-up-a-z" />
      <i className="fa-solid fa-dice" />
    </HideUs>
    <div
      className="flex items-center space-x-2 sticky top-[4rem] md:top-[5.25rem] pt-1 -mt-5 mb-5 z-40 bg-base-100">
      <div className="flex-auto">
        <SearchBar searchTerm onChange />
      </div>
      <button
        className="btn btn-square btn-primary btn-outline text-lg"
        onClick={_ => {
          open! Webapi.Dom // suppress warning for document

          (
            document
            ->Document.getElementById(filterModalId)
            ->Option.flatMap(Util.asHtmlDialogElement)
            ->Option.getExn
          )["showModal"]()->ignore

          closeDropdown()
        }}>
        <div className="indicator">
          {if categoryIDs->Array.length != categoryCnt || onlyWithoutTranslation {
            <span className="indicator-item badge badge-accent badge-xs" />
          } else {
            React.null
          }}
          <Outline.FunnelIcon className="h-5 w-5" />
        </div>
      </button>
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
                closeDropdown()
              }}>
              {"무작위순"->React.string}
            </button>
          </li>
        </ul>
      </details>
    </div>
    <dialog id=filterModalId className="modal modal-bottom sm:modal-middle">
      <div className="modal-box overflow-visible">
        <h3 className="font-bold text-lg"> {"분야 필터"->React.string} </h3>
        <div className="flex py-1">
          <button
            className="m-1 p-2 badge badge-lg badge-neutral"
            onClick={_ => setCategoryIDs(_ => options->Array.map(({value}) => value))}>
            {"모두 선택"->React.string}
          </button>
          <button className="m-1 p-2 badge badge-lg" onClick={_ => setCategoryIDs(_ => [])}>
            {"모두 해제"->React.string}
          </button>
        </div>
        <ul className="py-2 flex flex-wrap">
          {options
          ->Array.map(({label, value}) =>
            <li key={value->Int.toString} className="p-1">
              <button
                className={`badge badge-lg ${if categoryIDs->Array.includes(value) {
                    "badge-primary"
                  } else {
                    ""
                  }}`}
                onClick={_ =>
                  setCategoryIDs(categoryIDs =>
                    if categoryIDs->Array.includes(value) {
                      categoryIDs->Array.filter(v => v != value)
                    } else {
                      [value, ...categoryIDs]
                    }
                  )}>
                {label->React.string}
              </button>
            </li>
          )
          ->React.array}
        </ul>
        <div className="divider" />
        <h3 className="font-bold text-lg flex gap-4 items-center">
          {"번역 없는 용어만 보기"->React.string}
          <input
            type_="checkbox"
            className="checkbox checkbox-primary checkbox-md"
            checked={onlyWithoutTranslation}
            onChange={_ => setOnlyWithoutTranslation(v => !v)}
          />
        </h3>
        <div className="modal-action">
          <form method="dialog">
            <button className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">
              {"✕"->React.string}
            </button>
          </form>
        </div>
      </div>
      <form method="dialog" className="modal-backdrop">
        <button className="cursor-default" />
      </form>
    </dialog>
    <ErrorBoundary
      fallbackRender={({error, resetErrorBoundary}) => {
        Console.error(error)
        setResetErrorBoundary(_ => Some(resetErrorBoundary))
        React.null
      }}>
      <HomeJargonListSection
        searchTerm=debouncedSearchTerm categoryIDs onlyWithoutTranslation axis direction
      />
    </ErrorBoundary>
  </div>
}
