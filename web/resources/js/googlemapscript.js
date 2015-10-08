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
var headerArray = ['Categories', '', ''];
var dual;
var headerContentBackup; //new [SUMAYA]

// load visualization package and and load google map
setTimeout(function () {
    google.load('visualization', '1.1', {'callback': '', 'packages': ['bar']})
},
        100);

//To be put as tooltips to each category header
var categoryDescription = [
    'An overall performance of an area on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest)',
    'The total number of trees in each suburb/area', 'The total area square meters of the park and reserve of the suburb.',
    'Air pollutant emissions in kilos for each suburb. For example, the Carbon disulfide, monoxide, Acetonitrile.',
    'The total land chemical pollutant in kilos of the suburb, for example, pollutant can be the Wasted Benzene, Xylenes (individual or mixed isomers), Formaldehyde (methyl aldehyde).',
    'The total water chemical pollutant in kilos of the suburb, such as ammonia.',
    'CO2e saved kilotons per home for each suburb or area, by using solar energy, such as solar cell, solar heater.', 'Water usage (Liter/ L) for each household, per day, based on suburb and postcode'
];



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
        streetViewControl: false,
        // Setting Map style to grayscale [SUMAYA]
        //styles: [{"featureType": "all", "elementType": "all", "stylers": [{"saturation": -100}, {"gamma": 0.5}]}]
    };

    /*
     * 
     * ,
     // Setting Map style to grayscale [SUMAYA]
     styles: [{"featureType": "all", "elementType": "all", "stylers": [{"saturation": -100}, {"gamma": 0.5}]}]
     */
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
//selected will be populated on layer-cllick with the postcod and
    //a boolean (true when the area is highlighted, otherwise false)
    selected = {};

    //boolean to know when a second suburb is select (after the initial time there's been one select to compare)
    var comparison = false;
    headerContentBackup = document.getElementById('headerContentAll').innerHTML;

    // Add a listener to the layer that constructs a chart from
    // the data returned on click
    google.maps.event.addListener(layer, 'click', function (e) {



        var buttonsContent = "";
        buttonsContent += "<div class=\"large-3 columns\">";
        buttonsContent += "                                <a onclick=\"resetComparison()\">";
        buttonsContent += "                                    <i class=\"fi-page-remove\"><\/i>&nbsp; Reset Comparison";
        buttonsContent += "                                <\/a> <br>";
        buttonsContent += "                                <a onclick=\"print()\">";
        buttonsContent += "                                    <i class=\"fi-save\"><\/i>&nbsp; Save PDF report";
        buttonsContent += "                                <\/a>";
        buttonsContent += "                            <\/div>";

        document.getElementById('reportButtons').innerHTML = buttonsContent;

        //scroll down a little bit to show there's a report generated
        window.scrollBy(0, 300);

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
            //span the tooltip for each category and overall by pulling the comment from the
            //categorDescription array of strings. use <span data-tooltip...etc> and add it there
            var headerContent = "<h1 class=\"turn-blue\" style=\"font-size: 40px;\">" + e.row['Suburb Name'].value + "</h1><h1 ><span data-tooltip=\"true\" aria-haspopup=\"true\" class=\"has-tip\" title=\"" + categoryDescription[0].toString() + "\">Overall Rating</h1></span><h1 class=\"turn-green\">"
                    + stars +
                    "</h1>";
            document.getElementById('headerContent').innerHTML = headerContent;


            for (var i = 0; i <= 7; i += 1) {
                var rating = categories[i];
                var value = parseFloat(e.row[rating.toString()].value, 0);
                ratingsForSuburb[i] = parseFloat(e.row[rating.toString()].value, 0); // new // add rating of each categories (followed by var categories order)
                rows.push([rating, value]);


                var stars = getStars(value); //function uses starrating.js rounds number 1-5 and returns stars
                //div category content append boxes for small ratings boxes
                var categoryContent = "<li><div class=\"category-box\">" + "<span data-tooltip aria-haspopup=\"true\" class=\"has-tip\" title=\"" + categoryDescription[i].toString() + "\">" + categories[i] + "</span><div id=\"" + categories[i] + "\"><div class=\"score\"><h4>" + e.row['Suburb Name'].value + "</h4>" + stars + "</div></div></div></li>";
                document.getElementById('smallReportContent').innerHTML += categoryContent;
            }
            suburbContent = document.getElementById('smallReportContent').innerHTML; //Keep this as a backup for later use

            data.addRows(rows);
            //Everything CHARTS [SUMAYA]
            charts = new google.visualization.BarChart(
                    document.getElementById('chart'));
            suburbName = e.row['Suburb Name'].value; // new // get suburb name

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
        //If the first suburb selected, data is now no longer, thus coming here, 
        //for the second suburb selection
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
            var headerContent2 = "<h1 class=\"turn-blue\" style=\"font-size: 40px;\">" + e.row['Suburb Name'].value + "</h1><h1><span data-tooltip=\"true\" aria-haspopup=\"true\" class=\"has-tip\" title=\"" + categoryDescription[0].toString() + "\">Overall Rating</h1></span><h1 class=\"turn-green\">"
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
                var categoryContent = "<div class=\"score\"><h4>" + e.row['Suburb Name'].value + "</h4>" + stars + "&nbsp;</div>";

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

            //Change height of boxes to fit the second suburb's text
            var x = document.getElementsByClassName("category-box");
            var j;
            for (j = 0; j < x.length; j++) {
                x[j].style.height = 200;
            }
        }

        $(document).foundation('tooltip', 'reflow');
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
    //Reset all the needed content divs 
    //document.getElementById('headerContentAll').innerHTML = "";
    document.getElementById('headerContentAll').innerHTML = headerContentBackup;
    document.getElementById('chart').innerHTML = "Green report will be produced upon suburb selection on map.";
    document.getElementById('chart2').innerHTML = "";
    document.getElementById('smallReportContent').innerHTML = "";
    document.getElementById('reportButtons').innerHTML = "";



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
            waterC();
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
        case "7":
            waterP();
            break;
    }
}


