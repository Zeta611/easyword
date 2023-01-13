open Jargon

@module("./Filter.jsx") @react.component
external make: (~order: order, ~setOrder: (order => order) => unit) => React.element = "Filter_"
