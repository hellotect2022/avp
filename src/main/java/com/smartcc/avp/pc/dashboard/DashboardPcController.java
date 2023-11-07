package com.smartcc.avp.pc.dashboard;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.service.UserService;

import lombok.Setter;


/**
 * pc > 대시보드 
 * @author JS.LEE
 */
@Controller
@RequestMapping(value="/pc/dashboard")
public class DashboardPcController {

	
	
	@Value("#{config['upload.image.path']}")
	private String UPLOAD_IMAGE_PATH;
	
	
	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;
	
	@Setter
	@Resource UserService userService;
	
	@Setter
	@Resource LoginService loginService;
		
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
			@Value("#{config['schema.chum']}")
			private String chumSchema;
			
			@Value("#{config['schema.scgp']}")
			private String scgpSchema;
			
			@Value("#{config['schema.bogoga']}")
			private String bogogaSchema;
			// End of	
	/**
	 * 대쉬보드 페이지 이동
	 * @return /pc/dashboard/dash_board_page
	 * @throws Exception
	 */
	@RequestMapping(value="/dashboardPage", method = {RequestMethod.GET})
	public String dashboard(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("JS.LEE PC");

//		System.out.println("test :: " +testService.getList());
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		String ym = DateUtil.getMonth();
		UserDetailResponse userDetail	=	userService.getUserInfo(userIds, user.getDivision());
		long monthlyLimitSize			=	Long.valueOf(MONTHLY_LIMIT_SIZE).longValue();
		long myLimitSize				=	Long.valueOf(userDetail.getStorageSize()).longValue();
		
		  // 지금까지 내가쓴 총 용량 
		modelMap.put("user",userDetail);
		modelMap.put("monthlyLimitSize",monthlyLimitSize);
		modelMap.put("myLimitSize",myLimitSize);

		LogUtil.clearGroup();
		return "/pc/dashboard/dash_board_page";
	}
}
