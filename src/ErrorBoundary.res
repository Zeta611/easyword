type error = {message: string}
type fallbackRenderProps = {error: error, resetErrorBoundary: unit => unit}

@module("react-error-boundary") @react.component
external make: (
  ~children: React.element,
  ~fallbackRender: fallbackRenderProps => React.element,
  ~onReset: 'a => unit=?,
) => React.element = "ErrorBoundary"
