<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>Welcome to AVP </title>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.6.1/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyDD8LksK107UJopMggP2jTjZPm8G6hoook",
    authDomain: "smartar-203a4.firebaseapp.com",
    databaseURL: "https://smartar-203a4.firebaseio.com",
    projectId: "smartar-203a4",
    storageBucket: "smartar-203a4.appspot.com",
    messagingSenderId: "63108914665"
  };
  firebase.initializeApp(config);
</script>
<script type="text/javascript">
var connectType = "${lastConnectType}";
var isNewSession = "${isNewSession}";
var loginData ={
		snsType			: null,
		snsId 		: null,
// 		thumbnailImage	: null,
		nickName			: null
}
var mobileFlag = false;
$(document).ready(function(){
// 	var mobileInfo = new Array('Android', 'iPhone', 'iPod', 'BlackBerry', 'Windows CE', 'SAMSUNG', 'LG', 'MOT', 'SonyEricsson');
// 	for (var info in mobileInfo){
// 	    if (navigator.userAgent.match(mobileKeyWords[info]) != null){
// 	    	mobileFlag = true;
// 	    }
// 	}
	$("#superLogin").click(function(){
		location.href = "/pc/masterLoginPage"	
	})
	$("#superLogin").hover(function() {
	    $(this).css('cursor','pointer');
	});
	$("#logout").click(function(){
		FN.logout();
	})
	$("#unlink").click(function(){
		FN.unlink();
	})
	$("#twitter").click(function(){
		FN.twitterCheck();
	})
	
});
var FN = {
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
		twitterCheck:function(){
			$.ajax( "/pc/twitterAppCheck",{
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
			 		
			 		location.href = data.response.body.authUrl;
// 			 		location.href = "http://twitter.com/oauth/authorize?oauth_token="+data.response.body.token;
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
		},
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
			FN.dialogShow()
			$.ajax( "/pc/appLoginData",{
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
			 			return;	   
			 		}
			 		var validChek = data.response.body.valid;
			 		var user = data.response.body.user;
			 		
			 		if("FIRST" == validChek)
			 		{
			 			location.href = "/pc/loginSub";
			 			return;
			 		}
			 		else if("MOVELOGINSUB" == validChek)
			 		{
			 			location.href = "/pc/loginSub";
			 		}
					else if("NOTNORMAL" == validChek)
			 		{
						alert("승인 대기중입니다.\n관리자가 승인 후 이용 가능 합니다.");
						$(".backLayer").hide();
						return;
			 		}
			 		else if("SUPER" == validChek || "NORMAL" == validChek )
			 		{
			 			location.href = "/pc/dashboard/dashboardPage";
			 		}
			 		
// 			 		var userId = String(data.response.body.userId);
// 			 		android.loginUser("200",userId);
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

<script>
  // This is called with the results from from FB.getLoginStatus().
  function facebooklogin() {
	  console.log("I'm IN :::::::::::::::::::");
	  FB.login(function(response) {
    	  var fbName;
    	  var accessToken = response.authResponse.accessToken;
      }, {scope: 'public_profile,email'});
  }
  
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
//       document.getElementById('status').innerHTML = 'Please log ' +
//         'into Facebook.';
            
//    	  console.log("tesTSEtsetset")
//    	  console.log(response)
//	      if (response.status === 'connected')
//	      { 
	      
	    	  
//	      } 
//	      else if (response.status === 'not_authorized') 
//	      { // 페이스북에는 로그인 되어있으나, 앱에는 로그인 되어있지 않다. 
	    	  
//	      }
//	      else 
//	      { // 페이스북에 로그인이 되어있지 않아서, 앱에 로그인 되어있는지 불명확하다. 
	    	 
//	      } 
 //     });
     
      
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
    	console.log(response);
    	//176715566149352
    	loginData.snsId 		=	response.authResponse.userID;
 		loginData.snsType		=	"facebook";
		FN.sessionDataSet();
		
      statusChangeCallback(response);
    });
  }
  

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '158591617986945',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.8' // use graph api version 2.8
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
	  console.log("here :::::::");
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
//       document.getElementById('status').innerHTML =
//         'Thanks for logging in, ' + response.name + '!';
    });
  }
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<style>

</style>
</head>

<body> 
<!-- wrap start -->
<div  class="login_welcome">
	<div class="wel_top">
		<img src="<c:url value='/resources/images/logo_2.png'/>" style="width:500px; height:250px;" />
		<p>★ W e l c o m e ★</p>	
		
	</div>
	<div>
		<ul class="wel_login_wrap">
			<li class="wel_loginbox">  
				<form name="" method="" action="">
					<fieldset>
						<legend>로그인 폼</legend>   
						<div class="wel_form">
						   <p class="wel_s_admin">
							 <a href="/pc/masterLoginPage"></a>
							</p> 
							  <p class="wel_twitter">
							 	<a id="twitter" style="cursor: pointer;"></a>
							 </p> 
							  <p class="wel_kakao">
							  <a id="kakao-login-btn" href="javascript:kakaologin()" style="cursor: pointer;">
								<script type='text/javascript'>
								  //<![CDATA[
								    // 사용할 앱의 JavaScript 키를 설정해 주세요.
								    Kakao.init('aefd6bcbe341d2c6658f3f28b1f654dd');
								    function kakaologin() {
									    Kakao.Auth.login({
									      success: function(authObj) {
									    	 console.log(JSON.stringify(authObj))
											 	Kakao.Auth.getStatusInfo(function(statusObj) {
													loginData.snsId 	=	statusObj.user.id;
											 		loginData.snsType		=	"kakao";
											 		loginData.nickName		=	statusObj.user.properties.nickname;
													FN.sessionDataSet();
										      	});
									//     	 location.href = "/pc/prouduct/list"
									//         alert(JSON.stringify(authObj));
									    		 
									      },
									      fail: function(err) {
									         alert(JSON.stringify(err));
									      }
									    });
								    };
								
								  //]]>
								</script>
								</a>
								</p>
							  <p class="wel_facebook">
							 <a id="fb_login" onclick="facebooklogin()" style="cursor: pointer;"></a>
							</p>
							
						</div>
					</fieldset>
				</form> 
			</li>
		</ul>
	</div>

</div>
<!-- //wrap end -->

</body>
</html>