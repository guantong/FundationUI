<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Contact Us"/>
    <jsp:param name="filename" value="contact-us"/>
</jsp:include>
<!-- END TOP -->

<!-- CONTENT -->
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
<!-- TODO: INSERT CONTENT HERE. Example below.
    Or include another jsp file here using (take out comments):
    <%--  <jsp:include page="YOUR-PAGE.jsp"/>  --%>
    -->
    <div class="row">
        <h2> Heading </h2>
        <p> Some paragraph. </p>
    </div>

<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->