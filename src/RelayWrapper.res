@react.component
let make = (~children: React.element) => {
  let token = React.useContext(TokenContext.context)

  let fetchQuery: RescriptRelay.Network.fetchFunctionPromise = async (
    operation,
    variables,
    _cacheConfig,
    _uploadables,
  ) => {
    open Fetch
    let resp = await fetch(
      "https://easyword.hasura.app/v1beta1/relay",
      {
        method: #POST,
        body: {"query": operation.text, "variables": variables}
        ->JSON.stringifyAny
        ->Option.getExn
        ->Body.string,
        headers: switch token {
        | Some(token) =>
          Headers.fromObject({
            "content-type": "application/json",
            "authorization": `Bearer ${token}`,
          })
        | None =>
          Headers.fromObject({
            "content-type": "application/json",
          })
        },
      },
    )

    if resp->Response.ok {
      await resp->Response.json
    } else {
      raise(Exc.GraphQLError("Request failed: " ++ Response.statusText(resp)))
    }
  }

  let network = RescriptRelay.Network.makePromiseBased(~fetchFunction=fetchQuery)

  let environment = RescriptRelay.Environment.make(
    ~network,
    ~store=RescriptRelay.Store.make(
      ~source=RescriptRelay.RecordSource.make(),
      ~gcReleaseBufferSize=10 /* This sets the query cache size to 10 */,
    ),
  )

  <RescriptRelay.Context.Provider environment> children </RescriptRelay.Context.Provider>
}
