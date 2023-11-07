String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/gi,"");
};

//리서치 등록 페이지 변환

	function researchChange() {
		 var radioElements = document.getElementsByName("researchType");
			var form = document.getElementById("procForm");
		    for(var i = 0; i < radioElements.length; i++){
		        if(radioElements[i].checked == true){
		    		form.action = '/design_reserch/reg';
		    		form.submit();
		        }
		        else{

		        }
		    }

	}


///input에 숫자만 입력 하게하는 함수
	function digit_check(evt){
		var code = evt.which?evt.which:event.keyCode;
		if(code < 48 || code > 57){
		return false;
		}
		}

	function goCompView(comp,cname){
		var form = document.getElementById("viewForm");
		form.empnm.value = comp;
		form.cname.value = cname;
		form.submit();
	}


	function onlyNumber(obj) {
		var str = obj.value;
		var len = str.length;
		var ch = str.charAt(0);
		for(var i = 0; i < len; i++) {
			ch = str.charAt(i);
			if( (ch >= '0' && ch <= '9')) {
			continue;
			} else {
				alert("숫자만 입력 해주세요!");
				obj.value="";
				obj.focus();
				return false;
				} ;
			};
			return true;
	};

	///input에 숫자및 영문 입력 하게하는 함수
	function onlyNumber2(obj) {
		var str = obj.value;
		var len = str.length;
		var ch = str.charAt(0);
		for(var i = 0; i < len; i++) {
			ch = str.charAt(i);
			if( (ch >= '0' && ch <= '9')||(ch >= 'a' && ch <= 'z')||(ch >= 'A' && ch <= 'Z')) {
			continue;
			} else {
				alert("숫자와 영문만 입력 해주세요!");
				obj.value="";
				obj.focus();
				return false;
				} ;
			};
			return true;
	};


	function onlyPhonNumber(obj) {
		var str = obj.value;
		var len = str.length;
		var ch = str.charAt(0);
		for(var i = 0; i < len; i++) {
			ch = str.charAt(i);
			if( (ch >= '0' && ch <= '9' || ch == '-')) {
			continue;
			} else {
				alert("숫자 및 ( - )문자만 입력 해주세요!");
				obj.value="";
				obj.focus();
				return false;
				} ;
			};
			return true;
	};


	//ex) SendOpner('/board/delproc','POST','html' ,'/board/list' );
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC

	function SendOpner(url,method,rtype, turl){
		var dc = opener.document.getElementById("TBL_INQ_DC").value;
		var bul_c = opener.document.getElementById("BUL_C").value;
		$.ajax({
		    type : method //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  rtype //전송받을 데이터의 타입
		    , timeout : 50000 //제한시간 지정
		    , cache : false  //true, false
		    , data : $("#procForm",opener.document).serialize() //서버에 보낼 파라메터
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , success : function(response, status, request) {
			     //통신 성공시 처리

			     $('#resultDIV',opener.document).append(response);
//			     history.back();
			     goPageOpener(turl , bul_c,dc);


		    }
		    , beforeSend: function() {
		     //통신을 시작할때 처리
		     $('#ajax_indicator',opener.document).show().fadeIn('fast');
		    }
		    , complete: function() {
		     //통신이 완료된 후 처리
		     $('#ajax_indicator',opener.document).fadeOut();
		    }
		});

	}

