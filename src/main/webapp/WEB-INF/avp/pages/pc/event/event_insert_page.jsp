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
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	
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
		FN.insert();
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
		FN.changeTarGet($(this).attr("class"),$(this).val());		
	});

	$("#eventAfterType").change(function(){
		var type = $(this).val();
			$(".afterCommon").hide();
		if("ROADINFORMATION" == type)
		{
			$(".load").show();
		}
		else if("AFTEREVENT" == type)
		{
			$(".banner").show();
		}
		else 
		{
			$(".afterCommon").hide();
		}
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
	

	$(document).on("change","[type=file]",function(){
		if($(this).attr('id') == "templateImage"){
			targetChangeFlag = true;
			readURL(this,'templateImage_url');
		}
    });
	
	$("#cancelBtn").click(function(){
		history.back();
	})

	FN.getCompanyShopList();
	FN.dialogShow();
	FN.changeTarGet("tgGubun","A");	
	

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
            	var regNumber = /^[0-9]*$/;
            	var targetTime = $(".tgGubun:checked").val();
            	if(!$("#shopList").val().length > 0)
    			{
            		alert("상점 목록을 선택해 주세요.");
            		return false;
    			}
            	
             	if(undefined == $(".eventStatus:checked").val())
    			{
            		alert("진행상태를 선택해 주세요.");
            		return false;
    			}
            	
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
//         					$("#sTargetTime").focus();
        					return false;
        				}
        				if($("#eTargetTime").val() == ""){
        					alert("시간을 설정해 주세요.");
//         					$("#eTargetTime").focus();
        					return false;
        				}
        			}
        			
            	}
            	var startObj = $("#startDay")
            	var endObj = $("#endDay")
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
    			if(!$("#templateImage").val().length > 0)
    			{
            		alert("이벤트 이미지를 선택해 주세요.");
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
    			if("ROADINFORMATION" == $("#eventAfterType").val())
    			{
    				console.log( $(".loadType:checked").val())
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
    				
   					if(!$("#eventAfterFile").val().trim().length > 0)
   					{
   						alert("후이벤트 파일을 선택해 주세요.");
   						return false;
   					}	
    				if(!$("#eventAfterFileType").val().trim().length > 0)
    				{
    					alert("이벤트 파일 타입을 선택해 주세요.");
    					return false;
    				}
    				if(!$("#eventAfterButtonTitle").val().trim().length > 0)
    				{
    					alert("이벤트 확이버트명을 입력해 주세요.");
    					return false;
    				}
    			}
            	console.log(data);
            	console.log("form ::" + form);
            	console.log("option ::" + option);
                //validation체크
                //막기위해서는 return false를 잡아주면됨
                if(!confirm("등록하시겠습니까??"))
				{
					return false;	
				}	
                FN.dialogShow();
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
            	location.href = "/pc/event/eventListPage"
                //성공후 서버에서 받은 데이터 처리
// 				location.href = "/pc/shop/shopListPage"
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
			 			$(".backLayer").hide();
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
			 			
			 			$(row).find(".companyName").text(list[idx].companyName);
			 			$(row).find(".companyChk").val(list[idx].companyId);
			 			var shopList =	list[idx].shoplist;	
			 			$(shopList).each(function(i){
				 			var pRow = $(".src_row_p").clone();
// 			 				console.log(pRow)
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
			 			
			 			});
			 			//click event
			 			$(row).css("display", "");
			 			$("#companyList").append(row);
			 			
			 		});
			 		$(".backLayer").hide();

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
<div>이벤트 관리 > 이벤트 등록</div>
<div class="section">
<form  id="frm" action="/pc/event/eventInsert" method="post" enctype="multipart/form-data">
	<input type="hidden" id="shopList" name="shopList">
	<input type="hidden"  id="startYmd" name="startYmd">
	<input type="hidden"  id="endYmd"  name="endYmd">
	<input type="hidden"  id="eventStartHms"  name="eventStartHms">
	<input type="hidden"  id="eventEndHms"  name="eventEndHms">
	
	<div id="companyList">
		<p class="src_row_p" style="display: none;"><input type="checkbox"  name=shopChk class="shopChk"><span class="shopName"></span></p>
		<table > 
			<tr class="src_row" style="display: none;"> 
				<td>
					<input type="checkbox" class="companyChk" ><span class="companyName"></span>
					<div class="pDiv" style="margin-left: 10px"></div>
				</td> 
			</tr>
		</table> 
	</div>
	<table> 
	<tr>
		<th colspan="1"> 진행상태</th>
		<td colspan="3">
			<span class="r_txt">
				<input type="radio" class="eventStatus" name="eventStatus" id="ING" value="ING" ><label for="ING">진행중</label>
				<input type="radio" class="eventStatus" name="eventStatus" id="PAUSE" value="PAUSE" ><label for="PAUSE">일시정지</label>
				<input type="radio" class="eventStatus" name="eventStatus" id="END" value="END" ><label for="END">종료</label>
			</span>
		</td>
	</tr>
	<tr>
		<th colspan="1">표출기준</th>
		<td colspan="3">
			<span class="r_txt">
				<input type="radio" class="eventTypeGubun" name="eventType" id="LOCATION" value="LOCATION" ><label for="LOCATION">위치</label>
				<input type="radio" class="eventTypeGubun" name="eventType" id="TIME" value="TIME" ><label for="TIME">시간</label>
			</span>
		</td>
	</tr>
	<tr class="eventTypeGubunCommon eventTypeLocation" style="display: none;">
		<th >거리</th>
		<td >
			<input id="eventDistance" type="text" name="eventDistance" >
		</td>
	</tr>
	<tr class="eventTypeGubunCommon eventTypeTarget" style="display: none;">
		<th colspan="1">Target Time</th>
		<td colspan="3">
			<div>
				<span class="r_txt">
					<input type="radio" class="tgGubun"  name="trd" id="trdAll" value="A" ><label for="trdAll">All</label>
				</span>
				<span class="r_txt">
					<input type="radio" class="tgGubun"  name="trd" id="trtSet" value="D"><label for="trdSet">시간설정</label>
				</span>
				<select  id="sTargetTime" class="targetSet" style="width:137px" >
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
		<th colspan="1"> 노출기간</th>
		<td colspan="3">
				<span class="cal">
				<input type="text" id="startDay" name="startDay" value="" readonly="" class="datepicker" style="width:115px">
				</span>
				<span class="bar">~</span>
				<span class="cal">
					<input type="text" id="endDay" name=endDay" value="" readonly="" class="datepicker" style="width:115px">
				</span>
		</td>
	</tr>
	<tr>
	<th colspan="1">탬플릿</th>
	<td colspan="5">
		<span class="r_txt">
			<input type="radio" value="1" class="templateType"  name="templateType" id="temple1" ><label for="temple1">1</label>
			<input type="radio" class="templateType" name="templateType" value="2" id="temple2" ><label for="temple2">2</label>
			<input type="radio" class="templateType" name="templateType" value="3" id="temple3" ><label for="temple3">3</label>
			<input type="radio" class="templateType" name="templateType" value="4" id="temple4" ><label for="temple4">4</label> 
			<input type="radio" class="templateType" name="templateType" value="5" id="temple5" ><label for="temple5">5</label>
		</span>
	</td>
	</tr>
	<tr> 
	<th>이벤트 명</th> 
	<td><input id="templateTitle" type="text" name="templateTitle" required="required"></td>
	</tr>
	<tr> 
	<tr> 
	<th>이벤트 설명</th> 
	<td><input id="templateDesc" type="text" name="templateDesc" required=""></td>
	</tr>
	<tr> 
	<th>이미지</th> 
	<td><input id="templateImage" type="file" name="templateImage" required="required"></td> 
	</tr>
	<tr> 
	<th>이미지 미리보기</th> 
	<td><img id="templateImage_url" width="200px" src=""></td> 
	</tr>
	<tr> 
	<th>취소 버튼명</th> 
	<td><input id="cancelButtonTitle" type="text" name="templateButtonCancelTitle" ></td>
	</tr>
	<tr> 
	<th>확인 버튼명</th> 
	<td><input id="confirmButtonTitle" type="text" name="templateButtonConfirmTitle" ></td>
	</tr>
	</table> 
	<table> 
	<tr> 
	<th>후 이벤트</th> 
	<td>
	<select id="eventAfterType" name="eventAfterType">
	<option value="">없음</option>
	<option value="ROADINFORMATION">길안내</option>
	<option value="AFTEREVENT">후이벤트</option>
	</select>
	</td>
	</tr>
	<tr class="afterCommon load" style="display: none;" > 
	<th colspan="1">지도종류</th>
	<td colspan="3">
	<input type="radio" class="loadType" name="loadType" value="TMAP" id="TMAP" ><label for="TMAP">TMAP</label>
	<input type="radio" class="loadType" name="loadType" value="ARMAP" id="ARMAP" ><label for="ARMAP">AR MAP</label>
	<input type="radio" name="" value="ARPLAY" id="ARPLAY" ><label for="ARPLAY">AR PLAY</label>
	</tr>
	<tr class="afterCommon banner" style="display: none;"  > 
	<th>탬플릿</th>
	<td colspan="3">
		<span class="r_txt">
		<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem1" value="1"><label for="temple1">1</label>
		<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem2" value="2"><label for="temple2">2</label>
		<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem3" value="3"><label for="temple3">3</label>
		<input type="radio" class="eventAfterTemplateType" name="eventAfterTemplateType" id="afterTem4"value="4"><label for="temple4">4</label>
		</span>
	</td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트명</th> 
	<td><input id="eventAfterTitle" type="text" name="eventAfterTitle" required="required"></td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트 설명</th> 
	<td><input id="eventAfterDesc" type="text" name="eventAfterDesc" required="required"></td>
	</tr>
	<tr class="afterCommon banner" style="display: none;" > 
	<th>후 이벤트 이미지</th> 
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
	<th>확인버튼</th> 
	<td><input id="eventAfterButtonTitle" type="text" name="eventAfterButtonTitle" ></td>
	</tr>
	
	<tr>
	 <td colspan="2">
	  <a id="insertBtn" >등록하기</a> 
	  <a id="cancelBtn" >취소</a> 
	  </td> 
	</tr>
	</table> 
