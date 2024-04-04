module TranslationFragment = %relay(`
  fragment Translation_jargon on jargon {
    translations {
      id
      name
      comment {
        id
      }
    }
  }
`)

module TranslationRow = {
  @react.component
  let make = (~name, ~commentID) => {
    <tr>
      <td>
        <a href={`#${commentID}`}> {name->React.string} </a>
      </td>
    </tr>
  }
}

@react.component
let make = (~translationRefs) => {
  let {translations} = TranslationFragment.use(translationRefs)

  if translations->Array.length > 0 {
    <div className="overflow-x-auto">
      <table className="table w-full">
        <tbody>
          {translations
          ->Array.map(({id, name, comment}) =>
            <TranslationRow
              key={id} name commentID={comment->Option.map(x => x.id)->Option.getOr("")}
            />
          )
          ->React.array}
        </tbody>
      </table>
    </div>
  } else {
    React.null
  }
}
