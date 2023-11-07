<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>권한신청</title>


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
	
	
	var userType =	"${user.userType}";

	if("ADMIN"	==	userType)
		{
			$("#userType").text("관리자")
		}
		else if("SELLER"	==	userType)
		{
			$("#userType").text("판매자")
		}
		else if("NORMAL"	==	userType)
		{
			$("#userType").text("일반 사용자")
		}
		
	var memberViewAuth 		=	"${user.memberViewAuth}";
	var shopUpdateAuth 		=	"${user.shopUpdateAuth}";
	var productUpdateAuth	=	"${user.productUpdateAuth}";
	
	if("Y"	==	memberViewAuth)
	{
		$("#memberViewAuth").text("신청함");
	}
	if("Y"	==	shopUpdateAuth)
	{
		$("#shopUpdateAuth").text("신청함");
	}
	if("Y"	==	productUpdateAuth)
	{
		$("#productUpdateAuth").text("신청함");
	}
	
	$("#updateBtn").click(function(){
	     if(!confirm("수정하시겠습니까??"))
			{
				return false;	
			}	
			FN.dialogShow();
			FN.dataSet($(this).attr("userId"));
			FN.update($(this).attr("userId"));
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
		dataSet:function(userId)
		{
			param.userId	=	userId;
			if($("#memberViewAuth").is(":checked"))
			{
				param.memberViewAuth	=	"Y"	
			}
			else
			{
				param.memberViewAuth	=	"N"	
			}
			
			if($("#shopUpdateAuth").is(":checked"))
			{
				param.shopUpdateAuth	=	"Y"	
			}
			else
			{
				param.shopUpdateAuth	=	"N"	
			}
			
			if($("#productUpdateAuth").is(":checked"))
			{
				param.productUpdateAuth	=	"Y"	
			}
			else
			{
				param.productUpdateAuth	=	"N"	
			}
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
			$.ajax( "/pc/member/memberAuthApplyConfirmUpdate",{
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
			 		alert("수정 완료하였습니다.");
			 		location.href = "/pc/member/memberListPage";
// 			 		var users = data.response.body.users;
			 		//기존 row들 삭제
			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/member/memberAuthApplyConfirmUpdate :"+status;
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
<div id="wrap">
	<div id="container">
		<div class="contents">
			<h2><span class="titel-text-sm">멤버 관리 > 권한신청대기 ></span>상세</h2>
			
			<fieldset>
				<form name="" method="" action="">
					<legend>신청상세</legend>
					<table class="mytable2">
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr> 
							<td class="tdbg01" scope="col">등급</td> 
							<td id="userType" class="tdbg02"></td> 
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">닉네임</td> 
							<td id="nickName" class="tdbg02">${user.nickName}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">소속</td> 
							<td id="companyShop" class="tdbg02">${user.companyShopName}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">핸드폰</td> 
							<td id="phone" class="tdbg02">${user.phone}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">가입일</td> 
							<td id="createDate" class="tdbg02">${user.createDate}</td> 
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">멤버 보기 권한</td> 
							<td id="memberViewAuth" class="tdbg02"></td> 
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">상점 수정 권한</td> 
							<td id="shopUpdateAuth" class="tdbg02"></td> 
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">상품 수정 권한</td> 
							<td id="productUpdateAuth" class="tdbg02"></td> 
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" userId="${user.userId}">
					<span class="btntxt">권한승인</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2">
					<span class="btntxt">뒤로가기</span>
				</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>