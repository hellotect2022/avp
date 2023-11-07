
$(document).ready(function(){
	
	$('.num').keyup(function(){
		
		if($(this).val().replace(/[0-9]/g,"") != ""){
			alert("숫자만 입력해 주십시요.");
			$(this).val('');
			$(this).focus().select();
			return;
		}
	});
	
	$('.ENG').keyup(function(){
		
		if($(this).val().replace(/[a-zA-Z]/g,"") != ""){
			$(this).val($(this).val().replace(/[^a-zA-Z]/g,""));
		}else if($(this).val().replace(/[A-Z]/g,"") != ""){
			$(this).val($(this).val().toUpperCase());
		}
	});
	
	$('.eng').keyup(function(){
		
//		if($(this).val().replace(/[a-z]/g,"") != ""){
//			alert("소문자 알파벳만 입력해 주십시요.");
//			$(this).val('');
//			$(this).focus().select();
//			return;
//		}
		if($(this).val().replace(/[a-zA-Z]/g,"") != ""){
			$(this).val($(this).val().replace(/[^a-zA-Z]/g,""));
		}else if($(this).val().replace(/[a-z]/g,"") != ""){
			$(this).val($(this).val().toLowerCase());
		}
	});
	$('.Eng').keyup(function(){
		
		if($(this).val().replace(/[a-zA-Z]/g,"") != ""){
			alert("알파벳만 입력해 주십시요.");
			$(this).val('');
			$(this).focus().select();
			return;
		}
	});
});


/**
* @functoin : getBrowserType
* @description : 브라우저 체크
* @return : String 
*/
function getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
    /* IE7,8,9,10,11 */
    if (navigator.appName == 'Microsoft Internet Explorer' || ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null))) {
        
        var trident = _ua.match(/Trident\/(\d.\d)/i);
         
        //ie11에서는 MSIE토큰이 제거되고 rv:11 토큰으로 수정됨 (Trident표기는 유지)
        if(trident != null && trident[1]  == "7.0") return rv = "IE" + 11;
        if(trident != null && trident[1]  == "6.0") return rv = "IE" + 10;
        if(trident != null && trident[1]  == "5.0") return rv = "IE" + 9;
        if(trident != null && trident[1]  == "4.0") return rv = "IE" + 8;
        if(trident == null) return rv = "IE" + 7;
         
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(_ua) != null) rv = parseFloat(RegExp.$1);
        return "IE" +rv;
    }
    /* etc */
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}


/**
* @functoin : CkImageVal
* @description : 이미지 파일인지를 체크 (이미지 파일이 아니면 false 반환)
* @return : boolean
*/
function CkImageVal(fileName) {
	var isImgFile = false;
	fileName = getUrltoFileName(fileName);
	if((/(.jpg|.jpeg|.gif|.png|.bmp)$/i).test(fileName)) {
		isImgFile = true;
	}else
		isImgFile = false;

	return isImgFile;
}


/**
* @functoin : CkHtmlVal
* @description : HTML 파일인지를 체크 (HTML 파일이 아니면 false 반환)
* @return : boolean
*/
function CkHtmlVal(fileName) {
	var isImgFile = false;
	fileName = getUrltoFileName(fileName);
	if((/(.html|.htm)$/i).test(fileName)) {
		isImgFile = true;
	}else
		isImgFile = false;

	return isImgFile;
}

/**
* @functoin : CkXlsVal
* @description : 액셀 파일인지를 체크 (액셀 파일이 아니면 false 반환)
* @return : boolean
*/
function CkXlsVal(fileName) {
	var isXlsFile = false;
	fileName = getUrltoFileName(fileName);
	if((/(.xls)$/i).test(fileName)) {
		isXlsFile = true;
	}else
		isXlsFile = false;

	return isXlsFile;
}

/**
* @functoin : getUrltoFileName
* @description : 경로 전체를 가져와서 , 파일 이름만 반환
* @return : fileName 파일명
*/
function getUrltoFileName(url) {
	var fileName = "";
	var index = url.lastIndexOf("\\");
	if(index == -1)
		return url;
	else {
		fileName = url.substring(index+1);
		return fileName;
	}
}

/**
 * 이메일 유효성 체크
 * 
 * @param objNm			SELECT 오브젝트ID
 * 
 * 사용예> 

	if(!email_chk($('#rcv_email_oper').val())) {
		alert('수신자이메일 형식을 확인하세요');		
		$('#rcv_email_oper').focus();
		bool = false;
		return;
	}
	
 */
function email_chk(val){

	var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

    if (!regExp.test(val)) {
        return false;
    }
    else {
        return true;
    }
}


/**
 * @functoin : CheckPasswd
 * @description : 비밀번호 체크
 * @return : 
 */
function checkPasswd(str){
	var reg1 = /^[a-z0-9~!@\#$%<>^&*\()\-=+_\']{9,20}$/;	// a-z 0-9 중에 8자리 부터 10자리만 허용
	var reg2 = /[a-z]/g;    
	var reg3 = /[0-9]/g;
	
	var re = /[~!@\#$%<>^&*\()\-=+_\']/gi; //특수문자 정규식 변수 선언
	
	if(!re.test(str)) {
	    return false;	//특문없을경우
	}

	if(reg1.test(str) && reg2.test(str) && reg3.test(str)) {
		return true;
	} else {
		return false;
	}
};
//숫자만 입력받게 하기 
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return true;
	}
	else
	{
		return false;
	}
}

//공백 널 체크 알럿 출력 후 결과리턴 document.getElementById("luck_name") 형태여야함
function valChecked(obj,msg){
	var valCheck = true;
	if("" == obj.value || null == obj.value|| obj.value.trim().length  < 1 ){
		valCheck = false;
		alert(msg);
		obj.focus();
	}
	return valCheck;
}

//value 길이 체크
function lengthCheckVal(obj,msg,valLeng){
	if(obj.value.trim().length   > valLeng ){
		alert(msg);
		obj.value="";
		obj.focus();
	}	
}