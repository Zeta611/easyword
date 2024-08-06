module WhyQuery = %relay(`
  query WhyQuery {
    html_connection(where: {id: {_eq: 2}}) {
      edges {
        node {
          data
        }
      }
    }
  }
`)

@react.component
let make = () => {
  let {html_connection: {edges: htmlEdges}} = WhyQuery.use(~variables=())
  let data = htmlEdges->Array.get(0)->Option.map(edge => edge.node.data)
  switch data {
  | Some(data) =>
    <article className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"쉬운 전문용어"->React.string} </h1>
      <div className="text-right text-sm">
        <a href="http://kwangkeunyi.snu.ac.kr">
          {"서울대학교 컴퓨터공학부 이광근"->React.string}
        </a>
      </div>
      <div className="divider" />
      <div dangerouslySetInnerHTML={{"__html": data}} />
    </article>
  | None => React.null
  }
}
