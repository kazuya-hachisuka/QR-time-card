var time;
var clock = document.getElementById("clock")
function main() {
  time = new Date();
  clock.innerHTML = String(("0" + time.getHours()).slice(-2)+":"
    +("0" + time.getMinutes()).slice(-2)+":"
    +("0" + time.getSeconds()).slice(-2))
    .bold().fontsize(12);
  setTimeout(main, 1000-time.getMilliseconds());
}
main();

var today;
var day = document.getElementById("day")
var week = '日月火水木金土'[new Date().getDay()];
function sub() {
  today = new Date();
  day.innerHTML = String(today.getFullYear()+"年"
  +(today.getMonth()+1)+"月"
  +("0" + today.getDate()).slice(-2)+"日"
  +week+"曜日");
}
sub();