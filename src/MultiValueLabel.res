@react.component
let make = (~children: string) => {
  let acronym = children->String.split(" ")->Array.getUnsafe(0)
  <div className="badge badge-md ml-1"> {acronym->React.string} </div>
}
