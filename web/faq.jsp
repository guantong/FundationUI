<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Frequently Asked Questions"/>
    <jsp:param name="filename" value="faq"/>
</jsp:include>
<!-- END TOP -->
// Google analytics tracker
<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-39144765-3', 'auto');
    ga('send', 'pageview');

</script>
<!-- CONTENT -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- TODO: INSERT CONTENT HERE. Example below.
    Or include another jsp file here using (take out comments):
<%--  <jsp:include page="YOUR-PAGE.jsp"/>  --%>
-->
<br>
<div class="text-page-container-header bg-greenscale">
    <h1> Questions </h1>
</div>
<div class="text-page-container">
    <div class="row">
        <h3>About the website </h3>
        <p><b>What does VictoGreen do? </b></p>
        <p>The website introduces the concept of a Green Rating, which is a score that follows a criteria of categories (pollutants, energy, water usage, gas emissions and outdoor space) to tell how environmentally friendly –or green- a suburb is.</p>
        <p><b>Who is the audience of VictoGreen?</b></p>
        <p>The project’s target audience is the environmental organizations, local Government and anyone from the public domain with interest in the field. Furthermore, the website can be extended to allow other firms like the Real-estate agencies to embed the service in their websites. Where is the data from? All the data is from the Open Data Victoria and Open Data Melbourne, which are provided by government. Risk responsibility. VictoGreen does not hold responsibility for decisions made by users, and it is only an aid to users to gain knowledge and look for tips. The users or any party using the service -if in doubt about their area’s condition and/or find that the green report’s findings in their vicinity alarming- must consult a professional service to conduct a study and provide formal reports and advice.</p>
        <p><b>About the terms What is the “Green Rating”?</b></p>
        <p> “Green rating” is a score that follows a criteria of categories 
            (pollutants, energy, water usage, gas emissions and outdoor space)
            to tell how environmentally friendly –or green- a suburb is. 
            This Green Rating feature will be initially portrayed as a color coded map that allows the users to navigate or search this map to their own vicinity. </p>
        <p><b>What is the “Green Report”?</b></p>
        <p>A Green report can be produced if the user makes an area selection, this report provides indicators (using graphs) on the data categories used to formulate the Green Rating. </p>
        <p><b>What is the “poll”? </b></p>
        <p>A polling system to involve the users engagement with the website.
            Showing as a popup on the screen, the poll view prompts the user to vote and answer a simple question about the daily habits.  
        <p>
        <p><b>What are advices and tips? </b></p>
        <p>VictoGreen provides our users many advices and tips about environment. 
            Advice and tips make our neighborhood “Greener”.</p>  

        <h3>About the site actions</h3>
        <p><b>How can I search the Green rating? </p></b>
        <p>Just type in the postcode that you want to search. That is it, so easy.</p>
        <p><b>How to generate the Green Report? </p></b>
        <p>Click the “Generate report” button, you would get the Green Report of one specific suburb. </p>
        <p><b>Can I download the Green Report? Is it free? </p></b>
        <p>Yes, you can. The Green Report is the free to download, no other fees would be charged.</p>
        <p><b>What does result of poll use for?</p></b>
        <p>A polling system to involve the users engagement with the website.</p>
        <p>It’s a call-to-action tool to:</p>
        <li>Trigger the visitor’s curiosity </li>
        <li>Make them think </li>
        <li>Grasp their interest </li>
        <li>Pushes to the same direction of raising awareness VictoGreen keeps 
            users information only for making website better.  </li>

        <p>VictoGreen would never disclose users’ information. </p>

        <h3>About the future? </h3>
        <p><b>Can I register? </p></b>
        <p>Registration is not available at the moment, but soon enough (and after gathering enough interest) we shall provide a service
            and can be registered for to display green ratings.</p>
        <p><b>How to support us? </p></b>
        <p>If you are interest in VictoGreen and willing to donate this project, please <a href="#">email us</a>, thank you! </p>
        <p><b>Do you want to join us for the better, green, bright future?</b></p>
        <p>If you want to join us and to be an member of this project, please feel free to <a href="#">email us</a>.</p>
    </div>
</div>

<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->