package com.smartcc.avp.common.interceptor;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.smartcc.avp.common.menu.service.MenuService;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.service.LoginService;

import lombok.Setter;

public class Intercepter extends HandlerInterceptorAdapter {
	
	private final Logger LOGGER = LoggerFactory.getLogger(Intercepter.class);
	
	public final static String MENUS = "menus";
	 
	@Setter
	@Resource MenuService menuService;
	
	@Setter
	@Resource LoginService loginService;
	
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	
		LOGGER.debug("postHandle start");
		HttpSession session =  request.getSession();
		User user = (User)session.getAttribute("user");
		LOGGER.debug("user :::" + user);
		if(null != user)
		{
			if(null != session.getAttribute("userAgent") && !"WEBVIEW".equals(session.getAttribute("userAgent")))
			{
				request.setAttribute(MENUS, menuService.getMenus(user.getUserType()));
			}
		}
		LOGGER.debug("postHandle end");
	}
	
	
	
//	public static void main(String[] args) {
//		System.out.println("tourweb".indexOf("tourweb"));
//		System.out.println("mozila".indexOf("tourweb"));
//	}
//	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String url = request.getRequestURI();
		HttpSession session =  request.getSession();
		LOGGER.info("session :::" + session.getId());
		LOGGER.info("session :::" + session.getAttribute("userId"));
		
		User user = (User)session.getAttribute("user");
		String userAgent = request.getHeader("User-Agent");
		String phoneNumber = (String) session.getAttribute("phoneNumber");
		
		if("/pc/errorPage".equals(request.getRequestURI())){
		    return true;
		}
		
		userAgent = (userAgent == null) ? "" : userAgent;
		
		LOGGER.info("################################### userAetn :::" + userAgent);
		
		Integer userId  = (Integer)session.getAttribute("userId");
		LOGGER.info("################################### userId :::" + String.valueOf(userId));
		if(url.indexOf("intfc") > 0)
		{
			LOGGER.info("URL ::: intfc");
			
			if (!userAgent.equals("SC_AVP")) {
				LOGGER.info("Uncertified Access");
				return false;
			}
			
			return true;
		}
		else if(url.indexOf("opr") > 0)
		{
			return true;
		}
		else  if(url.indexOf("pc") > 0)
		{
			session.setAttribute("userAgent", "PC");
				if("/pc/masterLogin".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/masterLoginPage".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/insertSubData".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/company/allCompanyList".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/shop/companyShopList".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/login".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/twitterAppCheck".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/twitterCallBack".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/loginDataSet".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/appLoginData".equals(request.getRequestURI())){
				    return true;
				}
				else if("/pc/loginSub".equals(request.getRequestURI())){
					LOGGER.info("user :::" + user);
					if(null == userId){
					    response.sendRedirect("/pc/login");
					    return false;
					}
					else if(null == user){
					    response.sendRedirect("/pc/login");
					    return false;
					}
					else if("N".equals(user.getConfirmYn()) && null == user.getConfirmUserId() && null != user.getCompanyId() && !"NORMAL".equals(user.getUserType()))
					{
					    response.sendRedirect("/pc/login");
					    return false;
					}
					else if("Y".equals(user.getConfirmYn()))
					{
					    response.sendRedirect("/pc/dashboard/dashboardPage");
					    return false;
					}
				    return true;
				}
				/*																				// *>-- Modify. 2017. 06. 09 JBum | 테스트 종료로 인한 주석처리
				else if("/pc/user/quotas".equals(request.getRequestURI())) {					// *>-- Add. 2017. 05. 22. JBum
					return true;																// *>-- Add. 2017. 05. 22. JBum	
				}																				// *>-- Add. 2017. 05. 22. JBum
				*/
				else
				{
					if(null == user || null == userId){
					    response.sendRedirect("/pc/login");
					    return false;
					}
					if("N".equals(user.getConfirmYn()) && null == user.getConfirmUserId()&& null != user.getCompanyId())
					{
					    response.sendRedirect("/pc/login");
					    return false;
					}
					if("N".equals(user.getConfirmYn()) && null == user.getConfirmUserId()&& null == user.getCompanyId())
					{
					    response.sendRedirect("/pc/loginSub");
					    return false;
					}
				}
		}
	
		return super.preHandle(request, response, handler);
	}
}