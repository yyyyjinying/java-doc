function fn(num) {
  console.log(num);
  setTimeout(() => {
    num--;
    num > 0 && fn(num);
  }, 1000);
}

fn(5);
