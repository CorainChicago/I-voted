$(document).ready(function(){
  $('form').on('submit', function(event){
    if (checkForm() == true) {
      event.preventDefault();
      insertComma();
      getCandidates($(this));
    }
    else {
      if ($('#user_street_address').val().length < 1) {
        $('#user_street_address').val("Insert a street.");
      }
      if ($('#user_city').val().length < 1) {
        $('#user_city').val("Insert a city.");
      }
      if ($('#user_state').val().length < 1) {
        $('#user_state').val("Insert a state.");
      }
      if ($('#user_zip').val().length < 1) {
        $('#user_zip').val("Insert a zip code.");
      }
    }
  });
});

var checkForm = function() {
  if (($('#user_street_address').val().length > 1) && ($('#user_city').val().length > 1) && ($('#user_zip').val().length > 1) && ($('#user_state').val().length > 1)) {
    return true;
  }
  else {
    return false;
  }
}


var insertComma = function() {
   $('#user_city').val($('#user_city').val() + '');
}

var getCandidates = function(form) {
  formattedUrl = 'https://votesmart.org/x/search?s=' + $('#user_street_address').val() + '%20' + $('#user_city').val() + '%20' + $('#user_state').val() + '%20' + $('#user_zip').val();
  var candidatesRequest = $.ajax({
   method: 'get',
   url: formattedUrl
  });
 candidatesRequest.done(function(response){
  response.zip = $('#user_zip').val();
  var candidateCreateRequest = $.ajax({
    url: "/candidates/create",
    data: response,
    method: 'post'
  });
  form.unbind('submit').submit();
 });
};