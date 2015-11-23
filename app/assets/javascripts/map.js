// function initialize() {
//   var mapProp = {
//   center:new google.maps.LatLng(51.508742, -0.120850),
//   zoom: 7,
//   mapTypeId: google.maps.MapTypeId.ROADMAP
//   };
//   var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
// }

// google.maps.event.addDomListener(window, 'load', initialize);
$(document).ready(function(){
  function initialize() {
    var mapCanvas = document.getElementById('map');
    var mapOptions = {
      center: new google.maps.LatLng(44.5403, -78.5463),
      zoom: 11,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(mapCanvas, mapOptions);
  }
  google.maps.event.addDomListener(window, 'load', initialize);
});
