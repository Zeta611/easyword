module RelatedJargonsFragment = %relay(`
  fragment RelatedJargons_jargon on jargon {
    related_jargons {
      jargon {
        id
        name
      }
    }
  }
`)

@react.component
let make = (~relatedJargonsRef) => {
  let {related_jargons} = RelatedJargonsFragment.use(relatedJargonsRef)

  <div className="flex gap-2">
    <div className="font-medium"> {"연관 용어"->React.string} </div>
    <div className="flex gap-1">
      {related_jargons
      ->Array.map(r =>
        r.jargon.name->Util.badgify(~onClick=_ =>
          RescriptReactRouter.push(`/jargon/${r.jargon.id}`)
        )
      )
      ->React.array}
      // {"+"->Util.badgify}
    </div>
  </div>
}
