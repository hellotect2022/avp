<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>소속상세</title>


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
var dc = null;
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("companyId"));
	});
	if("SELLER" != "${userType}")
	{
		$(".commBtn").show();
	}
	else if("SELLER" == "${userType}")
	{
		$("#shopName").text("${shop.shopName}")
		$(".shopCommon").show();
	}
	$("#cancelBtn").click(function(){
		history.back();
	});
	$("#deleteBtn").click(function(){
		FN.companyDel($(this).attr("companyId"));
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
		companyDel : function(companyId)
		{
			$.ajax( "/pc/company/companyDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"companyId":companyId,
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("삭제성공")
					location.href = "/pc/company/companyListPage?userId="+userId;

			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/company/companyDelete :"+status;
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
		moveUpdatePage: function(companyId)
		{
// 			location.href = "/pc/company/companyUpdatePage?companyId="+companyId;
			location.href = "/pc/company/companyUpdatePage";
		},
		insert : function ()
		{
			$.ajax( "/pc/company/companyInsert",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(company),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
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
		        		alert("삭제 실패하였습니다.");
		       		}
		        }   
			});
		}
}

</script>
<body>
<div id="wrap">
       
   
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">소속관리 > 소속목록 > </span>소속상세</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>상점상세</legend>	
					<table class="mytable2">
						<caption>상점상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">소속회사</td>
							<td class="tdbg02" id="companyName">${company.companyName} </td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">소속 설명</td>
							<td class="tdbg02" id="companyDesc">${company.companyDesc} </td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">지점</td>
							 <td class="tdbg02" id="companyBranch">${company.companyBranch}</td> 
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">주소</td>
							 <td class="tdbg02" id="companyLocation">${company.companyLocation}</td> 
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">상점수</td>
							<td class="tdbg02" id="companyLocation">${company.shopCount}</td> 
						</tr>
						
				
					</table>
				</form>
			</fieldset>
 <div class="paging">
 <button type="button" id="updateBtn" class="pagebtn2" style="display: none;" companyId="${company.companyId}" ><span class="btntxt">수정</button> 
  <button type="button" id="deleteBtn" class="pagebtn2" style="display: none;" companyId="${company.companyId}" ><span class="btntxt">삭제</button> 
  <button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
  </div> 
</div>

<!-- //CONTAINER -->
 	</div>
</div>
    


</body>
</html>