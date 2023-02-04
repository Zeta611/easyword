type t = {id: string, english: string, korean: string}
type translation = {id: string, korean: string, votes: int}

type language = English | Korean
type direction = [#asc | #desc]
type order = (language, direction)
