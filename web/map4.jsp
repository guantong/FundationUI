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
        <!--map api-->
        <script src="https://maps.googleapis.com/maps/api/js?signed_in=false&callback=initMap&sensor=false&libraries=places" async defer></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <!--jquery api-->
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <!--new js for pdf--> 
        <script type="text/javascript" src="resources/js/jspdf.min.js"></script>

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
            var data = null;
            var rows;
            var charts;
            var categories;
            var rating;
            var value;
            var queryWhere = "'Overall Rating' >= 0.1 AND 'Overall Rating' <= 4.9";
            var suburbName = null; // new
            var ratingsForSuburb = []; // new
            var allComments = [[]]; // new
            var data2d = []; // new var for 2 axis chart
            //new code for initialsing arrays
            var selection1Data = [];
            var selection2Data = [];
            var headerArray = ['Categories','',''];
            var dual;

            // load visualization package and and load google map
            setTimeout(function () {
                google.load('visualization', '1.1', {'callback': '', 'packages': ['bar']})
            }, 
            100);
            
            
            function initMap() {
                google.maps.visualRefresh = true;
                
                var mapOptions = {
                    zoom: 12,
                    center: new google.maps.LatLng( - 37.811129, 144.9627607),
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    disableDoubleClickZoom: true,
                    scrollwheel: false
                };
                
                map = new google.maps.Map(document.getElementById('map'), mapOptions);
                        
                map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('googft-legend-open'));
                map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('googft-legend'));
                
                // with info window
