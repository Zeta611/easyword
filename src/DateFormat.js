// Generated by ReScript, PLEASE EDIT WITH CARE


function timeAgo(date) {
  var seconds = (Date.now() - date.getTime()) / 1000 | 0;
  var minutes = seconds / 60 | 0;
  var hours = minutes / 60 | 0;
  var days = hours / 24 | 0;
  var months = days / 30 | 0;
  var years = months / 12 | 0;
  if (seconds < 60) {
    return "방금 전";
  } else if (minutes < 60) {
    return String(minutes) + "분 전";
  } else if (hours < 24) {
    return String(hours) + "시간 전";
  } else if (days < 30) {
    return String(days) + "일 전";
  } else if (months < 12) {
    return String(months) + "달 전";
  } else {
    return String(years) + "년 전";
  }
}

export {
  timeAgo ,
}
/* No side effect */
