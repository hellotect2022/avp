<%@ page language="java" contentType="text/html; cheventset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<%--
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
	CO.checkForHash(); 
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	

	$("#btnSearch").click(function(){
		searchName = $("#searchName").val();
		searchCategory = $("#searchCategory option:selected").val();
		var searchCategoryName = $("#searchCategory option:selected").text();
		if(!$("#searchCategory option:selected").val().length > 0){
			searchCategory = null;
			$(".resultTxtDiv").hide();
			$("#searchName").val("");
		}
		else
		{
			$(".resultTxt").text(searchCategoryName+" : " +searchName+" 검색결과입니다.");
			$(".resultTxtDiv").show();
		}
		
		if(!$("#searchName").val().length > 0){
			searchName = null;
		};
		
		FN.movePage(1);
	});
	
	FN.dialogShow();
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
	        	
				FN.list();
		    }
			else
			{
				pageInfo.page = 1;
				searchCategory = null;
				searchName = null;
				period = null;
				FN.list();
			}
		}
};

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
		deleteAndReload : function ()
		{
			reward.params.rwdIds = new Array();
			$(".row .listChk:checked").each(function(){
				reward.params.rwdIds.push(this.value);
			});
			
			if(reward.params.rwdIds.length == 0)
			{
				alert('삭제 대상을 하나 이상 선택해주세요');
				return false;
			}
			
			if(!confirm("정말로 삭제 하시겠습니까?"))
			{
				return false;
			}
			
			console.log(reward.params);
			
			$.ajax( "/pc/reward/delete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(reward.params),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; cheventset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert('삭제되었습니다.');
			 		location.reload();

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
		},
		
		cancel : function()
		{
			history.back();			
		},
		
		modifyAndRedirect : function()
		{
			
		},
		
		list : function()
		{
			FN.dialogShow();
			$.ajax( "/pc/event/eventList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":{
						"page":pageInfo.page,
						"size":pageInfo.size
					},
					"searchCategory":searchCategory,
					"searchName":searchName,
					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; cheventset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var events = data.response.body.events;
			 		console.log(events)
			 		pageInfo = data.response.body.pageInfo;

			 		//기존 row들 삭제
			 		$("#eventList .row").detach();
			 		
			 		//데이터가 없으면
			 		if(pageInfo.resultCount == 0)
			 		{
			 			$("#eventList .nodata").css("display", "");
			 			$(".paging").css("display", "none");
				 		$(".backLayer").hide();			 		
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#eventList .nodata").css("display", "none");
		 			$(".paging").css("display", "");
		 			$(".table_box input[type=checkbox]").prop('checked',false);

			 		var topRowCnt = pageInfo.totalCount - ((pageInfo.page-1) * pageInfo.size);

			 		$(events).each(function(idx) {
			 			var row = $("#eventList .src_row").clone();
			 			$(row).removeClass("src_row");
			 			$(row).addClass("row");
					    
					    
			 			$(row).find(".topRowCnt").text(topRowCnt-idx);
			 			$(row).find(".templateTitle").text(events[idx].templateTitle);
			 			$(row).find(".eventType").text(events[idx].eventType);
			 			$(row).find(".eventYmd").text(events[idx].startYmd +"~"+events[idx].endYmd);
			 			$(row).find(".eventAfterType").text(events[idx].eventAfterType);
			 			$(row).find(".eventStatus").text(events[idx].eventStatus);
			 			$(row).find(".createDate").text(events[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(events[idx].eventId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#eventList").append(row);
			 		});
			 		$(".backLayer").hide();			 		
			 		
			 		if(pageInfo.lastPage == 1)
		 			{
			 			$(".paging .prev10").css("display", "none");
			 			$(".paging .next10").css("display", "none");
		 			}
			 		else
			 		{
			 			$(".paging .prev10").css("display", "");
			 			$(".paging .next10").css("display", "");
			 			
			 			$(".paging .prev10").click(function(){
				 			FN.movePage(1);
				 		});
				 		
			 			$(".paging .pre").click(function(){
			 				if(pageInfo.page-1 < 1){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page-1);
				 		});
				 		
			 			$(".paging .next").click(function(){
			 				if( pageInfo.page == pageInfo.lastPage){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page+1);
				 		});
				 		
			 			
				 		$(".paging .next10").click(function(){
				 			FN.movePage(pageInfo.lastPage);
				 		});
			 		}
			 		
			 		$(".paging .page").detach();
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
			 			$(".paging .next").before(pageElement);
			 			
			 			$(".paging a").hover(function() {
	 				        $(this).css('cursor','pointer');
	 				    });
		 			}
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
		detail:function(eventId) {
			location.href = "/pc/event/eventDetailPage?eventId="+eventId
		}
}

</script>
<div>이벤트 관리 > 이벤트 목록 </div>
<div class="section sect">
	<table class="type2">
		<colgroup>
		<col style="width:18%">
		<col style="width:82%">
		</colgroup>
		<tbody>
		<tr>
		<td>
		<select id="searchCategory">
		<option value="">전체</option>
		<option value="eventname">이벤트명</option>
		<option value="date">작성일</option>
		</select>
		</td>
		<td>
			<input type="text" id="searchName"><a id="btnSearch">검색</a>
		</td>
		</tr>
		</tbody>
	</table>
	<div class="resultTxtDiv" style="display: none;">
		<span class="resultTxt">검색 결과 입니다.</span>
	</div>
	
	<!-- sub_contents -->
	<div class="sub_contents">
		<!-- //table_box -->
		<!-- //btn_rgt_area -->
		<!-- table_box -->
		<div class="table_box mt10">
			<table class="type1">
			<colgroup>
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:15%">
			</colgroup>
			<thead>
			<tr>
			<th>No</th>
			<th>이벤트 타입</th>
			<th>이벤트 명</th>
			<th>진행날짜</th>
			<th>후이벤트 타입</h>
			<th>진행상태</h>
			<th>등록일자</h>
			</tr>
			</thead>
			<tbody id="eventList">
				<tr class="nodata" style="display:none">
					<td class="brln" colspan="4">- 데이터가 없습니다 -</td>
				</tr>
				<tr class="src_row" style="display:none">
					<td><a class="topRowCnt"></a></td>
					<td><a class="eventType"></a></td>
					<td><a class="templateTitle"></a></td>
					<td><a class="eventYmd"></a></td>
					<td><a class="eventAfterType"></a></td>
					<td><a class="eventStatus"></a></td>
					<td><a class="createDate"></a></td>
				</tr>
			</tbody>
			</table>
		</div>
	
	
		<div class="tb_bottom">
			<!-- paging  -->
			<div id="paging" class="paging">
			    <a class="prev10"><span class="blind">맨앞</span></a>
			    <a class="pre"><span class="blind">이전</span></a>
			    <a class="next"><span class="blind">다음</span></a>			    
			    <a class="next10"><span class="blind">맨끝</span></a>
			</div> 
			<!-- //paging -->
		</div>
		<!-- //tb_bottom -->
	</div>
	<!-- //sub_contents -->
</div>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>이벤트목록</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
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
$(document).ready(function(){
// 	dc = DateUtil.dateComponent();
	CO.checkForHash(); 
// 	dc.setYmd7Days();
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	

	$("#btnSearch").click(function(){
		searchName = $("#searchName").val();
		searchCategory = $("#searchCategory option:selected").val();
		var searchCategoryName = $("#searchCategory option:selected").text();
		if(!$("#searchCategory option:selected").val().length > 0){
			searchCategory = null;
			$(".resultTxtDiv").hide();
			$("#searchName").val("");
		}
		else
		{
			$(".resultTxt").text(searchCategoryName+" : " +searchName+" 검색결과입니다.");
			$(".resultTxtDiv").show();
		}
		
		if(!$("#searchName").val().length > 0){
			searchName = null;
		};
		
		FN.movePage(1);
	});
	
	FN.dialogShow();
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
	        	
				FN.list();
		    }
			else
			{
				pageInfo.page = 1;
				searchCategory = null;
				searchName = null;
				period = null;
				FN.list();
			}
		}
};

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
		deleteAndReload : function ()
		{
			reward.params.rwdIds = new Array();
			$(".row .listChk:checked").each(function(){
				reward.params.rwdIds.push(this.value);
			});
			
			if(reward.params.rwdIds.length == 0)
			{
				alert('삭제 대상을 하나 이상 선택해주세요');
				return false;
			}
			
			if(!confirm("정말로 삭제 하시겠습니까?"))
			{
				return false;
			}
			
			console.log(reward.params);
			
			$.ajax( "/pc/reward/delete",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(reward.params),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; cheventset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		alert('삭제되었습니다.');
			 		location.reload();

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
		},
		
		cancel : function()
		{
			history.back();			
		},
		
		modifyAndRedirect : function()
		{
			
		},
		
		list : function()
		{
			FN.dialogShow();
			$.ajax( "/pc/event/eventList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":{
						"page":pageInfo.page,
						"size":pageInfo.size
					},
					"searchCategory":searchCategory,
					"searchName":searchName,
					"period":period
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; cheventset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var events = data.response.body.events;
			 		console.log("EVENTS :::::::::::: " + events);
			 		pageInfo = data.response.body.pageInfo;

			 		//기존 row들 삭제
			 		$("#eventList .row").detach();
			 		
			 		//데이터가 없으면
			 		if(pageInfo.resultCount == 0)
			 		{
			 			$("#eventList .nodata").css("display", "");
			 			$(".paging").css("display", "none");
				 		$(".backLayer").hide();			 		
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#eventList .nodata").css("display", "none");
		 			$(".paging").css("display", "");
		 			$(".table_box input[type=checkbox]").prop('checked',false);

			 		var topRowCnt = pageInfo.totalCount - ((pageInfo.page-1) * pageInfo.size);

			 		$(events).each(function(idx) {
			 			var row = $("#eventList .src_row").clone();
			 			$(row).removeClass("src_row");
			 			$(row).addClass("row");
					    
					    
			 			$(row).find(".topRowCnt").text(topRowCnt-idx);
			 			$(row).find(".templateTitle").text(events[idx].templateTitle);
			 			$(row).find(".eventType").text(events[idx].eventType);
			 			$(row).find(".eventYmd").text(events[idx].startYmd +"~"+events[idx].endYmd);
			 			$(row).find(".eventAfterType").text(events[idx].eventAfterType);
			 			$(row).find(".eventStatus").text(events[idx].eventStatus);
			 			$(row).find(".createDate").text(events[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(events[idx].eventId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#eventList").append(row);
			 		});
			 		$(".backLayer").hide();			 		
			 		
			 		if(pageInfo.lastPage == 1)
		 			{
			 			$(".paging .prev10").css("display", "none");
			 			$(".paging .next10").css("display", "none");
		 			}
			 		else
			 		{
			 			$(".paging .prev10").css("display", "");
			 			$(".paging .next10").css("display", "");
			 			
			 			$(".paging .prev10").click(function(){
				 			FN.movePage(1);
				 		});
				 		
			 			$(".paging .prev").click(function(){
			 				if(pageInfo.page-1 < 1){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page-1);
				 		});
				 		
			 			$(".paging .next").click(function(){
			 				if( pageInfo.page == pageInfo.lastPage){
			 					return;
			 				}
				 			FN.movePage(pageInfo.page+1);
				 		});
				 		
			 			
				 		$(".paging .next10").click(function(){
				 			FN.movePage(pageInfo.lastPage);
				 		});
			 		}
			 		
			 		$(".paging .page").detach();
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
			 			$(".paging .next").before(pageElement);
			 			
			 			$(".paging a").hover(function() {
	 				        $(this).css('cursor','pointer');
	 				    });
		 			}
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
		detail:function(eventId) {
			console.log("eventID : : : : : : : " + eventId);
			location.href = "/pc/event/eventDetailPage?eventId="+eventId
		}
}

</script>
</head>



<body>
	
<div id="wrap">
   <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">이벤트관리 > </span>이벤트 목록</h2>
		  <!-- CONTENTS -->
		  
			<form name="" method="" action="">
				<fieldset>
					<legend></legend>
					<div class="tabContent">

						<dl>
						
							<dt></dt>
							<dd>
								<select id="searchCategory" class="selstyle">
									<option value="" selected="selected">전체보기</option>
									
									<option value="eventname">이벤트명</option>
									<option value="date">작성일</option>
									
								</select>
							</dd>
							<dt ></dt>
							<dd id="myinput2">
											
								<input id="searchName" type="text" size="30" class="date_format"/>
							</dd>
							
							<dd class="buttonpos"><button type="button" id="btnSearch" class="pagebtn02"><span class="btntxt">검색</span></button></dd>
						</dl>

					</div> 
				</fieldset>
			</form> 
	 
		</div>

    
    
		<!-- 상점목록 리스트 테이블 -->
		<table class="mytable">
			<caption>권한신청대기 목록</caption>
			<colgroup>
				<col width="6%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="15%"/>
				<col width="10%"/>
				<col width="10%"/>
	 
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">이벤트타입</th>
					<th scope="col">이벤트명</th>
					<th scope="col">진행날짜</th>
					<th scope="col">후이벤트 타입</th>
					<th scope="col">진행상태</th>
					<th scope="col">등록일자</th>
				</tr> 
			</thead>
			<tbody id="eventList">			
				<tr class="nodata" style="display:none">
					<td class="brln" colspan="7">- 데이터가 없습니다 -</td>
				</tr>
				<tr class="src_row" style="display:none">
					<td><a class="topRowCnt"></a></td>
					<td><a class="eventType"></a></td>
					<td><a class="templateTitle"></a></td>
					<td><a class="eventYmd"></a></td>
					<td><a class="eventAfterType"></a></td>
					<td><a class="eventStatus"></a></td>
					<td><a class="createDate"></a></td>
				</tr>
			</tbody>
		</table>

		<!-- 페이징 이전10개 / 다음10개 추가 수정 -->
	   
		<ul id="pagewrap">
			<li class="pleft">&nbsp;</li>
			<li class="pcenter">
				<div class="paging">
					<a class="prev10"><span>맨앞</span></a>
					<a class="prev"><span>이전</span></a>
					<a class="next"><span>다음</span></a>
					<a class="next10"><span>맨끝</span></a>
				</div>
			</li>
		</ul> 
		<!-- //CONTENT -->

	<!-- //CONTAINER -->
	 	
		
	</div>
</div>





</body>
</html>
