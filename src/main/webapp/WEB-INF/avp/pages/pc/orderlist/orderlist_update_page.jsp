<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>작업리스트 수정 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var user = "${user}";
var userType = "${user.userType}";
var companyId = "${user.companyId}";
var deviceId = "${orderlist.deviceId}";
var branchId = "${orderlist.branchId}";
var itemIdsArr = null;
var qtyArr = null;
var items = null;
$(document).ready(function(){	

	itemIdsArr = "${orderlist.itemIds}".split(',');
	qtyArr = "${orderlist.quantities}".split(',');
	
	$("#updateBtn").click(function(){
		FN.setData();
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
		FN.dialogShow();
		FN.getItemList($(this).val());
	});

	$("#deviceSel").on('change', function() {
		$("#deviceId").val($(this).val());
	});
	
	// 체크박스 변동 시 진입
	$(document).on("change","[type=checkbox]",function(){
		var chkValue = $(this).val();
	    var isCheck = $(this).is(":checked");
	    var chkId	=	$(this).attr('id');

		console.log("ID:::" + chkId);
		
	    // 체크박스 체크 시 수량 입력 input 동적 생성
	    if (isCheck) {
	    	var inp = $("<p id='qty" + chkValue + "' style='white-space:pre;'>" + chkValue + "&#9;&#9;<input type='text' id='" + chkId + "' name='qty' value='0'/></p>");

		    $("#dynamicInput").append(inp);
	    } 
		// 체크박스 체크 해제 시 수량 입력 input 동적 제거
	    else {
	    	$("#qty" + chkValue).remove();
	    }
	});
	
	$(".date_format_start").datepicker({     
		showMonthAfterYear:true
			, monthNames:['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월']
			, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			, dayNamesMin: ['일','월','화','수','목','금','토']
			, weekHeader: 'Wk'
			, dateFormat: 'yy-mm-dd'
			//, beforeShowDay: no_view
	});
	
	$(".date_format_end").datepicker({     
		showMonthAfterYear:true
			, monthNames:['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월']
			, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			, dayNamesMin: ['일','월','화','수','목','금','토']
			, weekHeader: 'Wk'
			, dateFormat: 'yy-mm-dd'
			//, beforeShowDay: no_view
	});

	$("#startDt").datepicker("option", "onClose", function ( selectedDate ) {
		$("#endDt").datepicker("option", "minDate", selectedDate);
		var stDate = selectedDate.split("-");
	     var dt = new Date(stDate[0], stDate[1], stDate[2]);
	     
	     var year = dt.getFullYear(); // 년도 구하기  
	     var month = dt.getMonth() + 1; // 한달뒤의 달 구하기  
	     var month = month + ""; // 문자형태  
	     if(month.length == "1") var month = "0" + month; // 두자리 정수형태  
	
	     var day = dt.getDate(); 
	     var day = day + ""; 
	     
	     if(day.length == "1") var day = "0" + day;  
	
	     var nextMonth = year + "-" + month + "-" + day;
	       
	     $("#endDt").datepicker( "option", "maxDate", nextMonth);
	});

	$('.date_format_start').val($.datepicker.formatDate('yy-mm-dd', dateParse('${orderlist.startDt}')));
	$('.date_format_end').val($.datepicker.formatDate('yy-mm-dd', dateParse('${orderlist.endDt}')));

	FN.dialogShow();
	FN.getDeviceList();
});