</form>
	<!-- //sub_contents -->
</div>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>이벤트 등록 </title>
<link rel="stylesheet" href="../css/jquery-ui.css">
<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
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
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	
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
		FN.insert();
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
		FN.changeTarGet($(this).attr("class"),$(this).val());		
	});

	$("#eventAfterType").change(function(){
		var type = $(this).val();
			$(".afterCommon").hide();
		if("ROADINFORMATION" == type)
		{
			$(".load").show();
		}
		else if("AFTEREVENT" == type)
		{
			$(".banner").show();
		}
		else 
		{
			$(".afterCommon").hide();
		}
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
	

	$(document).on("change","[type=file]",function(){
		if($(this).attr('id') == "templateImage"){
			targetChangeFlag = true;
			readURL(this,'templateImage_url');
		}
    });
	
	$("#cancelBtn").click(function(){
		history.back();
	})

	FN.getCompanyShopList();
	FN.dialogShow();
	FN.changeTarGet("tgGubun","A");	
	

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
            	var regNumber = /^[0-9]*$/;
            	var targetTime = $(".tgGubun:checked").val();
            	if(!$("#shopList").val().length > 0)
    			{
            		alert("상점 목록을 선택해 주세요.");
            		return false;
    			}
            	
             	if(undefined == $(".eventStatus:checked").val())
    			{
            		alert("진행상태를 선택해 주세요.");
            		return false;
    			}
            	
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
                	    alert('거리는 숫자만 입력해주세요.');
                	    return false;
                	}
    			}
            	else
            	{
        			if(targetTime != "A"){
        				if($("#sTargetTime").val() == ""){
        					alert("시간을 설정해 주세요.");
//         					$("#sTargetTime").focus();
        					return false;
        				}
        				if($("#eTargetTime").val() == ""){
        					alert("시간을 설정해 주세요.");
//         					$("#eTargetTime").focus();
        					return false;
        				}
        			}
        			
            	}
            	var startObj = $("#startDay")
            	var endObj = $("#endDay")
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
    			if(!$("#templateImage").val().length > 0)
    			{
            		alert("이벤트 이미지를 선택해 주세요.");
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
    			if("ROADINFORMATION" == $("#eventAfterType").val())
    			{
    				console.log( $(".loadType:checked").val())
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
    				
   					if(!$("#eventAfterFile").val().trim().length > 0)
   					{
   						alert("후이벤트 파일을 선택해 주세요.");
   						return false;
   					}	
    				if(!$("#eventAfterFileType").val().trim().length > 0)
    				{
    					alert("이벤트 파일 타입을 선택해 주세요.");
    					return false;
    				}
    				if(!$("#eventAfterButtonTitle").val().trim().length > 0)
    				{
    					alert("이벤트 확이버트명을 입력해 주세요.");
    					return false;
    				}
    			}
            	console.log(data);
            	console.log("form ::" + form);
            	console.log("option ::" + option);
                //validation체크
                //막기위해서는 return false를 잡아주면됨
                if(!confirm("등록하시겠습니까??"))
				{
					return false;	
				}	
                FN.dialogShow();
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
            	location.href = "/pc/event/eventListPage"
                //성공후 서버에서 받은 데이터 처리
// 				location.href = "/pc/shop/shopListPage"
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
			 			$(".backLayer").hide();
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
			 			
			 			$(row).find(".companyName").text(list[idx].companyName);
			 			$(row).find(".companyChk").val(list[idx].companyId);
			 			var shopList =	list[idx].shoplist;	
			 			$(shopList).each(function(i){
				 			var pRow = $(".src_row_p").clone();
// 			 				console.log(pRow)
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
			 			
			 			});
			 			//click event
			 			$(row).css("display", "");
			 			$("#companyList").append(row);
			 			
			 		});
			 		$(".backLayer").hide();

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
 <style type="text/css">

  .ui-datepicker-year { margin-right: -5px; }
 </style>
 <script type="text/javascript">
 
 $(document).ready(function(){
  $(".date_format").datepicker({     
  showMonthAfterYear:true
  , monthNames:['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월']
  , monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
  , dayNamesMin: ['일','월','화','수','목','금','토']
  , weekHeader: 'Wk'
  , dateFormat: 'yy-mm-dd'
  , beforeShowDay: no_view

  });      

  // 특정일 선택 막기
  function no_view(date) {
   var tmp_chk = 1; 
   //매월 12월 21일은 선택 안되도록 
   if(date.getDate()  == "21" && date.getMonth() == "11"){
    tmp_chk =0;
   }
   return [tmp_chk != 0, ''];
  }


 });
 </script>


