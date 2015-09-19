<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>PDF</title>
    </head>
    <body>
        <script type="text/javascript" src="resources/js/jspdf.min.js"></script>
        <script>
            function print() {
                // comments for ratings in each categories
                // rating 0 means no data
                var zero = "Sorry, data/rating isn't available at the moment.";
                // normally each categories has 5 comment as shown below plus raing 0
                // 0-4 in array
                var commentOverall = ['The selected area shows a low overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a relatively low overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows an average overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a good overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).', 'The selected area shows a great overall performance on water consumption, pollutant levels, areas of parks and reserves and number of trees (forest).'];
                var commentAirPollutant = ['The selected area shows high level of air pollutant emissions.', 'The selected area shows high level of air pollutant emissions.', 'The selected area shows average level of air pollutant emissions.', 'The selected area shows relatively low level of air pollutant emissions.', 'The selected area shows low level of air pollutant emissions.'];
                var commentForest = ['The selected area shows a lower than most others in the number of trees.', 'The selected area shows a relatively lower number of trees compared to others.', 'The selected area shows an average number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.', 'The selected area shows a relatively high number of trees compared to others.'];
                var commentParkReserve = ['The selected area shows a small area of parks and reserves compared to others.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.', 'The selected area shows a relatively small area of parks and reserves.'];
                var commentLandPollutant = ['The selected area shows high level of land pollutant.', 'The selected area shows relatively high level of land pollutant.', 'The selected area shows average level of land pollutant.', 'The selected area shows relatively low level of land pollutant.', 'The selected area shows low level of land pollutant.'];
                var commentWaterPollutant = ['The selected area shows high level of water chemical pollutants.', 'The selected area shows relatively  high level of water chemical pollutants.', 'The selected area shows average level of water chemical pollutants.', 'The selected area shows relatively low level of water chemical pollutants.', 'The selected area shows low level of water chemical pollutants.'];
                var commentSolarSaving = ['The selected area shows low level of using solar energy. ', 'The selected area shows relatively lower level of using solar energy.', 'The selected area shows average level of using solar energy.', 'The selected area shows relatively high level of using solar energy.', 'The selected area shows high level of using solar energy.'];
                var commentWaterConsumption = ['The selected area shows high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows relatively high water usage levels per household.', 'The selected area shows low water usage levels per household.'];

                var doc = new jsPDF();
                doc.text(20, 20, 'Hello world');
                doc.text(20, 30, 'd;kadladfadsf');
                doc.addPage();
                doc.text(20, 20, '2nd Hello world');
                doc.save('2page.pdf');
            }

        </script>
        <button id="save" onclick="print()">save</button>
    </body>

</html>