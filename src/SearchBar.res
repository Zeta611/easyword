@react.component
let make = (~searchTerm, ~onChange) => {
  <div className="relative flex place-items-center gap-1">
    <input
      id="search-bar"
      type_="search"
      value=searchTerm
      onChange
      className="input input-bordered w-full rounded-lg text-sm shadow-lg"
      placeholder="정규식으로 검색해보세요"
    />
  </div>
}
