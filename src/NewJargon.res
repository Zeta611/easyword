module NewJargonMutation = %relay(`
  mutation NewJargonMutation(
    $id: uuid!
    $authorID: String!
    $name: String!
    $translationID: uuid!
    $translation: String!
    $jargon_categories: [jargon_category_insert_input!]!
    $commentID: uuid!
    $comment: String!
  ) {
    insert_jargon_one(
      object: {
        id: $id
        author_id: $authorID
        name: $name
        comments: {
          data: {
            id: $commentID
            author_id: $authorID
            translation_id: $translationID
            content: $comment
          }
        }
        translations: {
          data: {
            id: $translationID
            comment_id: $commentID
            author_id: $authorID
            name: $translation
          }
        }
      }
    ) {
      id
    }
    insert_jargon_category(objects: $jargon_categories) {
      affected_rows
    }
  }
`)

module NewJargonWithoutTranslationMutation = %relay(`
  mutation NewJargonWithoutTranslationMutation(
    $id: uuid!
    $authorID: String!
    $name: String!
    $jargon_categories: [jargon_category_insert_input!]!
    $commentID: uuid!
    $comment: String!
  ) {
    insert_jargon_one(
      object: {
        id: $id
        author_id: $authorID
        name: $name
        comments: {
          data: { id: $commentID, author_id: $authorID, content: $comment }
        }
      }
    ) {
      id
    }
    insert_jargon_category(objects: $jargon_categories) {
      affected_rows
    }
  }
`)

