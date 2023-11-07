<!-- Add this file(.jsp). 2017. 05. 18. JBum -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>사용량 변경 | smartconvergence</title>

<link href="../css/css1.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">
var userData = 
{
		storageSize : null,
		userId : null
}
var dc = null;
var btnVaild = true;
$(document).ready(function(){
	$("#updateBtn").click(function(){
		if(btnVaild)
		{
			if(!FN.valid())
			{
				return;
			}
			if(confirm("변경 신청 하시겠습니까?"))
			{
				btnVaild = false;		
				FN.dataSet();
				FN.dialogShow();
				FN.update();
			}
			else
			{
				btnVaild = true;
			}
		}
		
	});
	
	$("#cancelBtn").click(function(){
		history.back();
	});
	
});
var FN = 
{
		valid : function(){
			if("" == $("#storageSize").val())
			{
				alert("파일 사이즈를 선택해주세요.");
				return false;
			}
			return true;
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
		dataSet: function(){
			userData.storageSize = $("#storageSize").val();
		},
		update : function ()
		{
			$.ajax( "/pc/user/requestQuotas",{
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
			 			if(900 == data.response.header.statusCode)
			 			{
			 				alert(data.response.header.statusMessage);
			 				$(".backLayer").hide();
			 				location.href = "/pc/user/myPage";
			 				return;
			 			}
			 			else if(998 == data.response.header.statusCode)
			 			{
			 				alert(data.response.header.statusMessage);
							location.href = "/pc/login";
			 				return;	
			 			}
			 		}
			 		alert("정상적으로 신청되었습니다.");
					location.href = "/pc/user/myPage";
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
		        		alert("수정 실패하였습니다.");
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
			<h2><span class="titel-text-sm">내정보 관리 > 내정보 ></span>사용량 변경</h2>
			
			<fieldset>
				<form name="" method="" action="">
					<legend>사용량변경</legend>
					<table class="mytable2">
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">파일 사이즈 선택</td>
							<td>
								<select id="storageSize"  style="width: 100px">
								<option  value="" >선택</option>
								<option  value="52428800" >50M</option>
								<option  value="104857600" >100M</option>
								<option  value="209715200" >200M</option>
								<option  value="524288000" >500M</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" class="pagebtn2" userId="${userId}"><span class="btntxt">변경하기</span></button>
				<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
		</div>
	</div>
</div>
</body>
</html>