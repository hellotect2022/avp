<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">

var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var dc = null;
var userId	= "${userId}";
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	
	$("#udpaeteBtn").click(function(){
		FN.moveUpdatePage($(this).attr("userId"),$(this).attr("eventId"));
	});
	
	
	$("#deleteBtn").click(function(){
		FN.ProductDel($(this).attr("eventId"));
	});
	$("#cancelBtn").click(function(){
		history.back();
	});
	
	var data = "${event}";
	console.log(data)
	if("ING" == "${event.eventStatus}")
	{
		$(".statusGubun").text("진행중")
	}
	else if("PAUSE" == "${event.eventStatus}")
	{
		$(".statusGubun").text("일시정지")
	}
	else
	{
		$(".statusGubun").text("종료")
	}
	
	if("LOCATION" == "${event.eventType}")
	{
		$(".eventTypeGubun").text("위치")
		$(".eventDistance").text("${event.eventDistance}");
		$(".eventTypeLocation").show();
	}
	else
	{
		$(".eventTypeGubun").text("시간")
		$(".timeset").text("${event.eventStartHms}"+"~"+"${event.eventEndHms}");
		$(".eventTypeTarget").show();
	}
	
	
	$(".ymd").text("${event.startYmd}"+" ~ "+"${event.endYmd}");
	
	if("LOADINFORMATION" == "${event.eventAfterType}")
	{
		$(".eventAfterType").text("길안내");
		$(".loadType").text("${event.loadType}");
		$(".load").show();
	}else if("AFTEREVENT" == "${event.eventAfterType}")
	{
		$(".eventAfterType").text("후이벤트");
		$(".eventAfterType").text("${event.eventAfterType}");
		$(".banner").show();
	}
	
	FN.eventDetailList("${event.eventId}");
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
		ProductDel : function(eventId)
		{
			$.ajax( "/pc/event/eventDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"eventId":eventId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/event/eventListPage?userId="+userId;

			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/event/eventDelete :"+status;
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
		moveUpdatePage:function(userId,eventId) {
			location.href = "/pc/event/eventUpdatePage?eventId="+eventId
		},
		dataSet : function()
		{
			var list = "";
			var leng = $("#companyList .shopChk:checked").length-1;
			
			$("#companyList .shopChk:checked").each(function(idx){
					if(0 == leng )
					{
						list += $(this).val();
					}
					else
					{
						if(leng == idx)
						{
							list += $(this).val()
						}
						else
						{
							list += $(this).val()+",";
						}
					}
			});
			console.log(list)
			$("#shopList").val(list);
			
			$("#startYmd").val($("#startDay").val().replace(/-/g,"")) ;
			$("#endYmd").val($("#endDay").val().replace(/-/g,"")) ;
			
			if($(".tgGubun:checked").val() == "A"){
				$("#eventStartHms").val("000000") ;
				$("#eventEndHms").val("235959");
			}
			else
			{
				console.log($("#sTargetTime").val())
				console.log($("#eTargetTime").val())
				$("#eventStartHms").val($("#sTargetTime").val());
				$("#eventEndHms").val($("#eTargetTime").val());
			}
			
			
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
		 		if( 200 != event.response.header.statusCode){
		 			alert(event.response.header.statusMessage);
		 			return;	
		 		}
            	alert("정상 등록되었습니다.")
                //성공후 서버에서 받은 데이터 처리
				location.href = "/pc/evnet/eventListPage"
            },
            error: function(){
                //에러발생을 위한 code페이지
            }                              
        }).submit();
	},
	appendZero:function(number,digits){
		var zeroData = "0";
		var rtnData;
		if(number == 24){
			return "235959"
		}
		for(var i=1; i< digits; i++){
			zeroData += "0";
		}
		return number+zeroData;
	},
	changeTarGet : function(tag,data){
			
			switch (tag) {
			  case "tgGubun": 	
				  			if (data == "A") {
								$('.tgGubun[value=A]').prop('checked',true);
								$(".targetSet").attr("disabled", true);
								$('.targetSet').css("background-color","#f5f5f5");
							}else {
								$('.targetSet').attr("disabled", false);
								$('.targetSet').css("background-color","white");
							}
			               break;
			  case "cmpgnIngStatus"   : 
						  if (data == "ING") {
								$('.cmpgnIngStatus[value=ING]').prop('checked',true);
							}else {
								$('.cmpgnIngStatus[value=PAUSE]').prop('checked',true);
							}
			               break;
			  default    : console.log('체크박스 셋팅 에러');
			               break;
			}
		},
		eventDetailList : function(eventId)
		{
			$.ajax( "/pc/event/eventDetailList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
						"eventId" : eventId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		
			 		var list =	data.response.body.listData;
			 		var shopList =	data.response.body.listData;
			 		
			 		console.log(list)
			 		//기존 row들 삭제
			 		$("#companyList .row").detach();
				
			 		var companyChekId = 0;
			 		$(list).each(function(idx){
			 			var row;
			 				if(0 == idx)
			 				{
			 					row = $("#companyList .src_row").clone();
					 			$(row).removeClass("src_row");
					 			$(row).addClass("row");
					 			$(row).children().find(".companyName").text(list[idx].companyName);
					 			$(row).children().find(".companyChk").val(list[idx].companyId);
					 			$(shopList).each(function(i){
					 				console.log(list[idx])
					 				console.log(shopList[i])
					 				console.log(list[idx].companyId)
					 				console.log(shopList[i].companyId)
					 				if(list[idx].companyId == shopList[i].companyId)
					 				{
							 			var pRow = $(".src_row_p").clone();
		//	 			 				console.log(pRow)
							 			$(pRow).removeClass("src_row_p");
							 			$(pRow).addClass("prow");
						 				$(pRow).find(".shopName").text(shopList[i].shopName);
							 			$(pRow).find(".shopChk").val(shopList[i].shopId);
							 			$(pRow).css("display", "");
							 			
							 			$(pRow).find(".shopChk").click(function(){
							 				if($(".shopChk").not(':checked').length > 1){
							 					$(pRow).parent().prop('checked',false);
							 				}else{
							 					$(pRow).parent().prop('checked',true);
							 				}
							 			});
							 			$(row).find(".pDiv").append(pRow);
					 				}
					 			});
					 			companyChekId = list[idx].companyId
								$(row).css("display", "");
					 			$("#companyList").append(row);
					 			
			 				}
			 				else
			 				{
			 					if(companyChekId != list[idx].companyId)
			 					{
			 						row = $("#companyList .src_row").clone();
						 			$(row).removeClass("src_row");
						 			$(row).addClass("row");
						 			$(row).find(".companyName").text(list[idx].companyName);
						 			$(row).find(".companyChk").val(list[idx].companyId);
						 			$(shopList).each(function(i){
						 				console.log(list[idx])
						 				console.log(shopList[i])
						 				console.log(list[idx].companyId)
						 				console.log(shopList[i].companyId)
						 				if(list[idx].companyId == shopList[i].companyId)
						 				{
								 			var pRow = $(".src_row_p").clone();
			//	 			 				console.log(pRow)
								 			$(pRow).removeClass("src_row_p");
								 			$(pRow).addClass("prow");
							 				$(pRow).find(".shopName").text(shopList[i].shopName);
								 			$(pRow).find(".shopChk").val(shopList[i].shopId);
								 			$(pRow).css("display", "");
								 			
								 			$(pRow).find(".shopChk").click(function(){
								 				if($(".shopChk").not(':checked').length > 1){
								 					$(pRow).parent().prop('checked',false);
								 				}else{
								 					$(pRow).parent().prop('checked',true);
								 				}
								 			});
								 			$(row).find(".pDiv").append(pRow);
						 				}
						 			});
						 			companyChekId = list[idx].companyId
									$(row).css("display", "");
						 			$("#companyList").append(row);
			 					}
			 				}
				 			//click event
				 			$(row).css("display", "");
				 			$("#companyList").append(row);
				 			
			 			
			 		});
			 		

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
<div>이벤트 관리 > 이벤트 목록 > 이벤트 상세</div>
<div class="section">
	<div id="companyList">
		<p class="src_row_p" style="display: none;"><span class="shopName">dddd</span></p>
		<table > 
			<tr class="src_row" style="display: none;"> 
				<td>
					<span class="companyName">dd</span>
					<div class="pDiv" style="margin-left: 10px"></div>
				</td> 
			</tr>
		</table> 
	</div>
	<table> 
	<tr>
		<th colspan="1"> 진행상태</th>
		<td colspan="3">
			<span class="r_txt statusGubun">
			</span>
		</td>
	</tr>
	<tr>
		<th colspan="1">표출기준</th>
		<td colspan="3">
			<span class="r_txt eventTypeGubun" >
			</span>
		</td>
	</tr>
	<tr class="eventTypeGubunCommon eventTypeLocation" style="display: none;">
		<th >거리</th>
		<td class="eventDistance" >
		</td>
	</tr>
	<tr class="eventTypeGubunCommon eventTypeTarget" style="display: none;">
		<th colspan="1">Target Time</th>
		<td colspan="3">
			<div class="timeset">
			</div>
		</td>
	</tr>
	<tr>
		<th colspan="1"> 노출기간</th>
		<td colspan="3" class="ymd">
		</td>
	</tr>
	<tr>
	<th colspan="1">탬플릿</th>
	<td colspan="5">
		<span class="r_txt templateType">
		${event.templateType}
		</span>
	</td>
	</tr>
	<tr> 
	<th>이벤트 명</th> 
	<td>${event.templateTitle}</td>
	</tr>
	<tr> 
	<tr> 
	<th>이벤트 설명</th> 
	<td>${event.templateDesc}</td>
	</tr>
	<tr> 
	<th>이미지</th> 
	<td><img src="${event.templateImageUrl}" width="200px"></td> 
	</tr>
	<tr> 
	<th>취소 버튼명</th> 
	<td>${event.templateButtonCancelTitle}</td>
	</tr>
	<tr> 
	<th>확인 버튼명</th> 
	<td>${event.templateButtonConfirmTitle}</td>
	</tr>
	</table> 
	<table> 
	<tr> 
	<th>후 이벤트</th> 
	<td class="eventAfterType">
	</td>
	</tr>
	<tr class="afterCommon load" style="display: none;" > 
	<th colspan="1">지도종류</th>
	<td colspan="3" class="loadType"></td>
	</tr>
	<tr class="afterCommon banner" style="display: none;"  > 
	<th>탬플릿</th>
	<td colspan="3" class="eventAfterTemplateType">
	${event.eventAfterTemplateType}
	</td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트명</th> 
	<td class="eventAfterTitle">${event.eventAfterTitle}</td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트 설명</th> 
	<td class="eventAfterDesc">${event.eventAfterDesc}</td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트 파일 </th> 
	<td class="eventAfterFile">${event.eventAfterFileName}</td> 
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트 파일 타입</th> 
	<td class="eventAfterFileType">${event.eventAfterFileType}</td> 
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>확인버튼</th> 
	<td>${event.eventAfterButtonTitle}</td>
	</tr>
	
	<tr>
	 <td colspan="2">
	   <a id="deleteBtn" eventId="${event.eventId}" >삭제하기</a> 
	  <a id="udpaeteBtn" userId="${userId}" eventId="${event.eventId}" >수정하기</a> 
	  <a id="cancelBtn"  >취소</a> 
	  </td> 
	</tr>
	</table> 
	<!-- //sub_contents -->
</div>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>이벤트상세 </title>

<link href="../css/css1.css" rel="stylesheet" type="text/css">
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
var userId	= "${userId}";
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	
	$("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("userId"),$(this).attr("eventId"));
	});
	$("#deleteBtn").click(function(){
		if(!confirm("정말로 삭제하시겠습니까?"))
		{
			return;	
		}
		//FN.dialogShow();
		FN.ProductDel($(this).attr("eventId"));
	});
	$("#cancelBtn").click(function(){
		history.back();
	});
	
	var data = "${event}";
	console.log(data)
	if("ING" == "${event.eventStatus}")
	{
		$(".statusGubun").text("진행중")
	}
	else if("PAUSE" == "${event.eventStatus}")
	{
		$(".statusGubun").text("일시정지")
	}
	else
	{
		$(".statusGubun").text("종료")
	}
	
	if("LOCATION" == "${event.eventType}")
	{
		$(".eventTypeGubun").text("위치")
		$(".eventDistance").text("${event.eventDistance}");
		$(".eventTypeLocation").show();
	}
	else
	{
		$(".eventTypeGubun").text("시간")
		$(".timeset").text("${event.eventStartHms}"+"~"+"${event.eventEndHms}");
		$(".eventTypeTarget").show();
	}
	
	
	$(".ymd").text("${event.startYmd}"+" ~ "+"${event.endYmd}");
	
	if("ROADINFORMATION" == "${event.eventAfterType}")
	{
		$(".eventAfterType").text("길안내");
		$(".loadType").text("${event.loadType}");
		$(".load").show();
	}else if("AFTEREVENT" == "${event.eventAfterType}")
	{
		$(".eventAfterType").text("후이벤트");
		$(".eventAfterType").text("${event.eventAfterType}");
		$(".banner").show();
	} else {
		$(".eventAfterType").text("없음");
	}
	
	FN.eventDetailList("${event.eventId}");
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
		ProductDel : function(eventId)
		{
			$.ajax( "/pc/event/eventDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"eventId":eventId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("정상적으로 삭제되었습니다.");
					location.href = "/pc/event/eventListPage?userId="+userId;

			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/event/eventDelete :"+status;
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
		moveUpdatePage:function(userId,eventId) {
			location.href = "/pc/event/eventUpdatePage?eventId="+eventId
		},
		dataSet : function()
		{
			var list = "";
			var leng = $("#companyList .shopChk:checked").length-1;
			
			$("#companyList .shopChk:checked").each(function(idx){
					if(0 == leng )
					{
						list += $(this).val();
					}
					else
					{
						if(leng == idx)
						{
							list += $(this).val()
						}
						else
						{
							list += $(this).val()+",";
						}
					}
			});
			console.log(list)
			$("#shopList").val(list);
			
			$("#startYmd").val($("#startDay").val().replace(/-/g,"")) ;
			$("#endYmd").val($("#endDay").val().replace(/-/g,"")) ;
			
			if($(".tgGubun:checked").val() == "A"){
				$("#eventStartHms").val("000000") ;
				$("#eventEndHms").val("235959");
			}
			else
			{
				console.log($("#sTargetTime").val())
				console.log($("#eTargetTime").val())
				$("#eventStartHms").val($("#sTargetTime").val());
				$("#eventEndHms").val($("#eTargetTime").val());
			}
			
			
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
		 		if( 200 != event.response.header.statusCode){
		 			alert(event.response.header.statusMessage);
		 			return;	
		 		}
            	alert("정상 등록되었습니다.")
                //성공후 서버에서 받은 데이터 처리
				location.href = "/pc/evnet/eventListPage"
            },
            error: function(){
                //에러발생을 위한 code페이지
            }                              
        }).submit();
	},
	appendZero:function(number,digits){
		var zeroData = "0";
		var rtnData;
		if(number == 24){
			return "235959"
		}
		for(var i=1; i< digits; i++){
			zeroData += "0";
		}
		return number+zeroData;
	},
	changeTarGet : function(tag,data){
			
			switch (tag) {
			  case "tgGubun": 	
				  			if (data == "A") {
								$('.tgGubun[value=A]').prop('checked',true);
								$(".targetSet").attr("disabled", true);
								$('.targetSet').css("background-color","#f5f5f5");
							}else {
								$('.targetSet').attr("disabled", false);
								$('.targetSet').css("background-color","white");
							}
			               break;
			  case "cmpgnIngStatus"   : 
						  if (data == "ING") {
								$('.cmpgnIngStatus[value=ING]').prop('checked',true);
							}else {
								$('.cmpgnIngStatus[value=PAUSE]').prop('checked',true);
							}
			               break;
			  default    : console.log('체크박스 셋팅 에러');
			               break;
			}
		},
		eventDetailList : function(eventId)
		{
			$.ajax( "/pc/event/eventDetailList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
						"eventId" : eventId
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		
			 		var list =	data.response.body.listData;
			 		var shopList =	data.response.body.listData;
			 		
			 		console.log(list)
			 		//기존 row들 삭제
			 		$("#companyList .row").detach();
				
			 		var companyChekId = 0;
			 		$(list).each(function(idx){
			 			var row;
			 				if(0 == idx)
			 				{
			 					row = $("#companyList .src_row").clone();
					 			$(row).removeClass("src_row");
					 			$(row).addClass("row");
					 			$(row).children().find(".companyName").text(list[idx].companyName);
					 			$(row).children().find(".companyChk").val(list[idx].companyId);
					 			$(shopList).each(function(i){
					 				console.log(list[idx])
					 				console.log(shopList[i])
					 				console.log(list[idx].companyId)
					 				console.log(shopList[i].companyId)
					 				if(list[idx].companyId == shopList[i].companyId)
					 				{
							 			var pRow = $(".src_row_p").clone();
		//	 			 				console.log(pRow)
							 			$(pRow).removeClass("src_row_p");
							 			$(pRow).addClass("prow");
						 				$(pRow).find(".shopName").text(shopList[i].shopName);
							 			$(pRow).find(".shopChk").val(shopList[i].shopId);
							 			$(pRow).css("display", "");
							 			
							 			$(pRow).find(".shopChk").click(function(){
							 				if($(".shopChk").not(':checked').length > 1){
							 					$(pRow).parent().prop('checked',false);
							 				}else{
							 					$(pRow).parent().prop('checked',true);
							 				}
							 			});
							 			$(row).find(".pDiv").append(pRow);
					 				}
					 			});
					 			companyChekId = list[idx].companyId
								$(row).css("display", "");
					 			$("#companyList").append(row);
					 			
			 				}
			 				else
			 				{
			 					if(companyChekId != list[idx].companyId)
			 					{
			 						row = $("#companyList .src_row").clone();
						 			$(row).removeClass("src_row");
						 			$(row).addClass("row");
						 			$(row).find(".companyName").text(list[idx].companyName);
						 			$(row).find(".companyChk").val(list[idx].companyId);
						 			$(shopList).each(function(i){
						 				console.log(list[idx])
						 				console.log(shopList[i])
						 				console.log(list[idx].companyId)
						 				console.log(shopList[i].companyId)
						 				if(list[idx].companyId == shopList[i].companyId)
						 				{
								 			var pRow = $(".src_row_p").clone();
			//	 			 				console.log(pRow)
								 			$(pRow).removeClass("src_row_p");
								 			$(pRow).addClass("prow");
							 				$(pRow).find(".shopName").text(shopList[i].shopName);
								 			$(pRow).find(".shopChk").val(shopList[i].shopId);
								 			$(pRow).css("display", "");
								 			
								 			$(pRow).find(".shopChk").click(function(){
								 				if($(".shopChk").not(':checked').length > 1){
								 					$(pRow).parent().prop('checked',false);
								 				}else{
								 					$(pRow).parent().prop('checked',true);
								 				}
								 			});
								 			$(row).find(".pDiv").append(pRow);
						 				}
						 			});
						 			companyChekId = list[idx].companyId
									$(row).css("display", "");
						 			$("#companyList").append(row);
			 					}
			 				}
				 			//click event
				 			$(row).css("display", "");
				 			$("#companyList").append(row);
				 			
			 			
			 		});
			 		

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
</head>


<body>
	
<div id="wrap">
    
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">이벤트 관리 > 이벤트 목록 > </span>이벤트상세</h2>
			<fieldset>	
				<form name="" method="" action="" >	
					<legend>이벤트상세</legend>
					<table class="mytable2">
						<caption>이벤트상세</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">진행상태</td>
							<td class="tdbg02"><span class="r_txt statusGubun"></span></td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">표출기준</td>
							<td class="tdbg02"><span class="r_txt eventTypeGubun"></span></td>                
						</tr> 
						<tr class="eventTypeGubunCommon eventTypeLocation" style="display: none;">
							<td class="tdbg01" scope="col">거리</td>
							 <td class="eventDistance"></td> 
						</tr> 
						<tr class="eventTypeGubunCommon eventTypeTarget" style="display: none;">
							<td class="tdbg01">시간</td>
							<td class="tdbg02">
								<div class="timeset">
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">노출기간</td>
							 <td class="ymd"></td> 
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">템플릿</td>
							<td class="tdbg02">
								<span class="r_txt templateType">
								${event.templateType}
								</span>
							</td> 
						</tr>
						
						<tr>
							<td class="tdbg01" scope="col">이벤트 명</td> 
							<td class="tdbg02">${event.templateTitle}</td>
						</tr>
						
						<tr>
							<td class="tdbg01" scope="col">이벤트 설명</td>
							 <td class="tdbg02">${event.templateDesc}</td> 
						</tr>
						
						<tr>
							<td class="tdbg01" scope="col">이미지</td>
							<td ><div id="photoview"><img src="${event.templateImageUrl}" width="100%" height="100%"></div>
						</tr>						
						<tr>
							<td class="tdbg01" scope="col">확인 버튼 명</td>
							 <td class="tdbg02">${event.templateButtonConfirmTitle}</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">취소 버튼 명</td>
							<td class="tdbg02">${event.templateButtonCancelTitle}</td>
						</tr>
						<tr> 
							<td class="tdbg01" scope="col">후 이벤트</td> 
							<td class="eventAfterType"></td>
						</tr>
						<tr class="afterCommon load" style="display: none;" > 
							<td class="tdbg01" scope="col">지도종류</td>
							<td colspan="3" class="loadType"></td>
						</tr>
						<tr class="afterCommon banner" style="display: none;"  > 
							<td class="tdbg01" scope="col">탬플릿</td>
							<td class="eventAfterTemplateType">${event.eventAfterTemplateType}</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 명</td> 
							<td class="eventAfterTitle">${event.eventAfterTitle}</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 설명</td> 
							<td class="eventAfterDesc">${event.eventAfterDesc}</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 파일 </td> 
							<td class="eventAfterFile">${event.eventAfterFileName}</td> 
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 파일 타입</td> 
							<td class="eventAfterFileType">${event.eventAfterFileType}</td> 
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">확인 버튼 명</td> 
							<td>${event.eventAfterButtonTitle}</td>
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" userId="${userId}" eventId="${event.eventId}"><span class="btntxt">수정하기</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="deleteBtn" class="pagebtn2" eventId="${event.eventId}"><span class="btntxt">삭제하기</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">뒤로가기</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>

</body>
</html>