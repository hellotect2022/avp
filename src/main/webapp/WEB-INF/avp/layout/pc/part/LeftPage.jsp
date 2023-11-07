<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<style>

.menu-wrap {padding:60px 0px 600px 50px;float:left;width:200px;  background-color:#f5f5f5;}
footer{padding-top:3px;}
</style>
</head>


<body>         
    <!--left menu-->
    <div class="menu-wrap">
    
		<ul id="tree">
			<c:forEach var="menu" items="${menus}">
			<li>
				<span>${menu.menuName }</span>
				<c:if test="${not empty menu.subMenus }">
				<ul>
					<c:forEach var="subMenu" items="${menu.subMenus }">
					<li><a href="${subMenu.linkUrl }" id="${subMenu.menuId }">${subMenu.menuName }</a></li>
					</c:forEach>
				</ul>
				<!-- //smenu -->
				</c:if>
			</li>			
			</c:forEach>
		</ul>
	</div>
</body>
</html>
