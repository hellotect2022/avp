package com.smartcc.avp.common.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.util.WebUtils;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.handler.AccessDeniedHandlerImpl;
import com.smartcc.avp.pc.user.model.User;


public class CustomSecurityFilter implements Filter {

	
	private static String ROLE_ALL = "ALL";
	private static String ROLE_LOGINED_USER = "ROLE_LOGINED_USER";
	
	private static AntPathMatcher delegate = new AntPathMatcher();
	
	private static Map<String, String> accessUrls = new HashMap<String, String>();
	
	private AccessDeniedHandler accessDeniedHandler = new AccessDeniedHandlerImpl();
	
	static{
		accessUrls.put("/*", ROLE_ALL);
		accessUrls.put("/resources/*", ROLE_ALL);
		accessUrls.put("/resources/**/*", ROLE_ALL);
		accessUrls.put("/login/*", ROLE_ALL);
		accessUrls.put("/login/**/*", ROLE_ALL);
		accessUrls.put("/error/*", ROLE_ALL);
		accessUrls.put("/error/**/*", ROLE_ALL);
		accessUrls.put("/html/*", ROLE_ALL);
		accessUrls.put("/html/**/*", ROLE_ALL);
		accessUrls.put("/moment-rmi/*", ROLE_ALL);
		accessUrls.put("/moment-rmi/**/*", ROLE_ALL);
		
		accessUrls.put("/download/**/*", ROLE_ALL);

		accessUrls.put("/opr/**/*", ROLE_LOGINED_USER);
		accessUrls.put("/targeting/*", ROLE_LOGINED_USER);
		accessUrls.put("/targeting/**/*", ROLE_LOGINED_USER);
	}
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest rq, ServletResponse res,
			FilterChain filterChain) throws IOException, ServletException {
		
		HttpServletRequest request =	(HttpServletRequest) rq;
		HttpServletResponse response = (HttpServletResponse)res;
		
		try{
			String uri = UrlUtils.buildRequestUrl(request);
			List<String> authList = new ArrayList<String>();
			getAccessRole(uri, authList);
			hasRole(request, authList);
			filterChain.doFilter(request, response);
		}catch(AccessDeniedException e){
			accessDeniedHandler.handle(request, response, e);
		}
	}
	
	public void hasRole(HttpServletRequest request, List<String> authList){
		if(authList.contains(ROLE_ALL)){
			return;
		}else{
			if(authList.contains(ROLE_LOGINED_USER )){
				User adminUser = (User) WebUtils.getSessionAttribute(request, BaseController.ADMIN_USER);
				if(adminUser == null)
				{
					throw new AccessDeniedException("session invalid");
				}
			}else{
				throw new AccessDeniedException("session invalid");
			}
		}
	}

	public void getAccessRole(String uri, List<String> authList){

		for(Entry<String, String> access : accessUrls.entrySet()){
			if(delegate.match(access.getKey(), uri)){
				
				authList.add(access.getValue());
			}		
		}
	}
	
	
	
	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}


}
