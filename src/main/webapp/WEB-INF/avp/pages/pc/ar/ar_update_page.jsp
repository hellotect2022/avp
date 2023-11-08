<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>AR 수정 | smartconvergence</title>

<link rel="stylesheet" type="text/css" media="all" href="../css/style.css">
<script language="javascript" type="text/javascript" src="../js/jquery-1.9.1.min.js" ></script>
<script language="javascript" type="text/javascript" src="../js/common.js" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.min.js'></script>
<script type="text/javascript">

var company = 
{
		companyName : null,
		companyDesc : null,
		companyBranch : null,
		companyLocation : null
}
var dc = null;
var arChangeFlag = false;
var recogChangeFlag = false;
$(document).ready(function(){
	/* left menu light on */
	$('ul.aside_menu li').removeClass('on');
	$('#RWD_MGMT').parent().addClass('on').parent().parent().addClass('on');
	/* left menu light on */
	$("#updateBtn").click(function(){
		FN.update();
	});
	$("#cancelBtn").click(function(){
		history.back();
	});
	
	$(document).on("change","[type=file]",function(){
		if($(this).attr('id') == "arImg"){
			arChangeFlag = true;
			readURL(this, "arImgPre");
		} else if($(this).attr('id') == "recogImg") {
			recogChangeFlag = true;
			readURL(this, "recogImgPre");
		}
    });
		
});
function readURL(input, id) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+id).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
var FN = 
{
		
		dialogShow : function(){
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
		update : function(){
		    //ajax form submit
		    $("#frm").ajaxForm({
			    
		    	arImagelimitSize : 2,
		    	arVideolimitSize : 300,
                arTtslimitSize : 10,

		            beforeSubmit: function (data,form,option) {
		            	console.log(data);
		            	console.log(form);
		            	console.log(option);

		            	var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			       		var blank_pattern = /[\s]/g;
		            	
			       		if(!$("#arName").val().trim().length > 0)
						{
		            		alert("AR 명을 입력해 주세요.");
							return false;
						}
		            	
			       		var regType1 = /^[A-Za-z0-9+]*$/;

		            	if(!regType1.test($("#arName").val())) 
		            	{ 
		            		alert("AR 명은 영문 숫자만 가능합니다."); 
		            		return false;
		            	}

		            	if($("#arName").val().length > 20)
						{
							alert("타겟 이름은 20자 미만으로 입력해 주세요.");
							return false;
						}
								            	
		            	if(arChangeFlag)
		            	{

		            		var arImg = data[1].value;
			            	var arImgName = data[1].value.name;

			            	if("" == $("#arImg").val())
			            	{
			            		alert("AR 이미지를 선택해 주세요.");
			            		return false;
			            	}
			        		if(arImg.type != "image/jpeg" && arImg.type != "image/png" && arImg.type != "image/jpg" && arImg.type != "image/JPG" && arImg.type != "image/jpeg" && arImg.type != "image/JPEG")
			        		{
			            		alert("AR 이미지 확장자를 확인해주세요.");
			            		return false;
			            	}

			        		if(check.test(arImgName)) 
   				     		{
								alert("AR 이미지 파일 이름에 한글이 존재합니다.");
								return false;
   				     		}

			        		if(blank_pattern.test(arImgName))
				     		{
   				     			alert("AR 이미지 파일 이름에 공백이 존재합니다.")
								return false;
				     		}
			            	
			            	// size
			        		if(arImg.size > 1024 * 1024 * this.arImagelimitSize)
			        		{
			            		alert("이미지의 크기는 최대 "+ this.arImagelimitSize + " MB 입니다.");
			            		return false;
			            	}
			            	
		            	}

		            	if(!$("#arScript").val().trim().length > 0)
                        {
                            alert("상품에 대한 설명을 작성해 주세요");
                            return false;
                        }


                        // 비디오
                        var arVideo = data[3].value;
                        var arVideoName = data[3].value.name;
                        //console.log("arVideo",arVideo);
                        if (arVideo !== ''){
                            if(arVideo.type != "video/mp4" && arVideo.type != "video/MP4" && arVideo.type != "video/webm" && arVideo.type != "video/WEBM"
                            && arVideo.type != "video/avi" && arVideo.type != "video/AVI" && arVideo.type != "video/wmv" && arVideo.type != "video/WMV")
                            {
                                alert("비디오 확장자를 확인해 주세요 ");
                                return false;
                            }

                            if(check.test(arVideoName))
                            {
                                alert("비디오 파일 이름에 한글이 존재합니다.");
                                return false;
                            }

                            if(blank_pattern.test(arVideoName))
                            {
                                alert("비디오 파일 이름에 공백이 존재합니다.")
                                return false;
                            }

                            // size
                            if(arVideo.size > 1024 * 1024 * this.arVideolimitSize)
                            {
                                alert("비디오 크기는 최대 "+ this.arVideolimitSize + " MB 입니다.");
                                return false;
                            }
                        }


                        var arTts = data[4].value;
                        var arTtsName = data[4].value.name;
                        if (arTts !== ''){
                            if(arTts.type != "audio/mpeg" && arTts.type != "audio/MPEG" && arTts.type != "audio/wav" && arTts.type != "audio/WAV" && arTts.type != "audio/MP3" && arTts.type != "audio/mp3")
                            {
                                alert("비디오 확장자를 확인해 주세요 ");
                                return false;
                            }

                            if(check.test(arTtsName))
                            {
                                alert("TTS 파일 이름에 한글이 존재합니다.");
                                return false;
                            }

                            if(blank_pattern.test(arTtsName))
                            {
                                alert("TTS 파일 이름에 공백이 존재합니다.")
                                return false;
                            }

                            // size
                            if(arTts.size > 1024 * 1024 * this.arTtslimitSize)
                            {
                                alert("TTS 사운드 크기는 최대 "+ this.arTtslimitSize + " MB 입니다.");
                                return false;
                            }
                        }




		            	/*
		            	if(recogChangeFlag)
		            	{

		            		var fileObject = data[3].value;
			                var fileName = data[3].value.name;
			            	
			            	// null check
			            	if(fileObject == "")
			            	{
			            		alert("인식 이미지를 선택해주세요.");
			            		return false;
			            	}
   				     		if(check.test(fileName)) 
   				     		{
								alert("인식 이미지 파일 이름에 한글이 존재합니다.");
								return false;
   				     		}
   				     		if(blank_pattern.test(fileName)) 
				     		{
   				     			alert("인식 이미지 파일 이름에 공백이 존재합니다.")
								return false;
				     		}
		            	}
		            	
		            	if(!$("#arSize").val().trim().length > 0)
		            	{
		            		alert("AR 이미지 사이즈를 입력해 주세요.");
		            		return false;
		            	}

		              	var regNumber = /^[0-9]*$/;
		              	
		            	if(!regNumber.test($("#arSize").val())) {
		            	    alert("숫자만 입력해주세요.");
		            	    return false;
		            	}
		            	*/
		            	
		            	if(!confirm("수정하시겠습니까?"))
						{
							return false;	
						}

			            FN.dialogShow();

		                //validation체크
		                //막기위해서는 return false를 잡아주면됨
		                return true;
		            },
		            success: function(data,status){
		            	console.log(data)
		            	console.log(status)
				 		if( 200 != data.response.header.statusCode){
				 			alert(data.response.header.statusMessage);
				 			$(".backLayer").hide();
				 			return;	
				 		}
		                //성공후 서버에서 받은 데이터 처리
		                alert("정상적으로 수정 되었습니다.");
		                location.href = "/pc/ar/arListPage"

		            },
		            error: function(status){
						var  statusStr = "AR 수정 처리 :"+status;
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
		        }).submit();
		}
}

</script>

</head>
<body>
<div id="wrap">
       
		  <!--본문-->       
	<div id="container"> 
		
		<div class="contents">
			<h2><span class="titel-text-sm">AR 관리 > AR 목록 > </span>AR 수정</h2>
			<fieldset>	
				<form id="frm" action="/pc/ar/arUpdate" method="post" enctype="multipart/form-data">	
					<legend>AR 수정</legend>	
					<table class="mytable2">
						<caption>AR 수정</caption>
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tr>
							<td class="tdbg01" scope="col">상품명</td>
							<td >${ar.itemName}</td> 
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 명</td>
							<td>
								<input type="text" id="arName"name="arName" value="${ar.arName}" required="required" placeholder="영어, 숫자 포함 20자 이하" maxlength="20"/>
							</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 이미지</td>
							<td class="tdbg02">
								<input id="arImg" type="file" name="arImg" accept=".png, .jpg" required="required"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">미리보기</td>
							<td class="tdbg02">
								<div id="photoview"><img id="arImgPre" src="${ar.arImgUrl}" style="width:100%;height:auto;max-height:350px;"></img></div>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">설명문</td>
							<td class="tdbg02">
								<textarea id="arScript" name="arScript" style="min-width:98%;width:98%;height:350px;max-height:500px;">${ar.arScript}</textarea>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR 비디오<br>(.mp4,.webm,.avi,.wmv)</td>
							<td class="tdbg02">
								<input id="arVideo" type="file" name="arVideo" accept=".mp4, .webm, .avi, .wmv" required="required" value="1"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">AR TTS<br>(.mp3,.wav)</td>
							<td class="tdbg02">
								<input id="arTts" type="file" name="arTts" accept=".mp3, .wav" required="required"/>
							</td>
						</tr>
						<!-- <tr>
							<td class="tdbg01" scope="col">AR 사이즈</td>
							<td class="tdbg02">
								<input id="arSize" type="text" name="arSize" value="${ar.arSize}" required="required" placeholder="숫자 5자리 이하" maxlength="5"/>
							</td>                
						</tr>
						<tr>
							<td class="tdbg01" scope="col">인식이미지</td>
							<td class="tdbg02">
								<input type="file" id="recogImg" name="recogImg" required="required"/>
							</td>
						</tr>
						<tr>
							<td class="tdbg01" scope="col">미리보기</td>
							<td class="tdbg02">
								<div id="photoview"><img id="recogImgPre" src="${ar.recogImgUrl}" style="width:100%;height:auto;max-height:350px;"></img></div>
							</td>
						</tr> -->
					</table>
					<input type="hidden" id="preArImgId" name="preArImgId" value="${ar.arImgId}"/>
					<input type="hidden" id="metaData" name="metaData" value="${ar.metaData}"/>
					<input type="hidden" id="preRecogImgId" name="preRecogImgId" value="${ar.recogImgId}"/>
					<input type="hidden" id="preRecogImgName" name="preRecogImgName" value="${ar.metaData}"/>
					
					<input type="hidden" name="targetId" value="${ar.targetId}"/>
					<input type="hidden" name="targetFileId" value="${ar.targetFileId}"/>
					<input type="hidden" name="objectFileId" value="${ar.objectFileId}"/>
					<input type="hidden" name="arId" value="${ar.arId}"/>
					<input type="hidden" name="objectFileName" value="${ar.objectFileName}"/>
				</form>
			</fieldset>
			<div class="paging">
				<button type="button" id="updateBtn" userId="${userId}" ar="${ar.arId}" class="pagebtn2"><span class="btntxt">저장</span></button>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="cancelBtn" class="pagebtn2"><span class="btntxt">취소</span></button>
			</div>
    <!-- //CONTENT -->
		</div>

<!-- //CONTAINER -->
 	</div>
<!-- //wrap -->
</div>
   
</body>
</html>
