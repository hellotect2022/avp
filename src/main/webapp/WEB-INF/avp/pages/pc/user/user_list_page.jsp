<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
var searchCategory = null;
var dc = null;
var userId = "${userId}";
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
			FN.dialogShow();
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
			 			$(".paging").css("display", "none");
				 		$(".backLayer").hide();			 		
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#userList .nodata").css("display", "none");
		 			$(".paging").css("display", "");
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
			 			$(row).find(".phone").text(users[idx].phone);
			 			$(row).find(".companyShopName").text(users[idx].companyShopName);
			 			$(row).find(".createDate").text(users[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(users[idx].userId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#userList").append(row);
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
			 				$(strongElement).text(p + " ");
			 				$(pageElement).append(strongElement);
		 				}
			 			else
		 				{
		 					$(pageElement).text(p + " ");
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
			 		var  statusStr = "/pc/user/userList :"+status;
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
		detail:function(userId) {
			location.href = "/pc/user/userDetailPage?userId="+userId;
		}
}

</script>
<div>회원관리 > 회원목록 </div>
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
		<option value="nickName">이름</option>
		<option value="companyShop">소속</option>
		<option value="date">가입일</option>
		</select>
		</td>
		<td>
			<input type="text" id="searchName"><a id="btnSearch">검색</a>
		</td>
		</tr>
<!-- 		<tr> -->
<!-- 		<th>기간</th> -->
<!-- 		<td> -->
<!-- 			<span class="cal"><input type="text" id="startYmd" name="search_sday" readonly="readonly" value="" class="datepicker"></span> -->
<!-- 			<span class="bar">~</span> -->
<!-- 			<span class="cal"><input type="text" id="endYmd" name="search_eday" readonly="readonly" value="" class="datepicker"></span> -->
<!-- 		</td> -->
<!-- 		</tr> -->
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
				<col style="width:14%">
			</colgroup>
			<thead>
			<tr>
			<th>NO</th>
			<th>닉네임</th>
			<th>소속</th>
			<th>SNS</th>
			<th>폰번호</th>
			<th>등급</th>
			<th>가입일</th>
			</tr>
			</thead>
			<tbody id="userList">
				<tr class="nodata" style="display:none">
					<td class="brln" colspan="5">- 데이터가 없습니다 -</td>
				</tr>
				<tr class="src_row" style="display:none">
					<td><a class="topRowCnt"></a></td>
					<td><a class="nickName"></a></td>
					<td><a class="companyShopName"></a></td>
					<td><a class="snsType"></a></td>
					<td><a class="phone"></a></td>
					<td><a class="userType"></a></td>
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

<title>회원목록 |SUPER ADMIN </title>

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
var searchCategory = null;
var dc = null;
var userId = "${userId}";
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
			FN.dialogShow();
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
			 			$(".paging").css("display", "none");
				 		$(".backLayer").hide();			 		
			 			return;
			 		}
			 		
			 		//데이터가 하나라도 있으면
		 			$("#userList .nodata").css("display", "none");
		 			$(".paging").css("display", "");
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
			 			$(row).find(".phone").text(users[idx].phone);
			 			$(row).find(".companyShopName").text(users[idx].companyShopName);
			 			$(row).find(".createDate").text(users[idx].createDate);
			 			//display 보이게 하고
			 			$(row).css("display", "");
			 			
			 			$(row).children().each(function(){
			 				if(!$(this).find("input").hasClass("listChk")){
				 				$(this).click(function(){
				 					FN.detail(users[idx].userId);
				 				});
			 				}
			 			});
			 		
			 			//rewardList 하위로 append
			 			$("#userList").append(row);
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
			 				$(strongElement).text(p + " ");
			 				$(pageElement).append(strongElement);
		 				}
			 			else
		 				{
		 					$(pageElement).text(p + " ");
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
			 		var  statusStr = "/pc/user/userList :"+status;
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
		detail:function(userId) {
			location.href = "/pc/user/userDetailPage?userId="+userId;
		}
}

</script>
</head>


<body>
<div id="container"> 
    <div class="contents">
		<h2><span class="titel-text-sm">회원 관리 > </span>회원 목록</h2>
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
									<option value="nickName">이름</option>
									<option value="companyShop">소속</option>
									<option value="date">가입일</option>
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
        <caption>회원목록리스트</caption>
        <colgroup>
            <col width="10%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="15%"/>
			<col width="15%"/>
            <col width="15%"/>
 
        </colgroup>
        <thead>
            <tr>
                <th scope="col">NO</th>
                <th scope="col">닉네임</th>
                <th scope="col">소속</th>
                <th scope="col">SNS</th>
                <th scope="col">연락처</th>
				<th scope="col">등급</th>
                <th scope="col">가입일</th>
            </tr> 
        </thead>
        <tbody id="userList">
				<tr class="nodata" style="display:none">
					<td class="brln" colspan="5">- 데이터가 없습니다 -</td>
				</tr>
				<tr class="src_row" style="display:none">
					<td><a class="topRowCnt"></a></td>
					<td><a class="nickName"></a></td>
					<td><a class="companyShopName"></a></td>
					<td><a class="snsType"></a></td>
					<td><a class="phone"></a></td>
					<td><a class="userType"></a></td>
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


</body>
</html>
