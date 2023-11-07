<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script type="text/javascript" src="/resources/js/jquery-1.11.0.min.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
var connectType = "${lastConnectType}";
var isNewSession = "${isNewSession}";
var loginData ={
		snsType			: null,
		kakaoUserId 		: null,
		thumbnailImageUrl	: null,
		userName			: null
}
var mobileFlag = false;
$(document).ready(function(){
	
	var mobileInfo = new Array('Android', 'iPhone', 'iPod', 'BlackBerry', 'Windows CE', 'SAMSUNG', 'LG', 'MOT', 'SonyEricsson');
	for (var info in mobileInfo){
	    if (navigator.userAgent.match(mobileKeyWords[info]) != null){
	    	mobileFlag = true;
	    }
	}
	
	$("#logout").click(function(){
		FN.logout();
	})
	$("#unlink").click(function(){
		FN.unlink();
	})
	
	
});
var FN = {
		unlink:function()
		{
			  Kakao.API.request({
	            url: '/v1/user/unlink',
	            success: function(res) {
	                console.log(res);
	            },
	            fail: function(error) {
	                console.log(error);
	            }
	        })
		},
		logout:function(){
		    Kakao.API.request({
		        url: '/v1/user/logout',
		        success: function(res) {
		        	console.log(res)
		        },
		        fail: function(error) {
		        	console.log(JSON.stringify(error))
		        }
		    })
		},
		sessionDataSet:function(){
			$.ajax( "/opr/appLoginData",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data	: JSON.stringify(loginData),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		console.log(data)
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 		//실패시  : 로그인 실패 브릿지
			 			android.loginUser("999",0);
			 			return;	   
			 		}
			 		
			 		var userId = String(data.response.body.userId);
			 		android.loginUser("200",userId);
			 		//성공시 로그인 성공 브릿지
			 		
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
		        		alert("로그인 셋팅 실패 하였습니다.");
		       		}
	      	  }   
		});
	}
}
</script>
<body>
<a id="kakao-login-btn"></a>
<a href="http://alpha-developers.kakao.com/logout"></a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('3a08285ea12803f4009a40815aeeedbd');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
    	 console.log(JSON.stringify(authObj))
		 	Kakao.Auth.getStatus(function(statusObj) {
				loginData.kakaoUserId 	=	statusObj.user.id;
		 		loginData.snsType		=	"kakao";
				FN.sessionDataSet();
	      	});
//     	 location.href = "/opr/prouduct/list"
//         alert(JSON.stringify(authObj));
    		 
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });

  //]]>
  
</script>
<p>
<a id="logout">카카오톡 로그아웃</a>
</p>
<p>
<a id="unlink">카카오톡 unlink</a>
</p>
</body>

