<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>지점 상세 | smartconvergence</title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>
<script type="text/javascript">
var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var x = "${branch.shopXLocation}";
var y = "${branch.shopYLocation}";
$(document).ready(function(){
	 $("input:text").val("test1");
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("branchId"));
	});
	$("#cancelBtn").click(function(){
		history.back();
	});
	$("#deleteBtn").click(function(){
		if(!confirm("정말로 삭제하시겠습니까?"))
		{
			return;	
		}
		FN.dialogShow();
		FN.delShop($(this).attr("branchId"));
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
		delShop : function(shopId){
			$.ajax( "/pc/shop/shopDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"shopId":shopId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
					alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/shop/shopListPage"
			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/shop/shopDelete :"+status;
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
		moveUpdatePage : function(branchId)
		{
			location.href = "/pc/shop/shopUpdatePage?branchId="+branchId

		},
		insert : function(){
		    //ajax form submit
		    $("#frm").ajaxForm({
		            beforeSubmit: function (data,form,option) {
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
		                //성공후 서버에서 받은 데이터 처리
						location.href = "/pc/shop/shopListPage"
		            },
		            error: function(){
		                //에러발생을 위한 code페이지
		            }                              
		        }).submit();
	}
}

</script>
 
</head>
<div id="wrap">
       
  		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">소속 관리 > 지점 목록 > </span>지점 상세</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>지점 상세</legend>	
					<table class="mytable2">
						<caption>지점 상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">소속명</td>
							<td class="tdbg02">${branch.companyName}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">지점명</td>
							<td class="tdbg02">${branch.branchName}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">주소</td>
							<td class="tdbg02">${branch.branchAddr}</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">인원 수</td>
							<td class="tdbg02">${branch.userCount}</td>                
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" branchId="${branch.branchId}">
					<span class="btntxt">수정</span>
				</button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="deleteBtn" class="pagebtn2" branchId="${branch.branchId}">
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