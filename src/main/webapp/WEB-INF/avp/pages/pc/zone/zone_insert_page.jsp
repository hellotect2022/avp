<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>Zone 등록 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>

<script type="text/javascript">

var updateLat = "";
var updateLng = "";
var insertZone =
{
	zone : null,
	zoneLat : null,
	zoneLng : null
};
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */

	$("#insertBtn").click(function(){
		if(FN.valid()) {
			FN.dialogShow();
			FN.dataSet();
			FN.insert();
		}
	});
	$("#cancelBtn").click(function(){
		history.back();
	});	
});

var FN = 
{
		valid : function() {
			if("" == $("#zone").val()) {
				alert("Zone 을 입력해주세요.");
				return false;
			}
			
			if("" == updateLat || "" == updateLng) {
				alert("위치를 선택해주세요.");
				return false;
			}

			if(!confirm("등록하시겠습니까?"))
			{
				return false;	
			}
			
			return true;
		},
		errorLogInsert:function(status){
			$.ajax( "/pc/error/errorLogInsert",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({"status":status}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; chshopset=UTF-8",
			 	success: function(data)
			 	{
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
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
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		dataSet : function() {
			insertZone.zone = $("#zone").val();
			insertZone.zoneLat = updateLat;
			insertZone.zoneLng = updateLng;
			console.log("NAME,LAT,LNG ::: " + insertZone.zone + "," + insertZone.zoneLat +","+insertZone.zoneLng);
		},
		insert : function ()
		{
			$.ajax( "/pc/zone/zoneInsert",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(insertZone),
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
			 		alert("정상적으로 등록되었습니다.");
			 		
			 		location.href = "/pc/zone/zoneListPage";

			 	},
			 	error: function(result, status)
			 	{
			 		var  statusStr = "/pc/zone/zoneInsert :"+status;
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
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBlg3zO2JfhNZDT7y0WhKHBINzdZ5BPoCs&sensor=false"></script>
<script type="text/javascript">
	var marker;
	
	function initialize() {

		var myOptions = {
			center: new google.maps.LatLng(37.544755309731755, 126.95198196152558),
			zoom: 20,
		};
    
		var map = new google.maps.Map(document.getElementById("googleMap"), myOptions);

		const imageBounds = {
				north: 37.54487682783014,
				south: 37.5446304007093,
				east: 126.95217368898291,
				west: 126.95187194047548,
			};
			
			//좌 하단
			//37.5446304007093, 126.95187194047548
			//우 상단
			//37.54487682783014, 126.95217368898291
			
			mapOverlay = new google.maps.GroundOverlay(
				"http://smartcc.co.kr:5504/imgStg/overlay_tilt.png",
				imageBounds
			);
			
			google.maps.event.addListener(mapOverlay, 'click', function(event) {
				updateLat = event.latLng.lat();
				updateLng = event.latLng.lng();
				console.log("UPDATELat ::: " + updateLat);
				console.log("UPDATELng ::: " + updateLng);
				if(marker != null) {
					marker.setMap(null);
				}
				marker = new google.maps.Marker({
					position : event.latLng,
					map : map
				});
			});
			
			mapOverlay.setMap(map);
		
		google.maps.event.addListener(map, 'click', function(event) {
			updateLat = event.latLng.lat();
			updateLng = event.latLng.lng();
			console.log("UPDATELat ::: " + updateLat);
			console.log("UPDATELng ::: " + updateLng);
			if(marker != null) {
				marker.setMap(null);
			}
			marker = new google.maps.Marker({
				position : event.latLng,
				map : map
			});
		});
    	
	}
  </script>
</head>



<body onload="initialize()">
<div id="wrap">
  <!--본문-->       
	<div id="container"> 	

		<div class="contents">
			<h2><span class="titel-text-sm">ZONE 관리 > </span>ZONE 등록</h2>
			<fieldset>	
				<form name="" method="" action="">
					<legend>ZONE 등록</legend>	
					<table class="mytable2">
						<caption>ZONE 등록</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">ZONE</td>
							<td class="tdbg02">
								<input type="text" id="zone" name="zone" maxlength="25" style="width:700px;"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">위치</td>
							<td class="tdbg02">
								<div id="googleMap" style="width:700px; height:500px;"></div>
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
		</div>
		
	</div>
    
</div>

</body>
</html>

