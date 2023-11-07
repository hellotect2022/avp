<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>가입신청 상세 | smartconvergence </title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">

var param = {
		confirmUserId : null,
		userId	: null,
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
	
	var userType =	"${user.userType}";

	if("ADMIN"	==	userType)
		{
			$("#userType").text("관리자")
		}
		else if("WORKER"	==	userType)
		{
			$("#userType").text("작업자")
		}
	
	var tmp = "${user.storageSize}";
	var standardGB = 1024 * 1024 * 1024;
	var standardMB = 1024 * 1024;
	var translatedStorage;
	if (tmp >= standardGB) {
		translatedStorage = tmp / standardGB;
		$("#storageSize").text(translatedStorage + " GB");
	} else {
		translatedStorage = tmp / standardMB;
		$("#storageSize").text(translatedStorage + " MB");
	}
	
	$("#updateBtn").click(function(){
		
       if(!confirm("승인하시겠습니까??"))
		{
			return false;	
		}	
		FN.dialogShow();
		FN.dataSet($(this).attr("confirmUserId"),$(this).attr("userId"));
		FN.update();
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
		dataSet:function(confirmUserId,userId)
		{
				param.confirmUserId	=	confirmUserId;
				param.userId	=	userId	;
		},
		moveCancelPage:function()
		{
			history.bakck();
		},
		startBtEndYmdAndAlert : function ()
		{
			var startYmd = $("#search_sday").val();
			var endYmd = $("#search_eday").val()
			
			if(startYmd.replace(/-/g,'') > endYmd.replace(/-/g,'')){
				alert("시작일이 종료일보다 클수 없습니다.");
				$("#search_eday").val("");
				return false;
			}
		},
		moveDetailPage : function (rwdId)
		{
			location.href="/pc/reward/detailPage?rwdId="+rwdId;
		},
		moveInsertPage: function()
		{
			location.href="/pc/reward/insertPage";
		},
		update : function()
		{
			$.ajax( "/pc/member/memberAppplyUpdate",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(param),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("승인 완료하였습니다.");
			 		location.href = "/pc/member/memberApplyListPage";
// 			 		var users = data.response.body.users;
			 		//기존 row들 삭제
			 	},
			 	error: function(result, status){
			 		var  statusStr = "AR 삭제 처리 :"+status;
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
		},
		movePage:function(page)
		{
			var query = "page="+page;
			if(period != null)
			{
				query += "&startYmd=" + period.startYmd + "&endYmd=" + period.endYmd;
			}
			if(searchCategory != null && searchCategory!= '')
			{
				query +="&searchCategory=" + searchCategory;
				query +="&searchName=" + searchName;

			}
			document.location.hash = "#" + query;
		},
		detail:function(companyId) {
			location.href = "/pc/company/companyDetailPage/"+companyId+"/"+userId;
		}
}

</script>
</head>


<body>
	 <!--본문-->       
<div id="container"> 
	<div class="contents">
		<h2><span class="titel-text-sm">회원 관리 > 가입신청 ></span>가입신청 상세</h2>
		<fieldset>	
			<form name="" method="" action="" >	
				<legend>가입신청 상세</legend>	
				<table class="mytable2">
					<caption>가입신청 상세</caption>
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tr>
						<td class="tdbg01" scope="col">닉네임</td>
						<td class="tdbg02" id="nickName">${user.nickName}</td>                
					</tr>
					<tr>
						<td class="tdbg01" scope="col">소속</td>
						<td class="tdbg02" id="companyShop">${user.companyShopName}</td> 
					</tr>
					<tr>
						<td class="tdbg01" scope="col">등급</td>
						<td class="tdbg02" id="userType"></td>                
					</tr>
					<tr>
						<td class="tdbg01" scope="col">SNS</td>
						<td class="tdbg02" id="snsType">${user.snsType}</td> 
					</tr>
					<tr>
						<td class="tdbg01" scope="col">연락처</td>
						<td class="tdbg02" id="phone">${user.phone}</td> 
					</tr>
					<tr>
						<td class="tdbg01" scope="col">이메일</td>
						<td class="tdbg02" id="email">${user.email}</td> 
					</tr>
					<tr>
						<td class="tdbg01" scope="col">신청용량</td>
						<td class="tdbg02" id="storageSize"></td> 
					</tr>
					<tr>
						<td class="tdbg01" scope="col">가입일</td>
						<td class="tdbg02" id="createDate">${user.createDate}</td> 
					</tr>
				
				</table>
			</form>
		</fieldset>
		<div class="paging">
			<button type="button" id="updateBtn" class="pagebtn2" confirmUserId="${confirmUserId}" userId="${user.userId}"><span class="btntxt">승인하기</span>
			</button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
		</div>
<!-- //CONTENT -->
	</div>

<!-- //CONTAINER -->
</div>



</body>
</html>