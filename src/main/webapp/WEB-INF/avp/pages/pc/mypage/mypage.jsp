<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>내 정보 | smartconvergence</title>

<link href="../css/css1.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var param = {
		memberViewAuth : null,
		shopUpdateAuth	: null,
		productUpdateAuth : null,
		userId:null,
		insertGubun : null
};
var user = {
		email			  : null,
		phone			  : null
};
var userType = "";
$(document).ready(function(){
	userType = "${user.userType}";

	if(userType == "SUPER") {
		$("#changeQuotasBtn").hide();
		$("#adminDelegationBtn").hide();
		$("#secessionBtn").hide();
		$("#userUpdateBtn").show();
		
		$(".notSuper").hide();
	} else if(userType == "ADMIN") {
		$("#changeQuotasBtn").show();
		$("#adminDelegationBtn").hide();
		$("#secessionBtn").show();
		$("#userUpdateBtn").show();
		
		$(".notSuper").show();
	} else if(userType == "WORKER") {
		$("#changeQuotasBtn").hide();
		$("#adminDelegationBtn").hide();
		$("#secessionBtn").show();
		$("#userUpdateBtn").show();
		
		$(".notSuper").show();
	}
	
	// 사용량 변경 버튼
	$("#changeQuotasBtn").click(function() {	// *>-- Add. 2017. 05. 18. JBum
		FN.moveQuotasPage();				// *>-- Add. 2017. 05. 18. JBum
	});										// *>-- Add. 2017. 05. 18. JBum

	// 탈퇴 버튼
	$("#secessionBtn").click(function(){
		if(!confirm("정말 탈퇴 하시겠습니까?\n(데이터가 모두 삭제되며 복구되지 않습니다.)"))
		{
			return false;	
		}	
		param.insertGubun = "sece";
		FN.dialogShow();
		FN.insertSecession();
	});
	
	// 관리자 위임 버튼
	$("#adminDelegationBtn").click(function(){
		param.insertGubun = "authApply";
		FN.dialogShow();
		FN.insertMyAuthApply();
	});
	// 정보 수정 버튼
	$("#userUpdateBtn").click(function(){
		if(!FN.valid()) {
			return;
		}
		
		if(!confirm("정보 수정 하시겠습니까?"))
		{
			return false;	
		}
		FN.userUpdateDataSet();
		FN.dialogShow();
		FN.updateUserData();
	});	
});

var FN = 
{
		valid : function() {
			str2 = $("#phone").val().trim();
      		var hpRegExp = /^\d{3}\d{3,4}\d{4}$/;		// ex)01020201010 - 핸드폰 번호
  			if(!hpRegExp.test(str2))
  			{
      			 alert("올바른 전화 번호를 입력해 주세요.");
      			 return false;
  			}
      		
  			str1 = $("#email").val().trim();
			var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!emailRegExp.test(str1)) {
				alert("올바른 이메일 형식을 입력해 주세요.");
				return false;
			}
			
			return true;
		},
		moveQuotasPage: function()											// *>-- Add. 2017. 05. 18. JBum
		{																	// *>-- Add. 2017. 05. 18. JBum
			location.href = "/pc/user/quotas"								// *>-- Add. 2017. 05. 18. JBum
		},																	// *>-- Add. 2017. 05. 18. JBum
		updateUserData: function()
		{
			$.ajax( "/pc/user/updateUserData",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(
					user
				),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			$(".backLayer").hide();
			 			return;	
			 		}
			 		alert("정상적으로 수정 되었습니다.");
			 		window.location.reload(true);
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
		        		alert("회원수정 실패하였습니다.");
		       		}
		        }   
			});
		},
		userUpdateDataSet : function()
		{
			user.email = $("#email").val();
			user.phone = $("#phone").val();
		},
		insertMyAuthApply:function(){
			$.ajax( "/pc/user/insertMyAuthApply",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(
					param
				),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			$(".backLayer").hide();
			 			return;
			 		}
			 		alert("정상적으로 신청되었습니다.");
			 		location.href = "/pc/dashboard/dashboardPage";
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
		        		alert("권한신청 실패하였습니다.");
		       		}
		        }   
			});
		},
		dialogShow:function(){
			var width = $(document).width();
			var height = $("#wrapper").height() +  $("#footer").height();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		insertSecession : function ()
		{
			$.ajax( "/pc/user/insertSecession",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			$(".backLayer")
			 			return;	
			 		}
			 		alert("정상적으로 탈퇴되었습니다.");
			 		location.href = "/pc/login";
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
		        		alert("탙퇴신청 실패하였습니다.");
		       		}
		        }   
			});
		}
}

</script>
<style>
.notSuper {
	display:none;
}
</style>
</head>

<body>
	
        
<div id="wrap">
    <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">내정보 관리 ></span> 내정보</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>내정보</legend>	
					<table class="mytable2">
						<caption>내정보</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr class="notSuper">
							<td class="tdbg01" scope="col">소속</td>
							<td class="tdbg02">${user.companyShopName}</td>                
						</tr>
						<tr class="notSuper">
							<td class="tdbg01" scope="col">등급</td>
							<td class="tdbg02">${user.userType}</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">닉네임</td>
							<td class="tdbg02">${user.nickName}</td>                
						</tr>
						<tr class="notSuper">
							<td class="tdbg01" scope="col">SNS</td>
							<td class="tdbg02">${user.snsType}</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">연락처</td>
							<td> <input  type="text" id="phone" value="${user.phone}" class="inp_text"  size="80" maxlength="100"/></td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이메일</td>
							<td> <input  type="text" id="email" value="${user.email}" class="inp_text"  size="80" maxlength="100"/></td>                
						</tr>
						<tr class="notSuper">
							<td class="tdbg01" scope="col">가입일</td>
							<td class="tdbg02">${user.createDate}</td>                
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="changeQuotasBtn" class="pagebtn2"><span class="btntxt">사용량 변경</span></button>
				<button type="button" id="adminDelegationBtn" class="pagebtn2"><span class="btntxt">관리장 위임</span></button>
				<button type="button" id="secessionBtn" class="pagebtn2"><span class="btntxt">탈퇴</span></button>
				<button type="button" id="userUpdateBtn" class="pagebtn2"><span class="btntxt">정보수정</span></button>
			</div>
		<!-- //CONTENT -->
		</div>

	<!-- //CONTAINER -->
	</div>
</div>


</body>
</html>