//                var layerWithInfoWindow = new google.maps.FusionTablesLayer({
//                    heatmap: {
//                        enabled: false
//                    },
//                    query: {
//                        select: "col5\x3e\x3e1",
//                        from: "19mLu-3XSHxXjAs3E7-LCCO8jlrf3cOEZPgnOEqWc",
//                        where: queryWhere.toString()
//                    },
//                    options: {
//                        styleId: 2,
//                        templateId: 2
//                    },
//                    map: map
//                });
                
                // fusion table query and map style
                var layer = new google.maps.FusionTablesLayer({
                    map: map,
                    heatmap: {
                        enabled: false
                    },
                    query: {
                        select: "col5\x3e\x3e1",
                        from: "19mLu-3XSHxXjAs3E7-LCCO8jlrf3cOEZPgnOEqWc",
                        where: queryWhere.toString()
                    },
                    options: {
                        styleId: 2,
                        templateId: 2
                    }
                }),

                //selected will be populated on layer-cllick with the postcod and
                //a boolean (true when the area is highlighted, otherwise false)
                selected = {};

                google.maps.event.addListener(layer, 'click', function (e) {
                    document.getElementById("infoWindowDiv").innerHTML = e.infoWindowHtml;
                    var val = e.row['Postcode'].value,
                            vals = [];

                    //update the selected-object
                    selected[val] = (!selected[val]) ? true : false;

                    //populate the vals-array with the selected postcodes 
                    for (var k in selected) {
                        if (selected[k]) {
                            vals.push(k);
                        }
                    }

                    layer.set("styles", [{
                        where: "'Postcode' IN('" + vals.join("','") + "')",
                        polygonOptions: {
                            fillColor: "#000000"
                        }
                    }]);
 
                    // Add a listener to the layer that constructs a chart from
                    // the data returned on click
                    if (data == null) {
                        data = new google.visualization.DataTable();
                        data.addColumn('string', 'Rating 0 - 5');
                        data.addColumn('number', 'Rating');
                        categories = ['Overall Rating', 'Forest Rating', 'Park and Reserve Rating', 'Air Pollutant Rating', 'Land Pollutant Rating', 'Water Pollutant Rating', 'Solar Saving Rating', 'Water Consumption Rating'];
                        rows = [];
                        
                        for (var i = 0; i <= 7; i += 1) {
                            var rating = categories[i];
                            var value = parseFloat(e.row[rating.toString()].value, 0);
                            // new
                            selection1Data.push(value);
                            // new // add rating of each categories (followed by var categories order)
                            ratingsForSuburb[i] = parseFloat(e.row[rating.toString()].value, 0); 
                            rows.push([rating, value]);
                        }

                        data.addRows(rows);

                        charts = new google.charts.Bar(document.getElementById('chart'));
                        suburbName = e.row['Suburb Name'].value; // new // get suburb name
                        //new code
                        headerArray[1] = suburbName.toString();
                        
                        var options = {
                            title: e.row['Suburb Name'].value + ' Green Rating Detail',
                            height: 400,
                            width: 1000,
                                // set max vAxis to 5 as highest rating
                            bars: 'horizontal', // Required for Material Bar Charts.
                            hAxis: {
                            title: "Rating",
                                viewWindowMode: 'explicit',
                                viewWindow: {
                                    max: 5,
                                    min: 0
                                }
                            }
                        };
                        charts.draw(data, options);
                    }
                    else {
                        data2d = [];
                        
                        
                        for (var i = 0; i <= 7; i += 1) {
                            var rating = categories[i];
                            var value = parseFloat(e.row[rating.toString()].value, 0);
                            selection2Data.push(value);
                        }
                        
                        // new // get suburb name 2
                        var suburbName2 = e.row['Suburb Name'].value; 
                        headerArray[2] = suburbName2.toString();
                        data2d.push(headerArray);
                        
                        for (var x = 0; x < 8; x++){
                            var names = categories[x].toString();
                            var suburb1 = selection1Data[x].toString();
                            var suburb2 = selection2Data[x].toString();
                            data2d.push([names,suburb1,suburb2]);
                        }
                        dual = new google.visualization.arrayToDataTable(data2d);
                        
                        var options = {
                        chart: {
                          title: 'Suburb Performance',
                        },
                        bars: 'horizontal', // Required for Material Bar Charts.
                        hAxis: {format: 'none'},
                        height: 400,
                        colors: ['#1b9e77', '#d95f02',]
                      };
                    var chart1 = new google.charts.Bar(document.getElementById('chart1'));
                    chart1.draw(dual, options);
                    }
                });

                var input = /** @type {!HTMLInputElement} */(document.getElementById('pac-input'));
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
                var autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.bindTo('bounds', map);
                var infowindow = new google.maps.InfoWindow();
                
                var marker = new google.maps.Marker({
                    map: map,
                    anchorPoint: new google.maps.Point(0, - 29)
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
                    } 
                    else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(17); // Why 17? Because it looks good.
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

            google.maps.event.addDomListener(window, 'load', initMap());

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
                } 
                else {
                    x.innerHTML = "Geolocation is not supported by this browser.";
                }
            }

            // set current lon,lat to variables
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

            // reset comparison, allow use to compare two new suburbs
            function resetComparison() {
                data = null;
            }

            // filter functions
            function waterC() {
                queryWhere = "'Water Consumption Rating' >= 0.1 AND 'Water Consumption Rating' <= 4.9";
                initMap();
            }
            
