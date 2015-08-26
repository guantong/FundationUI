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
<br>
<br>
<br>
<footer class="footer">
    <div class="row full-width">
        <div class="small-6 medium-6 large-6 columns">
            <div class="right">
                <img style="width:100px; height: auto;" class="img-resize" src="resources/images/a1_logo.png" alt=""/>
                <img style="width:100px; height: auto;" class="img-resize" src="resources/images/victogreen_logo.png" alt=""/>
            </div>
        </div>
        <div class="left-border small-6 medium-6 large-6 columns">
            <h4>Links</h4>

            <p class="footer-links">
                <a href="about.jsp">About</a>
                <a href="guide.jsp">Guide</a>
                <a href="faq.jsp">FAQ's</a>
                <a href="contact-us.jsp">Contact Us</a>
            </p>
            <p class="copyright"> A1 Foundation © 2015 </p>
        </div>
    </div>
</footer>
<!-- END FOOTER -->
<!-- JAVASCRIPT -->
<script src="resources/bower_components/jquery/dist/jquery.min.js"></script>
<script src="resources/bower_components/foundation/js/foundation.min.js"></script>
<script src="resources/js/app.js"></script>


<script>
    var topbar, yPos;
function yScroll(){
    topbar = document.getElementById('topbar');
    yPos = window.pageYOffset;
    if(yPos > 150){
        topbar.style.backgroundColor = "#ffffff";
    } else {
        topbar.style.backgroundColor = "transparent";
    }
}
window.addEventListener("scroll", yScroll);
    </script>
<!-- END JAVASCRIPT -->

<!-- Closures from the tags opened in the top.jsp file-->

</div>
</body>
</html>
