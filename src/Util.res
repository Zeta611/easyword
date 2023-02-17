let endsWithJong = korean => {
  let c = korean->String.get(korean->String.length - 1)
  if '가' <= c && c <= '힣' {
    mod(c->Char.code - '가'->Char.code, 28) > 0
  } else {
    false
  }
}

let eulLeul = korean => {
  korean ++ if korean->endsWithJong {
    "을"
  } else {
    "를"
  }
}
