type card = {
  id: string,
  name: string,
  updated_at: Date.t,
  translations: array<(string, string)>,
  commentsCount: int,
}

let joinTranslations = translations =>
  translations
  ->Dict.toArray
  ->Array.toSorted(((k1, v1), (k2, v2)) => {
    if v2 - v1 != 0 {
      float(v2 - v1)
    } else if k1 > k2 {
      1.0
    } else if k1 < k2 {
      -1.0
    } else {
      0.0
    }
  })
  ->Array.map(((k, _)) => k)
  ->Array.join(",")

type translation = {
  id: string,
  korean: string,
  @as("associated_comment") associatedComment: string,
}
type add = {english: string, korean: string, comment: string, withoutKorean: bool}
type addTranslation = {id: string, korean: string, comment: string}

type vote = {jargonID: string, translations: array<string>}

type axis = English | Chrono | Random(float)
