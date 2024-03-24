@react.component
let make = (~children: React.element) => {
  let token = React.useContext(TokenContext.context)
  let uri = _ => "https://easyword.hasura.app/v1/graphql"
  let link = switch token {
  | Some(token) =>
    ApolloClient.Link.HttpLink.make(
      ~uri,
      ~headers={
        "Authorization": `Bearer ${token}`,
      }->Obj.magic,
      (),
    )
  | None => ApolloClient.Link.HttpLink.make(~uri, ())
  }

  let client = {
    open ApolloClient
    make(
      ~cache=Cache.InMemoryCache.make(),
      ~connectToDevTools=true,
      ~defaultOptions=DefaultOptions.make(
        ~mutate=DefaultMutateOptions.make(~awaitRefetchQueries=true, ()),
        (),
      ),
      ~link,
      (),
    )
  }

  <ApolloClient.React.ApolloProvider client> children </ApolloClient.React.ApolloProvider>
}
