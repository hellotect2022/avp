<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>지점 등록 | smartconvergence</title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>

<script type="text/javascript">

var branchData = {
		branchName : null,
		branchAddr : null
}
$(document).ready(function(){
//     FN.dialogShow()
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	$("#insertBtn").click(function(){
		if(FN.valid()) {

			if(confirm("등록 하시겠습니까?")) {
			
				FN.dataSet();

				console.log("NAME ::: " + branchData.branchName);
				console.log("Addr ::: " + branchData.branchAddr);
				
				FN.insert();

			}
		}
	});
		
	$("#cancelBtn").click(function(){
		FN.moveCancelPage();
	});
	
});
var FN = 
{
		valid : function() {
			if("" == $("#branchName").val()) {
				alert("지점명을 입력해주세요.");
				return false;
			}

			if("" == $("#branchAddr").val()) {
				alert("주소를 입력해주세요.");
				return false;
			}

			return true;
		},
		dataSet : function() {
			branchData.branchName = $("#branchName").val();
			branchData.branchAddr = $("#branchAddr").val();
		},
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
		moveCancelPage: function()
		{
			history.back();
		},
		insert : function(){
			$.ajax("/pc/shop/shopInsert", {
				type : "POST",
			    dataType : "json",
			    data : JSON.stringify(branchData),
			    contentType : "application/json; charset=UTF-8",
			    success: function(data){
	            	console.log(data)
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
	            	alert("정상적으로 등록 되었습니다.");
	                //성공후 서버에서 받은 데이터 처리
					location.href = "/pc/shop/shopListPage"
	            },
				 error: function(result, status){
			 		var  statusStr = "/pc/shop/shopUpdate :"+status;
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
       
   
		  <!--본문   -->   
	<div id="container"> 
		<div class="contents">
				<h2><span class="titel-text-sm">소속 관리 > </span>지점 등록</h2>

				<fieldset>	
					<form name="" action="" method="">	
						<legend>지점 등록</legend>	
						<table class="mytable2">
							<caption>지점 등록</caption>
							<colgroup>
								<col width="20%"/>
								<col width="80%"/>
							</colgroup>
							<tr>
								<td class="tdbg01" scope="col">소속명</td>
								<td class="tdbg02">${companyShopName}</td>
							</tr>
							<tr>
								<td class="tdbg01" scope="col">지점명</td>
								<td class="tdbg02">
									<input type="text" id="branchName" name="branchName" maxlength="25" style="width:700px;"/>
								</td>
							</tr>
							<tr>
								<td class="tdbg01" scope="col">주소</td>
								<td class="tdbg02">
									<input type="text" id="branchAddr" name="branchAddr" maxlength="180" style="width:700px;"/>
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