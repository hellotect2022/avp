<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>Login | smartconvergence </title>

<script type="text/javascript">
var userData = 
{
		email 					: null,
		userPassword 			: null
}
var dc = null;
var btnVaild = true;
$(document).ready(function(){
// 	FN.dialogShow()
	/* left menu light on */
	$(".loginBtn").click(function(){
		// 원래 소스는 login function 으로 변경됨
		FN.login();								// Modify. 2017. 05. 19 JBum
	});	
});

var FN = 
{
		// Add. 2017. 05. 19. JBum
		// Enter Key event 를 위해 모듈화
		login : function(){
			if(btnVaild)
			{
				if(!FN.valid())
				{
					return;
				}
				//if(confirm("로그인 하시겠습니까?"))									// Modify. 2017. 05. 19 JBum
				//{																// Modify. 2017. 05. 19 JBum
					userData.userPassword = $("#userPassword").val();
					userData.email = $("#email").val();
					btnVaild = false;		
					FN.dialogShow();
					FN.insert();
				//}																// Modify. 2017. 05. 19 JBum
				//else															// Modify. 2017. 05. 19 JBum
				//{																// Modify. 2017. 05. 19 JBum
					//btnVaild = true;											// Modify. 2017. 05. 19 JBum
				//}																// Modify. 2017. 05. 19 JBum
			}
		},
		valid : function(){
			if("" == $("#email").val().trim())
			{
				alert("이메일을 입력해 주세요");
				return false;
			}
			
			if("" == $("#userPassword").val().trim())
			{
				alert("비밀번호를 입력해 주세요");
				return false;
			}
			
			return true;
		},
		dialogShow:function(){
			var width = $(document).width();
			var height = $(document).width();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		insert : function()
		{
			FN.dialogShow();
			$.ajax( "/pc/masterLogin",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(userData),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
		 				alert(data.response.header.statusMessage);
		 				$(".backLayer").hide();
		 				btnVaild = true;
		 				return;
			 		}
			 		else
			 		{
			 			
		 			location.href = "/pc/dashboard/dashboardPage";
			 		}
			 	},
			 	error: function(result, status)
			 	{
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("수정 실패하였습니다.");
		       		}
		        }   
			});
		}
}

</script>

</head>

<body> 


<!-- wrap start -->
<div id="login" class="login_container">
   
	<!-- login_wrap -->
   	<ul class="login_wrap">
		<!-- <li class="loginbox01"></li> -->
		<li><img src="<c:url value='/resources/images/logo_2.png'/>" style="width:500px; height:250px; padding-top:100px;" /></li>
		<li class="loginbox02">  
			<div class="hgroup">
				<h1><img src="<c:url value='/resources/images/logintitle.png'/>" alt="Login" /></h1>
			 </div>
			<form name="" method="" action="">
				<fieldset>
					<legend>로그인 폼</legend>
					<div class="login_form">
					  	<p class="field">
							<label for="uid">이메일을 입력하세요</label>
							<input name="uid" type="text" id="email" class="inp_text" onkeypress="if(event.keyCode==13){FN.login();}" />
						</p>
						<p class="field">
							<label for="pwd">비밀번호를 입력하세요. </label>
							<input name="pwd" type="password" id="userPassword" class="inp_text" onkeypress="if(event.keyCode==13){FN.login();}"/>     <!-- Modify. 2017. 05. 19 JBum -->
						</p>
				
						<p class="btn_login">
							<a class="loginBtn"><span class="blind">로그인</span></a>
						</p> 
						<p class="login_line">
						</p>										
						<p class="login_info">
							Copyright 2019. SMARTCONVERGENCE all rights reserved. 
						</p>
					</div>
				</fieldset>
			</form> 
		</li>
	</ul>      
</div>
<!-- //wrap end -->
 	
</body>
</html>