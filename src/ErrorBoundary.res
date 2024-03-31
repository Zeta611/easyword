type error = {message: string}

@module("react-error-boundary") @react.component
external make: (
  ~children: React.element,
  ~fallbackRender: error => React.element,
) => React.element = "ErrorBoundary"
