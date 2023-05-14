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
    j`$minutes분 전`
  } else if hours < 24 {
    j`$hours시간 전`
  } else if days < 30 {
    j`$days일 전`
  } else if months < 12 {
    j`$months달 전`
  } else {
    j`$years년 전`
  }
}
