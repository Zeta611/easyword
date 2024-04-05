let unsafeGet = (json, key) => {
  json->JSON.Decode.object->Option.getExn->Dict.getUnsafe(key)
}

@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)
  let photoURL = switch user->Nullable.toOption {
  | None => None
  | Some({photoURL}) => photoURL
  }

  let (jargonsCount, setJargonsCount) = React.Uncurried.useState(() => None)

  let gitHubURL = "https://github.com/Zeta611/easyword"

  React.useEffectOnEveryRender(() => {
    open Fetch

    (
      async () => {
        let resp = await fetch(
          "https://easyword.hasura.app/api/rest/jargons-count",
          {
            method: #GET,
            headers: Headers.fromObject({
              "content-type": "application/json",
            }),
          },
        )

        let json = if resp->Response.ok {
          await resp->Response.json
        } else {
          raise(Exc.GraphQLError("Failed to fetch jargons count"))
        }

        let count =
          json
          ->unsafeGet("jargon_aggregate")
          ->unsafeGet("aggregate")
          ->unsafeGet("count")
          ->JSON.Decode.float
          ->Option.getExn
          ->Int.fromFloat

        setJargonsCount(_ => Some(count))
      }
    )()->ignore

    None
  })

  let closeMenu = Hooks.useClosingDropdown("menu-dropdown-btn")
  let closeProfile = Hooks.useClosingDropdown("profile-dropdown-btn")

  <div className="navbar sticky top-0 z-50 bg-base-100">
    <div className="navbar-start">
      <details id="menu-dropdown-btn" className="dropdown">
        <summary className="btn btn-ghost md:hidden">
          <Heroicons.Solid.Bars3Icon className="h-5 w-5" />
        </summary>
        <ul
          className="menu menu-compact dropdown-content p-2 w-[9rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button
              onClick={_ => {
                RescriptReactRouter.push("/why")
                closeMenu()
              }}>
              <Heroicons.Solid.StarIcon className="h-4 w-4" />
              {"배경/원칙"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ => {
                RescriptReactRouter.push("/new-jargon")
                closeMenu()
              }}>
              <Heroicons.Outline.PencilSquareIcon className="h-4 w-4" />
              {"용어제안"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ => {
                RescriptReactRouter.push("/colophon")
                closeMenu()
              }}>
              <Heroicons.Outline.WrenchIcon className="h-4 w-4" />
              {"제작기"->React.string}
            </button>
          </li>
          <li>
            <button
              onClick={_ =>
                window
                ->Webapi.Dom.Window.open_(~url=gitHubURL, ~name="_blank", ())
                ->ignore}>
              <ReactIcons.FaGithub className="h-4 w-4" />
              {"참여하기"->React.string}
            </button>
          </li>
        </ul>
      </details>
      <button
        className="btn btn-ghost text-xl lg:hidden" onClick={_ => RescriptReactRouter.push("/")}>
        <div className="flex items-baseline gap-1">
          <span> {"쉬운 전문용어"->React.string} </span>
          <span className="text-xs"> {"컴퓨터과학/컴퓨터공학"->React.string} </span>
        </div>
      </button>
      <button
        className="btn btn-ghost text-xl hidden lg:flex"
        onClick={_ => RescriptReactRouter.push("/")}>
        <div className="flex items-baseline gap-1">
          <span> {"쉬운 전문용어"->React.string} </span>
          <span className="text-xs"> {"컴퓨터과학/컴퓨터공학"->React.string} </span>
        </div>
      </button>
    </div>
    <div className="navbar-center hidden md:flex text-sm">
      <ul className="menu menu-horizontal px-1">
        <li>
          <button onClick={_ => RescriptReactRouter.push("/why")}>
            <div className="grid justify-items-center">
              <Heroicons.Solid.StarIcon className="h-6 w-6 hidden sm:flex" />
              {"배경/원칙"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.push("/new-jargon")}>
            <div className="grid justify-items-center">
              <Heroicons.Outline.PencilSquareIcon className="h-6 w-6 hidden sm:flex" />
              {"용어제안"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.push("/colophon")}>
            <div className="grid justify-items-center">
              <Heroicons.Outline.WrenchIcon className="h-6 w-6 hidden sm:flex" />
              {"제작기"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button
            onClick={_ =>
              window
              ->Webapi.Dom.Window.open_(~url=gitHubURL, ~name="_blank", ())
              ->ignore}>
            <div className="grid justify-items-center">
              <ReactIcons.FaGithub className="h-6 w-6 hidden sm:flex" />
              {"참여하기"->React.string}
            </div>
          </button>
        </li>
      </ul>
    </div>
    <div className="navbar-end sm:gap-2">
      {switch jargonsCount {
      | None => React.null
      | Some(jargonsCount) =>
        <div className="items-center sm:gap-1 text-xs text-teal-800 hidden sm:flex">
          <Heroicons.Outline.ChartBarSquareIcon className="h-5 w-5" />
          <div className="ml-0"> {`총 ${jargonsCount->Int.toString}개`->React.string} </div>
        </div>
      }}
      <details id="profile-dropdown-btn" className="dropdown dropdown-end">
        {switch photoURL {
        | None =>
          <summary className="btn btn-circle btn-ghost">
            <Heroicons.Outline.UserCircleIcon className="h-6 w-6" />
          </summary>
        | Some(photoURL) =>
          <summary className="flex">
            <img className="mask mask-squircle h-8 w-8 m-2 cursor-pointer" src={photoURL} />
          </summary>
        }}
        <ul
          className="menu menu-compact dropdown-content p-2 w-[6.5rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          {if signedIn {
            <>
              <li>
                <button
                  onClick={_ => {
                    RescriptReactRouter.push("/profile")
                    closeProfile()
                  }}>
                  {"내 프로필"->React.string}
                </button>
              </li>
              <li>
                <button
                  onClick={_ => {
                    RescriptReactRouter.push("/logout")
                    closeProfile()
                  }}>
                  {"로그아웃"->React.string}
                </button>
              </li>
            </>
          } else {
            <li>
              <button onClick={_ => RescriptReactRouter.push("/login")}>
                {"로그인"->React.string}
              </button>
            </li>
          }}
        </ul>
      </details>
    </div>
  </div>
}
