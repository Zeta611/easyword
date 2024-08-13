module ColophonQuery = %relay(`
  query ColophonQuery {
    html_connection(where: {id: {_eq: 3}}) {
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
  let {html_connection: {edges: htmlEdges}} = ColophonQuery.use(~variables=())
  let data = htmlEdges->Array.get(0)->Option.map(edge => edge.node.data)
  switch data {
  | Some(data) =>
    <article className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"제작기"->React.string} </h1>
      <div className="text-right text-sm">
        <a href="http://ropas.snu.ac.kr/~jhlee/">
          {"서울대학교 프로그래밍 연구실 이재호"->React.string}
        </a>
      </div>
      <div className="divider" />
      <div dangerouslySetInnerHTML={{"__html": data}} />
    </article>
  | None => React.null
  }
}
