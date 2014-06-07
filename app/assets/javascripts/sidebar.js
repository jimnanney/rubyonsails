$(document).ready(function(){
  var m = $(".menu:first"), n = $(".menu:first+*:first");
  if (n.height() > m.height()) {
    m.height(n.height());
  }
});
