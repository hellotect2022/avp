<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#twitter").click(function(){
		FN.appChk();
	});
});

var FN = {
		appChk:function(){
			$.ajax( "/opr/product/twitterAppCheck",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		console.log(data)
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	   
			 		}
			 		
			 		https://api.twitter.com/oauth/authorize?oauth_token=ip5QjwAAAAAAzJJsAAABWjUtqGw
			 		location.href = "http://twitter.com/oauth/authorize?oauth_token="+
// 					response.sendRedirect("http://twitter.com/oauth/authorize?oauth_token="+requestToken.token);
			 		console.log(data.response.body.requestToken.token)
			 	},
		 		error: function(result, status){
		 			console.log(result,status)
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("트위터 인증 실패 하였습니다.");
		       		}
	      	  }   
		});
	}	
		
}
</script>

<body>
<a id ="twitter" ><img alt="" src="/resources/images/twitter/sign-in-with-twitter-gray.png"></a>
</body>

