<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Place Title Here"/>
    <jsp:param name="filename" value="template"/>
</jsp:include>
<!-- END TOP -->

<!-- CONTENT -->

<!-- TODO: INSERT CONTENT HERE. Example below.
    Or include another jsp file here using (take out comments):
    <%--  <jsp:include page="/template/bottom.jsp"/>  --%>
    -->
    <div class="row">
        <h2> Heading </h2>
        <p> Some paragraph. </p>
    </div>

<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->