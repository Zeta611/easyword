@val external encode: string => string = "btoa"
@val external decode: string => string = "atob"

let retrieveOriginalID = id => {
  try {
    switch id->decode->JSON.parseExn->JSON.Decode.array {
    | Some(decoded) => decoded[3]
    | None => None
    }
  } catch {
  | Exn.Error(_) => {
      Js.Console.error(`Error decoding ID: ${id}`)
      None
    }
  }
}

let retrieveOriginalIDString = id => {
  switch id->retrieveOriginalID {
  | Some(originalID) => originalID->JSON.Decode.string
  | None => None
  }
}

let retrieveOriginalIDInt = id => {
  switch id->retrieveOriginalID {
  | Some(originalID) => originalID->JSON.Decode.float->Option.map(n => n->Float.toInt)
  | None => None
  }
}