function print() {
    // comments for ratings in each categories
    // rating 0 means no data
    var zero = "Sorry, data/rating isn't available at the moment.";
    // normally each categories has 5 comment as shown below plus raing 0
    // All comment contains 8 categories with 5 comment for each categories
    allComments = [['The selected area shows a low overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a relatively low overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows an average overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a good overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a great overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).'], ['The selected area shows a lower than most others in the number of trees.', 'The selected area shows a relatively lower number of trees compared to others.', 'The selected area shows an average number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.'], ['The selected area shows a small area of parks and reserves compared to others.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.'], ['The selected area shows high level of air pollutant emissions.', 'The selected area shows high level of air pollutant emissions.', 'The selected area shows average level of air pollutant emissions.', 'The selected area shows relatively low level of air pollutant emissions.', 'The selected area shows low level of air pollutant emissions.'], ['The selected area shows high level of land pollutant.', 'The selected area shows relatively high level of land pollutant.', 'The selected area shows average level of land pollutant.', 'The selected area shows relatively low level of land pollutant.', 'The selected area shows low level of land pollutant.'], ['The selected area shows high level of water chemical pollutants.', 'The selected area shows relatively  high level of water chemical pollutants.', 'The selected area shows average level of water chemical pollutants.', 'The selected area shows relatively low level of water chemical pollutants.', 'The selected area shows low level of water chemical pollutants.'], ['The selected area shows low level of using solar energy. ', 'The selected area shows relatively lower level of using solar energy.', 'The selected area shows average level of using solar energy.', 'The selected area shows relatively high level of using solar energy.', 'The selected area shows high level of using solar energy.'], ['The selected area shows high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows low water usage levels per household.']];

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
        doc.text(20, 60 + (i * 3 * 10), categories[i].toString() + '-> ' + ratingsForSuburb[i].toString());
        var number = ratingsForSuburb[i];
        if (number == 0) {
            doc.text(20, 70 + (i * 3 * 10), zero.toString());
            continue;
        }
        if (number > 0 && number < 1) {
            doc.text(20, 70 + (i * 3 * 10), allComments[i][0].toString());
            continue;
        }
        if (number >= 1 && number < 2) {
            doc.text(20, 70 + (i * 3 * 10), allComments[i][1].toString());
            continue;
        }
        if (number >= 2 && number < 3) {
            doc.text(20, 70 + (i * 3 * 10), allComments[i][2].toString());
            continue;
        }
        if (number >= 3 && number < 4) {
            doc.text(20, 70 + (i * 3 * 10), allComments[i][3].toString());
            continue;
        }
        if (number >= 4 && number < 5) {
            doc.text(20, 70 + (i * 3 * 10), allComments[i][4].toString());
            continue;
        }
    }
    doc.save('VictoGreen.pdf');
}
