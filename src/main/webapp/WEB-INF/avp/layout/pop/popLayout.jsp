<%-- 
  - 작성자:  박희준
  - 작성일자: 2012. 11. 07.
  - 설명: 메인 Layout 화면.
  --%>
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
	
	<title>MomenT</title>
	<tiles:insertAttribute name="css" />
	<tiles:insertAttribute name="js" />
	
	
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

		<meta name="ROBOTS" content="NOINDEX, NOFOLLOW"/>
		<base target="_self" />
		<title> MomenT </title>		
</head>
<body> 
	<div id="wrapper">
		<div id="container">
			<!-- contents -->
			<div >
				<div id="contentsWrap">
					<tiles:insertAttribute name="content" />
				</div>
			</div>
		</div>
	</div>
	<div id="ajax-loading" style="position: absolute; left:50%; top:50%; display: none">
		<img src='<c:url value='/resources/images/ajax-loader.gif'/>'/>
	</div>
</body>
</html>