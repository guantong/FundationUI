<!-- TOP -->
<jsp:include page="/template/top.jsp">
    <jsp:param name="title" value="Home"/>
    <jsp:param name="filename" value="index"/>
</jsp:include>
<!-- END TOP -->

<!-- CONTENT -->


<div class="row map-container div-shadow" style="z-index: 1000;">
    <div class="large-4 columns bg-darkgreen bg-height">
        <br>
        <div class="large-8 medium-8 small-12 columns">
        <input type="text" class="prefix" placeholder="Type in postcode or suburb name"/></div>
        <div class="large-4 medium-4 small-12 columns"><a href="#" class="button postfix">Go</a></div>
        
        <p> <i class="fi-magnifying-glass"></i> Enter a suburb name or postcode to get the <a href="terminology.jsp">Green rating</a> result of that suburb.
    </div>
    <div class="large-8 columns  bg-height remove-gutter" >
        <%@ include file="map1.jsp" %>
    </div>
</div>
<div class="green-report row" style="z-index: -1;">
    <center>
        <h1><span> South Melbourne </span></h1>
        <h1> Green Rating </h1>
        <h1> <i class="fi-star"></i><i class="fi-star"></i><i class="fi-star"></i><i class="fi-star"></i> </h1>
    </center>
     <br>
</div>
<div class="row">
    <div class="container">
        <div class="large-3 columns">
            <div class="div-shadow category-box">
                Category <br>
                <h1><i class="fi-graph-bar"> </i></h1>
            </div>
        </div>
        <div class="large-3 columns">
            <div class="div-shadow category-box">
                Category <br>
                <h1><i class="fi-graph-bar"> </i></h1>
            </div>
        </div>
        <div class="large-3 columns">
            <div class="div-shadow category-box">
                Category <br>
                <h1><i class="fi-graph-bar"> </i></h1>
            </div>
        </div>
        <div class="large-3 columns">
            <div class="div-shadow category-box">
                Category <br>
                <h1><i class="fi-graph-bar"> </i></h1>
            </div>
        </div>
    </div>
</div>



<!-- END CONTENT -->

<!-- BOTTOM -->
<jsp:include page="/template/bottom.jsp"/>
<!-- END BOTTOM -->