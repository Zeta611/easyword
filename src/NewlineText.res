@react.component
let make = (~text) => {
  text->String.split("\n")->Array.map(s => <p> {s->React.string} </p>)->React.array
}
