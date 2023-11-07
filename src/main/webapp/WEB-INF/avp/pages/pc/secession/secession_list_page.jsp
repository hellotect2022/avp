<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>탈퇴 목록 | smartconvergence</title>


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
		
		if(!$("#searchCategory option:selected").val().length > 0){
			searchCategory = null;
		}
		
		if(!$("#searchName").val().length > 0){
			searchName = null;
		}
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
			$.ajax( "/pc/user/secessionList",{
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
			 			$(row).find(".companyShopName").text(users[idx].companyShopName);
			 			var str ="";	
			 			if("ADMIN"	==	users[idx].userType)
			 			{
			 				str = "관리자"
			 			}
			 			else if("WORKER"	==	users[idx].userType)
			 			{
			 				str = "작업자"
			 			}
			 			$(row).find(".userType").text(str);
			 			$(row).find(".createDate").text(users[idx].createDate);
			 			$(row).find(".secessionDate").text(users[idx].secessionDate);
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
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("목록 조회 중 에러가 발생했습니다.");
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
			location.href = "/pc/user/secessionDetailPage?userId="+userId;
		}
}

</script>
</head>

<style>
/*div{border:#f00 solid 1px;}*/
</style>
</head>


<body>
	
<div id="wrap">

		  <!--본문-->       
	<div id="container"> 
		<div class="contents">
			<h2><span class="titel-text-sm">회원 관리 > </span>탈퇴 목록</h2>
  <!-- CONTENTS -->
       		<form name="" method="" action="">
				<fieldset>
					<legend></legend>
					<div class="tabContent">

						<dl>
						
							<dt></dt>
							<dd>
								<select class="selstyle">
									<option selected="selected">전체</option>
									
									<option>이름</option>
									<option>소속</option>
									<option>가입일</option>
								</select>
							</dd>
							<dt ></dt>
							<dd id="myinput2">
											
								<input type="text" size="30" class="date_format"/>
							</dd>
							
							<dd class="buttonpos"><button type="button" id="" class="pagebtn02"><span class="btntxt">검색</span></button></dd>
						</dl>

					</div> 
				</fieldset>
			</form> 
		</div>

    
	  
		<!-- 상점목록 리스트 테이블 -->
		<table class="mytable">
			<caption>탈퇴 목록</caption>
			<colgroup>
				<col width="14%"/>
				<col width="16%"/>
				<col width="16%"/>
				<col width="16%"/>
				<col width="19%"/>
				<col width="19%"/>	 
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">닉네임</th>
					<th scope="col">소속</th>
					<th scope="col">등급</th>
					<th scope="col">가입일</th>
					<th scope="col">탈퇴일</th>
				</tr> 
			</thead>
			<tbody>
				<tr class="nodata" style="display:none">
					<td class="brln" colspan="5">- 데이터가 없습니다 -</td>
				</tr>
				<tr class="src_row" style="display:none">
					<td><a class="topRowCnt"></a></td>
					<td><a class="nickName"></a></td>
					<td><a class="companyShopName"></a></td>
					<td><a class="userType"></a></td>
					<td><a class="createDate"></a></td>
					<td><a class="secessionDate"></a></td>
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

	</div>
  
<!-- //CONTAINER -->
 
  
</div> 


</body>
</html>
