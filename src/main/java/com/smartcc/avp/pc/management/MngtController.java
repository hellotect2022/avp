package com.smartcc.avp.pc.management;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.intfc.model.request.ar.IntfcArRequest;
import com.smartcc.avp.pc.ar.service.ArService;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.orderlist.model.Orderlist;
import com.smartcc.avp.pc.orderlist.service.OrderlistService;
import com.smartcc.avp.pc.user.model.User;

import lombok.Setter;

@Controller
@RequestMapping(value="/pc/management")
public class MngtController {

	private static final Logger logger = LoggerFactory.getLogger(MngtController.class);
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource OrderlistService orderlistService;
	
	@Setter
	@Resource ArService arService;
	
	/**
	 * O&M 페이지 이동 
	 * @return /pc/management/onm_page
	 * @throws Exception
	 */
	@RequestMapping(value="/onm", method = {RequestMethod.GET})
	public String onmPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("onmPage");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		String todayDt = dateFormat.format(new Date());
		
		HttpSession session	=	request.getSession();
		Integer		userIds	=	(Integer) session.getAttribute("userId");
		
		User		user	=	loginService.getUserInfo(userIds);
		
		int arCount = arService.getArCount(new IntfcArRequest(user.getCompanyId()));
		int remainAr = 1000 - arCount;
		
		List<Orderlist> lists = orderlistService.getTodayOrderlistList();
		
		float wholeWorkRate = 0;
		float successWorkRate = 0;
		float remainWorkRate = 0;
		
		for (Orderlist orderlist : lists) {
			wholeWorkRate += orderlist.getWorkRate();
		}
		
		logger.info("LIST SIZE ::: " + lists.size());
		
		successWorkRate = wholeWorkRate / lists.size();
		remainWorkRate = 100 - successWorkRate;
		
		modelMap.put("arCount", arCount);
		modelMap.put("remainAr", remainAr);
		modelMap.put("successWorkRate", successWorkRate);
		modelMap.put("remainWorkRate", remainWorkRate);
		modelMap.put("todayDt", todayDt);
		
		LogUtil.clearGroup();
		
		return "/pc/management/onm_page";
	}
	
}
