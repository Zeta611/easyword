type t = {id: string, english: string, korean: string, timestamp: option<Firebase.Timestamp.t>}
type translation = {
  id: string,
  korean: string,
  @as("associated_comment") associatedComment: string,
}
type add = {english: string, korean: string, comment: string}
type addTranslation = {id: string, korean: string, comment: string}

type axis = English | Korean | Chrono
type direction = [#asc | #desc]
type order = (axis, direction)
