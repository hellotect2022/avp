<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<script type="text/javascript">

var eraseCondition = {
		date : null,
		cateGory	: null,
		cateGoryData : null,
		appCode:null
}

$(document).ready(function(){
	
		
	$("#btnUserKeyErase").click(function(){

		eraseCondition.cateGory = $(".tgGubun:checked").val();
		eraseCondition.cateGoryData = $("#userKeyErase").val();
		if(eraseCondition.cateGory == "MDN"){
			eraseCondition.appCode = $("#appData").val();
		}
		
		if(!FN.validCheck($("#userKeyErase").val())){
			return;
		};	

		FN.eraseHistory(eraseCondition);
		
	});

	$(".tgGubun").change(function(){
		if($(this).val() == "MDN"){
			FN.getAppData();
			$("#appTr").show();
		}else{
			$("#appTr").hide();
			
		}
		
	});
	
});	

FN = {
		getAppData:function(){
			$.ajax( "/opr/app/getAllApp",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				timeout : 20000, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data){
			 		if( 200 != data.response.header.statusCode){
			 			alert(data.response.header.statusMessage);
			 			return;	
			 		}
			 		$("#appData .cl").detach();
					var apps = data.response.body.apps;
					
			 		//데이터가 하나라도 있으면
					
			 		$(apps).each(function(i){
			 			var op = new Option(apps[i].appName,apps[i].appCode);
			 			op.className = "cl"
			 			$("#appData").append(op);
			 			
			 		});
			 		
					
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
		        		alert("앱리스트 불러오는 중 에러가 발생했습니다.");
		       		}
		        }   
			});
		},
		validCheck : function(userKeyErase){
			var trimUserKeyErase = $.trim(userKeyErase);
			if(trimUserKeyErase == ""){
				alert("삭제할 데이터를 입력하세요.");
				$("#userKeyErase").focus();
				return false;
			}
			
			return true;
				
		},
		eraseHistory : function(condi){
			
			console.log(condi);
			
			$.ajax( "/opr/erase/deleteHistory",{
			 	type : "POST", //"POST", "GET"
				dataType :  "json", //전송받을 데이터의 타입
				data : JSON.stringify(condi),
				timeout : 60*1000*5, //제한시간 지정
			 	contentType: "application/json; charset=UTF-8",
			 	success: function(data)
			 	{
			 		console.log(data);
			 		if( 200 != data.response.header.statusCode)
			 		{
			 			alert(data.response.header.statusMessage);
			 		}
			 		else
			 		{
				 		alert("이력이 삭제 되었습니다.");
			 		}
			 	},
			 	error: function(result, status)
			 	{
			 		console.log(result);
		        	if(result.responseText)
		        	{
		        		var response = JSON.parse(result.responseText);
		        		//에러발생을 위한 code페이지
		            	alert(response.response.header.statusMessage);
		        	}
		        	else
		       		{
		        		alert("이력 삭제에 실패 하였습니다.");
		       		}
		        }   
			});
		}
}
	
	

</script>
<div class="section">
	<!-- title_area -->
	<div class="title_area">
		<h2>이력 삭제</h2>
	</div>
	<!-- //title_area -->
	<!-- sub_contents -->

<div class="sub_contents">
	<div class="table_box mt20">
		<table class="type2">
		<colgroup>
		<col style="width:18%">
		<col style="width:82%">
		</colgroup>
		<tbody>
		<tr>
		<th>구분</th>
		<td colspan="3">
			<span class="r_txt">
				<input type="radio" class="tgGubun" name="trd" id="ChkUserKey" value="USERKEY" checked="checked"><label for="ChkUserKey">USER KEY</label>
			</span>
			<span class="r_txt">
				<input type="radio" class="tgGubun" name="trd" id="ChkMDN" value="MDN"><label for="ChkMDN">MDN</label>
			</span>
		</td>
		</tr>
		<tr id="appTr" style="display: none;">
		<th>App</th>
		<td colspan="3">
			<select name="targ_dvcd" id="appData" style="width:150px">
			
			</select>
		</td>
		</tr>
		<tr>
		<th><span id="spnRwdnm">제거</span></th>
		<td>
			<input type="text" id="userKeyErase" value="" style="width:50%" >
			<a id="btnUserKeyErase" class="btn_s_wht"><span class="bg"></span>제거</a>
		</td>
		</tr>
		
					
		</tbody>
		</table>
	</div>
	
</div>
</div>
