<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>사용자 분석</title>
<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>

<script type="text/javascript">

var map = null;
var markers = [];
var lists = null;
var currentDttm = null;

var sRequest = {
		type : null,
		date : null
}

$(document).ready(function() {
	
	var d = new Date();
	
	currentDttm = d.getFullYear() + "" + (d.getMonth() + 1) + "" + d.getDate();
	console.log(currentDttm);
	var mapContainer = document.getElementById('map_view'), // 지도를 표시할 div 
    mapOption = { 
        center: new daum.maps.LatLng(37.54890280604388,	127.07801655857033), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
    };

	map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	sRequest.type = "week";
	sRequest.date = currentDttm;
	FN.getList();
	
	$("#user").change(function() {		
		var phone = $("#user").val();
		
		var index = 0;
		
		$("#userList .row").remove();
		
		if (phone == "전체보기") {
			sRequest.type = "week";
			sRequest.date = currentDttm;
			FN.getList();
			return;
		}
		
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
				
		for (var i = 0; i < lists.length; i++) {
			if (phone != lists[i].phoneNumber) continue;
						
			index++;
			
			var row = $("#userList .src_row").clone();
			
			$(row).removeClass("src_row");
			$(row).addClass("row");
			
			$(row).find(".idx").text(index);
			$(row).find(".api").text(lists[i].apiName);
			$(row).find(".phone").text(lists[i].phoneNumber);
			$(row).find(".latitude").text(lists[i].latitude);
			$(row).find(".longitude").text(lists[i].longitude);
			$(row).find(".dttm").text(lists[i].createDate);
			
			$(row).css("display", "");
			
			$("#userList").append(row);
			
			var marker = new daum.maps.Marker({ 
			    map : map,
			    position: new daum.maps.LatLng(lists[i].latitude, lists[i].longitude),
			    title : index + 1 + "-" + lists[i].phoneNumber
			});
			
			marker.setMap(map);
			
			markers.push(marker);
			
			map.setCenter(new daum.maps.LatLng(lists[i].latitude, lists[i].longitude));
		}
	});
	
	$(".date_format").datepicker({     
		showMonthAfterYear:true
			, monthNames:['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월']
			, monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			, dayNamesMin: ['일','월','화','수','목','금','토']
			, weekHeader: 'Wk'
			, dateFormat: 'yy-mm-dd'
	});
	
});

var FN = {
		getList : function() {
			$.ajax("/pc/statistics/statisticsMap", {
				type : "POST",
				timeout : 20000,
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(sRequest),
				contentType : "application/json; chshopset=UTF-8",
				success : function(data) {
					if(data.response.header.statusCode != 200) {
						alert(data.response.header.statusMessage);
						return;
					}
					var countNonDist = data.response.body.countNonDist;
					var countDist = data.response.body.countDist;
					lists = data.response.body.list;
					
					console.log(countNonDist);
					console.log(countDist);
					console.log(lists);
					
					$("#countNonDist").text(countNonDist);
					$("#countDist").text(countDist);
					
					$(lists).each(function(idx){
						var row = $("#userList .src_row").clone();
						
						$(row).removeClass("src_row");
						$(row).addClass("row");
						
						$(row).find(".idx").text(idx + 1);
						$(row).find(".api").text(lists[idx].apiName);
						$(row).find(".phone").text(lists[idx].phoneNumber);
						$(row).find(".latitude").text(lists[idx].latitude);
						$(row).find(".longitude").text(lists[idx].longitude);
						$(row).find(".dttm").text(lists[idx].createDate);
						
						$(row).css("display", "");
						
						$("#userList").append(row);
						
						var marker = new daum.maps.Marker({ 
						    map : map,
						    position: new daum.maps.LatLng(lists[idx].latitude, lists[idx].longitude),
						    title : idx + 1 + "-" + lists[idx].phoneNumber
						});
						
						marker.setMap(map);
						
						markers.push(marker);
						
					});
					
					var listDists = data.response.body.listDist;
					
					for (var i = 0; i < listDists.length; i++) {
						$("#user").append("<option value='" + listDists[i] + "'>" + listDists[i] + "</option>");
					}
				}
			});
		}
}
</script>
</head>
<body>
<div id="wrap">

	<div id="container">
	
		<div class="contents">
		
			<h2><span class="titel-text-sm">OA&M > </span>사용자 분석</h2>
			
			<table>
			
				<tr>
				
					<td>
						<div id="map_view" style="width:750px; height:500px; margin:auto;"></div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=aefd6bcbe341d2c6658f3f28b1f654dd&libraries=services"></script>				<!-- 2017. 08. 28 JBum | Daum Map API 변경에 따른 소스 변경 -->
					</td>
				
				</tr>
				<tr>
					<td>
						<a>지난 주&nbsp;&nbsp;&nbsp;</a>				
						<input id="startDay" name="startDay" type="text" class="date_format"/>
			    		<a>&nbsp;&nbsp;&nbsp;다음 주</a>
					</td>
				</tr>				
				<tr>
					<td style="font-size:20px; font-weight:bold;">
						기간 내 트래픽 수 : <span id="countNonDist"></span> 
					</td>
				</tr>
				<tr>
					<td style="font-size:20px; font-weight:bold;">
						기간 내 접속자 수 : <span id="countDist"></span> 
					</td>
				</tr>
			</table>
			
			<div>

				<select id="user">
					<option selected='selected'>전체보기</option>
				</select>
			
			</div>
			
			<table>
				<colgroup>
					<col width="10%"/>
					<col width="18%"/>
					<col width="18%"/>
					<col width="18%"/>
					<col width="18%"/>
					<col width="18%"/>					
				</colgroup>
				<thead>
					<tr>
						<th scope="col">NO</th>
						<th scope="col">API명</th>
						<th scope="col">전화번호</th>
						<th scope="col">Latitude</th>
						<th scope="col">Longitude</th>
						<th scope="col">DateTime</th>
					</tr>
				</thead>
				<tbody id="userList">
					<tr class="src_row" style="display:none" align="center">
						<td><span class="idx"></span></td>
						<td><span class="api"></span></td>
						<td><span class="phone"></span></td>
						<td><span class="latitude"></span></td>
						<td><span class="longitude"></span></td>
						<td><span class="dttm"></span></td>
					</tr>
				</tbody>
			</table>
			
		</div>
	
	</div>

</div>
</body>
</html>