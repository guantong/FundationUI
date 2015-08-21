<%-- 
    Document   : template
    Created on : Aug 20, 2015, 9:40:17 PM
    Author     : SumayaBaitalmal

    Description:
    Use this template file to include the default header, footer and common css and js inclusions.
    All the content needs to go inside the CONTENT comments.
    Depending on where you place your page, make sure the uri for paths is correct. (ie /template/top.jsp)
    Note: No need to supply the <html><head><body> tags as they are already included in the top.jsp and bottom.jsp

    NOTICE: 
    The top.jsp and bottom.jsp work in conjunction and must be included in one jsp document. As follows:
    ==========================================
    <jsp:include page="top.jsp">
        <jsp:param name="title" value="Home"/>
    </jsp:include>

    <!-- JSP CONTENT -->

    <jsp:include page="bottom.jsp"/>
    ==========================================
--%>
<!-- FOOTER -->
<footer class="footer">
    <div class="row full-width">
        <div class="large-4 columns">
            <h4>A1 Foundation</h4>
            <p>Prepared by:</p>
        </div>

        <div class="small-6 medium-5 large-4 columns">
            <h4>VictoGreen</h4>
            <p>Copyright information go here</p>
        </div>
        <div class="small-6 medium-5 large-4 columns">
            <h4>Links</h4>
            <ul class="side-nav">
                <li class="has-dropdown" id="about"><a href="about.jsp">About</a></li>
                <li class="has-dropdown" id="guide"><a href="guide.jsp">Guide</a></li>
                <li id="faq"><a href="faq.jsp">FAQ's</a></li>
                <li id="contact-us"><a href="contact-us.jsp">Contact Us</a></li>
            </ul>
        </div>
    </div>
</footer>
<!-- END FOOTER -->
<!-- JAVASCRIPT -->
<script src="resources/bower_components/jquery/dist/jquery.min.js"></script>
<script src="resources/bower_components/foundation/js/foundation.min.js"></script>
<script src="resources/js/app.js"></script>
<!-- END JAVASCRIPT -->
</body>
</html>
