// var map = new GMap2(document.getElementById("map_canvas"));
var geocoder = new GClientGeocoder();

var address = "1505 W. Wilson, Chicago Illinois";
geocoder.getLatLng(address, function(point) {
         var latitude = point.y;
         var longitude = point.x; 
         console.log(latitude); 

         // do something with the lat lng
    });