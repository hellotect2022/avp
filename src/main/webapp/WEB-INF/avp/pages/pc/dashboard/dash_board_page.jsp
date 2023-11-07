<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/canvasjs.min.js'/>"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
window.onload = function () {
	var monthlyLimitSize = "${monthlyLimitSize}";
	var remainSize = "${remainSize}";
	var allUserSaveSize = "${allUserSaveSize}";
	var remainSizePer = (remainSize / monthlyLimitSize *100).toFixed(2);
	var allUserSaveSizePer = (allUserSaveSize / monthlyLimitSize *100).toFixed(2);
	
	console.log("monthlyLimitSize ::" + monthlyLimitSize);
	console.log("remainSize ::" + remainSize);
	console.log("allUserSaveSize ::" + allUserSaveSize);
	console.log("remainSizePer ::" + remainSizePer);
	console.log("allUserSaveSizePer ::" + allUserSaveSizePer);
	console.log("allUserSaveSizePer ::" + parseInt(remainSizePer));
	
	
	var mySaveSize = "${mySaveSize}";
	var mySaveSizePer = (mySaveSize / monthlyLimitSize*100).toFixed(2);
	
	var chart = new CanvasJS.Chart("chartContainer",
	{
		title:{
			text: "전체기준 이번달 사용량",
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
				{  y:parseFloat(remainSizePer),d: remainSize, name: "남은 용량", legendMarkerType: "triangle"},
				{  y:parseFloat(allUserSaveSizePer),d: allUserSaveSize, name: "이번달 사용량", legendMarkerType: "square"}
			]
		}
		]
	});
	chart.render();
	
	
	var myLimitSize = "${myLimitSize}";
	var myRemainSize = "${myRemainSize}";
	var myRemainSizePer = (myRemainSize / myLimitSize *100).toFixed(2);
	var myLimitSaveSizePer = (mySaveSize / myLimitSize *100).toFixed(2);
	
	var chart = new CanvasJS.Chart("chartContainer2",
	{
		title:{
			text: "나의기준 이번달 사용량",
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
				{  y:parseFloat(myRemainSizePer),d: myRemainSize, name: "남은 용량", legendMarkerType: "triangle"},
				{  y:parseFloat(myLimitSaveSizePer),d: mySaveSize, name: "이번달 사용량", legendMarkerType: "square"}
			]
		}
		]
	});
	chart.render();
	
	
}
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("companyId"));
	});
});

var FN = 
{
		moveUpdatePage: function(companyId)
		{
			location.href = "/opr/company/companyUpdatePage/"+companyId
		},
		insert : function ()
		{
			$.ajax( "/opr/company/companyInsert",{
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
<div>대시보드 관리 > 대시보드</div>
<div class="section" style="height: 650px; margin-top: 10px">
<table> 
<tr> 
<th>등급</th> 
<td id="userType">${user.userType}</td> 
</tr>
<tr> 
<th>닉네임</th> 
<td id="nickName">${user.nickName}</td>
</tr>
<tr> 
<th>소속</th> 
<td id="companyShop">${user.companyShopName}</td>
</tr>
<tr> 
<th>가입일</th> 
<td id="createDate">${user.createDate}</td> 
</tr>
<tr>
<td><div id="chartContainer" style="height: 300px;  width: 300px"></div></td>
<td><div id="chartContainer2" style="height: 300px;  width: 300px"></div></td>
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

<title>대시보드관리 </title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);

var monthlyLimitSize = "${monthlyLimitSize}";
var remainSize = "${remainSize}";
var allUserSaveSize = "${allUserSaveSize}";
var remainSizePer = (remainSize / monthlyLimitSize *100).toFixed(2);
var allUserSaveSizePer = (allUserSaveSize / monthlyLimitSize *100).toFixed(2);

var mySaveSize = "${mySaveSize}";
var mySaveSizePer = (mySaveSize / monthlyLimitSize*100).toFixed(2);
var myLimitSize = "${myLimitSize}";
var myRemainSize = "${myRemainSize}";
var myRemainSizePer = (myRemainSize / myLimitSize *100).toFixed(2);
var myLimitSaveSizePer = (mySaveSize / myLimitSize *100).toFixed(2);

function drawChart() {
	var data1 = google.visualization.arrayToDataTable([
		['Name', 'Number'],
		['남은 용량', monthlyLimitSize - allUserSaveSize],
		['이번달 사용량', monthlyLimitSize - remainSize]
	]);
	var options1 = {
			title: '전체기준 이번달 사용량'
	}
	
	var chart1 = new google.visualization.PieChart(document.getElementById('chartContainer'));
	chart1.draw(data1, options1);
	
	var data2 = google.visualization.arrayToDataTable([
		['Name', 'Number'],
		['남은 용량', myLimitSize - mySaveSize],
		['이번달 사용량', myLimitSize - myRemainSize]
	]);
	var options2 = {
			title: '나의 기준 이번달 사용량'
	}
	
	var chart2 = new google.visualization.PieChart(document.getElementById('chartContainer2'));
	chart2.draw(data2, options2);
}

$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#updateBtn").click(function(){
		FN.moveUpdatePage($(this).attr("companyId"));
	});
});

