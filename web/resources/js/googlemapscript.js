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



var suburbContent; //value to keeps track of first suburb selection content, so that multiple selections can be made for the second suburb without losing track of the first's content.


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
        scrollwheel: false,
        // Setting Map style to grayscale [SUMAYA]
        styles: [{"featureType": "all", "elementType": "all", "stylers": [{"saturation": -100}, {"gamma": 0.5}]}]
    };
    map = new google.maps.Map(document.getElementById('map'),
            mapOptions);

    //Stick to the left
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
            where: queryWhere.toString()
        },
        options: {
            styleId: 2,
            templateId: 2
        },
        map: map
    });


    //boolean to know when a second suburb is select (after the initial time there's been one select to compare)
    var comparison = false;

    // Add a listener to the layer that constructs a chart from
    // the data returned on click
    google.maps.event.addListener(layer, 'click', function (e) {

        //if a second suburb has already been selected for comparison, remove its info first then add this selection
        if (comparison) {



            //When a second suburb is selected (again), remove the initial second selection by id
            var elements = document.getElementsByClassName("score-blue");
            for (var i = 0; i < elements.length; i++) {
                elements[i].innerHTML = "";
            }
        }

        if (data == null)
        {
            var node = document.getElementById('smallReportContent');
            //reset divs to empty
            while (node.hasChildNodes()) {
                node.removeChild(node.firstChild);
            }

            data = new google.visualization.DataTable();
            data.addColumn('string', 'Rating 0 - 5');
            data.addColumn('number', 'Categories');
            categories = ['Overall Rating', 'Forest Rating', 'Park and Reserve Rating', 'Air Pollutant Rating', 'Land Pollutant Rating', 'Water Pollutant Rating', 'Solar Saving Rating', 'Water Consumption Rating'];
            rows = [];


            var input = parseFloat(e.row[categories[0].toString()].value);
            var stars = getStars(input);


            //set header for suburb name and overall rating.
            var headerContent = "<h1><span>" + e.row['Suburb Name'].value + "</span></h1><h1 class=\"turn-green\">Overall Rating</h1><h1 class=\"turn-green\">"
                    + stars +
                    "</h1>";
            document.getElementById('headerContent').innerHTML = headerContent;


            for (var i = 0; i <= 7; i += 1) {
                var rating = categories[i];
                var value = parseFloat(e.row[rating.toString()].value, 0);
                rows.push([rating, value]);


                var stars = getStars(value); //function uses starrating.js rounds number 1-5 and returns stars
                //div category content append boxes for small ratings boxes
                var categoryContent = "<li><div class=\"div-shadow category-box\">" + categories[i] + "<div id=\"" + categories[i] + "\"><div class=\"score\">" + e.row['Suburb Name'].value + ": <br />" + stars + "&nbsp;</div></div></div></li>";
                document.getElementById('smallReportContent').innerHTML += categoryContent;
            }
            suburbContent = document.getElementById('smallReportContent').innerHTML; //Keep this as a backup for later use

            data.addRows(rows);
            //Everything CHARTS [SUMAYA]
            charts = new google.visualization.BarChart(
                    document.getElementById('chart'));

            var options = {
                title: e.row['Suburb Name'].value + ' Green Rating Detail',
                height: 400,
                width: 800,
                backgroundColor: {fill: 'transparent'},
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

            //Change the large report's div height when the chart loads [SUMAYA]



            var height = data.getNumberOfRows() * 41 + 30;
            document.getElementById('largeReport').style.height = height;
            document.getElementById('largeReportContent').style.height = height;
            charts.draw(data, options);
            //Inform user that a second suburb selection can be made.
            document.getElementById('chart2').innerHTML = "Select a second suburb to compare";

        }
        else {
            data = new google.visualization.DataTable();
            data.addColumn('string', 'Rating 0 - 5');
            data.addColumn('number', 'Categories');
            categories = ['Overall Rating', 'Forest Rating', 'Park and Reserve Rating', 'Air Pollutant Rating', 'Land Pollutant Rating', 'Water Pollutant Rating', 'Solar Saving Rating', 'Water Consumption Rating'];
            rows = [];

            //set header for suburb name and overall rating.
            //document.getElementById('comparedTo').innerHTML = "Compared to";
            //was  class=\"turn-blue\"


            var input = parseFloat(e.row[categories[0].toString()].value); //get the raw rating 
            var stars = getStars(input); //function uses starrating.js rounds number 1-5 and returns stars


            //Header of suburb on green report section
            var headerContent2 = "<h1><span>" + e.row['Suburb Name'].value + "</span></h1><h1 class=\"turn-green\">Overall Rating</h1><h1 class=\"turn-green\">"
                    + stars +
                    "</h1>";
            //Set the header of this suburb with the above content
            document.getElementById('headerContent2').innerHTML = headerContent2;


            //First, reset the first suburb information from the backup
            document.getElementById('smallReportContent').innerHTML = suburbContent;
            //Then fillout new content using each section's id
            for (var i = 0; i <= 7; i += 1) {
                var rating = categories[i];
                var value = parseFloat(e.row[rating.toString()].value, 0);
                rows.push([rating, value]);

                //div append
                // class=\"score-blue\"
                var stars = getStars(value); //function uses starrating.js rounds number 1-5 and returns stars

                var categoryContent = "<div class=\"score\">" + e.row['Suburb Name'].value + ": <br />" + stars + "&nbsp;</div>";
                document.getElementById(categories[i]).innerHTML += categoryContent;
            }

            data.addRows(rows);


            charts = new google.visualization.BarChart(
                    document.getElementById('chart2'));

            var options = {
                title: e.row['Suburb Name'].value + ' Green Rating Detail',
                height: 400,
                width: 800,
                backgroundColor: {fill: 'transparent'},
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

            //Change the large report's div height when the chart loads [SUMAYA]
            var height = data.getNumberOfRows() * 41 + 30;
            document.getElementById('largeReport').style.height = height;
            document.getElementById('largeReportContent').style.height = height;


            //set this to keep track if comparison mode is on, so next time user selects a suburb the initial suburb for comparison is removed by id of "temprorary"
            comparison = true;
        }
    });

    var input = /** @type {!HTMLInputElement} */(
            document.getElementById('pac-input'));
    /* Commented out because the CSS in index.xhtml deals with location of this element [SUMAYA]*/

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
    //Reset all the needed content divs 
    document.getElementById('headerContent').innerHTML = "";
    document.getElementById('headerContent2').innerHTML = "";
    document.getElementById('chart').innerHTML = "";
    document.getElementById('chart2').innerHTML = "";
    document.getElementById('smallReportContent').innerHTML = "";

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


//On change handler for the options selection form. for the category filter [SUMAYA]
function changeFunc() {
    var dropdown = document.getElementById("categoryFilter");
    var selection = dropdown.options[dropdown.selectedIndex].value;
    //alert(selection);
    switch (selection) {
        case "0":
            overall();
            break;
        case "1":
            water();
            break;
        case "2":
            solar();
            break;
        case "3":
            land();
            break;
        case "4":
            air();
            break;
        case "5":
            forest();
            break;
        case "6":
            park();
            break;
    }
}



