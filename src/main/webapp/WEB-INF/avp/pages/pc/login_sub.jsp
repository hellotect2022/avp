<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>최초로그인</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>

<script type="text/javascript">
var userData = 
{
		userType 		: null,
		companyId 		: null,
		companyDirect   : null,
		branchId		: null,
		email			: null,
		phone			: null,
		storageSize 	: null
}
var dc = null;
var btnVaild = true;
var groupDB = null;
$(document).ready(function(){
// 	FN.dialogShow()
	/* left menu light on */
	$("#insertBtn").click(function(){
		
		//if(btnVaild)
		//{
			if(!FN.valid())
			{
				return;
			}
			if(confirm("회원 가입 하시겠습니까?"))
			{
				btnVaild = false;		
				FN.dataSet();
				FN.dialogShow();
				FN.insert();
			}
			else
			{
				btnVaild = true;
			}
		//}
		
	});
	
	$("#cancelBtn").click(function(){
		history.back();
	});
	
	$("#userType").change(function(){
		var companySel = $("#companySel").val();
		if("WORKER" == $(this).val()) {				// 작업자 선택 시
			$("#branch").show();
			$(".storageSize").hide();
			$("#companyInput").hide();
			$("#companyDirect").val("");
		} else {									// 관리자 선택 시
			$("#branch").hide();
			$(".storageSize").show();
		}
		FN.getCompanyList();
	});
	$("#companySel").change(function(){
		//alert($(this).val())
		console.log("CURRENT USERTYPE:::" + $("#userType").val());
		if("WORKER" == $("#userType").val())
		{
			FN.dialogShow();
			FN.getShopList($(this).val(), "WORKER");
		}
		if($(this).val() == "0") {
			$("#companyInput").show();
		}else {
			$("#companyInput").hide();
			$("#companyDirect").val("");
		}
	
	});
	//FN.dialogShow();
	//FN.getCompanyList();
});

