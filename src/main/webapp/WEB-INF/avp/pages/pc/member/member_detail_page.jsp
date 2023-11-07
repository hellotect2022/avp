<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>멤버상세</title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>
<script type="text/javascript">

var param = {
		memberViewAuth : null,
		shopUpdateAuth	: null,
		productUpdateAuth : null,
		userId:null
}
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	$("#cancelBtn").click(function(){
		history.back();
	});
		
	$("#deleteBtn").click(function(){
	    if(!confirm("강제 탈퇴시키시겠습니까?\n(데이터가 전부 삭제됩니다)"))
		{
			return false;	
		}	
		FN.dialogShow();
		FN.deleteMember($(this).attr("userId"));
	});
	
});

var FN = 
{
		errorLogInsert:function(status){
			$.ajax( "/pc/error/errorLogInsert",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
								"status":status
								}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; chshopset=UTF-8",
			 	success: function(data)
			 	{
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			$(".backLayer").hide();
			 			return;
			 		}
			 		if("parsererror" == status)
			 		{
			 			location.href = "/pc/login";
			 		}
			 		else
			 		{
			 			$(".backLayer").hide();
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
		        		alert("로그 저장중 에러 발생");
		       		}
		        }   
			});
			
		},	
		dialogShow:function(){
			var width = $(document).width();
			var height = $(document).height();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		deleteMember : function(userId)
		{
			$.ajax( "/pc/member/memberDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(
					"userId":userId
				),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("삭제 완료하였습니다.");
			 		location.href = "/pc/member/memberListPage";
// 			 		var users = data.response.body.users;
			 		//기존 row들 삭제
			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/member/memberUpdate :"+status;
				 	// session time out
				 		if(status == "parsererror")
				 		{
				 			alert("session이 만료되었습니다. 로그인페이지로 이동합니다.");
				 			FN.errorLogInsert(statusStr);
				 		}
				 		// ajax time out				
				 		else if(status == "timeout")
				 		{
				 			alert("서버 요청중 타임아웃이 발생하였습니다.");
				 			FN.errorLogInsert(statusStr);
				 		}
				 		// server 문법 에러		
				 		else if(status == "error")
				 		{
				        	if(result.responseText)
				        	{
				        		var response = JSON.parse(result.responseText);
				        		//에러발생을 위한 code페이지
				            	alert(response.response.header.statusMessage);
					 			FN.errorLogInsert(statusStr);
				        	}
				        	else
				       		{
				        		alert("처리 중 에러가 발생했습니다.");
					 			FN.errorLogInsert(statusStr);
				       		}
			 			}
		        }   
			});
		}
}

</script>
</head>
<body>
<div id="wrap">
	<div id="container">
		<div class="contents">
			<h2><span class="titel-text-sm">멤버 관리 > 멤버목록  ></span>멤버상세</h2>
			
			<fieldset>
				<form name="" method="" action="">
					<legend>멤버상세</legend>
					<table class="mytable2">
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr> 
							<td class="tdbg01" scope="col">닉네임</td> 
							<td id="userType" class="tdbg02">${user.nickName}</td> 
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">등급</td> 
							<td id="nickName" class="tdbg02">${user.userType}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">SNS</td> 
							<td id="companyShop" class="tdbg02">${user.snsType}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">연락처</td> 
							<td id="companyShop" class="tdbg02">${user.phone}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">이메일</td> 
							<td id="companyShop" class="tdbg02">${user.email}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">가입일</td>
							<td id="createDate" class="tdbg02">${user.createDttm}</td> 
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="deleteBtn" class="pagebtn2" userId="${userId}">
					<span class="btntxt">강제탈퇴</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2">
					<span class="btntxt">취소</span>
				</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>
