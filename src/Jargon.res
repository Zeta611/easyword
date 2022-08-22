@react.component
let make = (~id) => {
  let prompt = "Discussion on jargon " ++ id
  <div className="dark:text-white"> {React.string(prompt)} </div>
}
