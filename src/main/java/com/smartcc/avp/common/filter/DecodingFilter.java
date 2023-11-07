package com.smartcc.avp.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smartcc.avp.common.Wrapper.DecodingRequestWrapper;
import com.smartcc.avp.pc.shop.ShopPcController;

public class DecodingFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(ShopPcController.class);
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain filter)
			throws IOException, ServletException {
		
		//http://121.130.21.26/pc/shop/shopInsert
		//http://121.130.21.26/intfc/loginCheck
		logger.debug("URL? :: " + ((HttpServletRequest)req).getRequestURL());
		
		/* Modify 2018. 11. 05. JBum
		 * servletRequest에 intfc가 포함되어 있으면 decoding 실시
		 * 아니면 그냥 통과
		 * 테스트 결과 - 이밎 업로드, 앱 API 정상 동작 확인 완료
		 */
		if (((HttpServletRequest)req).getRequestURL().indexOf("intfc") != -1) {
			HttpServletRequest request = (HttpServletRequest)req;
	 		HttpServletResponse response = (HttpServletResponse)res;
			
	 		DecodingRequestWrapper requestWrapper = null;

	 		try{
	 			requestWrapper = new DecodingRequestWrapper(request);
	 		}catch(Exception e){
	 			e.printStackTrace();
	 		}

	 		filter.doFilter(requestWrapper, response);
		} else {
			filter.doFilter(req, res);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
