<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script type="text/javascript" src="<c:url value='/resources/js/jquery-1.11.0.min.js'/>"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#test").change(function(){
		console.log($(this).val())
	});
});
</script>

<body>
<form action="fileInsert" method="post" enctype="multipart/form-data">
<fieldset> 
<table> 
<tr> 
<th>타겟 이름</th> 
<td><input type="text" name="targetName" required="required"></td> 
</tr>
<tr> 
<th>타겟</th> 
<td><input type="file" name="targetfile" required="required"></td>
</tr>
<tr> 
<th>객체</th> 
<td><input type="file" name="uploadfile" required="required"></td> 
<!-- <td> -->
<!-- <select id="uploadType" name="uploadType"> -->
<!-- <option value="jpg" >이미지(.jpg)</option> -->
<!-- <option value="mp4" >동영상(.mp4)</option> -->
<!-- <option value="obj" >3d 모델(.obj)</option> -->
<!-- </select> -->
<!-- </td> -->
</tr>
<tr> <td colspan="2"> <input id="test" type="submit" value="작성"> <input type="reset" value="취소"> </td> 
</tr>
</table> 
</fieldset> 
</form> 

</body>

