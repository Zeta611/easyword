module Solid = {
  module ChevronDownIcon = {
    @module("@heroicons/react/20/solid") @react.component
    external make: (~className: string=?) => React.element = "ChevronDownIcon"
  }

  module ArrowDownIcon = {
    @module("@heroicons/react/20/solid") @react.component
    external make: (~className: string=?) => React.element = "ArrowDownIcon"
  }
  module ArrowUpIcon = {
    @module("@heroicons/react/20/solid") @react.component
    external make: (~className: string=?) => React.element = "ArrowUpIcon"
  }
}
