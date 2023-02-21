@react.component
let make = (~children: React.element) => {
  <div>
    <Navbar />
    children
  </div>
}
