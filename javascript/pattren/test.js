var a = 1234567;
// var b = a.replace(/(\d)(?=(?:\d{3})+$)/g, "$1,");
// var b = a.replace(/(\d{3})/g, "$1,"); // 123,456,7
// var b = a.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 123,456,7
var b = a.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,");
// var b = a.replace(/(\d)(?=(?:\d{3})+[$|\.])/g, "$1,");

console.log(b);
var c = b.replace(/\s?|(,*)/g, "");
console.log(c);
