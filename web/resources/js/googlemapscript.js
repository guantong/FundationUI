var map;
var lat;
var lon;

function initMap() {
    var mapOptions = {
        zoom: 12,
        center: new google.maps.LatLng(-37.811129, 144.9627607),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        streetViewControl: false,
        // Setting Map style to grayscale [SUMAYA]
        styles: [{"featureType": "all", "elementType": "all", "stylers": [{"saturation": -100}, {"gamma": 0.5}]}]
    };
    map = new google.maps.Map(document.getElementById('map'),
            mapOptions);

    //Commented out to be placed using CSS in index page. [SUMAYA]
    map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(document.getElementById('googft-legend-open'));
    map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(document.getElementById('googft-legend'));

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
        }
        //map: map
    });
    layer.setMap(map);

    var input = /** @type {!HTMLInputElement} */(
            document.getElementById('pac-input'));
    /* Commented out because the CSS in index.xhtml deals with locatino of this element [SUMAYA]*/

    //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var options = {
        //SUMAYA: Setting autocomplete options types to "regions" to get cities, suburbs and postal codes
        types: ['(regions)'],
        //Restrict search to australia. TODO: Victoria only?
        componentRestrictions: {country: "au"}
    };

    var autocomplete = new google.maps.places.Autocomplete(input, options); // Passing the autocomplete options here [SUMAYA]
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

