$(document).ready(function(){
  $(".candidate-name-list").on("click", function(){
    var div = $(this).attr("id")
    $("a[id="+ div+"]").siblings("div").toggle();
  })
})