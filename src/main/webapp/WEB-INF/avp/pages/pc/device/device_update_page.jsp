<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>디바이스 수정 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var device = "${device}";
var companyId = "${user.companyId}";
var userType = "${user.userType}";
var branchId = "${device.branchId}";
$(document).ready(function(){

	$("#updateBtn").click(function(){
		FN.update();
	});
	$("#backBtn").click(function(){
		history.back();
	});

	if(userType == "ADMIN") {
		$("#forAdmin").show();
		$("#forWorker").hide();
		
		FN.dialogShow();
	    FN.getShopList();
	} else {
		$("#forAdmin").hide();
		$("#forWorker").show();
	}

	$("#branchSel").on('change', function() {
		$("#branchId").val($(this).val());
	});
	
	FN.dialogShow();
});

var FN = {
		errorLogInsert : function(status){
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
		dialogShow : function(){
			var width = $(document).width();
			var height = $(document).height();  
//			var height = $(window).height();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		update : function(){
			    //ajax form submit
			    $("#frm").ajaxForm({
			            beforeSubmit: function (data,form,option) {
			            	
			            	console.log(data);
			            	console.log("form ::" + form);
			            	console.log("option ::" + option);
			            	   				     		
			            	if(!$("#branchSel").val().trim().length > 0)
			        		{
			        			alert("지점을 선택해 주세요.");
			        			return false;
			        		}
			            	
							if(!$("#deviceName").val().trim().length > 0)
							{
			            		alert("디바이스 명을 입력해주세요.");
								return false;
							}
							
			            	if(!$("#serial").val().trim().length > 0)
							{
								alert("일련번호를 입력해주세요.");
								return false;
							}
			            				            	
			        		if(!confirm("수정하시겠습니까?"))
							{
								return false;	
							}
			        		FN.dialogShow();
			                //validation체크
			                //막기위해서는 return false를 잡아주면됨
			                return true;
			            },
			            success: function(data,status){
			            	console.log(data)
			            	console.log(status)
					 		if( 200 != data.response.header.statusCode){
					 			alert(data.response.header.statusMessage);
					 			$(".backLayer").hide();
					 			return;	
					 		}
			                //성공후 서버에서 받은 데이터 처리
			                alert("정상적으로 수정 되었습니다.");
			                location.href = "/pc/device/deviceListPage"
			            },
			            error: function(result, status){
							var  statusStr = "작업리스트 등록 처리 :"+status;
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
			        }).submit();

	},
	getShopList	   : function()
	{
		$.ajax( "/pc/shop/companyShopList",{
		 	type : "POST", //"POST", "GET"
			dataType :  "json", //전송받을 데이터의 타입
			data : JSON.stringify({
				"pageInfo":null,
				"searchCategory":null,
				"searchName":null,
				"period":null,
				"companyId":companyId,
				"userType":userType
			}),
			timeout : 20000, //제한시간 지정
		 	contentType: "application/json; charset=UTF-8",
		 	success: function(data){
		 		if( 200 != data.response.header.statusCode){
		 			alert(data.response.header.statusMessage);
		 			return;	
		 		}
		 		var branches = data.response.body.branches;
		 		
		 		console.log(branches)
				$("#branchSel .row").detach();

		 		$(branches).each(function(i){
			 		var op = null;
			 		if(branches[i].branchId == branchId) {
			 			op = new Option(branches[i].branchName,branches[i].branchId, true, true);
				 	} else {
				 		op = new Option(branches[i].branchName,branches[i].branchId);
				 	}

		 			op.className = "row";

		 			$("#branchSel").append(op);
		 			
		 		});
		 		$(".backLayer").hide();
		 	},
		 	error: function(result, status){
	        	if(result.responseText)
	        	{
	        		var response = JSON.parse(result.responseText);
	        		//에러발생을 위한 code페이지
	            	alert(response.response.header.statusMessage);
	        	}
	        	else
	       		{
	        		alert("리워드 목록 조회 중 에러가 발생했습니다.");
	       		}
	        }   
		});
	}
}
</script>
</head>

<body>

<div id="wrap">
		  <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">디바이스 관리 > 디바이스 목록 > 디바이스 상세 > </span>디바이스 수정</h2>

			<fieldset>	
				<form id="frm" name="" method="post" action="/pc/device/deviceUpdate">
					<input type="hidden" id="branchId" name="branchId" value="${device.branchId}"/>
					<input type="hidden" id="deviceId" name="deviceId" value="${device.deviceId}"/>
					<legend>디바이스 수정</legend>	
					<table id="deviceUpdateTable" class="mytable2">
						<caption>디바이스 수정</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">지점명</td>
							<td id="forAdmin" class="tdbg02">
								<select title="" id="branchSel" name="">
									<option value="">지점을 선택하세요</option>
								</select>
							</td>
							<td id="forWorker" class="tdbg02">
								${user.branchName}
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">디바이스명</td>
							<td class="tdbg02">
								<input type="text" id="deviceName" name="deviceName" required="required" value="${device.deviceName}" maxlength="20" style="width:510px;"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">일련번호</td>
							<td class="tdbg02">
								<input type="text" id="serial" name="serial" required="required" value="${device.serial}" maxlength="20" style="width:510px;"/>
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2"><span class="btntxt">저장</span></button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="backBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    
</body>
</html>
