<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>AR 상세 | smartconvergence</title>

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
		FN.moveUpdatePage($(this).attr("ar"));
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
		FN.delAr($(this).attr("ar"));
	});
	console.log("AR:::::" + "${ar.arImgUrl}");
	console.log("RECOG:::::" + "${ar.recogImgUrl}");
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
		delAr : function(arId){
			$.ajax( "/pc/ar/arDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"arId":arId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/ar/arListPage"
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
		        		alert("상점 삭제중 에러가 발생했습니다.");
		       		}
		        }   
			});			
		},		
		moveUpdatePage: function(arId)
		{
			location.href = "/pc/ar/arUpdatePage?arId="+arId;
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
		}
}

</script>
</head>



<body>
	
 <div id="wrap">
       
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">AR 관리 > AR 목록 > </span>AR 상세</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>AR 상세</legend>	
					<table class="mytable2">
						<caption>AR 상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">상품명</td>
							<td class="tdbg02">${ar.itemName}</td> 
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 명</td>
							<td class="tdbg02">${ar.arName}</td>               
						</tr>	
						<tr>
							<td class="tdbg01" scope="col">AR 이미지</td>
							<td class="tdbg02">
								<div id="photoview">
									<img style="width:100%; height:auto; max-height:350px;" src="${ar.arImgUrl}"/>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 사이즈</td>
							<td class="tdbg02">${ar.arImgSize}</td> 
							<!-- <td class="tdbg02">${ar.arSize}</td>          -->
						</tr>
						<tr>
							<td class="tdbg01" scope="col">설명문</td>
							<td class="tdbg02">
								<textarea id="arScript" name="arScript" style="min-width:98%;width:98%;height:350px;max-height:500px;" readonly >${ar.arScript}</textarea>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 비디오</td>
							<td class="tdbg02">${ar.arVideoUrl}
								<!-- <input id="arVideo" type="file" name="arVideo" /> -->
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 비디오 사이즈</td>
							<td class="tdbg02">${ar.arVideoSize}</td> 
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR TTS</td>
							<td class="tdbg02">${ar.arTtsUrl}
								<!-- <input id="arTts" type="file" name="arTts" /> -->
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR TTS 사이즈</td>
							<td class="tdbg02">${ar.arTtsSize}</td> 
						</tr>
						<!-- <tr>
							<td class="tdbg01" scope="col">인식 이미지</td>
							<td class="tdbg02">
								<div id="photoview">
									<img style="width:100%; height:auto; max-height:350px;" src="${ar.recogImgUrl}"/>
								</div>
							</td>
						</tr> -->
						<tr>
							<td class="tdbg01" scope="col">등록자</td>
							<td class="tdbg02">${ar.createUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등록일</td>
							<td class="tdbg02">${ar.createDate}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">수정자</td>
							<td class="tdbg02">${ar.updateUser}</td>               
						</tr>
						<tr>
							<td class="tdbg01" scope="col">최종수정일</td>
							<td class="tdbg02">${ar.updateDate}</td>               
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" ar="${ar.arId}" class="pagebtn2"><span class="btntxt">수정</span></button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="deleteBtn" ar="${ar.arId}" class="pagebtn2"><span class="btntxt">삭제</span></button>
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