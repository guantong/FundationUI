<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Place Autocomplete</title>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">

        <script src="https://maps.googleapis.com/maps/api/js?signed_in=false&libraries=places&callback=initMap" async defer></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            #map {
                height: 100%;
            }
            .controls {
                margin-top: 10px;
                border: 1px solid transparent;
                border-radius: 2px 0 0 2px;
                box-sizing: border-box;
                -moz-box-sizing: border-box;
                height: 32px;
                outline: none;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
            }

            #pac-input {
                background-color: #fff;
                font-family: Roboto;
                font-size: 15px;
                font-weight: 300;
                margin-left: 12px;
                padding: 0 11px 0 13px;
                text-overflow: ellipsis;
                width: 300px;
            }

            #pac-input:focus {
                border-color: #4d90fe;
            }

            #googft-legend{
                background-color:#fff;
                border:1px solid #000;
                font-family:Arial,sans-serif;
                font-size:12px;
                margin:5px;
                padding:10px 10px 8px
            }

            #googft-legend p{
                font-weight:bold;
                margin-top:0
            }

            #googft-legend div{
                margin-bottom:5px
            }

            .googft-legend-swatch{
                border:1px solid;
                float:left;
                height:12px;
                margin-right:8px;
                width:20px
            }

            .googft-legend-range
            {
                margin-left:0
            }

            .googft-dot-icon
            {
                margin-right:8px
            }

            .googft-paddle-icon
            {
                height:24px;
                left:-8px;
                margin-right:-8px;
                position:relative;
                vertical-align:middle;
                width:24px
            }

            .googft-legend-source
            {
                margin-bottom:0;
                margin-top:8px
            }

            .googft-legend-source a
            {
                color:#666;
                font-size:11px
            }

            #chart {
                text-align: center;
                width: 500px;
                padding-top: 10px;
            }
        </style>
    </head>
    <body>
        <script>
            var map;
            var lat;
            var lon;
            var data;
            var rows;

            function loadApi() {
                google.load("visualization", "1", {"callback": pageLoaded});
            }

            function initMap() {

                google.maps.visualRefresh = true;

                var mapOptions = {
                    zoom: 12,
                    center: new google.maps.LatLng(-37.811129, 144.9627607),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                map = new google.maps.Map(document.getElementById('map'),
                        mapOptions);


                map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('googft-legend-open'));
                map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('googft-legend'));

                // fusion table query and map style
                var layer = new google.maps.FusionTablesLayer({
                    heatmap: {
                        enabled: false
                    },
                    query: {
                        select: "col5\x3e\x3e1",
                        from: "19mLu-3XSHxXjAs3E7-LCCO8jlrf3cOEZPgnOEqWc",
                        where: "'Overall Rating' >= 0.1 AND 'Overall Rating' <= 4.9"
                    },
                    options: {
                        styleId: 2,
                        templateId: 2
                    },
                    map: map
                });

                // Add a listener to the layer that constructs a chart from
                // the data returned on click
                google.maps.event.addListener(layer, 'click', function (e) {

                    data = new google.visualization.DataTable();
                    data.addColumn('string', 'Water Consumption Rating');
                    data.addColumn('number', 'Rating');
                    rows = [];
                    for (var i = 0; i <= 5; i += 1) {
                        var rating = i.toString();
                        var value = parseFloat(e.row['Water Consumption Rating'].value, 0);
                        rows.push([rating, value]);
                    }

                    data.addRows(rows);

                    var chart = new google.visualization.BarChart()(
                            document.getElementById('chart'));

                    var options = {
                        title: e.row['Water Consumption Rating'].value + ' Rating',
                        height: 400,
                        width: 600
                    };
                    chart.draw(data, options);
                });

                var input = /** @type {!HTMLInputElement} */(
                        document.getElementById('pac-input'));

                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                var autocomplete = new google.maps.places.Autocomplete(input);

                autocomplete.bindTo('bounds', map);

                var infowindow = new google.maps.InfoWindow();

                var marker = new google.maps.Marker({
                    map: map,
                    anchorPoint: new google.maps.Point(0, -29)
                });



                autocomplete.addListener('place_changed', function () {
                    infowindow.close();
                    marker.setVisible(false);
                    var place = autocomplete.getPlace();
                    if (!place.geometry) {
                        window.alert("Autocomplete's returned place contains no geometry");
                        return;
                    }

                    // If the place has a geometry, then present it on a map.
                    if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(17);  // Why 17? Because it looks good.
                    }
                    marker.setIcon(/** @type {google.maps.Icon} */({
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(35, 35)
                    }));
                    marker.setPosition(place.geometry.location);
                    marker.setVisible(true);

                    var address = '';
                    if (place.address_components) {
                        address = [
                            (place.address_components[0] && place.address_components[0].short_name || ''),
                            (place.address_components[1] && place.address_components[1].short_name || ''),
                            (place.address_components[2] && place.address_components[2].short_name || '')
                        ].join(' ');
                    }

                    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                    infowindow.open(map, marker);
                });
            }

//            google.maps.event.addDomListener(window, 'load', initMap());

            // shift map to current location
            function pan() {
                getLocation();
                var panPoint = new google.maps.LatLng(lat.toString(), lon.toString());
                map.panTo(panPoint);

                var marker = new google.maps.Marker({
                    position: panPoint,
                    animation: google.maps.Animation.BOUNCE,
                    title: 'My Location'
                });
                marker.setMap(map);
                setTimeout(function () {
                    marker.setAnimation(null);
                }, 750);
            }

            // get current location
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

            // error handling if user deny location tracking 
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

        <input id="pac-input" class="controls" type="text" placeholder="Enter a location">

        <button onclick="pan()">Track location</button>

        <div id="map"></div>

        <input id="googft-legend-open" style="display:none" type="button" value="Legend"></input>

        <div id="googft-legend">
            <p id="googft-legend-title">Overall Rating</p>
            <div>
                <span class="googft-legend-swatch" 
                      style="background-color: #ffffff"></span>
                <span class="googft-legend-range">0 to 1</span>
            </div>
            <div>
                <span class="googft-legend-swatch" 
                      style="background-color: #ff9900"></span>
                <span class="googft-legend-range">1 to 2</span>
            </div>
            <div>
                <span class="googft-legend-swatch" 
                      style="background-color: #93c47d"></span>
                <span class="googft-legend-range">2 to 3</span>
            </div>
            <div>
                <span class="googft-legend-swatch" 
                      style="background-color: #6aa84f"></span>
                <span class="googft-legend-range">3 to 4</span>
            </div>
            <div>
                <span class="googft-legend-swatch" 
                      style="background-color: #274e13"></span>
                <span class="googft-legend-range">4 to 5</span>
            </div>
            <input id="googft-legend-close" style="display:none" type="button" value="Hide"></input>
        </div>

        <div id="chart">Click on a marker to<br>display a chart here</div>

    </body>
</html>