function fn(num, backFn) {
  setTimeout(() => {
    var res = backFn && backFn(num);
    if (!res) return;
    num--;
    num > 0 && fn(num, backFn);
  }, 1000);
}

fn(5, function (num) {
  console.log(num);
  // 3结束
  if (num === 3) return false;
});