//공카드 관리 담당자 지정 관련
	function SendOpnerSel(url,method,rtype,dc,bul_c, turl){

		$.ajax({
		    type : method //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  rtype //전송받을 데이터의 타입
		    , timeout : 50000 //제한시간 지정
		    , cache : false  //true, false
		    , data : $("#procForm",opener.document).serialize() //서버에 보낼 파라메터
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , success : function(response, status, request) {
			     //통신 성공시 처리

			     $('#resultDIV',opener.document).append(response);
//			     history.back();
			     var sday = $('#datepicker', opener.document).val();
			     var eday = $('#datepicker1', opener.document).val();
			     var sel = $('#searchSelect', opener.document).val();
			     var word = $('#searchword', opener.document).val();
			     var curpage = $('#curpage', opener.document).val();


			     goPageOpener2(turl ,bul_c,dc,sday,eday,sel,word,curpage);


		    }
		    , beforeSend: function() {
		     //통신을 시작할때 처리
		     $('#ajax_indicator',opener.document).show().fadeIn('fast');
		    }
		    , complete: function() {
		     //통신이 완료된 후 처리
		     $('#ajax_indicator',opener.document).fadeOut();
		    }
		});

	}

	function goPageOpener2(dir,bul_c,dc,sday,eday,sel,word,curpage) {
		var form = opener.document.getElementById("GoForm");
		form.TBL_INQ_DC.value=dc;
		form.sday.value = sday;
		form.eday.value = eday;
		form.searchword.value = word;
		form.searchSelect.value = sel;
		form.curpage.value = curpage;
 		form.BUL_C.value = bul_c;
		form.action = dir;
		form.submit();
	}
	function goPageOpener(dir,bul_c,dc) {
		var form = opener.document.getElementById("GoForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
		form.action = dir;
		form.submit();
	}
	///empty_approval/list 이동
	function goViewFormeOpener(dir) {
		var form = opener.document.getElementById("viewForm");
		form.action = dir;
		form.submit();
	}

	///design_management/proc ajax
	function DesignSendOpner(url,method,rtype, turl){
		var dc = opener.document.getElementById("TBL_INQ_DC").value;
		var bul_c = opener.document.getElementById("BUL_C").value;
		var reqnum = opener.document.getElementById("reqItem").value;
		$.ajax({
		    type : method //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  rtype //전송받을 데이터의 타입
		    , timeout : 50000 //제한시간 지정
		    , cache : false  //true, false
		    , data : $("#procForm",opener.document).serialize()+"&"+$("#formItem"+reqnum,opener.document).serialize() //서버에 보낼 파라메터
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , success : function(response, status, request) {
			     //통신 성공시 처리
			     $('#resultDIV',opener.document).append(response);
//			     history.back();
			     goPageOpener(turl , bul_c,dc);


		    }
		    , beforeSend: function() {
		     //통신을 시작할때 처리
		     $('#ajax_indicator',opener.document).show().fadeIn('fast');
		    }
		    , complete: function() {
		     //통신이 완료된 후 처리
		     $('#ajax_indicator',opener.document).fadeOut();
		    }
		});

	}

	//글자 제한수 함수
	function checkLength(obj,count){
//		var obj = $("#aptext").val();
		var objVal =obj.value;
		if (objVal.length > count){
			alert("글자 제한수가  "+count+" 자입니다." );

			obj.value=objVal.substring(0,count-2);
		}
		return false;
	}


	//취소후에도 검색되어서 리스트로가게함
	function Cancel2(dir,bul_c,currpage,dc,word,select,sd,ed ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.searchword.value = word;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.searchSelect.value = select;
		form.action = dir;
		form.submit();

	}

	//디자인 조회 취소
	function Cancel3(dir,bul_c,currpage,dc,sd,ed,card,team ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.BGD_CD_NM.value = card;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.BLG_TM_C_NM.value = team;
		form.action = dir;
		form.submit();

	}

	//디자인 조회 수정 취소
	function modCancel5(dir,bul_c,currpage,dc,sd,ed,card,team,seq ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.BGD_CD_NM.value = card;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.BLG_TM_C_NM.value = team;
 		form.SEQ.value = seq;
		form.action = dir;
		form.submit();

	}
	//공지사항 상세보기 확인
	function Cancel4(dir,bul_c,currpage,dc,word,select,sd,ed ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.searchword.value = word;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.boardselect.value = select;
		form.action = dir;
		form.submit();

	}
	//공지사항 수정취소
	function modCancel4(dir,bul_c,currpage,dc,word,select,sd,ed,seq ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.searchword.value = word;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.boardselect.value = select;
 		form.SEQ.value = seq;
		form.action = dir;
		form.submit();

	}

	//qna 상세보기 확인
	function Cancel5(dir,bul_c,currpage,dc,word,sd,ed){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.sday.value = sd;
 		form.eday.value = ed;
 		form.searchword.value = word;
		form.action = dir;
		form.submit();
	}
	// 디자인자료실
	function Cancel6(dir, bul_c, currpage, dc, titNm, akTeamNm, desRlFileNm, sd, ed){

		var form = document.getElementById("CancelForm");
		/*		alert(currpage);*/
		form.BUL_C.value = bul_c;
		form.curpage.value = currpage;
		form.TBL_INQ_DC.value = dc;
		form.TIT_NM.value = titNm;
		form.AK_TEAM_NM.value = akTeamNm;
		form.DES_RL_FILE_NM.value = desRlFileNm;
		form.sday.value = sd;
		form.eday.value = ed;
		form.action = dir;
		form.submit();
	}
	//설정 내부사용자상세취소
	function Cancel7(dir,bul_c,currpage,dc,word,select ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.searchWord.value = word;
 		form.boardselect.value = select;
		form.action = dir;
		form.submit();

	}

	//설정 외부사용자상세취소
	function Cancel8(dir,bul_c,currpage,dc,word,select,stDc,uyn ){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
 		form.searchword.value = word;
 		form.boardselect.value = select;
 		form.ST_DC.value = stDc;
 		form.UYN.value = uyn;
		form.action = dir;
		form.submit();

	}
	//디자인 조회 유효성 체크
	function OnSubmit_v4(formName, target_name, url){
		var uForm = document.getElementById(formName);
		var category = uForm.DES_INQ_DC.value;


		if(category == "1"){
			if (validation(uForm.BGD_CD_NM, "카드명") == false ) return;							//카드명 체크
			if (validation(uForm.TEAM_NM, "요청팀") == false ) return;							//요청팀 체크

		}else{
			if (validation(uForm.TIT_NM, "제목") == false ) return;							//제목 체크
			if (validation(uForm.DON_MSG_CN, "내용") == false ) return;							//내용 체크
		}

		uForm.target =  target_name;
		uForm.action = url;
		uForm.submit();
	}

	//삭제후 검색한 리스트로 가기위해 추가함
	//ex) SendConfirm('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}','정말로 삭제하시겠습니까?','취소하셨습니다.!');
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC,  msg : confirm 확인 메시지, rtmsg : 취소 시 결과 메시지 (공백으로 처리가능)
	function delSendConfirm(url,method,rtype, turl , bul_c,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리
			    	
				     //$('#DelGoF').append(response);//자바스크립오류로인해 삭제함 실제 필요없는 로직 hyo 

				     delGoPage(turl , bul_c,dc);


			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}

	//게시판네비게이션 페이지 이동 삭제후 이동
	function delGoPage(dir,bul_c,dc) {
		var form = document.getElementById("DelGoForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
		form.action = dir;
		form.submit();
	}

	//개인정보 네비게이션 페이지 이동
	function modUserGoPage(dir,bul_c,dc,seq) {
		var form = document.getElementById("ModUser");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.SEQ.value = seq;
		form.action = dir;
		form.submit();
	}
	
	
	//수정네비 네비게이션 페이지 이동
	function modGoPage(dir,bul_c,dc,seq) {
		var form = document.getElementById("ModGoForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.SEQ.value = seq;
		form.action = dir;
		form.submit();
	}



	//수정후 메인으로
	//ex) SendConfirm('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}','정말로 삭제하시겠습니까?','취소하셨습니다.!');
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC,  msg : confirm 확인 메시지, rtmsg : 취소 시 결과 메시지 (공백으로 처리가능)
	function setModSendConfirm(url,method,rtype,bul,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리
			    	alert(response);
				     goPage('/main',bul,dc);


			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}

	//결재후 리스트로 이동
	function setModSendConfirm2(url,method,rtype,bul,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리
			    	alert(response);



			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}

	//수정후 로그아웃
	//ex) SendConfirm('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}','정말로 삭제하시겠습니까?','취소하셨습니다.!');
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC,  msg : confirm 확인 메시지, rtmsg : 취소 시 결과 메시지 (공백으로 처리가능)
	function setoutSendConfirm(url,method,rtype,bul,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리
			    	alert(response);
				     goPage('/login',bul,dc);


			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}

	//조회 기간 설정 함수
	function dateSearchCheck(sday,eday){
		var ch = true;
		if(sday != "" && eday != ""){

			var mySdayArray = sday.split("-");
			var myEdayArray = eday.split("-");
			var tempSday = new Date(mySdayArray[0],mySdayArray[1]-1,mySdayArray[2]);
			var tempEday = new Date(myEdayArray[0],myEdayArray[1]-1,myEdayArray[2]);
			var tempday = new Date(Date.parse(tempEday) - 179*1000*60*60*24);

			if(tempSday > tempEday){
				alert("시작일이 종료일보다 작아야됩니다.");
				ch = false;
			}
			if(tempday > tempSday){
				alert("조회 기간은 180일 이하 입니다.\n다시 선택 해주세요.");
				ch = false;
			}

		} else if(sday == "" && eday != ""){
			alert("시작일을 입력해 주세요.");
			ch = false;
		} else if(sday != "" && eday == ""){
			alert("종료일을 입력해 주세요.");
			ch = false;
		}
		return ch;
	}

	//조회기간 일 수
	function dateCheckDay(sDate,eDate){
		try {
			if(eDate == null){
				eDate = new Date();
			}
			var oneDay =(1000*60*60*24);
			return Math.ceil(eDate-sDate/oneDay);
		} catch (e) {
			return 0;
		}
	}


	//외주설정 비밀번호 초기화후 상세보기 그대로두기
	function outPassSetting(url,method,rtype , bul_c,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리

				    if(response=="SUCC"){
				    	alert("비밀번호가 초기화 되었습니다.");
				    	$("#UR_ACC_PSWD").val("12345678");
				    }else{
				    	alert("실패하였습니다.");
				    }



			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}


	//외주설정 수정후 성공해도 그대로 두기
	function outModSetting(url,method,rtype , bul_c,dc,msg, rtmsg){
		var cf = confirm(msg);

		if (cf){
			$.ajax({
			    type : method //"POST", "GET"
			    , async : false //true, false
			    , url : url //Request URL
			    , dataType :  rtype //전송받을 데이터의 타입
			    , timeout : 50000 //제한시간 지정
			    , cache : false  //true, false
			    , data : $("#procForm").serialize() //서버에 보낼 파라메터
			    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			    , error : function(request, status, error) {
			     //통신 에러 발생시 처리
			    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
			    }
			    , success : function(response, status, request) {
				     //통신 성공시 처리

				    if(response=="SUCC"){
				    	alert("수정 되었습니다.");

				    }else{
				    	alert("실패하였습니다.");
				    }



			    }
			    , beforeSend: function() {
			     //통신을 시작할때 처리
			     $('#ajax_indicator').show().fadeIn('fast');
			    }
			    , complete: function() {
			     //통신이 완료된 후 처리
			     $('#ajax_indicator').fadeOut();
			    }
			});
		}
		else {

			if(rtmsg.length > 3)
				alert(rtmsg);
		}
	}
	
	
	//스크립트 태그 잘라버리는 함수
	function scriptDel (objVal){
		var delTag =/<script.*?>|<\/script>/gi;
		if(objVal != null){
		objVal = objVal.split(delTag).join("");
		objVal = objVal.split(delTag).join("");
		}
		return objVal;
		}