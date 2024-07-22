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
      Select.label: `${acronym} (${name})`,
      value: id->Base64.retrieveOriginalIDInt->Option.getUnsafe,
    }
  })
  if options->Array.length > 0 && categoryCnt == 0 {
    // Only on the first render
    setCategoryCnt(_ => options->Array.length)
    setCategoryIDs(_ => options->Array.map(({value}) => value))
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
                closeDropdown()
              }}>
              {"무작위순"->React.string}
            </button>
          </li>
          <li>
            <button
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
              {"분야 필터"->React.string}
            </button>
          </li>
        </ul>
      </details>
    </div>
    <dialog id=filterModalId className="modal modal-bottom sm:modal-middle">
      <div className="modal-box overflow-visible">
        <h3 className="font-bold text-lg"> {"분야 필터"->React.string} </h3>
        <div className="py-2 pb-[20em]">
          <Select
            classNames={
              control: _ => "rounded-btn border text-base border-base-content/20 px-4 py-2",
              menuList: _ =>
                "grid grid-cols-1 menu bg-zinc-50 dark:bg-zinc-800 rounded-box px-2 py-2 mt-1 text-base shadow-lg",
              option: _ => "hover:bg-zinc-200 dark:hover:bg-zinc-600 px-2 py-1 rounded-box",
            }
            components={multiValueLabel: MultiValueLabel.make}
            onChange={options => setCategoryIDs(_ => options->Array.map(({value}) => value))}
            defaultValue=options
            options
            isSearchable=false
            isClearable=true
            isMulti=true
            unstyled=true
            placeholder="분야를 선택해주세요"
            noOptionsMessage={_ => "더 이상의 분야가 없어요"}
          />
        </div>
        <div className="modal-action">
          <form method="dialog">
            <button className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">
              {"✕"->React.string}
            </button>
          </form>
        </div>
      </div>
    </dialog>
    <ErrorBoundary
      fallbackRender={({error, resetErrorBoundary}) => {
        Console.error(error)
        setResetErrorBoundary(_ => Some(resetErrorBoundary))
        React.null
      }}>
      <HomeJargonListSection searchTerm=debouncedSearchTerm categoryIDs axis direction />
    </ErrorBoundary>
  </div>
}
