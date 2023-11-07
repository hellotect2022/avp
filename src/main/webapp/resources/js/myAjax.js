
// 사용 방법  전송 url 을 넣고 , param 데이터를 만들고, 리턴하는 함수를 선언 한다. 
/*
 *  var jData = '{ "sMode" : "1", "sTableName" : "TUI", "sValue" : "' + $('#txt_user_id').val() + '" }';﻿
 *  위 예제는 json을 사용하는 것이나. param형석으로 전달 하는것으로 한다.  
	getAjax("/ajax/user_info.php", jData, setAlert);

 * function setAlert(r) { 
﻿    ﻿aData = JSON.parse(r);                                      // json2.js 를 사용한다. 
    if( aData.length > 0 ) {﻿ 
        alert("아이디 : " + aData.sUserId + "﻿ 이름 : " + aData.sUserName); 
    } 
    else { 
﻿        alert("없는 사용자 입니다.");
    }﻿ 
} 
 */
function getAjax(url, jData, sFunction) {
	$.ajax({
	    type : "POST" //"POST", "GET"
	    , async : false //true, false
	    , url : url //Request URL
	    , dataType :  "json" //전송받을 데이터의 타입
	    , timeout : 20000 //제한시간 지정
	    , cache : false  //true, false
	    , data : jData
	    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
	    , error : function(request, status, error) {
	    	console.log(status);
	    	console.log(error);
	     //통신 에러 발생시 처리
	    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요");
//	    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
	    	location.reload();
	    }
	    , success : function(response, status, request) {
	    	sFunction(response);
	    }
	});
}

function getAjax(url, jData, sFunction,addData) {
	$.ajax({
	    type : "POST" //"POST", "GET"
	    , async : false //true, false
	    , url : url //Request URL
	    , dataType :  "json" //전송받을 데이터의 타입
	    , timeout : 20000 //제한시간 지정
	    , cache : false  //true, false
	    , data : jData
	    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
	    , error : function(request, status, error) {
	     //통신 에러 발생시 처리
	    	console.log(status);
	    	console.log(error);
	    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요");
//	    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
	    	location.reload();
	    }
	    , success : function(response, status, request) {
	    	sFunction(response,addData);
	    }
	});
}

//<script type="text/javascript" src="/resources/js/jquery.form.js"></script> js 추가 해야함
//폼용 ajax
function getFromAjax(url, formId, sFunction) {

	$("#"+formId).ajaxSubmit({
	    type : "POST" //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  "json" //전송받을 데이터의 타입
		    , timeout : 20000 //제한시간 지정
		    , cache : false  //true, false
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요");
//		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , complete : function(response) {
		    	sFunction(JSON.parse(response.responseText));
		    }
		});
}
    

