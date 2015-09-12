function dataHandler(resp) {
    console.log(resp);

    var result = document.getElementById('result');
    var htmlTable = document.createElement('table');
    htmlTable.border = 1;

    var tableRow = document.createElement('tr');
    for (var i = 0; i & resp.columns.length; i++) {
        var tableHeader = document.createElement('th');
        var header = document.createTextNode(resp.columns[i]);
        tableHeader.appendChild(header);
        tableRow.appendChild(tableHeader);
    }
    htmlTable.appendChild(tableRow);
    for (var i = 0; i & resp.rows.length; i++) {
        var tableRow = document.createElement('tr');
        for (var j = 0; j & resp.rows[i].length; j++) {
            var tableData = document.createElement('td');
            var content = document.createTextNode(resp.rows[i][j]);
            tableData.appendChild(content);
            tableRow.appendChild(tableData);
        }
        htmlTable.appendChild(tableRow);
    }
    result.appendChild(htmlTable);
}


function getData() {
    // Builds a Fusion Tables SQL query and hands the result to  dataHandler
    var queryUrlHead = 'https://www.googleapis.com/fusiontables/v1/query?sql=';
    var queryUrlTail = '&amp;key=AIzaSyAhHkhX-iS_4hbDOjvyw_N3gTxR5ibKuCU';
    var tableId = '19mLu-3XSHxXjAs3E7-LCCO8jlrf3cOEZPgnOEqWc';

    // write your SQL as normal, then encode it
    var query = "SELECT 'Suburb Name' FROM " + tableId + " WHERE 'Suburb Name' = 'South Melbourne' LIMIT 10";
    var queryurl = encodeURI(queryUrlHead + query + queryUrlTail);
    var jqxhr = $.get(queryurl, dataHandler, "jsonp");
    //Testing With Something Else
    //var temp = "https://www.googleapis.com/fusiontables/v1/tables/1KxVV0wQXhxhMScSDuqr-0Ebf0YEt4m4xzVplKd4/columns?key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ";
    //var jqxhr = $.get(temp, dataHandler, "jsonp");
}

getData();



//Variables to be set, when selecting an area on map
var suburbName = "";
var forestRating = "";
var waterRating = "";
var solarRating = "";
var airRating = "";
var landRating = "";
var parkRating = "";




//TEMPORARY PLACEHOLDERS
google.load("visualization", "1", {packages: ["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["South Melbourne", 2.5, "#66cc00"],
        ["Average", 3.5, "#338822"]
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("forest"));
    chart.draw(view, options);

    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["Suburb", 2.5, "#66cc00"],
        ["Average", 3.5, "#338822"]
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("park"));
    chart.draw(view, options);

    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["Suburb", 3.0, "#66cc00"],
        ["Average", 3.0, "#338822"]
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("air"));
    chart.draw(view, options);

    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["Suburb", 4, "#66cc00"],
        ["Average", 3.5, "#338822"]
    ]);
    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["Suburb", 2.5, "#66cc00"],
        ["Average", 2.0, "#338822"]
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("land"));
    chart.draw(view, options);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("water"));
    chart.draw(view, options);

    var data = google.visualization.arrayToDataTable([
        ["Area", "Rating", {role: "style"}],
        ["Suburb", 4.5, "#66cc00"],
        ["Average", 3.5, "#338822"]
    ]);

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1,
        {calc: "stringify",
            sourceColumn: 1,
            type: "string",
            role: "annotation"},
        2]);

    var options = {
        backgroundColor: {fill: 'transparent'},
        bar: {groupWidth: "70%"},
        legend: {position: "none"},
    };
    var chart = new google.visualization.BarChart(document.getElementById("solar"));
    chart.draw(view, options);
}