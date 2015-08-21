<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Home"/>
    <jsp:param name="filename" value="index"/>
</jsp:include>
<!-- END TOP -->

<!-- CONTENT -->
<div class="row">
    <div class="large-10 small-10 columns">
        <input type="text" placeholder="Type in postcode or suburb name"/>
    </div>
    <div class="large-2 small-2 columns">
        <a href="#" class="button postfix">Search</a>
    </div>
</div>
<div class="row">
    <div class="large-10 small-10 columns">
        <h2> How is this not changing? </h2>
    </div>
    <div class="large-2 small-2 columns">
        <a href="#" class="button postfix">Search</a>
    </div>
</div>
<div class="row">
    <%@ include file="map.jsp" %>
</div>
<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->