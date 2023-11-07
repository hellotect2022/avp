<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	
	<%-- <title>SmartTour</title> --%>
	<tiles:insertAttribute name="css" />
	<tiles:insertAttribute name="js" />	
	
	
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

		<meta name="ROBOTS" content="NOINDEX, NOFOLLOW"/>
		<base target="_self" />
</head>
<body> 
	<div class='backLayer' style="position: absolute; background-color: black; z-index:10;"  >
		<div id="loadingbar" style="display:none;"><img  src='<c:url value='/resources/images/ajax-loader.gif'/>'/></div>
	</div>
	<%--
	<div id="wrapper">
		<tiles:insertAttribute name="header" />
		
		<div id="container" >
		
			<div class="contents" >
			
				<tiles:insertAttribute name="left" />
				
				<div id="contentsWrap" style="margin-left:25%">
					<tiles:insertAttribute name="content" />
				</div>
				
				<tiles:insertAttribute name="footer" />
				
			<!-- END OF .contents -->
			</div>
			
		<!-- END OF #container -->
		</div>
		
	<!-- END OF #wrapper -->
	</div>
	--%>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="left" />
	<div id="contentsWrap" style="margin-left:250px">
		<tiles:insertAttribute name="content" />
	</div>
	<tiles:insertAttribute name="footer" />

	<div id="ajax-loading" style="position: absolute; left:50%; top:50%; display: none">
		<img src='<c:url value='/resources/images/ajax-loader.gif'/>'/>
	</div>
</body>
</html>