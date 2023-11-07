<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript" src="<c:url value='/resources/js/jquery-1.8.0.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.form.min.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.easing.1.3.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery-ui-1.10.3.custom.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/ui.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/comCheck.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/pageCommon.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/myAjax.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/resources/js/jquery.alphanumeric.js'/>" ></script>

<script>
query_to_hash = function(queryString) {
	var j, q;
  	q = queryString.replace(/\?/, "").split("&");
  	j = {};
  	$.each(q, function(i, arr) {
    	arr = arr.split('=');
    	
    	if(arr[1].indexOf(",") > -1)
    	{
    		var values = arr[1].split(",");
    		if(values.length > 1)
   			{
    			return j[arr[0]] = values;
   			}
    	}    	
    	return j[arr[0]] = arr[1];
  	});
  	return j;
}

$(document).ajaxStart(function() {
	$("#ajax-loading").css("display","block");
}).ajaxSuccess(function() {
	$("#ajax-loading").css("display","none");
});
</script>