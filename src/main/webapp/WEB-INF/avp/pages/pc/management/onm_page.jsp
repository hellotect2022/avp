<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<title>O & M | smartconvergence</title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css"/>
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
var arCount;
var remainAr;
var successWorkRate;
var remainWorkRate;
$(document).ready(function(){
	
	arCount = parseInt("${arCount}");
	remainAr = parseInt("${remainAr}");
	successWorkRate = parseInt("${successWorkRate}");
	remainWorkRate = parseInt("${remainWorkRate}");
	
	console.log(arCount);
	console.log(remainAr);
	console.log(successWorkRate);
	console.log(remainWorkRate);
	
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
});

function drawChart() {
	var data = new google.visualization.DataTable();
	
	data.addColumn('string', 'name');
	data.addColumn('number', 'rate');
	
	data.addRows([
		['인식횟수', arCount],
		['남은횟수', remainAr]
	]);
	
	var opt = {
		'title': 'AR 인식 횟수',
		'width': 600,
		'height': 600,
		pieSliceText: 'label'
	};
	
	var arCountChart = new google.visualization.PieChart(document.getElementById('pieArCount'));
	var workRateChart = new google.visualization.PieChart(document.getElementById('pieWorkRate'));
	
	arCountChart.draw(data, opt);
	
	var data = new google.visualization.DataTable();
	
	data.addColumn('string', 'name');
	data.addColumn('number', 'rate');
	
	data.addRows([		
		['완료', successWorkRate],
		['미완', remainWorkRate]
	]);
	
	var opt = {
		'title': '작업 완료율(' + "${todayDt}" + ' 기준)',
		'width': 600,
		'height': 600,
		pieSliceText: 'label'
	};
	
	workRateChart.draw(data, opt);
	
}

</script>
</head>


<body>
<div id="wrap">
	<!--본문-->       
	<div id="container"> 
		<div class="contents">
		<h2><span class="titel-text-sm">유지보수 > </span>O &amp; M</h2>
		<!-- CONTENTS -->
			<div>
				<div id="pieArCount" style="float:left;">
				</div>
				
				<div id="pieWorkRate" style="float:left;">
				</div>
			</div>
		<!-- CONTENTS -->
		</div>

		<!-- CONTAINER -->
		
	</div>
    
</div>     
</body>
</html>
