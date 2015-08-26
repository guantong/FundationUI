<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Map</title>
        <script src="http://maps.googleapis.com/maps/api/js"></script>
        <script>
            var map;
            var lat;
            var lon;

            function initialize() {
                var mapOptions = {
                    zoom: 14,
                    center: new google.maps.LatLng(-37.8180819, 144.968177),
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                styles:[{"featureType":"all","elementType":"all","stylers":[{"saturation":-100},{"gamma":0.5}]}]
                };

                map = new google.maps.Map(document.getElementById('map-canvas'),
                        mapOptions);

                var marker = new google.maps.Marker({
                    position: mapOptions.center,
                    animation:google.maps.Animation.BOUNCE,
                    title: 'My Location'
                });
                marker.setMap(map);
                setTimeout(function(){ marker.setAnimation(null); }, 750);
            }

            google.maps.event.addDomListener(window, 'load', initialize);

            function pan() {
                getLocation();
                var panPoint = new google.maps.LatLng(lat.toString(), lon.toString());
                map.panTo(panPoint);

                var marker = new google.maps.Marker({
                    position: panPoint,
                    animation:google.maps.Animation.BOUNCE,
                    title: 'My Location'
                });
                marker.setMap(map);
                setTimeout(function(){ marker.setAnimation(null); }, 750);
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
        <div id="map-canvas" class="bg-height map-style">
        </div>
        <div style="margin-top: -70px;">
            <a onclick="pan()" class="button round tiny right">
                <div style=" font-size: 14px; color: #FFFFFF;">
                    <i class="fi-target-two"></i>
                    Your location
                </div>
            </a>
        </div>

    </body>
</html>