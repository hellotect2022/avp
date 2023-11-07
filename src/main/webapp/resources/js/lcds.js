	//LIST 이동 
	function goList(page) {
		var form = document.getElementById("listForm");
		form.curpage.value = page;
		form.submit();
	}
	//VIEW 페이지 이동
	function goView( articleNo) {
 
		var form = document.getElementById("viewForm");
		form.AN_BUL_SEQ.value = articleNo;
		form.SEQ.value = articleNo;
		form.submit();
	}
	//VIEW 페이지 이동
	function goView2( articleNo) {
		sendHit("/board/boardHit","POST","html",   articleNo  );
		var form = document.getElementById("viewForm");
		form.AN_BUL_SEQ.value = articleNo;
		form.SEQ.value = articleNo;
		form.submit();
		
		
	}
	function goDetailView( articleNo) {
		var form = document.getElementById("viewForm");
		form.SEQ.value = articleNo;

		form.submit();
	}
	//등록 처리 
	function goWrite(dir,bul_c,dc) {
 
		var form = document.getElementById("writeForm");
		form.TBL_INQ_DC.value = dc;
		form.BUL_C.value = bul_c;
		form.action = dir;
		form.submit();
	}
	//검색 처리 
	function search() {
		var form = document.getElementById("searchForm");
		var sday = $("#datepicker").val();
		var eday = $("#datepicker1").val();
		if (sday > eday) {
			alert("시작일이 종료일보다 작아야됩니다.");
		} else {
			form.submit();
		}
	}	

	// 조회버튼 눌렸을 경우 1페이지부터 조회
  function searchNew() {

    var form = document.getElementById("searchForm");
    var sday = $("#datepicker").val();
    var eday = $("#datepicker1").val();

    if (sday > eday) {
      alert("종료일자가 시작일자 이전입니다.");
      return;
    }
    
    if(!dateSearchCheck(sday, eday)){
      $("#datepicker").focus();
      return;
    }
    
    // 1페이지부터 조회
    $("#curpage").val("1");
    form.submit();
  }
  
  // 메뉴(top, left)에서 이동(페이지 정보 외 파라메터 초기화)
  function goMenu(dir, bul_c, dc) {
    var form = document.getElementById("MenuForm");
    form.TBL_INQ_DC.value = dc;
    form.BUL_C.value = bul_c;
    form.action = dir;
    form.submit();
  }

	//네비게이션 페이지 이동
	function goPage(dir,bul_c,dc) {
		var form = document.getElementById("GoForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
		form.action = dir;
		form.submit();
	}	

	//수정 페이지 
	function goMod(dir,bul_c,dc, a_bul_c) {
		var form = document.getElementById("procForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.AN_BUL_SEQ.value = a_bul_c;
		form.action = dir;
		form.submit();
	}	
	
	function goModify(dir,bul_c,dc, a_bul_c) { 
		var form = document.getElementById("procForm");
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.SEQ.value = a_bul_c;
		form.action = dir;
		form.submit();
	}	
	
	function modCancel(articleNo,dir) { 
		var form = document.getElementById("procForm");
 		form.SEQ.value = articleNo;
		form.action = dir;
		form.removeAttribute("enctype");
		form.submit();
	}	
	//폼 클리어 
	function Cancel(dir,bul_c,currpage,dc){
		var form = document.getElementById("CancelForm");
/*		alert(currpage);*/
		form.TBL_INQ_DC.value = dc;
 		form.BUL_C.value = bul_c;
 		form.curpage.value = currpage;
		form.action = dir;
		form.submit();
	}
	//폼 클리어 
	function Clear(name){
		var form = document.getElementById(name);
 
			form.DON_MSG_CN.value='';
	 
			form.TIT_NM.value="";
			
	}
	//메시지 
	function Msg (msg){
		alert(msg);
	}
	//ex) Send('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}' );
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC 
	function Send(url,method,rtype, turl , bul_c,dc){ 
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
			     $('#resultDIV').append(response); 
//			     history.back();
			     goPage(turl , bul_c,dc);
			     
		     
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
	
	//ex) Send('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}' );
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC 
//	function SendFile(url,method,rtype, turl , bul_c,dc){ 
//		$.ajax({
//		    type : method //"POST", "GET"
//		    , async : false //true, false
//		    , url : url //Request URL
//		    , dataType :  rtype //전송받을 데이터의 타입
//		    , timeout : 50000 //제한시간 지정
//		    , cache : false  //true, false
//			 , secureuri:false
//			 , fileElementId: $("uploadfile")
//		    , data : $("input, textarea ,a ").serialize()//서버에 보낼 파라메터
//		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8 ; multipart/form-data"
//		    , beforeSend: function( xhr ) {    xhr.overrideMimeType( "multipart/form-data; charset=UTF-8" );  }
//		    , error : function(request, status, error) {
//		     //통신 에러 발생시 처리
//		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
//		    }
//		    , success : function(response, status, request) {
//			     //통신 성공시 처리
//			     $('#resultDIV').append(response); 
////			     history.back();
//			     goPage(turl , bul_c,dc);
//			     
//		     
//		    }
//		    , beforeSend: function() {
//		     //통신을 시작할때 처리
//		     $('#ajax_indicator').show().fadeIn('fast'); 
//		    }
//		    , complete: function() {
//		     //통신이 완료된 후 처리
//		     $('#ajax_indicator').fadeOut();
//		    }
//		});
//		
//	}
	
//	ex) Send('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}' );
//	 url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC 
	function sendHit(url,method,rtype,selectData){ 
		$.ajax({
		    type : method //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  rtype //전송받을 데이터의 타입
		    , timeout : 50000 //제한시간 지정
		    , cache : false  //true, false
			 , secureuri:false
		    , data :  { AN_BUL_SEQ :   selectData } //$("input, textarea ,a ").serialize()//서버에 보낼 파라메터
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8 ; multipart/form-data"
		    , beforeSend: function( xhr ) {    xhr.overrideMimeType( "multipart/form-data; charset=UTF-8" );  }
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , success : function(response, status, request) {
			     //통신 성공시 처리
			     $('#resultDIV').append(response); 
 
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
	
	
	
	//ex) Send('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}' );
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC 
	function SendFile2(url,method,rtype, turl , bul_c,dc){ 
 
		$(function(){
			  $('#procForm').ajaxForm({
				  success: function(responseText, statusText, xhr, $form){
				      alert(responseText);
				      $form.css('background','red');
				    }

			  });
			});
		

	}
	
	//ex) Send('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}' );
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC 
	function SendFileDel(url,method,rtype,val1, val2 ){ 
 
		$.ajax({
		    type : method //"POST", "GET"
		    , async : false //true, false
		    , url : url //Request URL
		    , dataType :  rtype //전송받을 데이터의 타입
		    , timeout : 50000 //제한시간 지정
		    , cache : false  //true, false
			 , secureuri:false
		    , data : { LT_CH_USID : val1,  FSEQ :val2  }//서버에 보낼 파라메터
		    , contentType: "application/x-www-form-urlencoded; charset=UTF-8 ; multipart/form-data"
		    , beforeSend: function( xhr ) {    xhr.overrideMimeType( "multipart/form-data; charset=UTF-8" );  }
		    , error : function(request, status, error) {
		     //통신 에러 발생시 처리
		    	alert("통신 오류가 발생 하였습니다. 잠시 후 다시 시도해 주세요"   + status  + " request [" + request  + "] error[" + error +"]");
		    }
		    , success : function(response, status, request) {
			     //통신 성공시 처리
			     $('#resultDIV').append(response); 
 
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
	
	//ex) SendConfirm('/board/delproc','POST','html' ,'/board/list','${BUL_C }','${TBL_INQ_DC}','정말로 삭제하시겠습니까?','취소하셨습니다.!');
	// url : 실행할 URL , method : GET/POST, rtype : 전문형식 , turl : 처리 후 이동할 페이지 , BUL_C, TBL_INQ_DC,  msg : confirm 확인 메시지, rtmsg : 취소 시 결과 메시지 (공백으로 처리가능)
	function SendConfirm(url,method,rtype, turl , bul_c,dc,msg, rtmsg){ 
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
		 
				     goPage(turl , bul_c,dc);
				     
			     
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

 

	///////////////  UPLOAD JS ////////////////////////
	// <![CDATA[

	// 업로드 파일 지정
	function uploadForm(obj){

		var ele=document.getElementById("upload_form");
		var fEle=document.createElement("INPUT");

		fEle.type='file';
		fEle.name='upload_form[]';
		fEle.onchange=function(){

			uploadForm(this);		

		}

		ele.appendChild(fEle);
		obj.style.display='none';
		setList(ele);

	}

	// 업로드 대기 중인 파일 리스트를 가져온다.
	function setList(ele){

		this.getFileName=function(str){

			var segment=str.split('\\');
			var len=segment.length;

			return segment[(len-1)];

		}

		// 파일리스트 초기화
		var sEle=document.getElementById("files_list");
		var len=sEle.length;
		for(var i=0 ; i < len ; i++){ sEle[i]=null; }	// 한번에 다 없어지지 않으므로 두번실행

		// 업로드 폼과 업로드 파일들을 읽어온다.
		var uEle=ele.getElementsByTagName('INPUT');
		var len=uEle.length;

		for(var i=0 ; i < len ; i++){

			if(uEle[i].value=='') continue;

			var text=this.getFileName(uEle[i].value);
			var value=uEle[i].value;

			sEle[i]=new Option(text, value);

		}

	}

	// select 폼의 파일을 선택하면 이미지 미리보기를 할수 있다.
	function chooseThis(obj){

		var ele=document.getElementById("display");
		var str=obj.value;

		ele.src=str;

	}

	// 파일리스트에 있는 파일 항목을 제거한다.
	function deleteFile(){

		var ele=document.getElementById('files_list');

		// get file list
		var uForm=document.getElementById('upload_form');
		var uEle=uForm.getElementsByTagName('INPUT');
		var len=uEle.length;

		for(var i=0 ; i < len ; i++){

			if(!uEle[i]) continue;
			if(uEle[i].value==ele.value) uForm.removeChild(uEle[i]);

		}
		setList(uForm);
		
	}
	///////////////  UPLOAD JS ////////////////////////
	
	function PopUp(name, pk,width, height,toolbar,menubar, scrollbar, resizeable, status) {

		if(toolbar == ""  || toolbar == null  ) toolbar="no";
		if(menubar == "" || menubar == null ) menubar = "no";
		if(scrollbar == "" || scrollbar == null ) scrollbar = "no";
		if(resizeable == "" || resizeable == null ) resizeable = "no";
		if(status == "" || status == null ) status = "no";
 
		
		window.open(name,pk,'width=' + width +  ', height='  + height + ' , toolbar='  +  toolbar +    ', menubar=='  +  menubar +    ', scrollbars=='  + scrollbar +    ', resizable=='  + resizeable +    ',status=='  +  status +    ' ' );
	}
	
	
	
	


	function FileSizePrint (filesize,MaxTail)
	{
		if (MaxTail == '')	{
			MaxTail = 3;
		}
		var human_size  = 0;
		var max_div = 1;
		var FIX_SIXE = 1024;
		var filelength = filesize.toString().length;
		var print_tail = "B";

		if(filelength > 3 && filelength < 6)  print_tail = "K" + print_tail;
		if(filelength > 5 && filelength < 9)  print_tail = "K" + print_tail;
		if(filelength > 8 )  print_tail = "G" + print_tail;
		//가변 사이즈 처리 
	 	for(var i =0;i <  filelength;i++)
		{
			if( (i%3) == 0) {
				max_div = max_div * FIX_SIXE;
			}
		}
	 
		human_size  = (filesize/max_div) * FIX_SIXE;

		return human_size.toFixed(MaxTail) + print_tail;
	}

	function fileType(filename)
	{
		return filename.split('.').pop();
	}
	
	//INPUT TYPE SIZE CHECK Ver
	function Inputfilesize(filepath) {

		var size = 0;

		var browser=navigator.appName;
		if (browser=="Microsoft Internet Explorer")
		{
			var oas = new ActiveXObject("Scripting.FileSystemObject");
			var e = oas.getFile(filepath);
			size = e.size;
		}
		else
		{
			var node = filepath;
			size = node.files[0].fileSize;
		}
		return size;
	}
	function OnSubmit_v3(formName, target_name, url){
		var uForm=document.getElementById(formName);
 
		uForm.target =  target_name;
		uForm.action = url;
		uForm.submit();
	}

	function OnSubmit_v2(formName, target_name, url){
		var uForm=document.getElementById(formName);
	 
		if (validation(uForm.cardName, "카드명") == false ) return;							//카드명 체크
		if (validation(uForm.NumBin, "Bin NO.") == false ) return;							//Bin NO 체크
		if (validation(uForm.suju, "수주 NO.") == false ) return;							//sujo NO 체크
		if (validation(uForm.chip, "칩 사양") == false ) return;								//칩사양 체크
		if (validation(uForm.code, "제휴코드") == false ) return;								//제휴코드 체크
		if (validation(uForm.msTapeCn, "MS Tape") == false ) return;						//MS Tape 체크
		if (validation(uForm.signWidth, "서명판넬 넓이") == false ) return;			//서명판넬 넓이 체크
		if (validation(uForm.signheight, "서명판넬 높이") == false ) return;		//서명판넬 넓이 체크
		
		uForm.target =  target_name;
		uForm.action = url;
		uForm.submit();
	}
	
	//디자인확인서 등록 유효성 체크
	function validation(str, name) {
		if ( str.value.replace(/(^\s*)|(\s*$)/gi, '').length == 0 ) {
			alert(name+"의 값을 입력해주세요");
			str.focus();
			return false;
		}
	}
	
	function downloadFile(fileSeq){
		
		$("#DES_FILE_SEQ").val(fileSeq);
		$("#downloadForm").submit();
	}
	
	function downloadSelectFile(flag){
		var selectFiles = new Array;
		if(flag == "A"){
			$(".checkBox").each(function(){
				selectFiles.push($(this).attr("name"));
			});
		}else if(flag == "S"){
			$(".checkBox").each(function(){
				if($(this).is(":checked")){
					selectFiles.push($(this).attr("name"));
				}
			});
			if(selectFiles.length == 0){
				alert("선택된 파일이 없습니다.");
				return;
			}
		}
		for (var i = 0; i < selectFiles.length; i++) {
			$("#downloadForm").append("<iframe id='downloadFrame" + (i + 1) + "' style='display:none'></iframe>");
		}
		fileDownControl(selectFiles);
	}

	function fileDownControl(selectFiles){
		$("#downloadFrame" + selectFiles.length).attr("src", "/downloadFile?DES_FILE_SEQ=" + selectFiles[selectFiles.length-1]);

		selectFiles.pop();
		setTimeout(function(){
			if(selectFiles.length > 0){
				fileDownControl(selectFiles);
			}else{
				$("#downloadForm iframe").remove();
			}
		}, 500);
	}
	
	function inputTextArea(formName, id){
		//공지사항내용 변경
		var uForm=document.getElementById(formName);
		
		if(id == "DON_MSG_CN"){
			uForm.DON_MSG_CN.value = $("#DON_MSG_CN").val().split("\n").join("<br/>");
		}else if(id = "ETC_CN"){
			uForm.ETC_CN.value = $("#ETC_CN").val().split("\n").join("<br/>");
		}
		
	}
	
	function outputTextArea(formName, id){
		//공지사항내용 변경
		var uForm=document.getElementById(formName);
		
		if(id == "DON_MSG_CN"){
			uForm.DON_MSG_CN.value = $("#DON_MSG_CN").val().split("<br/>").join("\n");
		}else if(id = "ETC_CN"){
			uForm.ETC_CN.value = $("#ETC_CN").val().split("<br/>").join("\n");
		}
		
	}
	
	//e-mail @표시체크
	function check_mail(obj){
		var len = obj.length; 
		var countChar = 0 ;
		var ch = obj.charAt(0);
		for(var i = 0; i < len; i++) { 
			ch = obj.charAt(i); 
			if(ch == '@') {
				countChar++;
			}
		}
		
		if(countChar == 1){
			return true;
		}else{
			alert("이메일입력 방식이 틀립니다.");
			return false; 
		}
		
	}
	

	//글자수 제한 
	 function textarea_maxlength(obj,maxlengthAttr) {
		 
		  var message;
		   var tempMessage = "";
		   var totalString= obj.value;
//		   var maxlengthAttr = obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : "";
//		   alert(maxlengthAttr);
		   maxlength = maxlengthAttr * 2; 
		        var textareaLength = obj.value.length;
		 
		        if (textareaLength == 0) {
		          totalString = maxlengthAttr * 2;
		         } 
		        else {
		              for (var i=0; i<textareaLength; i++) {
		                   message = totalString.charAt(i);
		                    if (escape(message).length > 4) {
		                    maxlength -= 2;
		                    }
		                    else {
		                   maxlength--;
		                   }
		   
		                   if (maxlength < 0) {
		                      alert("총 영문 "+(maxlengthAttr*2)+"자 한글 " + maxlengthAttr + "자 까지 적을 수 있습니다.");
		                   obj.value= tempMessage;
		                   break;
		                  } 
		                else {
		                    tempMessage += message;
		                 }
		              }//end for
		         }
		  }



		function setContents() {
			var contentsText = document.body.innerHTML;
			initBody = contentsText;
			// 본문에서 'print start' 이 문자열(주석 문자 포함) 부터 프린트 시작 
			var PrnStart = contentsText.toLowerCase().indexOf(
					"<!-- print start -->");
			// 본문에서 'print end' 이 문자열(주석 문자 포함) 부터 프린트 시작
			var PrnEnd = contentsText.toLowerCase().indexOf("<!-- print end -->");
			var PrnContent = contentsText.substring(PrnStart, PrnEnd);

			ContentsText = PrnContent;

			if (ContentsText != "") {
				document.body.innerHTML = ContentsText;
				window.print();
				document.body.innerHTML = initBody;
			} else {
				alert("출력할 내용을 찾지 못하였습니다.");
			}
			//self.close();
		}




		function goPrint(title){
		    var sw=screen.width;
		    var sh=screen.height;
		    var w=800;//팝업창 가로길이
		    var h=600;//세로길이
		    var xpos=(sw-w)/2; //화면에 띄울 위치
		    var ypos=(sh-h)/2; //중앙에 띄웁니다.

		    var pHeader="<html><head><meta http-equiv='Pragma' content='no-cache'><link rel='stylesheet' type='text/css' href='/resources/css/style.css'>"+
		    "<link rel='stylesheet' type='text/css' href='/resources/css/lcds.css'>"+
		    "<title>" + title + "</title></head><body>";
		  
//		    $(".border_box").hide();
//		    $(".detail_view").hide();
		    var pgetContent=document.getElementById("right").innerHTML + "<br>";
		 
		    var pFooter="</body></html>";
		    
//		    $(".border_box").show();
//		    $(".detail_view").show();
		    
		    pContent=pHeader + pgetContent + pFooter;  
		     
		    pWin=window.open("","print","width=" + w +",height="+ h +",top=" + ypos + ",left="+ xpos +",status=yes,scrollbars=yes"); //동적인 새창을 띄웁니다.
		    pWin.document.open(); //팝업창 오픈
		    pWin.document.write(pContent); //새롭게 만든 html소스를 씁니다.
		    pWin.document.close(); //클로즈
		    pWin.print(); //윈도우 인쇄 창 띄우고
		    pWin.close(); //인쇄가 되던가 취소가 되면 팝업창을 닫습니다.
		   }	



		function saveExcel(title){
		    var sw=screen.width;
		    var sh=screen.height;
		    var w=800;//팝업창 가로길이
		    var h=600;//세로길이
		    var xpos=(sw-w)/2; //화면에 띄울 위치
		    var ypos=(sh-h)/2; //중앙에 띄웁니다.

		    var pHeader="<html><head><meta http-equiv='Pragma' content='no-cache'>\r\n"+
		    "<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel;charset=utf-8\">"+
		    "<link rel='stylesheet' type='text/css' href='resources/css/style.css'>"+
		    "<link rel='stylesheet' type='text/css' href='resources/css/lcds.css'>"+
		    "<title>excel</title></head><body>";
		    
		    var pgetContent=document.getElementById("right").innerHTML + "<br>";
		    //innerHTML을 이용하여 Div로 묶어준 부분을 가져옵니다.
		    var pFooter="</body></html>";
		    pContent=pHeader + pgetContent + pFooter;  
		     
		    window.open('data:application/vnd.ms-excel,' + pContent  );
		    e.preventDefault();
		  }	

		/*
		 * 사용 방법 .. container를 무조건 읽어서 처리 하도록 되어 있음. 
		 * 아래 excel에서 url을 넣어야 정확하게 처리가 되서 이미지 등등 url 처리에 대해서는 확인이 필요함
		 * 
		<li class="last m5"  ><a href="#"  onclick="goPrint('디자인접수');"  >인쇄</a></li>
		<li class="last m5"  ><a href="#"  onclick="saveExcel('c:\\kim.xls');"  >Excel</a></li>
		*/

		var tableToExcel = (function() {
		  var uri = 'data:application/vnd.ms-excel;base64,'
		    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><link rel="stylesheet" type="text/css" href="http://127.0.0.1:8080/resources/css/lcds.css"><link rel="stylesheet" type="text/css" href="http://127.0.0.1:8080/resources/css/style.css"><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
		    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
		    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
		  return function(table, name) {
		    if (!table.nodeType) table = document.getElementById(table)
		    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
		    window.location.href = uri + base64(format(template, ctx))
		  }
		})()