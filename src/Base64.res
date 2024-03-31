@val external encode: string => string = "btoa"
@val external decode: string => string = "atob"

let retrieveOriginalID = id => {
  try {
    switch id->decode->Js.Json.parseExn->Js.Json.decodeArray {
    | Some(decoded) =>
      decoded
      ->Array.get(3)
      ->Option.flatMap(x => x->Js.Json.decodeNumber)
      ->Option.map(x => x->Int.fromFloat)
    | None => None
    }
  } catch {
  | Js.Exn.Error(_) => {
      Js.Console.error(`Error decoding ID: ${id}`)
      None
    }
  }
}