</head>


<body>
  <div id="wrap">

		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">이벤트관리 > </span>이벤트등록</h2>

			<fieldset>	
				<form name="" id="frm" action="/pc/event/eventInsert" method="post" enctype="multipart/form-data">	
					<input type="hidden" id="shopList" name="shopList">
					<input type="hidden"  id="startYmd" name="startYmd">
					<input type="hidden"  id="endYmd"  name="endYmd">
					<input type="hidden"  id="eventStartHms"  name="eventStartHms">
					<input type="hidden"  id="eventEndHms"  name="eventEndHms">
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
							<td>
								<input type="radio" name="eventStatus" id="ING" value="ING" class="eventStatus"/>&nbsp진행중
								<input type="radio" name="eventStatus" id="PAUSE" value="PAUSE" class="eventStatus"/>&nbsp일시정지
								<input type="radio" name="eventStatus" id="END" value="END" class="eventStatus"/>&nbsp종료
							</td>
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">표출기준</td>
							<td><input type="radio" name="eventType" id="LOCATION" value="LOCATION" class="eventTypeGubun"/>&nbsp위치
								<input type="radio" name="eventType" id="TIME" value="TIME" class="eventTypeGubun"/>&nbsp시간</td>                
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
                                	<input type="text" id="startDay" name="startDay" value="" readonly="" class="date_format">~ <input type="text" id="endDay" name=endDay" value="" readonly="" class="date_format">
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
							<td> <input  type="text" id="templateTitle" name="templateTitle" class="inp_text" size="30" maxlength="45" required="required">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이벤트 설명</td>
							<td> <input  type="text" id="templateDesc" name="templateDesc" class="inp_text" size="30" maxlength="45" required="required">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이미지</td>
							<td ><input id="templateImage" type="file" name="templateImage" required="required">
								<!-- <button type="button" id="" class="search-btn"><span class="btntxt">파일선택</span></button>&nbsp;&nbsp;&nbsp;<span class="search-text">선택된 파일 없음</span> -->
						</tr>
						<tr>
							<td class="tdbg01" scope="col">이미지 미리보기</td>
							<td ><div id="photoview"><img id="templateImage_url" width="260px" height="200px"></div>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">취소 버튼명</td>
							<td> <input  type="text" id="cancelButtonTitle" class="inp_text" size="30" maxlength="45" name="templateButtonCancelTitle">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">확인 버튼명</td>
							<td> <input  type="text" id="confirmButtonTitle" class="inp_text" size="30" maxlength="45" name="templateButtonConfirmTitle">&nbsp;&nbsp;&nbsp;</td>             
						</tr>
						<tr>
							<td class="tdbg01" scope="col">후 이벤트</td>
							<td><select title="" id="eventAfterType" name="eventAfterType">
								<option value="" selected="selected">없음</option>
								<option value="ROADINFORMATION">길안내</option>
								<option value="AFTEREVENT">후이벤트</option>								
							</select>
						</tr>
						
						<tr class="afterCommon load" style="display: none;" > 
							<td class="tdbg01" scope="col">지도종류</td>
							<td>
								<input type="radio" class="loadType" name="loadType" value="TMAP" id="TMAP" /><label for="TMAP">TMAP</label>
								<input type="radio" class="loadType" name="loadType" value="ARMAP" id="ARMAP" /><label for="ARMAP">AR MAP</label>
								<input type="radio" name="" value="ARPLAY" id="ARPLAY" ><label for="ARPLAY" />AR PLAY</label>
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
							<td><input id="eventAfterTitle" type="text" name="eventAfterTitle" required="required"></td>
						</tr>
						<tr class="afterCommon banner" style="display: none;" > 
							<td class="tdbg01" scope="col">후 이벤트 설명</td> 
							<td><input id="eventAfterDesc" type="text" name="eventAfterDesc" required="required"></td>
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
							<td><input id="eventAfterButtonTitle" type="text" name="eventAfterButtonTitle" ></td>
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="insertBtn" class="pagebtn2"><span class="btntxt">등록</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
	</div>
</div>
      

</body>
</html>