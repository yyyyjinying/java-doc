/**
 * 冒泡排序
 */
var arrs = [3, 44, 5, 6, 23, 56, 78];
for (var i = arrs.length; i > 0; i--) {
  for (var j = 0; j < i - 1; j++) {
    if (arrs[j] > arrs[j + 1]) {
      var temp = arrs[j];
      arrs[j] = arrs[j + 1];
      arrs[j + 1] = temp;
    }
  }
}

console.log(arrs);