module CategoryQuery = %relay(`
  query NewJargonCategoryQuery {
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

let jargonAndCategoryIDToGraphQLInput = jargonID => (
  categoryID
): RelaySchemaAssets_graphql.input_jargon_category_insert_input => {
  jargon_id: jargonID,
  category_id: categoryID,
}

@react.component
let make = () => {
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

  let (english, setEnglish) = React.useState(() => "")
  let handleJargonChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setEnglish(_ => value)
  }

  let (korean, setKorean) = React.useState(() => "")
  let handleTranslationChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setKorean(_ => value)
  }

  let sanitizedEnglish = english->Util.sanitize
  let sanitizedKorean = korean->Util.sanitize

  let (withoutKorean, setWithoutKorean) = React.useState(() => false)

  let (categoryIDs, setCategoryIDs) = React.useState(() => [])

  let (comment, setComment) = React.useState(() => "")
  let handleCommentChange = event => {
    let value = ReactEvent.Form.currentTarget(event)["value"]
    setComment(_ => value)
  }

  let (newJargonMutate, isNewJargonMutating) = NewJargonMutation.use()
  let (
    newJargonWithoutTranslationMutate,
    isNewJargonWithoutTranslationMutating,
  ) = NewJargonWithoutTranslationMutation.use()

  let {category_connection: {edges: categoryEdges}} = CategoryQuery.use(~variables=())
  let options = categoryEdges->Array.map(edge => {
    let {node: {id, name, acronym}} = edge
    {
      Select.label: `${acronym} (${name})`,
      value: id->Base64.retrieveOriginalIDInt->Option.getUnsafe,
    }
  })

  let handleSubmit = event => {
    // Prevent a page refresh, we are already listening for updates
    ReactEvent.Form.preventDefault(event)

    if sanitizedEnglish->String.length < 1 {
      Window.alert("용어를 입력해주세요")
    } else if !withoutKorean && sanitizedKorean->String.length < 1 {
      Window.alert("번역을 입력해주세요")
    } else if signedIn {
      switch user->Nullable.toOption {
      | Some(user) => {
          let comment = switch comment {
          | "" =>
            if !withoutKorean {
              `${sanitizedKorean->Util.eulLeul} 제안합니다.`
            } else {
              `"${sanitizedEnglish}" 용어의 번역이 필요합니다.`
            }
          | _ => comment
          }

          let (jargonID, translationID, commentID) = (Uuid.v4(), Uuid.v4(), Uuid.v4())
          let categoryIDToGraphQLInput = jargonAndCategoryIDToGraphQLInput(jargonID)

          if withoutKorean {
            newJargonWithoutTranslationMutate(
              ~variables={
                id: jargonID,
                commentID,
                authorID: user.uid,
                name: sanitizedEnglish,
                comment,
                jargon_categories: categoryIDs->Array.map(categoryIDToGraphQLInput),
              },
              ~onError=error => Js.Console.error(error),
              ~onCompleted=({insert_jargon_one}, _errors) => {
                switch insert_jargon_one {
                | Some({id}) => RescriptReactRouter.replace("/jargon/" ++ id)
                | None => ()
                }
              },
            )->ignore
          } else {
            newJargonMutate(
              ~variables={
                id: jargonID,
                translationID,
                commentID,
                authorID: user.uid,
                name: sanitizedEnglish,
                comment,
                translation: sanitizedKorean,
                jargon_categories: categoryIDs->Array.map(categoryIDToGraphQLInput),
              },
              ~onError=error => Js.Console.error(error),
              ~onCompleted=({insert_jargon_one}, _errors) => {
                switch insert_jargon_one {
                | Some({id}) => RescriptReactRouter.replace("/jargon/" ++ id)
                | None => ()
                }
              },
            )->ignore
          }
        }
      | None => RescriptReactRouter.replace("/logout") // Something went wrong
      }
    } else {
      RescriptReactRouter.replace("/login")
    }
  }

  if signedIn {
    <div className="px-6 py-12 max-w-xl mx-auto md:max-w-4xl prose">
      <h1> {"쉬운 전문용어 제안하기"->React.string} </h1>
      <form className="mt-8 max-w-md" onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 gap-6">
          <label className="block">
            <label className="label">
              <span className="label-text"> {"원어"->React.string} </span>
            </label>
            <input
              type_="text"
              value={english}
              onChange={handleJargonChange}
              placeholder="separated sum"
              className="input input-bordered w-full"
            />
          </label>
          <label className="block">
            <label className="label">
              <span className="label-text"> {"번역"->React.string} </span>
              {// data-* is invalid in ReScript--this is a warkaround
              React.cloneElement(
                <div className="flex gap-1 text-xs place-items-center tooltip tooltip-bottom">
                  <input
                    type_="checkbox"
                    className="checkbox checkbox-secondary"
                    checked={withoutKorean}
                    onChange={_ => setWithoutKorean(v => !v)}
                  />
                  {"번역 없이 제안하기"->React.string}
                </div>,
                {"data-tip": "번역을 제안하지 않고 용어를 추가해보세요"},
              )}
            </label>
            <input
              type_="text"
              value={korean}
              disabled={withoutKorean}
              onChange={handleTranslationChange}
              placeholder="출신을 기억하는 합"
              className="input input-bordered w-full"
            />
            <label className="label">
              <span className="label-text-alt" />
              <span className="label-text-alt text-zinc-700">
                {"번역을 새로 제안할 때는 "->React.string}
                <a href="https://claude.ai/" className="link text-zinc-700">
                  {"Claude"->React.string}
                </a>
                {"등의 LLM도 활용해보세요"->React.string}
              </span>
            </label>
          </label>
          <label className="block">
            <label className="label">
              <span className="label-text"> {"분야"->React.string} </span>
            </label>
            <Select
              classNames={
                control: _ => "rounded-btn border text-base border-base-content/20 px-4 py-2",
                menuList: _ =>
                  "grid grid-cols-1 menu bg-zinc-50 dark:bg-zinc-800 rounded-box px-2 py-2 mt-1 text-base shadow-lg",
                option: _ => "hover:bg-zinc-200 dark:hover:bg-zinc-600 px-2 py-1 rounded-box",
              }
              components={multiValueLabel: MultiValueLabel.make}
              onChange={options => setCategoryIDs(_ => options->Array.map(({value}) => value))}
              options
              isSearchable=false
              isClearable=false
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
          <label className="block">
            <label className="label">
              <span className="label-text"> {"의견"->React.string} </span>
            </label>
            <textarea
              value={comment}
              onChange={handleCommentChange}
              placeholder="첫 댓글로 달려요"
              className="textarea textarea-bordered w-full"
            />
          </label>
          <input
            type_="submit"
            value="제안하기"
            disabled={isNewJargonMutating || isNewJargonWithoutTranslationMutating}
            className="btn btn-primary"
          />
        </div>
      </form>
    </div>
  } else {
    React.null
  }
}
