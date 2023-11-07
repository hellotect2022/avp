<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>비콘 수정 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>

<script type="text/javascript">

var updateLat = "";
var updateLng = "";
var updateBeacon =
{
	beaconId : null,
	beaconName : null,
	beaconMac : null,
	beaconLat : null,
	beaconLng : null
};
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */

	$("#updateBtn").click(function(){
		if(FN.valid()) {
			FN.dialogShow();
			FN.dataSet($(this).attr("beaconId"));
			FN.update();
		}
	});
	$("#cancelBtn").click(function(){
		history.back();
	});	
});

var FN = 
{
		valid : function() {
			if("" == $("#beaconName").val()) {
				alert("비콘명을 입력해주세요.");
				return false;
			}
			if("" == $("#beaconMac").val()) {
				alert("MAC을 입력해주세요.");
				return false;
			}

			if("" == updateLat || "" == updateLng) {
				alert("위치를 선택해주세요.");
				return false;
			}

			if(!confirm("수정하시겠습니까?"))
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
		dataSet : function(beaconId) {
			updateBeacon.beaconId = beaconId;
			updateBeacon.beaconName = $("#beaconName").val();
			updateBeacon.beaconMac = $("#beaconMac").val();
			updateBeacon.beaconLat = updateLat;
			updateBeacon.beaconLng = updateLng;
			console.log("ID,NAME,MAC,LAT,LNG ::: " + updateBeacon.beaconId + "," + updateBeacon.beaconName +","+updateBeacon.beaconMac +","+updateBeacon.beaconLat+","+updateBeacon.beaconLng);
		},
		update : function ()
		{
			$.ajax( "/pc/beacon/beaconUpdate",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(updateBeacon),
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
			 		alert("정상적으로 수정되었습니다.");
			 		
			 		location.href = "/pc/beacon/beaconListPage";

			 	},
			 	error: function(result, status)
			 	{
			 		var  statusStr = "/pc/beacon/beaconUpdate :"+status;
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

	//var locations = new Array();

	var marker;
	
	function initialize() {

		//locations = "${beacon}";

		//console.log("BEACON ::: " + locations);
		
		var myOptions = {
			center: new google.maps.LatLng(37.544755309731755, 126.95198196152558),
			zoom: 15,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
    
		var map = new google.maps.Map(document.getElementById("googleMap"), myOptions);

    	setMarkers(map);

		google.maps.event.addListener(map, 'click', function(event) {
			updateLat = event.latLng.lat();
			updateLng = event.latLng.lng();
			console.log("UPDATELat ::: " + updateLat);
			console.log("UPDATELng ::: " + updateLng);
			marker.setMap(null);
			marker = new google.maps.Marker({
				position : event.latLng,
				map : map
			});
		});
    	
	}

	function setMarkers(map){

		var i;

		var loan = "${beacon.beaconName}";
		var lat = "${beacon.beaconLat}";
		var lng = "${beacon.beaconLng}";
		
		latLng = new google.maps.LatLng(lat, lng);

		marker = new google.maps.Marker({  
			map : map, title : loan , position : latLng  
		});

		updateLat = lat;
		updateLng = lng;
    
		var content = "이름 : " + loan + "<br>" +
					  "MAC : " + "${beacon.beaconMac}";

		var infowindow = new google.maps.InfoWindow();

		google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){ 
			return function() {
				infowindow.setContent(content);
				infowindow.open(map,marker);
			};
		})(marker, content, infowindow)); 
		
	}

  </script>
</head>



<body onload="initialize()">
<div id="wrap">
  <!--본문-->       
	<div id="container"> 	

		<div class="contents">
			<h2><span class="titel-text-sm">비콘 관리 > 비콘 목록 > </span>비콘 수정</h2>
			<fieldset>	
				<form name="" method="" action="">
					<legend>비콘 수정</legend>	
					<table class="mytable2">
						<caption>비콘 수정</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">비콘명</td>
							<td class="tdbg02">
								<input type="text" id="beaconName" name="beaconName" maxlength="25" style="width:700px;" value="${beacon.beaconName}"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">MAC</td>
							<td class="tdbg02">
								<input type="text" id="beaconMac" name="beaconMac" maxlength="25" style="width:700px;" value="${beacon.beaconMac}"/>
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
				<button type="button" id="updateBtn" beaconId="${beacon.beaconId}" class="pagebtn2"><span class="btntxt">저장</span></button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
		</div>
		
	</div>
    
</div>

</body>
</html>

