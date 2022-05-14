// 实例一
/*
var susan = {
  name: "susan",
  sex: "女孩",
  tell: function () {
    console.log("我的名字", this.name);
    console.log("我的性别是", this.sex);
  },
};
*/
/**
 * 利用函数的作用域，保护私有作用域
 * 自执行函数创建一个模块
 */
/*
var susan = (function fn() {
  var name = "susan";
  var sex = "女孩";
  return {
    tell: function () {
      console.log("我的名字", name);
      console.log("我的性别是", sex);
    },
  };
})();
*/
/**
 * 作用域决定了代码中变量和其它资源的可见性；
 * 模块化优点：
 * 作用域封装；
 * 重用性；
 * 接触耦合；
 */
(function (window) {
  var name = "susan";
  var sex = "女孩";
  function tell() {
    console.log("我的名字", name);
    console.log("我的性别是", sex);
  }
  window.susanModule = { tell };
})(window);