function dateParse(str) {
	var y = str.substr(0,4);
    var m = str.substr(4,2) - 1;
    var d = str.substr(6,2);
	return new Date(y,m,d);
}

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
		setData : function() {
			var items = "";
			var qty = "";

			$('input[name="qty"]').each(function(index) {
				var itemId = $(this).attr('id');
				items = items + itemId + ",";
				
				var qtyValue = $(this).val();
				qty = qty + qtyValue + ",";
			});

			items = items.substring(0, items.length - 1);
			qty = qty.substring(0, qty.length - 1);

			console.log("ITEMID ::: " + items);
			console.log("QTY ::: " + qty);
			
			$("#itemIds").val(items);
			$("#quantities").val(qty);
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
			            	
							if(!$("#startDt").val().trim().length > 0)
							{
			            		alert("시작 일을 선택해 주세요.");
								return false;
							}
							
			            	if(!$("#endDt").val().trim().length > 0)
							{
								alert("마감 일을 선택해 주세요.");
								return false;
							}

			        		if(!$("#orderlistName").val().trim().length > 0)
			            	{
			            		alert("작업 이름을 입력해 주세요.");
			            		return false;
			            	}
			        		
			            	if(!$("#deviceSel").val().trim().length > 0)
							{
								alert("디바이스를 선택해 주세요.");
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
			                location.href = "/pc/orderlist/orderlistListPage"
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
		 		FN.getItemList(branchId);
		 		//$(".backLayer").hide();
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
	},
	getDeviceList	   : function()
	{
		$.ajax( "/pc/device/deviceList",{
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
		 		var devices = data.response.body.devices;
		 		
		 		console.log(devices)
				$("#deviceSel .row").detach();

		 		$(devices).each(function(i){
			 		var op = null;

			 		if(devices[i].deviceId == deviceId) {
			 			op = new Option(devices[i].deviceName, devices[i].deviceId, true, true);
			 		} else {
			 			op = new Option(devices[i].deviceName, devices[i].deviceId);
			 		}

		 			op.className = "row";

		 			$("#deviceSel").append(op);
		 			
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
	},
	getItemList : function(branchId)
	{
		$.ajax( "/pc/product/productListByBranch",{
		 	type : "POST", //"POST", "GET"
			dataType :  "json", //전송받을 데이터의 타입
			data : JSON.stringify({
				"pageInfo":null,
				"searchCategory":null,
				"searchName":null,
				"period":null,
				"branchId":branchId
			}),
			timeout : 90000, //제한시간 지정
		 	contentType: "application/json; charset=UTF-8",
		 	success: function(data){
			 	console.log(data);
		 		if( 200 != data.response.header.statusCode){
		 			alert(data.response.header.statusMessage);
		 			return;	
		 			$(".backLayer").hide();
		 		}
		 		items = data.response.body.products;

				$("#dynamicChk .items").detach();

		 		$(items).each(function(i){

		 			var isExist = false;
		 			
			 		$(itemIdsArr).each(function(j){
			 			if(itemIdsArr[j] == items[i].itemId) {
				 			isExist = true;
			 			}
				 	});

			 		if(isExist) {
			 			var inp = $("<p><label for='" + items[i].itemId + "' style='cursor:pointer'><input type='checkbox' id='" + items[i].itemId + "' name='items' class='items' value='" + items[i].itemName + "' checked='checked'>" + items[i].itemName + "</label></p>");
			 		} else {
			 			var inp = $("<p><label for='" + items[i].itemId + "' style='cursor:pointer'><input type='checkbox' id='" + items[i].itemId + "' name='items' class='items' value='" + items[i].itemName + "'>" + items[i].itemName + "</label></p>");
				 	}
				 	
				    $("#dynamicChk").append(inp);
				    
		 		});
		 		FN.setQty();
		 		//$(".backLayer").hide();
		 	},
		 	error: function(result, status){
				var  statusStr = "AR 상점목록 가져오기 :"+status;
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
	setQty : function() {
		var itemName = null;
		$(itemIdsArr).each(function(i){
			$(items).each(function(j){
				if(itemIdsArr[i] == items[j].itemId) {
					itemName = items[j].itemName;
				}
			});
			var inp = $("<p id='qty" + itemName + "' style='white-space:pre;'>" + itemName + "&#9;&#9;<input type='text' id='" + itemIdsArr[i] + "' name='qty' value='" + qtyArr[i] + "'/></p>");

		    $("#dynamicInput").append(inp);
		});
		$(".backLayer").hide();
	}
}
</script>
</head>

<body>
 <div id="wrap">

		  <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">작업리스트 관리 > 작업리스트 목록 > 작업리스트 상세 > </span>작업리스트 수정</h2>

			<fieldset>	
				<form id="frm" name="" method="post" action="/pc/orderlist/orderlistUpdate">
					<input type="hidden" id="orderlistId" name="orderlistId" value="${orderlist.orderlistId}"/>
					<input type="hidden" id="branchId" name="branchId" value="${orderlist.branchId}"/>
					<input type="hidden" id="deviceId" name="deviceId" value="${orderlist.deviceId}"/>
					<input type="hidden" id="itemIds" name="itemIds"/>
					<input type="hidden" id="quantities" name="quantities"/>
					<legend>작업리스트 수정</legend>	
					<table id="orderlistUpdateTable" class="mytable2">
						<caption>작업리스트 수정</caption>
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
							<td class="tdbg01" scope="col">작업일자</td>
							<td class="tdbg02">
								<input id="startDt" name="startDt" type="text" class="date_format_start"/> ~ 
								<input id="endDt" name="endDt" type="text" class="date_format_end"  />
							</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">작업명</td>
							<td class="tdbg02">
								<input type="text" id="orderlistName" name="orderlistName" value="${orderlist.orderlistName}" required="required" maxlength="20" style="width:510px;"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">할당디바이스</td>
							<td class="tdbg02">
								<select title="" id="deviceSel" name="deviceId">
									<option value="" selected="selected">선택</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">상품선택</td>
							<td id="dynamicChk" class="tdbg02">
								
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">수량입력</td>
							<td id="dynamicInput" class="tdbg02">
								
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
