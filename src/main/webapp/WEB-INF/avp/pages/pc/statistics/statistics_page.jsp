<%@ page language="java" contentType="text/html; chshopset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/canvasjs.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<script type="text/javascript">
window.onload = function () {
	var monthlyReamilSize = "${monthlyReamilSize}";
	var monthlySize = "${monthlySize}";
	var monthlyReamilSizePer = (monthlyReamilSize / monthlySize *100).toFixed(2);
	var allUserSaveSize = "${allUserSaveSize}";
	var allUserSaveSizePer = (allUserSaveSize / monthlySize*100).toFixed(2);
	
	console.log("monthlyReamilSize ::: " + monthlyReamilSize);
	console.log("monthlySize ::: " + monthlySize);
	console.log("monthlyReamilSizePer ::: " + monthlyReamilSizePer);
	console.log("allUserSaveSize ::: " + allUserSaveSize);
	console.log("allUserSaveSizePer ::: " + allUserSaveSizePer);
	var chart = new CanvasJS.Chart("chartContainer",
	{
		title:{
			text: "이번달 사용량",
			fontFamily: "arial black"
		},
                animationEnabled: true,
		legend: {
			verticalAlign: "bottom",
			horizontalAlign: "center"
		},
		theme: "theme1",
		data: [
		{        
			type: "pie",
			indexLabelFontFamily: "Garamond",       
			indexLabelFontSize: 20,
			indexLabelFontWeight: "bold",
			startAngle:0,
			indexLabelFontColor: "MistyRose",       
			indexLabelLineColor: "darkgrey", 
			indexLabelPlacement: "inside", 
			toolTipContent: "{name}: {d}byte",
			showInLegend: true,
// 			indexLabel: "#percent%", 
			indexLabel: "#percent%", 
			dataPoints: [
				{  y:parseFloat(monthlyReamilSizePer),d: monthlyReamilSize, name: "남은 용량", legendMarkerType: "triangle"},
				{  y:parseFloat(allUserSaveSizePer),d: "${allUserSaveSize}", name: "이번달 사용량", legendMarkerType: "square"}
			]
		}
		]
	});
	chart.render();
	
	
	var limitAuthCount = "${limitAuthCount}";
	var dailyRemainAuthCount = "${dailyRemainAuthCount}";
	var dailyRemainAuthCountPer = (dailyRemainAuthCount / limitAuthCount *100).toFixed(2);
	var dailyUsedAuthCount = "${dailyUsedAuthCount}";
	var dailyUsedAuthCountPer = (dailyUsedAuthCount / limitAuthCount*100).toFixed(2);
	
	console.log("limitAuthCount ::: " + limitAuthCount);
	console.log("dailyRemainAuthCount ::: " + monthlySize);
	console.log("dailyRemainAuthCountPer ::: " + dailyRemainAuthCountPer);
	console.log("dailyUsedAuthCount ::: " + dailyUsedAuthCount);
	console.log("dailyUsedAuthCountPer ::: " + dailyUsedAuthCountPer);
	
	
	var chartTmap = new CanvasJS.Chart("tmapAuthContainer",
			{
				title:{
					text: "티맵 인증 금일 사용량",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(dailyRemainAuthCountPer),d: dailyRemainAuthCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(dailyUsedAuthCountPer),d: dailyUsedAuthCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartTmap.render();
	
	var limitTmapviewCount		 = "${limitTmapviewCount}";
	var dailyRemainTmapviewCount = "${dailyRemainTmapviewCount}";
	var dailyRemainTmapviewCountPer  = (dailyRemainTmapviewCount / limitTmapviewCount *100).toFixed(2);
	var dailyUsedTmapViewCount		 = "${dailyUsedTmapViewCount}";
	var dailyUsedTmapViewCountPer	 = (dailyUsedTmapViewCount / limitTmapviewCount*100).toFixed(2);
	
	var chartTmapView = new CanvasJS.Chart("tmapViewContainer",
			{
				title:{
					text: "티맵 지도보기 금일 사용량",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(dailyRemainTmapviewCountPer),d: dailyRemainTmapviewCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(dailyUsedTmapViewCountPer),d: dailyUsedTmapViewCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartTmapView.render();
	
	
	var limitRoadInfoCount		 = "${limitRoadInfoCount}";
	var dailyRemainRoadInfoCount = "${dailyRemainRoadInfoCount}";
	var dailyRemainRoadInfoCountPer  = (dailyRemainRoadInfoCount / limitRoadInfoCount *100).toFixed(2);
	var dailyUsedRoadInfoCount		 = "${dailyUsedRoadInfoCount}";
	var dailyUsedRoadInfoCountPer	 = (dailyUsedTmapViewCount / limitRoadInfoCount*100).toFixed(2);
	
	var chartTmapRoadInfo = new CanvasJS.Chart("tmapRoadInfoContainer",
			{
				title:{
					text: "티맵 길안내 금일 사용량",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(dailyRemainRoadInfoCountPer),d: dailyRemainRoadInfoCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(dailyUsedRoadInfoCountPer),d: dailyUsedRoadInfoCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartTmapRoadInfo.render();
	
	var limitCloudTargetsCount		 = "${limitCloudTargetsCount}";
	var monthlyRemainCloudTargetsCount = "${monthlyRemainCloudTargetsCount}";
	var monthlyRemainCloudTargetsCountPer  = (monthlyRemainCloudTargetsCount / limitCloudTargetsCount *100).toFixed(2);
	var monthlyUsedCloudTargetsCount		 = "${monthlyUsedCloudTargetsCount}";
	var monthlyUsedCloudTargetsCountPer	 = (monthlyUsedCloudTargetsCount / limitRoadInfoCount*100).toFixed(2);
	
	var chartVuforiaTarget = new CanvasJS.Chart("vuforiaTargetContainer",
			{
				title:{
					text: "이번달 뷰포리아 인식 횟수",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(monthlyRemainCloudTargetsCountPer),d: monthlyRemainCloudTargetsCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(monthlyUsedCloudTargetsCountPer),d: monthlyUsedCloudTargetsCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartVuforiaTarget.render();
	
	
	var limitCloudRecosCount		 = "${limitCloudRecosCount}";
	var monthlyRemainCloudRecosCount = "${monthlyRemainCloudRecosCount}";
	var monthlyRemainCloudRecosCountPer  = (monthlyRemainCloudRecosCount / limitCloudRecosCount *100).toFixed(2);
	var monthlyUsedCloudRecosCount		 = "${monthlyUsedCloudRecosCount}";
	var monthlyUsedCloudRecosCountPer	 = (monthlyUsedCloudRecosCount / limitCloudRecosCount*100).toFixed(2);
	
	var chartVuforiaRecos = new CanvasJS.Chart("vuforiaRecosContainer",
			{
				title:{
					text: "이번달 뷰포리아 등록 횟수",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(monthlyRemainCloudRecosCountPer),d: monthlyRemainCloudRecosCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(monthlyUsedCloudRecosCountPer),d: monthlyUsedCloudRecosCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartVuforiaRecos.render();
	
	

	var limitFileGetCount		 = "${limitFileGetCount}";
	var monthlyRemainFileGetCount = "${monthlyRemainFileGetCount}";
	var monthlyRemainFileGetCountPer  = (monthlyRemainFileGetCount / limitFileGetCount *100).toFixed(2);
	var monthlyUsedFileGetCount		 = "${monthlyUsedFileGetCount}";
	var monthlyUsedFileGetCountPer	 = (monthlyUsedFileGetCount / limitFileGetCount*100).toFixed(2);
	
	var chartFileGet = new CanvasJS.Chart("fileGetContainer",
			{
				title:{
					text: "이번달 s3 파일 로드 횟수",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(monthlyRemainFileGetCountPer),d: monthlyRemainFileGetCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(monthlyUsedFileGetCountPer),d: monthlyUsedFileGetCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartFileGet.render();
	
	
	var limitFilePutCount		 = "${limitFilePutCount}";
	var monthlyRemainFilePutCount = "${monthlyRemainFilePutCount}";
	var monthlyRemainFilePutCountPer  = (monthlyRemainFilePutCount / limitFilePutCount *100).toFixed(2);
	var monthlyUsedFilePutCount		 = "${monthlyUsedFilePutCount}";
	var monthlyUsedFilePutCountPer	 = (monthlyUsedFilePutCount / limitFilePutCount*100).toFixed(2);
	
	console.log(limitFilePutCount)
	console.log(monthlyRemainFilePutCount)
	console.log(monthlyRemainFilePutCountPer)
	console.log(monthlyUsedFilePutCount)
	console.log(monthlyUsedFilePutCountPer)
	
	var chartFilePut = new CanvasJS.Chart("filePutContainer",
			{
				title:{
					text: "이번달 s3 파일 저장 횟수",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(monthlyRemainFilePutCountPer),d: monthlyRemainFilePutCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(monthlyUsedFilePutCountPer),d: monthlyUsedFilePutCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	chartFilePut.render();
	
	
	var limitRdsCount		 = "${limitRdsCount}";
	var monthlyUsedRdsCount = "${monthlyUsedRdsCount}";
	var monthlyUsedRdsCountPer  = (monthlyUsedRdsCount / limitRdsCount *100).toFixed(2);
	var monthlyRemainRdsCount		 = "${monthlyRemainRdsCount}";
	var monthlyRemainRdsCountPer	 = (monthlyRemainRdsCount / limitRdsCount*100).toFixed(2);
	console.log(limitRdsCount)
	console.log(monthlyUsedRdsCount)
	console.log(monthlyUsedRdsCountPer)
	console.log(monthlyRemainRdsCount)
	console.log(monthlyRemainRdsCountPer)
	var rdsContainer = new CanvasJS.Chart("rdsContainer",
			{
				title:{
					text: "이번달 쿼리 요청 횟수",
					fontFamily: "arial black"
				},
		                animationEnabled: true,
				legend: {
					verticalAlign: "bottom",
					horizontalAlign: "center"
				},
				theme: "theme1",
				data: [
				{        
					type: "pie",
					indexLabelFontFamily: "Garamond",       
					indexLabelFontSize: 20,
					indexLabelFontWeight: "bold",
					startAngle:0,
					indexLabelFontColor: "MistyRose",       
					indexLabelLineColor: "darkgrey", 
					indexLabelPlacement: "inside", 
					toolTipContent: "{name}: {d}번",
					showInLegend: true,
//		 			indexLabel: "#percent%", 
					indexLabel: "#percent%", 
					dataPoints: [
						{  y:parseFloat(monthlyRemainRdsCountPer),d: monthlyRemainRdsCount, name: "남은 횟수", legendMarkerType: "triangle"},
						{  y:parseFloat(monthlyUsedRdsCountPer),d: monthlyUsedRdsCount, name: "사용 횟수", legendMarkerType: "square"}
					]
				}
				]
			});
	rdsContainer.render();
	
	
}
</script>
	<script type="text/javascript" src="/assets/script/canvasjs.min.js"></script>
</head>
<script type="text/javascript">

var pageInfo = 
{	
	"page":1,
	"size":10
}
var period = null;
var searchName = null;
var searchCategory	=null
var dc = null;
var userId = "${userId}";
$(document).ready(function(){
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
// 	FN.list();
});

var FN = 
{
		movePage:function(page)
		{
			var query = "page="+page;
			if(period != null)
			{
				query += "&startYmd=" + period.startYmd + "&endYmd=" + period.endYmd;
			}
			if(searchCategory != null && searchCategory!= '')
			{
				query +="&searchCategory=" + searchCategory;
				query +="&searchName=" + searchName;

			}
			document.location.hash = "#" + query;
		},
		detail:function(shopId) {
			location.href = "/opr/shop/shopDetailPage/"+shopId+"/"+userId;
			
		}
}

</script>
<div>ON&M > ON&M 관리 </div>
<div class="section">
<table>
<tr>
<td>
<div id="chartContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="tmapAuthContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="tmapViewContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="tmapRoadInfoContainer" style="height: 300px;  width: 300px"></div>
</td>
</tr>
<tr>
<td>
<div id="vuforiaTargetContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="vuforiaRecosContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="fileGetContainer" style="height: 300px;  width: 300px"></div>
</td>
<td>
<div id="filePutContainer" style="height: 300px;  width: 300px"></div>
</td>
</tr>
<tr>
<td>
<div id="rdsContainer" style="height: 300px;  width: 300px"></div>
</td>
</tr>
</table>
<!-- <div id="chartContainer" style="height: 300px; width: 100%;"></div> -->
	<!-- //sub_contents -->
</div>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>OA&M 관리</title>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);

var monthlyReamilSize = "${monthlyReamilSize}";
var monthlySize = "${monthlySize}";
var monthlyReamilSizePer = (monthlyReamilSize / monthlySize *100).toFixed(2);
var allUserSaveSize = "${allUserSaveSize}";
var allUserSaveSizePer = (allUserSaveSize / monthlySize*100).toFixed(2);

var limitAuthCount = "${limitAuthCount}";
var dailyRemainAuthCount = "${dailyRemainAuthCount}";
var dailyRemainAuthCountPer = (dailyRemainAuthCount / limitAuthCount *100).toFixed(2);
var dailyUsedAuthCount = "${dailyUsedAuthCount}";
var dailyUsedAuthCountPer = (dailyUsedAuthCount / limitAuthCount*100).toFixed(2);

var limitTmapviewCount		 = "${limitTmapviewCount}";
var dailyRemainTmapviewCount = "${dailyRemainTmapviewCount}";
var dailyRemainTmapviewCountPer  = (dailyRemainTmapviewCount / limitTmapviewCount *100).toFixed(2);
var dailyUsedTmapViewCount		 = "${dailyUsedTmapViewCount}";
var dailyUsedTmapViewCountPer	 = (dailyUsedTmapViewCount / limitTmapviewCount*100).toFixed(2);

var limitRoadInfoCount		 = "${limitRoadInfoCount}";
var dailyRemainRoadInfoCount = "${dailyRemainRoadInfoCount}";
var dailyRemainRoadInfoCountPer  = (dailyRemainRoadInfoCount / limitRoadInfoCount *100).toFixed(2);
var dailyUsedRoadInfoCount		 = "${dailyUsedRoadInfoCount}";
var dailyUsedRoadInfoCountPer	 = (dailyUsedTmapViewCount / limitRoadInfoCount*100).toFixed(2);

var limitCloudTargetsCount		 = "${limitCloudTargetsCount}";
var monthlyRemainCloudTargetsCount = "${monthlyRemainCloudTargetsCount}";
var monthlyRemainCloudTargetsCountPer  = (monthlyRemainCloudTargetsCount / limitCloudTargetsCount *100).toFixed(2);
var monthlyUsedCloudTargetsCount		 = "${monthlyUsedCloudTargetsCount}";
var monthlyUsedCloudTargetsCountPer	 = (monthlyUsedCloudTargetsCount / limitRoadInfoCount*100).toFixed(2);

var limitCloudRecosCount		 = "${limitCloudRecosCount}";
var monthlyRemainCloudRecosCount = "${monthlyRemainCloudRecosCount}";
var monthlyRemainCloudRecosCountPer  = (monthlyRemainCloudRecosCount / limitCloudRecosCount *100).toFixed(2);
var monthlyUsedCloudRecosCount		 = "${monthlyUsedCloudRecosCount}";
var monthlyUsedCloudRecosCountPer	 = (monthlyUsedCloudRecosCount / limitCloudRecosCount*100).toFixed(2);

var limitFileGetCount		 = "${limitFileGetCount}";
var monthlyRemainFileGetCount = "${monthlyRemainFileGetCount}";
var monthlyRemainFileGetCountPer  = (monthlyRemainFileGetCount / limitFileGetCount *100).toFixed(2);
var monthlyUsedFileGetCount		 = "${monthlyUsedFileGetCount}";
var monthlyUsedFileGetCountPer	 = (monthlyUsedFileGetCount / limitFileGetCount*100).toFixed(2);

var limitFilePutCount		 = "${limitFilePutCount}";
var monthlyRemainFilePutCount = "${monthlyRemainFilePutCount}";
var monthlyRemainFilePutCountPer  = (monthlyRemainFilePutCount / limitFilePutCount *100).toFixed(2);
var monthlyUsedFilePutCount		 = "${monthlyUsedFilePutCount}";
var monthlyUsedFilePutCountPer	 = (monthlyUsedFilePutCount / limitFilePutCount*100).toFixed(2);

var limitRdsCount		 = "${limitRdsCount}";
var monthlyUsedRdsCount = "${monthlyUsedRdsCount}";
var monthlyUsedRdsCountPer  = (monthlyUsedRdsCount / limitRdsCount *100).toFixed(2);
var monthlyRemainRdsCount		 = "${monthlyRemainRdsCount}";
var monthlyRemainRdsCountPer	 = (monthlyRemainRdsCount / limitRdsCount*100).toFixed(2);

console.log(monthlySize - monthlyReamilSize);
console.log(monthlySize - allUserSaveSize);

function drawChart() {
	var data1 = google.visualization.arrayToDataTable([
		['Name', 'Number'],
		['남은 용량', monthlySize - allUserSaveSize],
		['이번달 사용량', monthlySize - monthlyReamilSize]
	]);
	var options1 = {
			title: '이번달 사용량'
	}
	
	var chart1 = new google.visualization.PieChart(document.getElementById('chartContainer'));
	chart1.draw(data1, options1);
	
	
	
	var data2 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitAuthCount - dailyUsedAuthCount],
		['사용 횟수', limitAuthCount - dailyRemainAuthCount]
	]);
	var options2 = {
			title: '티맵 인증 금일 사용량'
	}
	
	var chart2 = new google.visualization.PieChart(document.getElementById('tmapAuthContainer'));
	chart2.draw(data2, options2);
		
	
	
	var data3 = google.visualization.arrayToDataTable([
		['Name', 'Month'],
		['남은 횟수', limitTmapviewCount - dailyUsedTmapViewCount],
		['사용 횟수', limitTmapviewCount - dailyRemainTmapviewCount]
	]);
	var options3 = {
			title: '티맵 지도보기 금일 사용량'
	}
	
	var chart3 = new google.visualization.PieChart(document.getElementById('tmapViewContainer'));
	chart3.draw(data3, options3);
	
	
	
	var data4 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitRoadInfoCount - dailyUsedRoadInfoCount],
		['사용 횟수', limitRoadInfoCount - dailyRemainRoadInfoCount]
	]);
	var options4 = {
			title: '티맵 길안내 금일 사용량'
	}
	
	var chart4 = new google.visualization.PieChart(document.getElementById('tmapRoadInfoContainer'));
	chart4.draw(data4, options4);
	
	
	
	var data5 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitCloudTargetsCount - monthlyUsedCloudTargetsCount],
		['사용 횟수', limitCloudTargetsCount - monthlyRemainCloudTargetsCount]
	]);
	var options5 = {
			title: '이번달 VF 인식 횟수'
	}
	
	var chart5 = new google.visualization.PieChart(document.getElementById('vuforiaTargetContainer'));
	chart5.draw(data5, options5);
	
	
	
	var data6 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitCloudRecosCount - monthlyUsedCloudRecosCount],
		['사용 횟수', limitCloudRecosCount - monthlyRemainCloudRecosCount]
	]);
	var options6 = {
			title: '이번달 VF 등록 횟수'
	}
	
	var chart6 = new google.visualization.PieChart(document.getElementById('vuforiaRecosContainer'));
	chart6.draw(data6, options6);
	
	
	
	var data7 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitFileGetCount - monthlyUsedFileGetCount],
		['사용 횟수', limitFileGetCount - monthlyRemainFileGetCount]
	]);
	var options7 = {
			title: '이번달 S3 파일 로드 횟수'
	}
	
	var chart7 = new google.visualization.PieChart(document.getElementById('fileGetContainer'));
	chart7.draw(data7, options7);
	
	
	
	var data8 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitFilePutCount - monthlyUsedFilePutCount],
		['사용 횟수', limitFilePutCount - monthlyRemainFilePutCount]
	]);
	var options8 = {
			title: '이번달 S3 파일 저장 횟수'
	}
	
	var chart8 = new google.visualization.PieChart(document.getElementById('filePutContainer'));
	chart8.draw(data8, options8);
	
	
	
	var data9 = google.visualization.arrayToDataTable([
		['Name', 'Mount of Month'],
		['남은 횟수', limitRdsCount - monthlyUsedRdsCount],
		['사용 횟수', limitRdsCount - monthlyRemainRdsCount]
	]);
	var options9 = {
			title: '이번달 Query 요청 횟수'
	}
	
	var chart9 = new google.visualization.PieChart(document.getElementById('rdsContainer'));
	chart9.draw(data9, options9);
}

</script>
<script type="text/javascript">

var pageInfo = 
{	
	"page":1,
	"size":10
}
var period = null;
var searchName = null;
var searchCategory	=null
var dc = null;
var userId = "${userId}";
$(document).ready(function(){
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
// 	FN.list();
});

var FN = 
{
		movePage:function(page)
		{
			var query = "page="+page;
			if(period != null)
			{
				query += "&startYmd=" + period.startYmd + "&endYmd=" + period.endYmd;
			}
			if(searchCategory != null && searchCategory!= '')
			{
				query +="&searchCategory=" + searchCategory;
				query +="&searchName=" + searchName;

			}
			document.location.hash = "#" + query;
		},
		detail:function(shopId) {
			location.href = "/opr/shop/shopDetailPage/"+shopId+"/"+userId;
			
		}
}

</script>

<style>

.menu-wrap {padding:60px 0px 450px 50px;float:left;width:200px;  background-color:#f5f5f5;}

</style>
</head>


<body>

<div id="wrap">
   
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">OA&M > </span>OA&M 관리</h2>
			<div class="on-data-amount" >
				<div class="on-whole">
					<div id="chartContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole">
					<div id="tmapAuthContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole" id="query">
					<div id="tmapViewContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole">
					<div id="tmapRoadInfoContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole">
					<div id="vuforiaTargetContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole" id="query">
					<div id="vuforiaRecosContainer" style="height: 300px;  width: 500px"></div>
				</div>	
				<div class="on-whole">
					<div id="fileGetContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole">
					<div id="filePutContainer" style="height: 300px;  width: 500px"></div>
				</div>
				<div class="on-whole" id="query">
					<div id="rdsContainer" style="height: 300px;  width: 500px"></div>
				</div>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>

</body>
</html>
