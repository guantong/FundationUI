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
        <link href="resources/bower_components/foundation-icon-fonts/foundation-icons.css" rel="stylesheet" type="text/css"/>
        <!--added aug 25 to prevent horizontal scrolling on small screen devices -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    </head>
    <body>
        <div class="bg-img">
            <!-- HEADER -->
            <div class="row bg-grayscale">
                <center>
                    <div class="hide-small-show-large">
                        <a href="index.jsp"><img src="resources/images/victogreen_logo_small.png"/></a>
                    </div>
                </center>

                <div class="contain-to-grid sticky">
                    <nav class="top-bar" id="topbar" data-topbar role="navigation">
                        <ul class="title-area">
                            <li class="name">
                                <!--<h1><a href="index.jsp">VictoGreen</a></h1>-->
                            </li>
                            <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                            <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
                        </ul>

                        <section class="top-bar-section middle">
                            <!-- Left Nav Section -->
                            <ul class="left">

                            </ul>
                            <!-- Right Nav Section -->
                            <ul class="">
                                <li id="index">
                                    <a href="index.jsp">
                                        <i class="fi-marker"></i>
                                        &nbsp;
                                        Home
                                    </a>
                                </li>
                                <li id="about" id="about">
                                    <a href="about.jsp">
                                        <i class="fi-info"></i>
                                        &nbsp;
                                        About
                                    </a>
                                </li>
                                <li class="has-dropdown" id="guide">
                                    <a href="guide.jsp"><i class="fi-projection-screen"></i>&nbsp; Guide</a>
                                    <ul class="dropdown">
                                        <li id="terminology"><a href="terminology.jsp">Terminology</a></li>
                                        <li id="tips"><a href="tips.jsp">Tips and Advice</a></li>
                                    </ul>
                                </li>
                                <li id="faq"><a href="faq.jsp"><i class="fi-comment-quotes"></i>&nbsp; Questions</a></li>
                                <li id="contact-us"><a href="contact-us.jsp"><i class="fi-mail"></i>&nbsp; Contact Us</a></li>
                            </ul>
                        </section>
                    </nav>
                    <div class="row header-title bg-green div-shadow hide-small-show-large" style="height: 5px;">
                    </div>
                </div>
            </div>

            <!-- JS -->
            <!-- Active Button Script -->
            <script type="text/javascript">
                var currentfilename = '${param.filename}';
                //alert(currentfilename);
                document.getElementById(currentfilename).className += "active";
            </script>

            <!-- END JS -->
            <div class="row header-title bg-green">
            </div>



            <!-- END HEADER -->
