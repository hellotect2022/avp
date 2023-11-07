<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#targetfile").click(function(){
		android.selectImage();
	});
	
});

function test(encodingData)
{
	$("#ddd").text(encodingData);
	location.href = "/opr/product/fileInsertKitKat?encodingData="+encodingData;

}
</script>

<body>
<fieldset> 
<table> 
<tr> 
<th>타겟 이름</th> 
<td><input type="text" name="targetName" required="required"></td> 
</tr>
<tr> 
<th>타겟 이미지</th> 
<td><input type="file" id="targetfile" name="targetfile" required="required"></td> 
</tr>
<tr> 
<th>객체 이미지</th> 
<td><input type="file" name="uploadfile" required="required"></td> 
</tr>
<tr> <td colspan="2"> <input id="test" type="submit" value="작성"> <input type="reset" value="취소"> </td> 
</tr>
</table> 
</fieldset> 

<div id="ddd"></div>
</body>

