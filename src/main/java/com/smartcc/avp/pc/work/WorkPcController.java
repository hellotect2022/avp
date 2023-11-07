package com.smartcc.avp.pc.work;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.device.model.Device;
import com.smartcc.avp.pc.device.service.DeviceService;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.work.model.Work;
import com.smartcc.avp.pc.work.service.WorkService;
import com.smartcc.avp.pc.zone.model.Zone;
import com.smartcc.avp.pc.zone.service.ZoneService;

import lombok.Setter;

@Controller
@RequestMapping(value="/pc/work")
public class WorkPcController {

	@Setter
	@Resource WorkService workService;
	
	@Setter
	@Resource ZoneService zoneService;
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource DeviceService deviceService;
	
	@RequestMapping(value="/workControlPage", method = {RequestMethod.GET})
	public String workControlPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("workControlPage");
		
		HttpSession session = request.getSession();
		Integer userId		= (Integer) session.getAttribute("userId");
		User user			= loginService.getUserInfo(userId);

		List<Work> workList = workService.getWorkerLoc(user.getCompanyId());
		List<Zone> zoneList = zoneService.getZoneList(user.getCompanyId());
		
		modelMap.put("workList", workList);
		modelMap.put("zoneList", zoneList);
		
		LogUtil.clearGroup();
		return "/pc/worker/work_control_page";
	}
	
	@RequestMapping(value="/workRatePage", method = {RequestMethod.GET})
	public String workRatePage(HttpServletRequest request, ModelMap modelMap, Device req) throws Exception {
		LogUtil.setGroup("workRatePage");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);

		Device list = deviceService.getDevice(req.getDeviceId());
		
		modelMap.put("device", list);
		
		LogUtil.clearGroup();
		return "/pc/work/work_control_page";
	}
	
}
