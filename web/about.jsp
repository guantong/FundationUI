<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="About"/>
    <jsp:param name="filename" value="about"/>
</jsp:include>
<!-- END TOP -->


<!-- CONTENT -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- TODO: INSERT CONTENT HERE. Example below.
    Or include another jsp file here using (take out comments):
<%--  <jsp:include page="YOUR-PAGE.jsp"/>  --%>
-->

<br>
<div class="text-page-container-header bg-greenscale">
    <h1> About </h1>
</div>
<div class="text-page-container">
    <div class="row">
        <div class="large-6 columns">
            <h2> Project </h2>
            <h3> VictoGreen </h3>
            <p><b> Victoria to Green </b></p>
            <p>The VictoGreen website introduces the concept of a Green Rating, which is a score
                that follows a criteria of categories (pollutants, energy, water usage, gas
                emissions and outdoor space) to tell how environmentally friendly –or green- a 
                suburb is. </p>
            <h3>Audience</h3>
            <p><b> You are! </b></p>
            <p>
                The project’s target audience is the environmental organizations, local
                Government and anyone from the public domain with interest in the field.
                Furthermore, the website can be extended to allow other firms like the
                Real-estate agencies to embed the service in their websites.
            </p>
            <h3>Data </h3>
            <p>
                All the data is from the Open Data Victoria and Open Data Melbourne, which are provided by 
                government. </p>
            <h3> Disclaimer </h3>
            <p>
                VictoGreen does not hold responsibility for decisions made by users, and it is only an aid to 
                users to gain knowledge and look for tips. The users or any party using the service -if in doubt 
                about their area’s condition and/or find that the green report’s findings in their vicinity 
                alarming- must consult a professional service to conduct a study and provide formal reports 
                and advice.
            </p>
        </div>
        <div class="large-6 columns">
            <h2> Team </h2>
            <ul>
                <li>
                    <b>Sumaya Baitalmal</b>  Master of Information Technology 
                </li>
                <li>
                    <b>Junfeng Guan</b>      Master of Information Technology
                </li>
                <li>
                    <b>Tianfeng Shan</b>     Master of Business Information Systems
                </li>
                <li>
                    <b>Guantong Wo</b>      Master of Information Technology
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <h3> References </h3>
        <ul>
            <li> ref 1 </li>
            <li> ref 2 </li>
        </ul>
    </div>
</div>

<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->