//            new
            function waterP() {
                queryWhere = "'Water Pollutant Rating' >= 0.1 AND 'Water Consumption Rating' <= 4.9";
                initMap();
            }

            function air() {
                queryWhere = "'Air Pollutant Rating' >= 0.1 AND 'Air Pollutant Rating' <= 4.9";
                initMap();
            }

            function land() {
                queryWhere = "'Land Pollutant Rating' >= 0.1 AND 'Land Pollutant Rating' <= 4.9";
                initMap();
            }

            function park() {
            queryWhere = "'Park and Reserve Rating' >= 0.1 AND 'Park and Reserve Rating' <= 4.9";
                initMap();
            }

            function overall() {
                queryWhere = "'Overall Rating' >= 0.1 AND 'Overall Rating' <= 4.9";
                initMap();
            }

            function solar() {
                queryWhere = "'Solar Saving Rating' >= 0.1 AND 'Solar Saving Rating' <= 4.9";
                initMap();
            }

            function forest() {
                queryWhere = "'Forest Rating' >= 0.1 AND 'Forest Rating' <= 4.9";
                initMap();
            }

            function print() {
                // comments for ratings in each categories
                // rating 0 means no data
                var zero = "Sorry, data/rating isn't available at the moment.";
                // normally each categories has 5 comment as shown below plus raing 0
                // and element from 0-4 in 'all comments' array
                allComments = [['The selected area shows a low overall performance.', 'The selected area shows a relatively low overall performance.', 'The selected area shows an average overall performance.', 'The selected area shows a good overall performance.', 'The selected area shows a great overall performance.'], ['The selected area shows a lower than most others in the number of trees.', 'The selected area shows a relatively lower number of trees compared to others.', 'The selected area shows an average number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.'], ['The selected area shows a small area of parks and reserves compared to others.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.'], ['The selected area shows high level of air pollutant emissions.', 'The selected area shows high level of air pollutant emissions.', 'The selected area shows average level of air pollutant emissions.', 'The selected area shows relatively low level of air pollutant emissions.', 'The selected area shows low level of air pollutant emissions.'], ['The selected area shows high level of land pollutant.', 'The selected area shows relatively high level of land pollutant.', 'The selected area shows average level of land pollutant.', 'The selected area shows relatively low level of land pollutant.', 'The selected area shows low level of land pollutant.'], ['The selected area shows high level of water chemical pollutants.', 'The selected area shows relatively  high level of water chemical pollutants.', 'The selected area shows average level of water chemical pollutants.', 'The selected area shows relatively low level of water chemical pollutants.', 'The selected area shows low level of water chemical pollutants.'], ['The selected area shows low level of using solar energy. ', 'The selected area shows relatively lower level of using solar energy.', 'The selected area shows average level of using solar energy.', 'The selected area shows relatively high level of using solar energy.', 'The selected area shows high level of using solar energy.'], ['The selected area shows high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows low water usage levels per household.']];
        
                var doc = new jsPDF();
                // para1 - left margin
                // para2 - top margin
                // para3 - string for output
                // print suburb name           
                doc.text(20, 20, 'Thank you for using VictoGreen');
                doc.text(20, 30, 'This is a report for you selected suburb');
                // for loop to compare and select comments for a given rating in each category
                doc.text(20, 50, 'Suburb name: ' + suburbName.toString());
                
                var i;
                    
                for (i = 0; i < ratingsForSuburb.length; i++) {
                    doc.text(20, 60 + (i*3*10), categories[i].toString() + '-> ' + ratingsForSuburb[i].toString());
                    var number = ratingsForSuburb[i];
                    if (number == 0) {
                        doc.text(20, 70 + (i*3*10), zero.toString());
                        continue;
                    }
                    if (number > 0 && number < 1) {
                        doc.text(20, 70 + (i*3*10), allComments[i][0].toString());
                        continue;
                    }
                    if (number >= 1 && number < 2) {
                        doc.text(20, 70 + (i*3*10), allComments[i][1].toString());
                        continue;
                    }
                    if (number >= 2 && number < 3) {
                        doc.text(20, 70 + (i*3*10), allComments[i][2].toString());
                        continue;
                    }
                    if (number >= 3 && number < 4) {
                        doc.text(20, 70 + (i*3*10), allComments[i][3].toString());
                        continue;
                    }
                    if (number >= 4 && number < 5) {
                        doc.text(20, 70 + (i*3*10), allComments[i][4].toString());
                        continue;
                    }
                }
                doc.save('VictoGreen.pdf');
            }

        </script>

        <input id="pac-input" class="controls" type="text" placeholder="Enter a location">

        <div>
            <!--tracking user local button-->
            <button onclick="pan()">Track location</button>

            <!--filter button for each categories-->
            <button onclick="waterC()">water consumption rating</button>
            <!--new-->
            <button onclick="waterP()">water pollutant rating</button>
            <button onclick="air()">air pollutant rating</button>
            <button onclick="land()">land pollutant rating</button>
            <button onclick="park()">park and reserve rating</button>
            <button onclick="overall()">overall rating</button>
            <button onclick="solar()">solar installation rating</button>
            <button onclick="forest()">forest ocverage rating</button>

            <!--new-->
            <!--print button allow use to print a pdf document-->
        </div>

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

        <div>
            <button onclick="resetComparison()">reset comparison</button>
            <button onclick="saveAsPDF()">Save PDF Report</button>
        </div>
        <div id="chart1">Click on a marker to<br>display a chart here</div>
        <div id="chart">Click on a marker to<br>display a chart here</div>
        
        <div id="infoWindowDiv">Info Window</div>
        
    </body>
</html>