@react.component
let make = () => {
  let {signedIn, user} = React.useContext(SignInContext.context)
  let photoURL = switch user->Js.Nullable.toOption {
  | None => None
  | Some({photoURL}) => photoURL
  }

  let (jargonsCount, setJargonsCount) = React.Uncurried.useState(() => None)

  open Firebase
  let firestore = useFirestore()
  let jargonsCollection = firestore->collection(~path=`jargons`)
  React.useEffect0(() => {
    let countJargons = async (. ()) => {
      let snapshot = await getCountFromServer(jargonsCollection)
      let count = snapshot.data(.).count
      setJargonsCount(._ => Some(count))
    }
    let _ = countJargons(.)

    None
  })

  <div className="navbar sticky top-0 z-50 bg-base-100">
    <div className="navbar-start">
      <div className="dropdown dropdown-hover">
        <label tabIndex={0} className="btn btn-ghost lg:hidden">
          <Heroicons.Solid.Bars3Icon className="h-5 w-5" />
        </label>
        <ul
          tabIndex={0}
          className="menu menu-compact dropdown-content p-2 w-[9rem] shadow bg-teal-50 dark:bg-zinc-800 rounded-box">
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/")}>
              <Heroicons.Outline.HomeIcon className="h-4 w-4" />
              {"홈"->React.string}
            </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
              <Heroicons.Outline.PencilSquareIcon className="h-4 w-4" />
              {"용어제안"->React.string}
            </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/colophon")}>
              <Heroicons.Outline.WrenchIcon className="h-4 w-4" />
              {"제작기"->React.string}
            </button>
          </li>
          <li>
            <button onClick={_ => RescriptReactRouter.replace("/why")}>
              <Heroicons.Solid.StarIcon className="h-4 w-4" />
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
        <div className="flex items-baseline gap-1">
          <span> {"쉬운 전문용어"->React.string} </span>
          <span className="text-xs"> {"컴퓨터과학/컴퓨터공학"->React.string} </span>
        </div>
      </button>
    </div>
    <div className="navbar-center hidden lg:flex">
      <ul className="menu menu-horizontal px-1">
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/")}>
            <div className="grid justify-items-center">
              <Heroicons.Outline.HomeIcon className="h-6 w-6 hidden sm:flex" />
              {"홈"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/new-jargon")}>
            <div className="grid justify-items-center">
              <Heroicons.Outline.PencilSquareIcon className="h-6 w-6 hidden sm:flex" />
              {"용어제안"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/colophon")}>
            <div className="grid justify-items-center">
              <Heroicons.Outline.WrenchIcon className="h-6 w-6 hidden sm:flex" />
              {"제작기"->React.string}
            </div>
          </button>
        </li>
        <li>
          <button onClick={_ => RescriptReactRouter.replace("/why")}>
            <div className="grid justify-items-center">
              <Heroicons.Solid.StarIcon className="h-6 w-6 hidden sm:flex" />
              {"배경/원칙"->React.string}
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
      <div className="dropdown dropdown-hover dropdown-end">
        {switch photoURL {
        | None =>
          <label tabIndex={0} className="btn btn-circle btn-ghost">
            <Heroicons.Outline.UserCircleIcon className="h-6 w-6" />
          </label>
        | Some(photoURL) =>
          <img
            tabIndex={0} className="mask mask-squircle h-8 w-8 m-2 cursor-pointer" src={photoURL}
          />
        }}
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
