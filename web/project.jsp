<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Project"/>
    <jsp:param name="filename" value="project"/>
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

<!-- TODO: INSERT CONTENT HERE. Example below.
    Or include another jsp file here using (take out comments):
    <%--  <jsp:include page="YOUR-PAGE.jsp"/>  --%>
    -->
    <div class="row">
        <h2> Project </h2>
        <p> Learn about the project here. </p>
    </div>

<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->