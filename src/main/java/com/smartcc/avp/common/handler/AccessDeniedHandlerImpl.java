package com.smartcc.avp.common.handler;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;


public class AccessDeniedHandlerImpl implements AccessDeniedHandler {
    //~ Static fields/initializers =====================================================================================
	public final static int AUTH_TOKEN_EXPIRED = 408;

    protected static final Log logger = LogFactory.getLog(AccessDeniedHandlerImpl.class);

    //~ Instance fields ================================================================================================

    //~ Methods ========================================================================================================

    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException)
            throws IOException, ServletException {
        if (!response.isCommitted()) {
        	String contentType = request.getHeader("Content-Type");

            // Content-Type 확인, json 만 View를 따로 처리함.
            if(contentType!=null && MediaType.APPLICATION_JSON_VALUE.equals(contentType)){
            	Response resp = new Response(new ApiException(AUTH_TOKEN_EXPIRED, "세션이 만료되었습니다. 다시 로그인해주세요."));
            	
            	String responseBody = null;
        		ObjectMapper mapper = new ObjectMapper();
        		response.setHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        		response.setCharacterEncoding("UTF-8");
        		responseBody = mapper.writeValueAsString(resp);
    			response.getWriter().print(responseBody);
            } else {
                //json 이 아닐경우 error page 로 이동
            	response.setStatus(HttpServletResponse.SC_FOUND); // SC_FOUND = 302
            	response.sendRedirect("/opr/login");
            }
        }
    }
}

