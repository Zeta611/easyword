@module("react-infinite-scroll-component") @react.component
external make: (
  ~className: string,
  ~dataLength: int,
  ~next: unit => unit,
  ~hasMore: bool,
  ~loader: React.element,
  ~children: React.element,
) => React.element = "default"
