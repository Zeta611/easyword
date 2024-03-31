let timeAgo = date => {
  let seconds = ((Js.Date.now() -. date->Js.Date.getTime) /. 1000.)->Float.toInt
  let minutes = seconds / 60
  let hours = minutes / 60
  let days = hours / 24
  let months = days / 30
  let years = months / 12

  if seconds < 60 {
    "방금 전"
  } else if minutes < 60 {
    `${minutes->Int.toString}분 전`
  } else if hours < 24 {
    `${hours->Int.toString}시간 전`
  } else if days < 30 {
    `${days->Int.toString}일 전`
  } else if months < 12 {
    `${months->Int.toString}달 전`
  } else {
    `${years->Int.toString}년 전`
  }
}
