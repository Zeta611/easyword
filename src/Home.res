@react.component
let make = () => {
  <div>
    <h1 className="text-3xl font-bold underline"> {React.string("Hello world, this is EKO!")} </h1>
    <a href="/jargon"> {React.string(`사전 열기`)} </a>
  </div>
}
