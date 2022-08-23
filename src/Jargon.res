type comment = {
  comment: string,
  user: string,
  timestamp: Firebase.timestamp,
  parent: option<string>,
}

@react.component
let make = (~id) => {
  open Firebase

  let commentsCollection = useFirestore()->collection(~path=`jargons/${id}/comments`)
  let {status, data: comments} =
    commentsCollection->query(orderBy("timestamp", ~direction="asc"))->useFirestoreCollectionData()

  if status == "loading" {
    React.string("loading")
  } else {
    let prompt = "Discussion on jargon " ++ id

    <div>
      <div className="dark:text-white"> {React.string(prompt)} </div>
      {React.array(
        comments->Array.map(({comment, user, timestamp, parent}) =>
          <div className="ml-4">
            {React.string(user ++ " | " ++ Js.Date.toString(timestamp->toDate))}
            <br />
            {React.string(comment)}
          </div>
        ),
      )}
    </div>
  }
}
