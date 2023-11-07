<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>상품 등록 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var user = "${user}";
var userType = "${userType}";
var companyId = "${user.companyId}";
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#insertBtn").click(function(){
		if(confirm("등록하시겠습니까?")) {
			FN.insert();
		}
	});
    
	$("#cancelBtn").click(function(){
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
		$("#branchId").val(user.branchId);
	}

	$("#zoneSel").on('change', function() {
		$("#zone").val($(this).val());
	});
	
	FN.setBarcodeList();
	FN.getZoneList();
	
	// Select Tag on Change function
	$("#branchSel").on('change', function() {
		$("#branchId").val($(this).val());
	});

	$("#barcodeTypeSel").on('change', function() {
		$("#barcodeType").val($("#barcodeTypeSel option:selected").text());
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

				 		op = new Option(branches[i].branchName,branches[i].branchId);

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
		},
		setBarcodeList : function() {
			var barcodeList = "${barcodeList}";
			var substringList = barcodeList.substring(1, barcodeList.length - 1);
			var splitedList = substringList.split(',');

			console.log("barcodeList:::"+barcodeList);
			console.log("substringList:::"+substringList);
			console.log("splitedList:::"+splitedList);
			
			$("#barcodeTypeSel .row").detach();
			
			$(splitedList).each(function(i) {
				var op = null;
				var trimStr = splitedList[i].trim();
				if(trimStr == barcodeType) {
					op = new Option(trimStr, i, true, true);
				} else {
					op = new Option(trimStr, i);
				}
				op.className = "row";

				$("#barcodeTypeSel").append(op);
			});				
		},
		getZoneList : function()
		{
			$.ajax( "/pc/zone/zoneList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : null,
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var zone = data.response.body.zone;
			 		
			 		console.log(zone)
					$("#zoneSel .row").detach();

			 		$(zone).each(function(i){
				 		var op = null;

				 		op = new Option(zone[i].zone, zone[i].zone);

			 			op.className = "row";

			 			$("#zoneSel").append(op);
			 			
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
		        		alert("목록 조회 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
		insert : function(){
		    //ajax form submit
		    $("#frm").ajaxForm({
		            beforeSubmit: function (data,form,option) {
		            	
		            	if(!$("#branchSel").val().trim().length > 0)
		        		{
		        			alert("지점을 선택해 주세요.");
		        			return false;
		        		}
		        		
		        		if(!$("#itemName").val().trim().length > 0)
		        		{
		        			alert("상품명을 입력해 주세요.");
		        			return false;
		        		}
		        		
		        		if(!$("#barcode").val().trim().length > 0)
		        		{
		        			alert("바코드 정보를 입력해 주세요.");
		        			return false;
		        		}
		        		if(!$("#barcodeTypeSel").val().trim().length > 0)
		        		{
		        			alert("바코드 종류를 선택해 주세요.");
		        			return false;
		        		}
		        		
		        		if(!$("#zone").val().trim().length > 0)
		        		{
		        			alert("존 위치를 입력해 주세요.");
		        			return false;
		        		}

		        		if(!$("#local").val().trim().length > 0)
		        		{
		        			alert("로컬 위치를 입력해 주세요.");
		        			return false;
		        		}

		        		if(!$("#location").val().trim().length > 0)
		        		{
		        			alert("로케이션 위치를 입력해 주세요.");
		        			return false;
		        		}
		        		
		        		FN.dialogShow();
		            	console.log(data);
		            	console.log("form ::" + form);
		            	console.log("option ::" + option);
		                //validation체크
		                //막기위해서는 return false를 잡아주면됨
		                return true;
		            },
		            success: function(data,status){
		            	console.log(data)
		            	console.log(status)
				 		if( 200 != data.response.header.statusCode){
				 			alert(data.response.header.statusMessage);
				 			return;	
				 		}
		            	alert("정상적으로 등록되었습니다.");
		                //성공후 서버에서 받은 데이터 처리
		            	location.href = "/pc/product/productListPage"
		            },
		            error: function(result, status){
				 		var  statusStr = "상품 등록 :"+status;

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
	}
}
</script>
</head>

<body>
	
<div id="wrap">
        
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">상품 관리 > </span>상품 등록</h2>

			<fieldset>	
				<form name="" id="frm" action="/pc/product/productInsert" method="post">
					<input type="hidden" id="branchId" name="branchId"/>
					<input type="hidden" id="barcodeType" name="barcodeType"/>	
					<legend>상품등록</legend>
					<table class="mytable2">
						<caption>상품등록</caption>
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
							<td class="tdbg01" scope="col">상품명</td>
							<td class="tdbg02">
								<input type="text" id="itemName" name="itemName" maxlength="180" style="width:700px;"/>
							</td>  
						</tr>
						<tr>
							<td class="tdbg01" scope="col">바코드</td>
							<td class="tdbg02">
								<input type="text" id="barcode" name="barcode" maxlength="180" style="width:700px;"/>
							</td>  
						</tr>
						<tr>
							<td class="tdbg01" scope="col">바코드 종류</td>
							<td class="tdbg02">
								<select title="" id="barcodeTypeSel" name="">
									<option value="">바코드 종류를 선택하세요</option>
								</select>
							</td>  
						</tr>
						<tr>
							<td class="tdbg01" scope="col" rowspan="3">위치</td>
							<td class="tdbg02">
								ZONE
								<select title="" id="zoneSel" name="">
									<option value="" selected="selected">선택</option>								
								</select>
								<input type="hidden" id="zone" name="zone"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg02">
								LOCAL
								<input type="text" id="local" name="local" maxlength="180" style="width:700px;"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg02">
								LOCATION
								<input type="text" id="location" name="location" maxlength="180" style="width:700px;"/>
							</td>
						</tr>						
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="insertBtn" class="pagebtn2"><span class="btntxt">등록</span></button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    
      
</body>
</html>
