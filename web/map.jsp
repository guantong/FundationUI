<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Map</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            html, body, #map-canvas{
                margin: 0;
                padding: 0;
                height: 500px;
            }
        </style>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script>
            var map;
            var lat;
            var lon;

            function initialize() {
                var mapOptions = {
                    zoom: 14,
                    center: new google.maps.LatLng(-37.8180819, 144.968177),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);

                var marker = new google.maps.Marker({
                    position: mapOptions.center,
                    title: 'My Location'
                });
                marker.setMap(map);
            }

            google.maps.event.addDomListener(window, 'load', initialize);

            function pan() {
                getLocation();
                var panPoint = new google.maps.LatLng(lat.toString(), lon.toString());
                map.panTo(panPoint);

                var marker = new google.maps.Marker({
                    position: panPoint,
                    title: 'My Location'
                });
                marker.setMap(map);
            }


            function getLocation() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(showPosition);
                } else {
                    x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }

            function showPosition(position) {
                lat = position.coords.latitude;
                lon = position.coords.longitude;
            }

            function showError(error) {
                switch (error.code) {
                    case error.PERMISSION_DENIED:
                        x.innerHTML = "User denied the request for Geolocation."
                        break;
                    case error.POSITION_UNAVAILABLE:
                        x.innerHTML = "Location information is unavailable."
                        break;
                    case error.TIMEOUT:
                        x.innerHTML = "The request to get user location timed out."
                        break;
                    case error.UNKNOWN_ERROR:
                        x.innerHTML = "An unknown error occurred."
                        break;
                }
            }
        </script>
    </head>
    <body>
        <div class="row">
            <input type="button" class="button round tiny right" value="Track your location" onclick="pan()" />
        </div>
        <div class="row"><div id="map-canvas"></div></div>
        
    </body>

</html>