var FN = 
{
		moveUpdatePage: function(companyId)
		{
			location.href = "/opr/company/companyUpdatePage/"+companyId
		},
		insert : function ()
		{
			$.ajax( "/opr/company/companyInsert",{
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
			<h2><span class="titel-text-sm">대시보드  > </span>대시보드관리</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>대시보드</legend>	
					<table class="mytable2">
						<caption>대시보드</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">등급</td>
							<td class="tdbg02">${user.userType}</td>                
						</tr>
						
						<!-- 사용량 조회 -->
						<tr>													<!-- Add. 2017. 05. 19. JBum -->
							<td class="tdbg01" scope="col">신청한 사용량</td>			<!-- Add. 2017. 05. 19. JBum -->
							<td class="tdbg02">									<!-- Add. 2017. 05. 19. JBum -->
								<script>										<!-- Add. 2017. 05. 19. JBum -->
									var tmp = "${user.storageSize}";			<!-- Add. 2017. 05. 19. JBum -->
									var ss;										<!-- Add. 2017. 05. 19. JBum -->
									if (tmp >= 1073741824) {					<!-- Add. 2017. 05. 19. JBum -->
										ss = tmp / 1024 / 1024 / 1024;			<!-- Add. 2017. 05. 19. JBum -->
										document.write(ss + " GB");				<!-- Add. 2017. 05. 19. JBum -->
									} else {									<!-- Add. 2017. 05. 19. JBum -->
										ss = tmp / 1024 / 1024;					<!-- Add. 2017. 05. 19. JBum -->
										document.write(ss + " MB");				<!-- Add. 2017. 05. 19. JBum -->
									}											<!-- Add. 2017. 05. 19. JBum -->
								</script>										<!-- Add. 2017. 05. 19. JBum -->
							</td>												<!-- Add. 2017. 05. 19. JBum -->
						</tr>													<!-- Add. 2017. 05. 19. JBum -->
						
						<tr>
							<td class="tdbg01" scope="col">닉네임</td>
							<td class="tdbg02">${user.nickName}</td>                
						</tr>
						
						<tr>
							<td class="tdbg01" scope="col">소속</td>
							<td class="tdbg02">${user.companyShopName}</td>                
						</tr>
						
						<tr>		
							<td class="tdbg01" scope="col">가입일</td>
							<td>${user.createDate}</td>
						</tr>
					</table>
					
					
					<div class="data-amount" >
						<div class="whole">
							<div id="chartContainer" style="height: 300px;  width: 300px; display:none;"></div>
							<%--
							<p>전체기준 이번달 사용량 </p>
							<div id="whole-month"><img src="../images/circle.png" width="100%"></div>	
							<div class="data-icon"><img src="../images/dot6.png" alt="남은용량"><span>남은용량</span><img src="../images/dot5.png" alt="사용량"><span>이번달 사용량</span></div>
							--%>
						</div>
						<div class="whole" >
							<div id="chartContainer2" style="height: 300px;  width: 300px; display:none;"></div>
							<%--
							<p> 나의기준 이번달 사용량</p>
							<div id="mywhole-month"><img src="../images/circle.png" width="100%"></div>
							<div class="data-icon"><img src="../images/dot6.png" alt="남은용량"><span>남은용량</span><img src="../images/dot5.png" alt="사용량"><span>이번달 사용량</span></div>
							--%>
						</div>
					</div>
				</form>
			</fieldset>
			
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    

</body>
</html>
