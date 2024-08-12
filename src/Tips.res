module TipsQuery = %relay(`
  query TipsQuery {
    html_connection(where: { id: { _eq: 1 } }) {
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
  let {html_connection: {edges: htmlEdges}} = TipsQuery.use(~variables=())
  let data = htmlEdges->Array.get(0)->Option.map(edge => edge.node.data)
  switch data {
  | Some(data) =>
    <article
      className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose"
      dangerouslySetInnerHTML={{"__html": data}}
    />
  | None => React.null
  }
}
