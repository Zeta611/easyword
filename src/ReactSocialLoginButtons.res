module GoogleLoginButton = {
  @react.component @module("react-social-login-buttons")
  external make: (~onClick: (. unit) => unit, ~children: React.element) => React.element =
    "GoogleLoginButton"
}
