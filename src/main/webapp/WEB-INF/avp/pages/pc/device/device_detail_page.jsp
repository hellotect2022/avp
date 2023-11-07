<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>디바이스 상세 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var updateYn = "${updateYn}";
$(document).ready(function(){	

	$("#updateBtn").click(function(){
		FN.movePage($(this).attr("deviceId"));
	});
	$("#deleteBtn").click(function(){
		if(!confirm("정말로 삭제하시겠습니까?"))
		{
			return;
		}
		FN.dialogShow();
		FN.deviceDel($(this).attr("deviceId"));
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
		deviceDel : function(deviceId)
		{
			$.ajax( "/pc/device/deviceDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"deviceId":deviceId,
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/device/deviceListPage";

			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/device/deviceDelete:"+status;
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
		movePage : function(deviceId)
		{
			location.href = "/pc/device/deviceUpdatePage?deviceId=" + deviceId
		},
}
</script>
</head>

<body>
 <div id="wrap">

		  <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">디바이스 관리 > 디바이스 목록 > </span>디바이스 상세</h2>

			<fieldset>	
				<form id="" name="" method="" action="">
					<legend>디바이스 상세</legend>	
					<table id="orderlistInsertTable" class="mytable2">
						<caption>디바이스 상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">지점명</td>
							<td class="tdbg02">${device.branchName}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">디바이스명</td>
							<td class="tdbg02">${device.deviceName}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">일련번호</td>
							<td class="tdbg02">${device.serial}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등록자</td>
							<td class="tdbg02">${device.createUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등록일</td>
							<td class="tdbg02">${device.createDttm}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">수정자</td>
							<td class="tdbg02">${device.updateUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">최종수정일</td>
							<td class="tdbg02">${device.updateDttm}</td>               
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" deviceId="${device.deviceId}">
					<span class="btntxt">수정</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="deleteBtn" class="pagebtn2" deviceId="${device.deviceId}">
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
