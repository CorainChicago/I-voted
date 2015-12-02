var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('autocomplete')),
      {types: ['geocode']});
  autocomplete.addListener('place_changed', fillInAddress);
}


function fillInAddress() {
  var place = autocomplete.getPlace();
  $('#user_street_address').val($('#autocomplete').val().split(', United States')[0].split(',')[0]);
  $('#user_city').val($('#autocomplete').val().split(', United States')[0].split(',')[1] + ',');
  $('#user_state').val($('#autocomplete').val().split(', United States')[0].split(',')[2]);
  var streetAddress = $('#user_street_address').val() + $('#user_city').val() + $('#user_state').val();
  var zipCode = $.ajax({
    method: 'post',
    url: '/getzipcode',
    data: {'address': streetAddress}
  });
  zipCode.done(function(response){
    $('#zipcode').html('Zip: -' + response + '-');
    $('#user_zip').val(response);
  });
}

function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}



