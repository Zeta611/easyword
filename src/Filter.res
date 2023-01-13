@module("./Filter.jsx") @react.component
external make: (
  ~enKo: bool,
  ~setEnKo: (bool => bool) => unit,
  ~ascending: bool,
  ~setAscending: (bool => bool) => unit,
) => React.element = "Filter_"
