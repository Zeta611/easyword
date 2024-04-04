// Generated by ReScript, PLEASE EDIT WITH CARE


function joinTranslations(translations) {
  return Object.entries(translations).toSorted(function (param, param$1) {
                  var v2 = param$1[1];
                  var v1 = param[1];
                  if ((v2 - v1 | 0) !== 0) {
                    return v2 - v1 | 0;
                  }
                  var k2 = param$1[0];
                  var k1 = param[0];
                  if (k1 > k2) {
                    return 1.0;
                  } else if (k1 < k2) {
                    return -1.0;
                  } else {
                    return 0.0;
                  }
                }).map(function (param) {
                return param[0];
              }).join(",");
}

export {
  joinTranslations ,
}
/* No side effect */
