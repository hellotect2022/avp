<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>작업량 확인 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>

<script type="text/javascript">

$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
	CO.checkForHash(); 
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */

	/* $("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("beaconId"));
	});
	$("#deleteBtn").click(function(){
		
		if(!confirm("정말로 삭제하시겠습니까?"))
		{
			return;	
		}
		FN.dialogShow();
		FN.delBeacon($(this).attr("beaconId"));
	}); */
	
});

$(window).on('hashchange', function(){ 
	CO.checkForHash(); 
});

var	CO = 
{
	checkForHash:function(){
		console.log("checkForHash!");
		if(document.location.hash)
		{
	        var hashLocationName = document.location.hash;
	        hashQuery = hashLocationName.replace("#","");
	        
        	var queryHash = query_to_hash(hashQuery);
        	console.log(queryHash);
        	pageInfo.page = queryHash.page; 
        	
        	if(queryHash.searchCategory != null)
    		{
        		searchCategory = queryHash.searchCategory;
				searchName = queryHash.searchName;
    		}
        	
	    }
		else
		{
			pageInfo.page = 1;
			searchCategory = null;
			searchName = null;
			period = null;
		}
	}
};
var FN = 
{
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
		moveDetailPage : function(deviceId) {
			location.href = "/pc/work/workRatePage?deviceId=" + deviceId;
		}
}

</script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBlg3zO2JfhNZDT7y0WhKHBINzdZ5BPoCs&sensor=false"></script>
<script type="text/javascript">
	
	function initialize() {

		var myOptions = {
			center: new google.maps.LatLng(37.561608, 126.981957),
			zoom: 15,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
    
		var map = new google.maps.Map(document.getElementById("googleMap"), myOptions);

    	setMarkers(map);

	}

	function setMarkers(map){

		var marker, i;

		var loan = "${work.deviceName}";
		var lat = "${work.latitude}";
		var lng = "${work.longitude}";
		
		latLng = new google.maps.LatLng(lat, lng);

		var marker = new google.maps.Marker({  
			map : map, title : loan , position : latLng
		});
    
		var content = "디바이스 : " + loan + "<br>" +
					  "작업률 : " + "${work.workRate}"
					  ;

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
			<h2><span class="titel-text-sm">작업 관제 > </span>작업량 확인</h2>
			<table class="mytable2">
				<caption>작업량 확인</caption>
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
				<tr>
					<td class="tdbg01" scope="col">디바이스명</td>
					<td class="tdbg02">${device.deviceName}</td>    
				</tr>
				<tr>
					<td class="tdbg01" scope="col">지점</td>
					<td class="tdbg02">${device.branchName}</td>    
				</tr>
				<tr>
					<td class="tdbg01" scope="col">진행 중인 작업</td>
					<td class="tdbg02">${device.orderlistName}</td>    
				</tr>
				<tr>
					<td class="tdbg01" scope="col">작업 진행률</td>
					<td class="tdbg02">${device.workRate}</td>
				</tr>
				<tr>
					<td class="tdbg01" scope="col">위치</td>
					<td class="tdbg02">
						<div id="googleMap" style="width:700px; height:500px;"></div>
					</td>
				</tr>
			</table>
		</div>
		
	</div>
    
</div>

</body>
</html>