var FN = 
{
		valid : function(){
			if("" == $("#userType").val())
			{
				alert("유저 타입을 선택해주세요.");
				return false;
			}
						
			if("" == $("#companySel").val())
			{
				alert("소속을 선택해주세요.");
				return false;
			}
			
			var userType = $("#userType").val();
			
			if("WORKER" == userType)
			{
				if("" == $("#branchSel").val())
				{
					alert("지점을 선택해주세요.");
					return false;
				}	
			}
			
			if("" == $("#email").val()) {
				alert("E-Mail 을 입력해주세요.");
				return false;
			}
			
			str1 = $("#email").val().trim();
			var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(!emailRegExp.test(str1)) {
				alert("올바른 이메일 형식을 입력해 주세요.");
				return false;
			}
			
			if("" == $("#phone").val())
			{
				alert("전화번호를 입력해 주세요.");
				return false;
			}
			
			str2 = $("#phone").val().trim();
      		var hpRegExp = /^\d{3}\d{3,4}\d{4}$/;		// ex)01020201010 - 핸드폰 번호
  			if(!hpRegExp.test(str2))
  			{
      			 alert("올바른 전화 번호를 입력해 주세요.");
      			 return false;
  			}
			
			if("ADMIN" == userType) {
				if("" == $("#storageSize").val())
				{
					alert("파일 사이즈를 선택해주세요.");
					return false;
				}
			}
			
			return true;
		},
		dialogShow:function(){
			var width = $(document).width();
			var height = $(document).width();
			
			//화면을 가리는 레이어의 사이즈 조정
			$(".backLayer").width(width);
			$(".backLayer").height(height);
			
			//화면을 가리는 레이어를 보여준다 (0.4초동안 30%의 농도의 투명도)
			var loadingDivObj = $("#loadingbar");
			loadingDivObj.css("margin-left", width/2);
			loadingDivObj.css("margin-top",height/2);
			$(".backLayer").fadeTo(400, 0.2);
		},
		getShopList : function(companyId, userType)
		{
			$.ajax( "/pc/shop/companyShopList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":null,
					"searchCategory":null,
					"searchName":null,
					"period":null,
					"companyId":companyId,
					"userType":userType
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var branches = data.response.body.branches;
			 		
			 		console.log(branches)
					$("#branchSel .row").detach();

			 		$(branches).each(function(i){
			 			var op = new Option(branches[i].branchName,branches[i].branchId);
			 			op.className = "row";

			 			$("#branchSel").append(op);
			 			
			 		});
			 		$(".backLayer").hide();
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
		        		alert("상점 목록 조회 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
		getCompanyList : function(groupDbName)
		{
			$.ajax( "/pc/company/allCompanyList",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify({
					"pageInfo":null,
					"searchCategory":null,
					"searchName":null,
					"period":null
				}),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		var companys = data.response.body.companys;
			 		
			 		$("#companySel .row").detach();
			 		
			 		$(companys).each(function(i){			 					
			 			var op = new Option(companys[i].companyName,companys[i].companyId); // var optionElementReference = new Option(text, value, defaultSelected, selected);
			 			op.className = "row";
			 			
			 			$("#companySel").append(op);
			 		});

			 		if($("#userType").val() == "ADMIN") {
			 		
				 		var op = new Option("직접입력", "0");
				 		op.className = "row";
				 		$("#companySel").append(op);
			 		
			 		}
			 		
			 		$(".backLayer").hide()
			 		console.log(companys)
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
		        		alert("소속 목록 조회 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
		dataSet: function(){
			userData.userType = $("#userType").val();
			userData.companyId = $("#companySel").val();
			
			if($("#companyDirect").val() != "") {
				userData.companyDirect = $("#companyDirect").val();
			}
			
			userData.branchId = $("#branchSel").val();
			userData.email = $("#email").val();
			userData.phone = $("#phone").val();
			
			if(userData.userType == "ADMIN") {
				userData.storageSize = $("#storageSize").val();
			} else {
				userData.storageSize = "0";
			}
		},
		insert : function ()
		{
			$.ajax( "/pc/insertSubData",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(userData),
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			if(999 == data.response.header.statusCode)
			 			{
			 				alert(data.response.header.statusMessage);
			 				$(".backLayer").hide();
			 				return;
			 			}
			 			else if(998 == data.response.header.statusCode)
			 			{
			 				alert(data.response.header.statusMessage);
							location.href = "/pc/login";
			 				return;	
			 			}
			 		}
			 		alert("정상등록 되었습니다.\n관리자 승인후 이용이 가능합니다. 감사합니다.");
					location.href = "/pc/login";
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
		        		alert("등록 실패하였습니다.");
		        		location.href = "/pc/login";
		       		}
		        }   
			});
		}
}

</script>

<style>

.contents{margin-left:600px;}

</style>

</head>


<body>
	
		  <!--본문-->       

<div class='backLayer'  style="display: none; position: absolute;background-color: black;"  >
	<div id="loadingbar"><img  src='<c:url value='/resources/images/ajax-loader.gif'/>'/></div>
</div>		 
			
<div class="contents-center">
	<div class="user-top">
		<%-- <img src="<c:url value='/resources/images/wel_logo.png'/>" width="70%"> --%>
		<p>회원가입</p>	
	</div>
	<fieldset>	
		<form name="" method="" action="" >	
			<legend>정보입력</legend>	
			<table class="mytable-user" >
				<caption>정보입력</caption>
				<colgroup>
					<col width="45%"/>
					<col width="55%"/>
				</colgroup>
					
				<tr>
					<td class="tdbg04" scope="col"><p>등급선택</p></td>				
					<td>
						<select title="" id="userType" name=""  >
							<option value="" selected="selected">등급을 선택하세요</option>
							<option value="ADMIN">관리자</option>
							<option value="WORKER">작업자</option>													
						</select>
					</td>                               
				</tr>
				<tr>
					<td class="tdbg04" scope="col"><p>소속선택</p></td>
					<td>
						<select title="" id="companySel" name=""  >
							<option value="" selected="selected">회사를 선택하세요</option>								
						</select>
					</td>
				</tr>
				<tr id="companyInput" style="display:none;">
					<td class="tdbg04" scope="col"><p>소속직접입력</p></td>
					<td>
						<input type="text" id="companyDirect" name="companyDirect"/>
					</td>
				</tr>
				<tr id="branch" style="display:none;">
					<td class="tdbg04" scope="col"><p>지점선택</p></td>
					<td>
						<select title="" id="branchSel" name=""  >
							<option value="" selected="selected">지점을 선택하세요</option>								
						</select>
					</td>
				</tr>
				<tr>
					<td class="tdbg04" scope="col"><p>E-MAIL</p></td>
					<td>
						<input type="text" id="email" name="email" placeholder="abc@abc.com"/>
					</td>
				</tr>
				<tr>
					<td class="tdbg04" scope="col"><p>핸드폰 번호 입력</p></td>
					<td class="inp_border"><input  type="text" id="phone" name="phone" class="inp_text04" size="15" maxlength="13" placeholder="- 제외" ></td>                
				</tr> 
				<tr class="storageSize" style="display: none;">
					<td class="tdbg04" scope="col"><p>신청 용량</p></td>
					<td>
						<select title="" id="storageSize" name=""  >
							<option value="" selected="selected">선택</option>
							<option value="52428800">&nbsp;50MB</option>
							<option value="104857600">100MB</option>
							<option value="209715200">200MB</option>
							<option value="524288000">500MB</option>								
						</select>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	<div class="paging">
		<button type="button" id="insertBtn" class="pagebtn2" userId="${userId}"><span class="btntxt">회원가입</span></button>
		<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
	</div>
		<!-- //CONTENT -->
</div>

</body>
</html>

