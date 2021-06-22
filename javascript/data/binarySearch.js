function binarySearch(arrs, value) {
  var low = 0;
  var high = arrs.length - 1;

  while (low <= high) {
    var mid = (low + high) / 2;
    if (value == arrs[mid]) {
      return mid;
    }

    if (value < arrs[mid]) {
      high = mid - 1;
    }

    if (value > arrs[mid]) {
      low = mid + 1;
    }
  }

  return -1;
}

console.log(binarySearch([3, 5, 6, 23, 44, 56, 78], 78));
