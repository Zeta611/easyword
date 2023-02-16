module Solid = {
  module ChevronDownIcon = {
    @module("@heroicons/react/24/solid") @react.component
    external make: (~className: string=?) => React.element = "ChevronDownIcon"
  }

  module ArrowDownIcon = {
    @module("@heroicons/react/24/solid") @react.component
    external make: (~className: string=?) => React.element = "ArrowDownIcon"
  }
  module ArrowUpIcon = {
    @module("@heroicons/react/24/solid") @react.component
    external make: (~className: string=?) => React.element = "ArrowUpIcon"
  }

  module Bars3Icon = {
    @module("@heroicons/react/24/solid") @react.component
    external make: (~className: string=?) => React.element = "Bars3Icon"
  }
}

module Outline = {
  module UserCircleIcon = {
    @module("@heroicons/react/24/outline") @react.component
    external make: (~className: string=?) => React.element = "UserCircleIcon"
  }
}
