@val external encode: string => string = "btoa"
@val external decode: string => string = "atob"

let retrieveOriginalID = id => {
  try {
    switch id->decode->JSON.parseExn->JSON.Decode.array {
    | Some(decoded) =>
      decoded
      ->Array.get(3)
      ->Option.flatMap(x => x->JSON.Decode.string)
    | None => None
    }
  } catch {
  | Exn.Error(_) => {
      Js.Console.error(`Error decoding ID: ${id}`)
      None
    }
  }
}
