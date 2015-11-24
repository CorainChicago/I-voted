$(document).ready(function(){
  $('#state_name').on("click", function(){
    var request = $.ajax({
      url: '/map',
    })
    request.done(function(response){
      
    }
  })
});
