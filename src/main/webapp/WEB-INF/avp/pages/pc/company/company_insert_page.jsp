<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">

var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var dc = null;
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#insertBtn").click(function(){
		if(!$("#companyName").val().trim().length > 0)
		{
			alert("소속 명을 입력해 주세요.");
			return;
		}
		if($("#companyName").val().length > 45)
		{
			alert("소속 명은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyDesc").val().trim().length > 0)
		{
			alert("소속 설명을 입력해 주세요.");
			return;
		}
		if($("#companyDesc").val().length > 45)
		{
			alert("소속 설명은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyBranch").val().trim().length > 0)
		{
			alert("지점을 입력해 주세요.");
			return;
		}
		if($("#companyBranch").val().length > 45)
		{
			alert("지점은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyLocation").val().trim().length > 0)
		{
			alert("주소를 입력해 주세요.");
			return;
		}
		if($("#companyLocation").val().length > 45)
		{
			alert("주소는 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!confirm("등록하시겠습니까?"))
		{
			return;	
		}	
		FN.dialogShow();
		FN.dataSet();
		FN.insert();
	});
	$("#cancelBtn").click(function(){
		history.back();
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
		dataSet: function(){
			company.companyName = $("#companyName").val();
			company.companyDesc = $("#companyDesc").val();
			company.companyBranch = $("#companyBranch").val();
			company.companyLocation = $("#companyLocation").val();
		},
		insert : function ()
		{
			$.ajax( "/pc/company/companyInsert",{
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
			 		alert("정상등록 되었습니다.");
			 		
			 		location.href = "/pc/company/companyListPage";

			 	},
			 	error: function(result, status)
			 	{
			 		var  statusStr = "/pc/company/companyInsert :"+status;
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
		}
}

</script>
<div>소속관리 > 소속등록 > 소속등록 페이지</div>
<div class="section sect" >
<!-- 	<fieldset>  -->
<table> 
<tr> 
<th>소속 명</th> 
<td><input id="companyName" type="text" name="targetName"  required="required" placeholder="45자 이내"></td> 
</tr>
<tr> 
<th>소속 설명</th> 
<td><input id="companyDesc" type="text" name="targetfile" required="required" placeholder="45자 이내"></td>
</tr>
<tr> 
<tr> 
<th>지점</th> 
<td><input id="companyBranch" type="text" name="targetfile" required="required" placeholder="45자 이내"></td>
</tr>
<tr> 
<th>주소</th> 
<td><input id="companyLocation" type="text" name="uploadfile" required="required" placeholder="45자 이내"></td> 
</tr>
<tr>
 <td colspan="2">
  <a id="insertBtn" >등록</a> 
  <a id="cancelBtn" >취소</a> 
  </td> 
</tr>
</table> 
<!-- </fieldset>  -->
	<!-- //sub_contents -->
</div>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>소속등록 |SUPER ADMIN </title>


<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript">

var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var dc = null;
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#insertBtn").click(function(){
		if(!$("#companyName").val().trim().length > 0)
		{
			alert("소속 명을 입력해 주세요.");
			return;
		}
		if($("#companyName").val().length > 45)
		{
			alert("소속 명은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyDesc").val().trim().length > 0)
		{
			alert("소속 설명을 입력해 주세요.");
			return;
		}
		if($("#companyDesc").val().length > 45)
		{
			alert("소속 설명은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyBranch").val().trim().length > 0)
		{
			alert("지점을 입력해 주세요.");
			return;
		}
		if($("#companyBranch").val().length > 45)
		{
			alert("지점은 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!$("#companyLocation").val().trim().length > 0)
		{
			alert("주소를 입력해 주세요.");
			return;
		}
		if($("#companyLocation").val().length > 45)
		{
			alert("주소는 45자 미만으로 입력해 주세요.");
			return;
		}
		if(!confirm("등록하시겠습니까?"))
		{
			return;	
		}	
		FN.dialogShow();
		FN.dataSet();
		FN.insert();
	});
	$("#cancelBtn").click(function(){
		history.back();
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
		dataSet: function(){
			company.companyName = $("#companyName").val();
			company.companyDesc = $("#companyDesc").val();
			company.companyBranch = $("#companyBranch").val();
			company.companyLocation = $("#companyLocation").val();
		},
		insert : function ()
		{
			$.ajax( "/pc/company/companyInsert",{
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
			 		alert("정상등록 되었습니다.");
			 		
			 		location.href = "/pc/company/companyListPage";

			 	},
			 	error: function(result, status)
			 	{
			 		var  statusStr = "/pc/company/companyInsert :"+status;
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
		}
}

</script>
</head>


<body>
<div id="wrap">
   
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">소속관리 > </span> </span>소속등록</h2>

			<fieldset>	
				<form name="" method="" action="" >	
					<legend>소속등록</legend>	
					<table class="mytable2">
						<caption>상점정보</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						
						<tr>
							<td class="tdbg01" scope="col">소속 명</td>
							<td> <input  type="text" id="companyName" class="inp_text" size="80" maxlength="45" placeholder="45자이내" ></td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">소속 설명</td>
							<td> <input  type="text" id="companyDesc" class="inp_text"  size="80" maxlength="100"  placeholder="45자이내" ></td>                
						</tr> 
						<tr>
							<td class="tdbg01" scope="col">지점</td>
							<td> <input  type="text" id="companyBranch" class="inp_text"  size="80" maxlength="100"  placeholder="45자이내" ></td>                
						</tr> 
									 
						<tr>
							<td class="tdbg01" scope="col">주소</td>
							<td> <input  type="text" id="companyLocation" class="inp_text" size="80"  ></td>                
						</tr> 
					
					</table>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="insertBtn" class="pagebtn2"><span class="btntxt">등록</span></button>&nbsp;&nbsp;&nbsp;<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
</div>
    
    





</body>
</html>
