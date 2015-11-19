$(document).ready(function(){
  $('form').on('submit', function(event){
    event.preventDefault();
    if (checkForm() == true) {
      insertComma();
      getCandidates();
    }
    else {
      if ($('#_street_number').val().length < 1) {
        $('#_street_number').val("Insert a street number.");
      }
      if ($('#_street_address').val().length < 1) {
        $('#_street_address').val("Insert a street.");
      }
      if ($('#_city').val().length < 1) {
        $('#_city').val("Insert a city.");
      }
      if ($('#_state').val().length < 1) {
        $('#_state').val("Insert a state.");
      }
      if ($('#_zip').val().length < 1) {
        $('#_zip').val("Insert a zip code.");
      }
    }
  });
});

var checkForm = function() {
  if (($('#_street_number').val().length > 1) && ($('#_street_address').val().length > 1) && ($('#_city').val().length > 1) && ($('#_zip').val().length > 1) && ($('#_state').val().length > 1)) {
    return true;
  }
  else {
    return false;
  }
}


var insertComma = function() {
   $('#_city').val($('#_city').val() + ',');
}

var getCandidates = function() {
  formattedUrl = 'http://votesmart.org/x/search?s=' + $('#_street_number').val() + '%20' + $('#_street_address').val() + '%20' + $('#_city').val() + '%20' + $('#_state').val() + '%20' + $('#_zip').val();
  var candidatesRequest = $.ajax({
   method: 'get',
   url: formattedUrl
  });
 candidatesRequest.done(function(response){
  var candidateCreateRequest = $.ajax({
    url: "/candidates/create",
    data: response,
    method: 'post'
  });
  candidateCreateRequest.done(function(response){
    alert(response);
  });
 });
};
