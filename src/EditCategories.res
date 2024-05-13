module JargonQuery = %relay(`
  query EditCategoriesJargonQuery($id: ID!) {
    node(id: $id) {
      ... on jargon {
        name
        jargon_categories {
          category_id
        }
      }
    }
  }
`)

module EditCategoriesMutation = %relay(`
  mutation EditCategoriesMutation(
    $jargon_id: uuid!
    $new_jargon_categories: [jargon_category_insert_input!]!
    $drop_categories: [Int!]!
  ) {
    insert_jargon_category(objects: $new_jargon_categories) {
      affected_rows
    }
    delete_jargon_category(
      where: {
        _and: {
          jargon_id: { _eq: $jargon_id }
          category_id: { _in: $drop_categories }
        }
      }
    ) {
      affected_rows
    }
  }
`)

module CategoryQuery = %relay(`
  query EditCategoriesCategoryQuery {
    category_connection(order_by: { name: asc }) {
      edges {
        node {
          id
          name
          acronym
        }
      }
    }
  }
`)

module MultiValueLabel = {
  @react.component
  let make = (~children: string) => {
    let acronym = children->String.split(" ")->Array.getUnsafe(0)
    <div className="badge badge-md ml-1"> {acronym->React.string} </div>
  }
}

let jargonAndCategoryIDToGraphQLInput = jargonID => (
  categoryID
): RelaySchemaAssets_graphql.input_jargon_category_insert_input => {
  jargon_id: jargonID,
  category_id: categoryID,
}

@react.component
let make = (~jargonID: string) => {
  let {signedIn, user} = React.useContext(SignInContext.context)

  React.useEffect0(() => {
    if signedIn {
      switch user->Nullable.toOption {
      | Some(_) => ()
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }

    None
  })

  let (categoryIDs, setCategoryIDs) = React.useState(() => [])

  let (newTranslationMutate, isNewTranslationMutating) = EditCategoriesMutation.use()

  let {category_connection: {edges: categoryEdges}} = CategoryQuery.use(~variables=())
  let options = categoryEdges->Array.map(edge => {
    let {node: {id, name, acronym}} = edge
    {
      Select.label: `${acronym} (${name})`,
      value: id->Base64.retrieveOriginalIDInt->Option.getUnsafe,
    }
  })

  let {node} = JargonQuery.use(~variables={id: jargonID})
  // Refactor this into another component
  React.useEffect(() => {
    switch node {
    | Some(Jargon({jargon_categories})) =>
      setCategoryIDs(_ => jargon_categories->Array.map(({category_id}) => category_id))
    | _ => ()
    }
    None
  }, [node])
  let oldCategoryIDs = switch node {
  | Some(Jargon({jargon_categories})) =>
    jargon_categories->Array.map(({category_id}) => category_id)
  | _ => []
  }
  let newCategoryIDs = categoryIDs->Array.filter(id => !(oldCategoryIDs->Array.includes(id)))
  let dropCategoryIDs = oldCategoryIDs->Array.filter(id => !(categoryIDs->Array.includes(id)))

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if signedIn {
      let (id, jargonID) = (jargonID, jargonID->Base64.retrieveOriginalIDString)

      switch jargonID {
      | Some(jargonID) =>
        newTranslationMutate(
          ~variables={
            jargon_id: jargonID,
            new_jargon_categories: newCategoryIDs->Array.map(
              jargonAndCategoryIDToGraphQLInput(jargonID),
            ),
            drop_categories: dropCategoryIDs,
          },
          ~onError=error => Js.Console.error(error),
          ~onCompleted=({insert_jargon_category}, _errors) => {
            switch insert_jargon_category {
            | Some(_) => RescriptReactRouter.replace(`/jargon/${id}`)
            | None => {
                Js.Console.error("Translation mutation failed")
                RescriptReactRouter.replace(`/jargon/${id}`)
              }
            }
          },
        )->ignore
      | None => ()
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
  }

  switch node {
  | Some(Jargon({name: english})) =>
    if signedIn {
      <div className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
        <h2> {`${english}의 분야 수정하기`->React.string} </h2>
        <form className="mt-8 max-w-md" onSubmit={handleSubmit}>
          <div className="grid grid-cols-1 gap-6">
            <label className="block">
              <label className="label">
                <span className="label-text"> {"분야"->React.string} </span>
              </label>
              <Select
                classNames={
                  control: _ => "rounded-btn border text-base border-base-content/20 px-4 py-2",
                  menuList: _ =>
                    "focus:cursor-pointer menu bg-zinc-50 dark:bg-zinc-800 rounded-box px-2 py-2 mt-1 text-base shadow-lg",
                  option: _ =>
                    "cursor-pointer hover:bg-zinc-200 dark:hover:bg-zinc-600 px-2 py-1 rounded-box",
                }
                components={multiValueLabel: MultiValueLabel.make}
                value={options->Array.filter(({value}) => categoryIDs->Array.includes(value))}
                onChange={options => setCategoryIDs(_ => options->Array.map(({value}) => value))}
                options
                isSearchable=false
                isMulti=true
                unstyled=true
                placeholder="분야를 선택해주세요"
                noOptionsMessage={_ => "더 이상의 분야가 없어요"}
              />
              <label className="label">
                <span className="label-text-alt" />
                <span className="label-text-alt text-zinc-700">
                  {"원하는 분야가 없으면 '"->React.string}
                  <a
                    href="https://github.com/Zeta611/easyword/discussions"
                    className="link text-zinc-700">
                    {"제작참여"->React.string}
                  </a>
                  {"'에서 요청해주세요"->React.string}
                </span>
              </label>
            </label>
            <input
              type_="submit"
              value="제안하기"
              disabled={isNewTranslationMutating}
              className="btn btn-primary"
            />
          </div>
        </form>
      </div>
    } else {
      React.null
    }
  | _ => React.null
  }
}
