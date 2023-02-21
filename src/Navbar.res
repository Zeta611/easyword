@react.component
let make = (~signedIn: bool) => {
  <div className="navbar sticky top-0 z-50 bg-base-100">
    <div className="navbar-start">
      <div className="dropdown dropdown-hover">
        <label tabIndex={0} className="btn btn-ghost lg:hidden">
          <Heroicons.Solid.Bars3Icon className="h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content p-2 w-[7rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/")}> {"홈"->React.string} </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
              {"용어제안"->React.string}
            </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/why")}>
              {"배경/원칙"->React.string}
            </button>
          </li>
        </ul>
      </div>
      <button
        className="btn btn-ghost text-xl lg:hidden" onClick={_ => RescriptReactRouter.replace("/")}>
        <div className="flex items-baseline gap-1">
          <span> {"쉬운 전문용어"->React.string} </span>
          <span className="text-xs"> {"컴퓨터과학/컴퓨터공학"->React.string} </span>
        </div>
      </button>
      <button
        className="btn btn-ghost text-xl hidden lg:flex"
        onClick={_ => RescriptReactRouter.replace("/")}>
        {"EKO: 쉬운 컴퓨터 분야 전문용어 번역"->React.string}
      </button>
    </div>
    <div className="navbar-center hidden lg:flex">
      <ul className="menu menu-horizontal px-1">
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/")}> {"홈"->React.string} </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
            {"용어제안"->React.string}
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/why")}>
            {"배경/원칙"->React.string}
          </button>
        </li>
      </ul>
    </div>
    <div className="navbar-end">
      <div className="dropdown dropdown-hover dropdown-end">
        <label tabIndex={0} className="btn btn-circle btn-ghost">
          <Heroicons.Outline.UserCircleIcon className="h-6 w-6" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
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
