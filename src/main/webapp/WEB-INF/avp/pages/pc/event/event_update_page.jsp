<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>이벤트 등록</title>
<link rel="stylesheet" href="../css/jquery-ui.css">
<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">

<!-- 
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
 <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>
-->

<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

 <script type="text/javascript">

var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var dc = null;
var imgId;
var webviewFlag = false;
var userId= "${userId}";
var beforeAfterEventType 	= "${event.eventAfterType}";	
$(document).ready(function(){
	var userAgent = navigator.userAgent.toLowerCase();
	console.log(userAgent);
	// 모바일 홈페이지 바로가기 링크 생성
	if(userAgent.match('tourweb')) 
	{    //아이폰
		webviewFlag = true;
	}
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	console.log("${event}")
	$(".datepicker").datepicker({
		inline: true,
		dateFormat: 'yy-mm-dd',
		showOn: "both", 
		autoSize: false,
		buttonImageOnly:true, 
		buttonImage: '/resources/images/ico_calendar.gif'
	});
	
	
	$("#insertBtn").click(function(){
		FN.dataSet();
		if(FN.validCheck($("#startDay"),$("#endDay")))
		{
			FN.insert();
		}
// 		FN.dataSet();
// 		FN.insert();
	});
	for(var i=0; i<24; i++){
		var option = $("#sTargetTime .srcRow").clone();
		option.removeClass("srcRow");
		option.attr("selected",false);
		if(i < 10){
			i = '0'+i;
		}
		$(option).text(i);
		valData = FN.appendZero(i,4);
		$(option).val(valData);
		$("#sTargetTime").append(option);
	}
	
	for(var i=1; i<25; i++){
		var option = $("#eTargetTime .srcRow").clone();
		var valData;
		option.removeClass("srcRow");
		option.attr("selected",false);
		if(i < 10){
			i = '0'+i;
		}
		$(option).text(i);
		valData = FN.appendZero(i,4);
		$(option).val(valData);
		$("#eTargetTime").append(option);
	}
	$(".tgGubun").click(function(){
		console.log($(this).attr("class"));
		FN.changeTarGet($(this).val());		
	});

	$("#eventAfterType").change(function(){
		var type = $(this).val();
			$(".afterCommon").hide();
		if("LOADINFORMATION" == type)
		{
			$(".load").show();
		}
		else if("AFTEREVENT" == type)
		{
			$(".banner").show();
		}
		else
		{
			
		}
	});
	$("#cancelBtn").click(function(){
		history.back();
	});
	
	$(".eventTypeGubun").change(function(){
		var type = $(this).val();
		$(".eventTypeGubunCommon").hide();
		if("LOCATION" == type)
		{
			$(".eventTypeLocation").show();
		}
		else if("TIME"  == type)
		{
			$(".eventTypeTarget").show();
		}
	});
	
	
	$("input[name=eventStatus][value=" + '${event.eventStatus}' + "]").attr("checked", true);
	$("input[name=eventType][value=" + '${event.eventType}' + "]").attr("checked", true);
	$("input[name=templateType][value=" + '${event.templateType}' + "]").attr("checked", true);
// 	$("#eventAfterFileType").val("${event.eventAfterFileType}");
	if("LOCATION" == "${event.eventType}")
	{
		$("#eventDistance").val("${event.eventDistance}");
		$(".eventTypeLocation").show();
	}
	else
	{
		$("#sTargetTime").val("${event.eventStartHms}");
		$("#sTargetTime").val("${event.eventEndHms}");
		$(".eventTypeTarget").show();
	}
	
	
	
	var sTargetTime = '${event.eventStartHms}'.replace(/:/g,"");
	var eTargetTime = '${event.eventEndHms}'.replace(/:/g,"");

	if('000000' == sTargetTime && '235959' == eTargetTime){
		FN.changeTarGet("A")
	}else{
		FN.changeTarGet("")
		$("#sTargetTime").val(sTargetTime)
		$("#eTargetTime").val(eTargetTime)
	}
	
	$("#eventAfterType").val("${event.eventAfterType}");

	if("ROADINFORMATION" == "${event.eventAfterType}")
	{
		$("input[name=loadType][value=" + '${event.loadType}' + "]").attr("checked", true);
		$(".load").show();
	}else if("AFTEREVENT" == "${event.eventAfterType}")
	{
		$("#eventAfterTitle").val("${event.eventAfterTitle}");
		$("#eventAfterDesc").val("${event.eventAfterDesc}");
		$("#eventAfterButtonTitle").val("${event.eventAfterButtonTitle}");
		$("#eventAfterFileType").val("${event.eventAfterFileType}");

		$("input[name=eventAfterTemplateType][value=" + '${event.eventAfterTemplateType}' + "]").attr("checked", true);
		$(".banner").show();
	}
	
	
	
	$(document).on("change","[type=file]",function(){
//		$(document).on("change","#uploadFile",function(){
		if($(this).attr('id') == "templateImage"){
			readURL(this,'templateImage_url');
		}
		if($(this).attr('id') == "eventAfterFile"){
// 			readURL(this,'eventAfterFile_url');
		}
    });
	
	$("#ARPLAY").attr("disabled");
	FN.eventDetailList("${event.eventId}");
});
function readURL(input,id) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+id).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
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
			var height = $("#wrapper").height() +  $("#footer").height();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		validCheck:function(startObj,endObj){
			var targetTime = $(".tgGubun:checked").val();
        	var regNumber = /^[0-9]*$/;
        	
        	if(!$("#shopList").val().length > 0)
			{
        		alert("상점 목록을 선택해 주세요.");
        		return false;
			}
        	console.log($(".eventTypeGubun:checked").val())
        	if(undefined == $(".eventTypeGubun:checked").val())
			{
        		alert("표출기준을 선택해 주세요.");
        		return false;
			}
        	if("LOCATION" == $(".eventTypeGubun:checked").val())
			{
				if(!$("#eventDistance").val().length > 0)
				{
					alert("거리를 입력해 주세요.");
					return false;
				}
				if(!regNumber.test($("#eventDistance").val())) {
            	    alert('숫자만 입력해주세요.');
            	    return false;
            	}
			}
        	else
        	{
    			if(targetTime != "A"){
    				if($("#sTargetTime").val() == ""){
    					alert("시간을 설정해 주세요.");
//     					$("#sTargetTime").focus();
    					return false;
    				}
    				if($("#eTargetTime").val() == ""){
    					alert("시간을 설정해 주세요.");
//     					$("#eTargetTime").focus();
    					return false;
    				}
    			}
    			
        	}
        	if(!$(startObj).val().length > 0) {
				alert("시작기간을 선택하셔야 합니다.");
				$(startObj).focus();
				return false;
			}
			if(!$(endObj).val().length > 0) {
				alert("종료기간을 선택하셔야 합니다.");
				$(endObj).focus();
				return false;
			}
			
			if ($(startObj).val().replace(/-/g,"") > $(endObj).val().replace(/-/g,"")) {
				alert("시작기간은 종료기간보다 클 수 없습니다.");
				$(startObj).focus();
				return false;
			}
			
			if(undefined == $(".templateType:checked").val())
			{
        		alert("탬플릿을 선택해 주세요.");
        		return false;
			}
			if(!$("#templateTitle").val().trim().length > 0)
			{
        		alert("이벤트 명을 선택해 주세요.");
        		return false;
			}
			if(!$("#templateDesc").val().trim().length > 0)
			{
        		alert("이벤트 설명을 선택해 주세요.");
        		return false;
			}
			if(!$("#cancelButtonTitle").val().trim().length > 0)
			{
        		alert("취소 버튼명을 입력해 주세요.");
        		return false;
			}
			if(!$("#confirmButtonTitle").val().trim().length > 0)
			{
        		alert("확인 버튼명을 입력해 주세요");
        		return false;
			}
			if("LOADINFORMATION" == $("#eventAfterType").val())
			{
				if(undefined == $(".loadType:checked").val())
				{
        			alert("지도 종류를 선택해 주세요");
        			return false;
				}
			}
			
			if("AFTEREVENT" == $("#eventAfterType").val())
			{
				if(undefined == $(".eventAfterTemplateType").val())
				{
					alert("후이벤트 탬플릿을 선택해 주세요.");
					return false;
				}
				if(!$("#eventAfterTitle").val().trim().length > 0)
				{
					alert("후이벤트 타이틀을 입력해 주세요.");
					return false;
				}
				if(!$("#eventAfterDesc").val().trim().length > 0)
				{
					alert("후이벤트 설명을 입력해 주세요.");
					return false;
				}
				
				if("AFTEREVENT" != beforeAfterEventType)
				{
					if(!$("#eventAfterFile").val().trim().length > 0)
					{
						alert("후이벤트 파일을 선택해 주세요.");
						return false;
					}	
				}
				if(!$("#eventAfterFileType").val().trim().length > 0)
				{
					alert("이벤트 파일 탑입을 선택해 주세요.");
					return false;
				}
				if(!$("#eventAfterButtonTitle").val().trim().length > 0)
				{
					alert("이벤트 확이버트명을 입력해 주세요.");
					return false;
				}
			}
			if(!confirm("수정 하시겠습니까??"))
			{
				return false;	
			}	
			FN.dialogShow();
        	return true;
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
			console.log(list);
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
		 		if( 200 != data.response.header.statusCode){
		 			alert(data.response.header.statusMessage);
		 			return;	
		 		}
            	alert("정상 등록되었습니다.")
                //성공후 서버에서 받은 데이터 처리
				location.href = "/pc/event/eventListPage?userId="+userId;
            },
            error: function(result, status){
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
	changeTarGet : function(data){
			if (data == "A")
			{
				$('.tgGubun[value=A]').prop('checked',true);
				$(".targetSet").attr("disabled", true);
				$('.targetSet').css("background-color","#f5f5f5");
			}
			else 
			{
				$(".tgGubun[value=D]").attr("checked",true);
				$('.targetSet').attr("disabled", false);
				$('.targetSet').css("background-color","white");
			}
		},
		eventDetailList : function(eventId)
		{
			$.ajax( "/pc/event/updatePageEventshopList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
						"eventId" : eventId
				}),
				timeout : 90000, //제한시간 지정
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
							 			if(0 < shopList[i].selShopId)
						 				{
							 			$(pRow).find(".shopChk").prop('checked',true);
						 				}
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
					 			$(row).children().find('.companyChk').click(function(){
									if($(this).is(":checked"))
									{
										$(row).find(".shopChk").prop('checked', true);
									}
									else
									{
										$(row).find(".shopChk").prop('checked', false);
									}
					 			})
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
								 			if(0 < shopList[i].selShopId)
							 				{
								 			$(pRow).find(".shopChk").prop('checked',true);
							 				}
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
						 			$(row).children().find('.companyChk').click(function(){
										if($(this).is(":checked"))
										{
											$(row).find(".shopChk").prop('checked', true);
										}
										else
										{
											$(row).find(".shopChk").prop('checked', false);
										}
						 			})
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

			 		var  statusStr = "/pc/event/updatePageEventshopList :"+status;
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
		getCompanyShopList : function()
		{
			$.ajax( "/pc/event/companyEventList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(company),
				timeout : 90000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		
			 		var list =	data.response.body.listData
			 		
			 		console.log(list)
			 		//기존 row들 삭제
			 		$("#companyList .row").detach();
				
			 		$(list).each(function(idx){
			 			var row = $("#companyList .src_row").clone();
			 			$(row).removeClass("src_row");
			 			$(row).addClass("row");
			 			
			 			$(row).children().find(".companyName").text(list[idx].companyName);
			 			$(row).children().find(".companyChk").val(list[idx].companyId);
			 			var shopList =	list[idx].shoplist;	
			 			$(shopList).each(function(i){
				 			var pRow = $(".src_row_p").clone();
// 			 				console.log(pRow)
				 			$(pRow).removeClass("src_row_p");
				 			$(pRow).addClass("prow");
			 				$(pRow).find(".shopName").text(shopList[i].shopName);
				 			$(pRow).find(".shopChk").val(shopList[i].shopId);
				 			$(pRow).css("display", "");
				 			if(null != shopList[i].selShopId)
			 				{
				 			$(pRow).find(".shopChk").prop('checked',true);
			 				}
				 			
				 			$(pRow).find(".shopChk").click(function(){
				 				if($(".shopChk").not(':checked').length > 1){
				 					$(pRow).parent().prop('checked',false);
				 				}else{
				 					$(pRow).parent().prop('checked',true);
				 				}
				 			});
				 			$(row).find(".pDiv").append(pRow);
			 			});
			 			
			 			$(row).children().find('.companyChk').click(function(){
							console.log("Ddd")			 				
							if($(this).is(":checked"))
							{
								$(row).find(".shopChk").prop('checked', true);
							}
							else
							{
								$(row).find(".shopChk").prop('checked', false);
							}
			 			
			 			});
			 			//click event
			 			$(row).css("display", "");
			 			$("#companyList").append(row);
			 			
			 		});
			 		

			 	},
			 	error: function(result, status)
			 	{

			 		var  statusStr = "pc/event/companyEventList :"+status;
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
function imageCallBack(fileId,fileName,rtnFile,url)
{
	if("templateImage" == imgId)
	{
		$("#templateImage_url").attr("src",rtnFile);
		$("#templateImageId").val(fileId)
		$("#templateImageName").val(fileName)
		$("#templateImagePath").val(rtnFile)
	}
	else if("eventAfterFile" == imgId)
	{
		$("#eventAfterFileId").val(fileId)
		$("#eventAfterFileName").val(fileName)
		$("#eventAfterFilePath").val(rtnFile)
		$("#selectEventAfterFile").text(rtnFile)
	}

}
</script>

</head>

<body>
        
<div id="wrap">
    		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">이벤트관리 > </span>이벤트등록</h2>

			<fieldset>	
				<form id="frm" action="/pc/event/eventUpdate" method="post" enctype="multipart/form-data">	
					<input type="hidden" id="shopList" name="shopList">
					<input type="hidden"  id="userId" name="userId" value="${userId}">
					<input type="hidden"  id="startYmd" name="startYmd">
					<input type="hidden"  id="endYmd"  name="endYmd">
					<input type="hidden"  id="eventStartHms"  name="eventStartHms">
					<input type="hidden"  id="eventEndHms"  name="eventEndHms">
					<input type="hidden"  id="eventId" 				name="eventId" value="${event.eventId}">
					
					<input type="hidden"  id="templateImageId"		name="templateImageId" >
					<input type="hidden"  id="templateImagePath"  name="templateImagePath">
					<input type="hidden"  id="templateImageName"  name="templateImageName">
					<input type="hidden"  id="preTemplateImageId"   name="preTemplateImageId"  value="${event.templateImageId}">
					
					<input type="hidden"  id="eventAfterFileId" 	name="eventAfterFileId" >
					<input type="hidden"  id="eventAfterFileName"  name="eventAfterFileName">
					<input type="hidden"  id="eventAfterFilePath"  name="eventAfterFilePath">
					<input type="hidden"  id="preEventAfterFileId"  name="preEventAfterFileId" value="${event.eventAfterFileId}">
	
					<input type="hidden"  id="preEventAfterType"  name="preEventAfterType" value="${event.eventAfterType}">
	
					<legend>상점등록</legend>	
					<table class="mytable2">
						<caption>상점등록</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">상점선택</td>
							<td >
								<div id="companyList" class="checklist">
									<p class="src_row_p" style="display: none;"><input type="checkbox"  name="shopChk" class="shopChk"><span class="shopName"></span></p>
									<table > 
										<tr class="src_row" style="display: none;"> 
											<td style="border:none;">
												<input type="checkbox" class="companyChk" ><span class="companyName"></span>
												<div class="pDiv" style="margin-left: 10px"></div>
											</td> 
										</tr>
									</table> 
								</div>		
							</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">진행상태</td>
							<td> <input type="radio" class="statusGubun" name="eventStatus" id="ING" value="ING"/>&nbsp진행중
								<input type="radio" class="statusGubun" name="eventStatus" id="PAUSE" value="PAUSE"/>&nbsp일시정지
								<input type="radio" class="statusGubun" name="eventStatus" id="END" value="END"/>&nbsp종료
							</td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">표출기준</td>
							<td><input type="radio" class="eventTypeGubun" name="eventType" id="LOCATION" value="LOCATION"/>&nbsp위치
								<input type="radio" class="eventTypeGubun" name="eventType" id="TIME" value="TIME"/>&nbsp시간</td>                
						</tr>
						<tr class="eventTypeGubunCommon eventTypeLocation" style="display: none;">
							<td class="tdbg01" scope="col">거리</td>
							<td>
								<input id="eventDistance" type="text" name="eventDistance" >
							</td>
						</tr>
						<tr class="eventTypeGubunCommon eventTypeTarget" style="display: none;">
							<td class="tdbg01" scope="col">표출 시간</td>
							<td>
								<div>
									<span class="r_txt">
										<input type="radio" class="tgGubun"  name="trd" id="trdAll" value="A" ><label for="trdAll">All</label>
									</span>
									<span class="r_txt">
										<input type="radio" class="tgGubun"  name="trd" id="trtSet" value="D"><label for="trdSet">시간설정</label>
									</span>
									<select id="sTargetTime" class="targetSet" style="width:137px" >
										<option value="" selected="selected" class="srcRow">선택</option>
									</select>
									<span class="bar">~</span>
									<select  id="eTargetTime" class="targetSet" style="width:137px" >
										<option value="" selected="selected" class="srcRow">선택</option>								
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">노출기간</td>
							<td id="myinput5">
                                	<input type="text" id="startDay" name="startDay" value="${event.startYmd}" readonly="" class="datepicker">~ 
                                	<input type="text" id="endDay" name="endDay" value="${event.endYmd}" readonly="" class="datepicker">
							</td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">탬플릿</td>
							<td>
								<div class="tem"> 
									<div class="tem-img"><img src="../images/tem-img.jpg"><br> <input type="radio" name="templateType" value="1" id="temple1" class="templateType"/></div>
									<div class="tem-img"><img src="../images/tem-img5.jpg"><br><input type="radio" name="templateType" value="2" id="temple2" class="templateType"/></div>	
									<div class="tem-img"><img src="../images/tem-img2.jpg"><br><input type="radio" name="templateType" value="3" id="temple3" class="templateType"/></div>
									<div class="tem-img"><img src="../images/tem-img3.jpg"><br><input type="radio" name="templateType" value="4" id="temple4" class="templateType"/></div>	
									<div class="tem-img"><img src="../images/tem-img4.jpg"><br><input type="radio" name="templateType" value="5" id="temple5" class="templateType"/></div>
								</div>
							</td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">이벤트명</td>
							<td> <input id="templateTitle" type="text" name="templateTitle"  value="${event.templateTitle}" required="required">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이벤트 설명</td>
							<td> <input id="templateDesc" type="text" name="templateDesc" value="${event.templateDesc}" required="">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이미지</td>
							<td ><input id="templateImage" type="file" name="templateImage" required="required">&nbsp;&nbsp;&nbsp;
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이미지 미리보기</td>
							<td ><div id="photoview"><img id="templateImage_url" width="260px" height="200px" src="${event.templateImageUrl}"/></div>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">취소 버튼명</td>
							<td> <input id="cancelButtonTitle" type="text" name="templateButtonCancelTitle" value="${event.templateButtonCancelTitle}" >&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">확인 버튼명</td>
							<td> <input id="confirmButtonTitle" type="text" name="templateButtonConfirmTitle" value="${event.templateButtonConfirmTitle}">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">후 이벤트</td>
							<td><select id="eventAfterType" name="eventAfterType">
								<option value="">없음</option>
								<option value="ROADINFORMATION">길안내</option>
								<option value="AFTEREVENT">후이벤트</option>
								
							</select>
							</td>
						</tr>
						<tr class="afterCommon load" style="display: none;" > 
							<td class="tdbg01" scope="col">지도종류</td>
							<td>
								<input type="radio" name="loadType" value="TMAP" id="TMAP" ><label for="TMAP">TMAP</label>
								<input type="radio" name="loadType" value="ARMAP" id="ARMAP" ><label for="ARMAP">AR MAP</label>
								<input type="radio" name="loadType" value="ARPLAY" id="ARPLAY" disabled="disabled"><label for="ARPLAY">AR PLAY</label>
							</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;"  > 
							<td class="tdbg01" scope="col">탬플릿</td>
							<td>
								<span class="r_txt">
								<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem1" value="1"><label for="temple1">1</label>
								<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem2" value="2"><label for="temple2">2</label>
								<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem3" value="3"><label for="temple3">3</label>
								<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem4"value="4"><label for="temple4">4</label>
								</span>
							</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트명</td>  
							<td>
								<input id="eventAfterTitle" type="text" name="eventAfterTitle" required="required">
							</td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 설명</td> 
							<td>
								<input id="eventAfterDesc" type="text" name="eventAfterDesc" required="required">
							</td>
						</tr>						
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 이미지</td>
							<td>
								<input id="eventAfterFile" type="file" name="eventAfterFile" required="required">
								<select id="eventAfterFileType" name="eventAfterFileType">
								<option value="JPG">JPG</option>
								<option value="OBJ">OBJ</option>
								<option value="MP3">MP3</option>
								</select>
							</td> 
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">확인버튼</td> 
							<td>
								<input id="eventAfterButtonTitle" type="text" name="eventAfterButtonTitle" value="${event.eventAfterButtonTitle}" >
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="insertBtn" class="pagebtn2"><span class="btntxt">수정하기</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    
</body>
</html>

