$(document).ready(function(){
  $('form').on('submit', function(event){
    event.preventDefault();
    if (checkForm() == true) {
      //submit data
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
    // getCandidates($(this).serialize());
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