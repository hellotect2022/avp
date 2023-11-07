<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script type="text/javascript">
$(document).ready(function(){
	$("#logout").click(function(event){
		event.preventDefault();
		if(confirm("로그아웃 하시겠습니까?")){
			location.href = "/pc/logoutChk";
		}
	});
});

</script>

<style>
/*div{border:#f00 solid 1px;}*/
.menu-wrap {padding:60px 0px 570px 50px;float: left;width:200px;  background-color:#f5f5f5;}
</style>
</head>


<body>
	<div id="myheader">
		<div class="gnblogo"><img src="<c:url value='/resources/images/logo_sc.png'/>" style="width:350px; height:50px; margin-top:25px" /></div>
		<ul>
			<li  class="memberinfo">
				<span class="farmlist">
					<span class="logout_txt">
						<a href="" id="logout">로그아웃</a>
					</span>
					<span class="fontcol_02">&nbsp;|&nbsp;</span>
					<span class="greeting"><a href="/pc/user/myPage">${sessionScope.user.nickName}</a>님 환영합니다 </span>
				</span>
			</li>
		</ul>
	</div>   

</body>
</html>
