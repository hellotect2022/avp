<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--

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
var pageInfo = 
{	
	"page":1,
	"size":10
}
var period = null;
var searchName = null;
var searchCategory = null;
var dc = null;
var userId = "${userId}";
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	var userType =	"${user.userType}";

	if("ADMIN"	==	userType)
		{
			$("#userType").text("관리자")
		}
		else if("SELLER"	==	userType)
		{
			$("#userType").text("판매자")
		}
		else if("NORMAL"	==	userType)
		{
			$("#userType").text("일반 사용자")
		}
	var myStorage =	"${user.storageSize}"; 
	
	var myUsedSize =	"${myUsedSize}"; 
	
	
	$("#cancelBtn").click(function(){
		history.back();
	});
	$("#deleteBtn").click(function(){
		if(!confirm("삭제 하시겠습니까?"))
		{
			return false;	
		}		
		FN.dialogShow();
		FN.userDelete($(this).attr("userId"));
	});
	
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
		dialogShow:function(){
			var width = $(document).width();
			var height = $(window).height();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		userDelete:function(userId)
		{
			$.ajax( "/opr/user/userDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"delUserId":userId
// 					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("삭제 성공");
			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/user/userDelete :"+status;
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
		moveCancelPage:function()
		{
			history.bakck();
		},
		startBtEndYmdAndAlert : function ()
		{
			var startYmd = $("#search_sday").val();
			var endYmd = $("#search_eday").val()
			
			if(startYmd.replace(/-/g,'') > endYmd.replace(/-/g,'')){
				alert("시작일이 종료일보다 클수 없습니다.");
				$("#search_eday").val("");
				return false;
			}
		},
		moveDetailPage : function (rwdId)
		{
			location.href="/pc/reward/detailPage?rwdId="+rwdId;
		},
		moveInsertPage: function()
		{
			location.href="/pc/reward/insertPage";
		},
		list : function()
		{
			$.ajax( "/pc/user/userList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":{
						"page":pageInfo.page,
						"size":pageInfo.size
					},
					"searchName":searchName,
					"searchCategory":searchCategory
// 					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var users = data.response.body.users;
			 		
			 		pageInfo = data.response.body.pageInfo;

			 		//기존 row들 삭제
			 		$("#userList .row").detach();
			 		
			 		//데이터가 없으면
			 		if(pageInfo.resultCount == 0)
			 		{
			 			$("#userList .nodata").css("display", "");
			 			$("#paging").css("display", "none");
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#userList .nodata").css("display", "none");
		 			$("#paging").css("display", "");
		 			$(".table_box input[type=checkbox]").prop('checked',false);

			 		var topRowCnt = pageInfo.totalCount - ((pageInfo.page-1) * pageInfo.size);

			 		$(users).each(function(idx) {
			 			var row = $("#userList .src_row").clone();
			 			$(row).removeClass("src_row");
			 			$(row).addClass("row");
			 			$(row).find(".topRowCnt").text(topRowCnt-idx);
			 			$(row).find(".nickName").text(users[idx].nickName);
			 			$(row).find(".snsType").text(users[idx].snsType);
			 			var str ="";	
			 			if("ADMIN"	==	users[idx].userType)
			 			{
			 				str = "관리자"
			 			}
			 			else if("SELLER"	==	users[idx].userType)
			 			{
			 				str = "판매자"
			 			}
			 			else if("NORMAL"	==	users[idx].userType)
			 			{
			 				str = "일반 사용자"
			 			}
			 			$(row).find(".userType").text(str);
			 			$(row).find(".companyShopName").text(users[idx].companyShopName);
			 			$(row).find(".createDate").text(users[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(users[idx].companyId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#userList").append(row);
			 		});
			 		
			 		
			 		if(pageInfo.lastPage == 1)
		 			{
			 			$("#paging .ppre").css("display", "none");
			 			$("#paging .nnext").css("display", "none");
		 			}
			 		else
			 		{
			 			$("#paging .ppre").css("display", "");
			 			$("#paging .nnext").css("display", "");
			 			
			 			$("#paging .ppre").click(function(){
				 			FN.movePage(1);
				 		});
				 		
			 			$("#paging .pre").click(function(){
			 				if(pageInfo.page-1 < 1){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page-1);
				 		});
				 		
			 			$("#paging .next").click(function(){
			 				if( pageInfo.page == pageInfo.lastPage){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page+1);
				 		});
				 		
			 			
				 		$("#paging .nnext").click(function(){
				 			FN.movePage(pageInfo.lastPage);
				 		});
			 		}
			 		
			 		$("#paging .page").detach();
			 		for(p=pageInfo.blockFirstPage; p<=pageInfo.blockLastPage; p++)
		 			{
			 			//<a href="#" class="on">1</a>
			 			var pageElement = document.createElement("a");
			 			$(pageElement).addClass("page");
			 			$(pageElement).attr("page", p);
			 			if(pageInfo.page == p)
		 				{
			 				$(pageElement).addClass("on");
			 				var strongElement = document.createElement("strong");
			 				$(strongElement).text(p);
			 				$(pageElement).append(strongElement);
		 				}
			 			else
		 				{
		 					$(pageElement).text(p);
		 					$(pageElement).click(function(){
		 						FN.movePage($(this).attr("page"));
		 					});
		 				}
			 			$("#paging .next").before(pageElement);
			 			
			 			$("#paging a").hover(function() {
	 				        $(this).css('cursor','pointer');
	 				    });
		 			}
			 	},
			 	error: function(result, status){
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("리워드 목록 조회 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
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
		detail:function(companyId) {
			location.href = "/pc/company/companyDetailPage/"+companyId+"/"+userId;
		}
}

</script>
<div>회원관리 > 회원목록  > 회원상세</div>
<div class="section sect">
<table> 
<tr> 
<th>등급</th> 
<td id="userType"></td> 
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
<th>폰번호</th> 
<td id="myUsedSize">${user.phone}</td>
</tr>
<tr> 
<th>가입일</th> 
<td id="createDate">${user.createDate}</td> 
</tr>
<tr>
<td><div id="chartContainer" style="height: 300px;  width: 300px"></div></td>
<td><div id="chartContainer2" style="height: 300px;  width: 300px"></div></td>
</tr>
<tr>
 <td colspan="2">
    <a id="deleteBtn" userId="${user.userId}" >강제탈퇴</a> 
  <a id="cancelBtn" >취소</a> 
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

<title>회원상세|SUPER ADMIN </title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
window.onload = function () {
	var monthlyLimitSize = "${monthlyLimitSize}";
	var remainSize = "${remainSize}";
	var allUserSaveSize = "${allUserSaveSize}";
	var remainSizePer = (remainSize / monthlyLimitSize *100).toFixed(2);
	var allUserSaveSizePer = (allUserSaveSize / monthlyLimitSize *100).toFixed(2);
	
	var myLimitSize = "${myLimitSize}";
	var myRemainSize = "${myRemainSize}";
	var myRemainSizePer = (myRemainSize / myLimitSize *100).toFixed(2);
	var myLimitSaveSizePer = (mySaveSize / myLimitSize *100).toFixed(2);
	
	var mySaveSize = "${mySaveSize}";
	var mySaveSizePer = (mySaveSize / monthlyLimitSize*100).toFixed(2);
	
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
			['Name', 'Mount of Month'],
			['남은 용량', myLimitSize - mySaveSize],
			['이번달 사용량', myLimitSize - myRemainSize]
		]);
		var options2 = {
				title: '나의기준 이번달 사용량'
		}
		
		var chart2 = new google.visualization.PieChart(document.getElementById('chartContainer2'));
		chart2.draw(data2, options2);
	}
}
var pageInfo = 
{	
	"page":1,
	"size":10
}
var period = null;
var searchName = null;
var searchCategory = null;
var dc = null;
var userId = "${userId}";
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	
	var userType =	"${user.userType}";

	if("ADMIN"	==	userType)
		{
			$("#userType").text("관리자")
		}
		else if("SELLER"	==	userType)
		{
			$("#userType").text("판매자")
		}
		else if("NORMAL"	==	userType)
		{
			$("#userType").text("일반 사용자")
		}
	var myStorage =	"${user.storageSize}"; 
	
	var myUsedSize =	"${myUsedSize}"; 
	
	
	$("#cancelBtn").click(function(){
		history.back();
	});
	$("#deleteBtn").click(function(){
		if(!confirm("삭제 하시겠습니까?"))
		{
			return false;	
		}		
		FN.dialogShow();
		FN.userDelete($(this).attr("userId"));
	});
	
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
		dialogShow:function(){
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
		userDelete:function(userId)
		{
			$.ajax( "/opr/user/userDelete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"delUserId":userId
// 					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert("삭제 성공");
			 	},
			 	error: function(result, status){
			 		var  statusStr = "/pc/user/userDelete :"+status;
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
		moveCancelPage:function()
		{
			history.bakck();
		},
		startBtEndYmdAndAlert : function ()
		{
			var startYmd = $("#search_sday").val();
			var endYmd = $("#search_eday").val()
			
			if(startYmd.replace(/-/g,'') > endYmd.replace(/-/g,'')){
				alert("시작일이 종료일보다 클수 없습니다.");
				$("#search_eday").val("");
				return false;
			}
		},
		moveDetailPage : function (rwdId)
		{
			location.href="/pc/reward/detailPage?rwdId="+rwdId;
		},
		moveInsertPage: function()
		{
			location.href="/pc/reward/insertPage";
		},
		list : function()
		{
			$.ajax( "/pc/user/userList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":{
						"page":pageInfo.page,
						"size":pageInfo.size
					},
					"searchName":searchName,
					"searchCategory":searchCategory
// 					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var users = data.response.body.users;
			 		
			 		pageInfo = data.response.body.pageInfo;

			 		//기존 row들 삭제
			 		$("#userList .row").detach();
			 		
			 		//데이터가 없으면
			 		if(pageInfo.resultCount == 0)
			 		{
			 			$("#userList .nodata").css("display", "");
			 			$("#paging").css("display", "none");
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#userList .nodata").css("display", "none");
		 			$("#paging").css("display", "");
		 			$(".table_box input[type=checkbox]").prop('checked',false);

			 		var topRowCnt = pageInfo.totalCount - ((pageInfo.page-1) * pageInfo.size);

			 		$(users).each(function(idx) {
			 			var row = $("#userList .src_row").clone();
			 			$(row).removeClass("src_row");
			 			$(row).addClass("row");
			 			$(row).find(".topRowCnt").text(topRowCnt-idx);
			 			$(row).find(".nickName").text(users[idx].nickName);
			 			$(row).find(".snsType").text(users[idx].snsType);
			 			var str ="";	
			 			if("ADMIN"	==	users[idx].userType)
			 			{
			 				str = "관리자"
			 			}
			 			else if("SELLER"	==	users[idx].userType)
			 			{
			 				str = "판매자"
			 			}
			 			else if("NORMAL"	==	users[idx].userType)
			 			{
			 				str = "일반 사용자"
			 			}
			 			$(row).find(".userType").text(str);
			 			$(row).find(".companyShopName").text(users[idx].companyShopName);
			 			$(row).find(".createDate").text(users[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(users[idx].companyId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#userList").append(row);
			 		});
			 		
			 		
			 		if(pageInfo.lastPage == 1)
		 			{
			 			$("#paging .ppre").css("display", "none");
			 			$("#paging .nnext").css("display", "none");
		 			}
			 		else
			 		{
			 			$("#paging .ppre").css("display", "");
			 			$("#paging .nnext").css("display", "");
			 			
			 			$("#paging .ppre").click(function(){
				 			FN.movePage(1);
				 		});
				 		
			 			$("#paging .pre").click(function(){
			 				if(pageInfo.page-1 < 1){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page-1);
				 		});
				 		
			 			$("#paging .next").click(function(){
			 				if( pageInfo.page == pageInfo.lastPage){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page+1);
				 		});
				 		
			 			
				 		$("#paging .nnext").click(function(){
				 			FN.movePage(pageInfo.lastPage);
				 		});
			 		}
			 		
			 		$("#paging .page").detach();
			 		for(p=pageInfo.blockFirstPage; p<=pageInfo.blockLastPage; p++)
		 			{
			 			//<a href="#" class="on">1</a>
			 			var pageElement = document.createElement("a");
			 			$(pageElement).addClass("page");
			 			$(pageElement).attr("page", p);
			 			if(pageInfo.page == p)
		 				{
			 				$(pageElement).addClass("on");
			 				var strongElement = document.createElement("strong");
			 				$(strongElement).text(p);
			 				$(pageElement).append(strongElement);
		 				}
			 			else
		 				{
		 					$(pageElement).text(p);
		 					$(pageElement).click(function(){
		 						FN.movePage($(this).attr("page"));
		 					});
		 				}
			 			$("#paging .next").before(pageElement);
			 			
			 			$("#paging a").hover(function() {
	 				        $(this).css('cursor','pointer');
	 				    });
		 			}
			 	},
			 	error: function(result, status){
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("리워드 목록 조회 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
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
		detail:function(companyId) {
			location.href = "/pc/company/companyDetailPage/"+companyId+"/"+userId;
		}
}

</script>
</head>

<body>
<div id="container"> 
	<div class="contents">
		<h2><span class="titel-text-sm">회원관리 > 회원목록 > </span>회원상세</h2>
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
						<td class="tdbg01" scope="col">등급</td>
						<td class="tdbg02" id="userType"></td>                
					</tr>
				
					<tr>
						<td class="tdbg01" scope="col">닉네임</td>
						<td class="tdbg02" id="nickName">${user.nickName}</td>                
					</tr>
					
					<tr>
						<td class="tdbg01" scope="col">소속</td>
						<td class="tdbg02" id="companyShop">${user.companyShopName}</td>                
					</tr>
					<tr>
						<td class="tdbg01" scope="col">폰번호</td>
						<td class="tdbg02" id="myUsedSize">${user.phone}</td>                
					</tr>

					<tr>
						<td class="tdbg01" scope="col">가입일</td>
						<td id="createDate">${user.createDate}</td>
					</tr>
				</table>
					
					
				<div class="data-amount" >
					<div class="whole">
						<div id="chartContainer" style="height: 300px;  width: 300px"></div>
					</div>
					<div class="whole" >
						<div id="chartContainer2" style="height: 300px;  width: 300px"></div>
					</div>
				</div>
			</form>
		</fieldset>
		<div class="paging">
			<button type="button" id="deleteBtn" class="pagebtn2" userId="${user.userId}"><span class="btntxt">강제탈퇴</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
		</div>
    <!-- //CONTENT -->
	</div>

<!-- //CONTAINER -->
 	
</div>

</body>
</html>