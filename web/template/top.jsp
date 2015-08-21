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
        <jsp:param name="title" value="Place Title Here"/>
    </jsp:include>
    <!-- JSP CONTENT -->

    <jsp:include page="bottom.jsp"/>
    ==========================================
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>
<html>
    <head>
        <title>VictoGreen:${param.title}</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="resources/bower_components/modernizr/modernizr.js"></script>
        <link href="resources/css/app.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    </head>
    <body>
        <!-- HEADER -->
        <div class="contain-to-grid sticky">
            <nav class="top-bar" data-topbar="true" role="navigation">
                <ul class="title-area">
                    <li class="name">
                        <h1><a href="index.jsp">VictoGreen</a></h1>
                    </li>
                    <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
                </ul>

                <section class="top-bar-section">
                    <!-- Right Nav Section -->

                    <ul class="right">
                        <li class="has-dropdown" id="about">
                            <a href="about.jsp">About</a>
                            <ul class="dropdown">
                                <li id="project"><a href="project.jsp">Project</a></li>
                                <li id="references"><a href="references.jsp">References</a></li>
                            </ul>
                        </li>
                        <li class="has-dropdown" id="guide">
                            <a href="guide.jsp">Guide</a>
                            <ul class="dropdown">
                                <li id="terminology"><a href="terminology.jsp">Terminology</a></li>
                                <li id="tips"><a href="tips.jsp">Tips and Advice</a></li>
                            </ul>
                        </li> <!--Originally called Tips-->
                        <li id="faq"><a href="faq.jsp">FAQ's</a></li>
                        <li id="contact-us"><a href="contact-us.jsp">Contact Us</a></li>
                    </ul>

                    <!-- Left Nav Section -->
                    <ul class="left">
                        <li  id="index"><a href="index.jsp">Home</a></li>
                    </ul>
                </section>
            </nav>
        </div>

        <!-- JS -->
        <!-- Active Button Script -->
        <script type="text/javascript">
            var currentfilename = '${param.filename}';
            //alert(currentfilename);
            document.getElementById(currentfilename).className += "active";
        </script>

        <!-- END JS -->

        <div class="row">
            <h1> ${param.title} </h1>
        </div>
        <!-- END HEADER -->
