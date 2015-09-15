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

setTimeout(function () {
    google.load('visualization', '1', {'callback': '', 'packages': ['corechart']})
}, 100);

function initMap() {

    google.maps.visualRefresh = true;

    var mapOptions = {
        zoom: 12,
        center: new google.maps.LatLng(-37.811129, 144.9627607),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        disableDoubleClickZoom: true,
        scrollwheel: false
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
            where: queryWhere.toString()
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

        if (data == null)
        {
            data = new google.visualization.DataTable();
            data.addColumn('string', 'Rating 0 - 5');
            data.addColumn('number', 'Categories');
            categories = ['Overall Rating', 'Forest Rating', 'Park and Reserve Rating', 'Air Pollutant Rating', 'Land Pollutant Rating', 'Water Pollutant Rating', 'Solar Saving Rating', 'Water Consumption Rating'];
            rows = [];
            for (var i = 0; i <= 7; i += 1) {
                var rating = categories[i];
                var value = parseFloat(e.row[rating.toString()].value, 0);
                rows.push([rating, value]);
            }

            data.addRows(rows);


            charts = new google.visualization.BarChart(
                    document.getElementById('chart'));

            var options = {
                title: e.row['Suburb Name'].value + ' Green Rating Detail',
                height: 400,
                width: 600,
                // set max vAxis to 5 as highest rating
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

            data = new google.visualization.DataTable();
            data.addColumn('string', 'Rating 0 - 5');
            data.addColumn('number', 'Categories');
            categories = ['Overall Rating', 'Forest Rating', 'Park and Reserve Rating', 'Air Pollutant Rating', 'Land Pollutant Rating', 'Water Pollutant Rating', 'Solar Saving Rating', 'Water Consumption Rating'];
            rows = [];
            for (var i = 0; i <= 7; i += 1) {
                var rating = categories[i];
                var value = parseFloat(e.row[rating.toString()].value, 0);
                rows.push([rating, value]);
            }

            data.addRows(rows);


            charts = new google.visualization.BarChart(
                    document.getElementById('chart2'));

            var options = {
                title: e.row['Suburb Name'].value + ' Green Rating Detail',
                height: 400,
                width: 600,
                // set max vAxis to 5 as highest rating
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

function resetComparison() {
    data = null;
}

function water() {
    queryWhere = "'Water Consumption Rating' >= 0.1 AND 'Water Consumption Rating' <= 4.9";
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
Ï