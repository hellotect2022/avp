	

// 페이지 목록 나타내기
// 총 레코드수, 페이지당 게시물수, 현재 페이지를 파라미터로 받습니다.
function arrayPageList(totalRecords, tableLimit, nowPage)
{
    pageList = document.all.pageListTable; // 페이지 목록이 뿌려질 곳 <td>
    pageList.innerHTML = '';

     totalPages = Math.ceil(totalRecords/tableLimit); // 총페이지수


     blockPage = 0; // 1,11,21,...각 블럭 들의 첫페이지 1~10 까지가 한블럭
     blockSize = 10; // 보여줄 페이지 갯수, 이전 x개, 다음 x개

     //블럭의 첫번째 페이지 구하기
     blockPage = Math.floor((nowPage-1)/blockSize);
     blockPage = blockPage * blockSize + 1;

     //이전 n개구문
     if(blockPage != 1)
         pageList.insertAdjacentHTML("beforeEnd","[<a href='javascript:goTo("+( blockPage-1) + ")'>이전" + blockSize + "개</a>]..");

     //페이지리스트, blockPage++
     for(i=1; i<=blockSize; i++, blockPage++){
          // 마지막 페이지와 같다면..
          if(blockPage == totalPages)
          i = blockSize+1; // 이러면 다음차례에는 for문을 빠져나가겠져?

          // 블럭페이지와 현재페이지가 같으면 링크없다.
          if(blockPage == nowPage)
              pageList.insertAdjacentHTML("beforeEnd"," <b>" + blockPage + "</b> ");
          else
              pageList.insertAdjacentHTML("beforeEnd","[ <a href='javascript:goTo("+ blockPage + ")'>"  + blockPage +  "</a> ]");
     }

     //다음 n개
     if((blockPage-1) < totalPages)
         pageList.insertAdjacentHTML("beforeEnd","..[<a href='javascript:goTo("+ blockPage+ ")'>다음" + blockSize + "개</a>]");

}

//function goTo(i){
//    // 원하는 주소를 적어준다.
//    arrayPageList(171, 10, i);
//}


//폼이동
function submitForm(formId,url) {
	var form = document.getElementById(formId);
	form.action = url;
	form.submit();
}

	//LIST 이동 
	function goList(page) {
		var form = document.getElementById("listForm");
		form.page_no.value = page;
		form.submit();
	}
	//VIEW 페이지 이동
	function goLuckView( articleNo) {
 
		var form = document.getElementById("viewForm");
		form.luck_id.value = articleNo;
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
//	function search() {
//		var form = document.getElementById("searchForm");
//		var sday = $("#datepicker").val();
//		var eday = $("#datepicker1").val();
//		if (sday > eday) {
//			alert("시작일이 종료일보다 작아야됩니다.");
//		} else {
//			form.submit();
//		}
//	}	
