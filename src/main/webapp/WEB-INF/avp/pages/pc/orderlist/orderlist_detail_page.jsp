<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>작업리스트 상세 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var user = "${user}";
var userType = "${userType}";
var companyId = "${user.companyId}";
var updateYn = "${updateYn}";
$(document).ready(function(){	

	$("#updateBtn").click(function(){
		FN.movePage($(this).attr("orderlistId"));
	});
	$("#deleteBtn").click(function(){
		if(!confirm("정말로 삭제하시겠습니까?"))
		{
			return;
		}
		FN.dialogShow();
		FN.orderlistDel($(this).attr("orderlistId"));
	});
	$("#cancelBtn").click(function(){
		history.back();
	});

	if(updateYn == "Y") {
		$("#updateBtn").show();
		$("#deleteBtn").show();
	} else {
		$("#updateBtn").hide();
		$("#deleteBtn").hide();
	}

});

var FN = {
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
		orderlistDel : function(orderlistId, userId)
		{
			$.ajax( "/pc/orderlist/orderlistDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"orderlistId":orderlistId,
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/orderlist/orderlistListPage";

			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/orderlist/orderlistDelete:"+status;
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
		movePage : function(orderlistId)
		{
			location.href = "/pc/orderlist/orderlistUpdatePage?orderlistId="+orderlistId

		},
}
</script>
</head>

<body>
 <div id="wrap">

		  <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">작업리스트 관리 > 작업리스트 목록 > </span>작업리스트 상세</h2>

			<fieldset>	
				<form id="" name="" method="" action="">
					<legend>작업리스트 상세</legend>	
					<table id="orderlistInsertTable" class="mytable2">
						<caption>작업리스트 상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">작업일자</td>
							<td class="tdbg02">
								<span id="startDt">${orderlist.startDt}</span> ~ 
								<span id="endDt">${orderlist.endDt}</span>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">작업명</td>
							<td class="tdbg02">${orderlist.orderlistName}
							</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">할당디바이스</td>
							<td class="tdbg02">
								${orderlist.deviceName}
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">상품</td>
							<td class="tdbg02">
								${orderlist.itemNames}
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">수량</td>
							<td class="tdbg02">
								${orderlist.quantities}
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등록자</td>
							<td class="tdbg02">${orderlist.createUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등록일</td>
							<td class="tdbg02">${orderlist.createDttm}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">수정자</td>
							<td class="tdbg02">${orderlist.updateUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">최종수정일</td>
							<td class="tdbg02">${orderlist.updateDttm}</td>               
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" orderlistId="${orderlist.orderlistId}">
					<span class="btntxt">수정</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="deleteBtn" class="pagebtn2" orderlistId="${orderlist.orderlistId}">
					<span class="btntxt">삭제</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2">
					<span class="btntxt">취소</span>
				</button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    
</body>
</html>
