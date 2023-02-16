@react.component
let make = (~signedIn: bool) => {
  <div className="navbar bg-base-100">
    <div className="navbar-start">
      <div className="dropdown">
        <label tabIndex={0} className="btn btn-ghost lg:hidden">
          <Heroicons.Solid.Bars3Icon className="h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/")}> {"홈"->React.string} </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
              {"용어 추가"->React.string}
            </button>
          </li>
        </ul>
      </div>
      <button
        className="btn btn-ghost normal-case text-xl"
        onClick={_ => RescriptReactRouter.replace("/")}>
        {"EKO"->React.string}
      </button>
    </div>
    <div className="navbar-center hidden lg:flex">
      <ul className="menu menu-horizontal px-1">
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/")}> {"홈"->React.string} </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
            {"용어 추가"->React.string}
          </button>
        </li>
      </ul>
    </div>
    <div className="navbar-end">
      <div className="dropdown dropdown-end">
        <label tabIndex={0} className="btn btn-circle btn-ghost">
          <Heroicons.Outline.UserCircleIcon className="h-6 w-6" />
        </label>
        <ul tabIndex={0} className="menu dropdown-content shadow bg-base-100 rounded-box w-52 mt-4">
          {if signedIn {
            <>
              <li>
                <button onClick={_ => RescriptReactRouter.replace("/profile")}>
                  {"내 프로필"->React.string}
                </button>
              </li>
              <li>
                <button onClick={_ => RescriptReactRouter.replace("/logout")}>
                  {"로그아웃"->React.string}
                </button>
              </li>
            </>
          } else {
            <li>
              <button onClick={_ => RescriptReactRouter.replace("/login")}>
                {"로그인"->React.string}
              </button>
            </li>
          }}
        </ul>
      </div>
    </div>
  </div>
}
