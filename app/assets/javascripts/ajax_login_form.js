$(document).ready(function(){

  $("#login").on("click", function(event){
    event.preventDefault();
    var link = $(this).attr("href");
    var request = $.ajax({
      url: link,
      method: "GET"
    })

    request.done(function(response){
      console.log(response)
      $(".slick-list").append(response);
    })

  })
})