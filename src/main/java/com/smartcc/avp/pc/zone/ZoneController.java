package com.smartcc.avp.pc.zone;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.zone.model.Zone;
import com.smartcc.avp.pc.zone.service.ZoneService;

import lombok.Setter;

@Controller
@RequestMapping(value="/pc/zone")
public class ZoneController {
	
	private static final Logger logger = LoggerFactory.getLogger(ZoneController.class);
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource ZoneService zoneService;
	
	@RequestMapping(value="/zoneListPage", method = {RequestMethod.GET})
	public String zoneListPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("zoneListPage");

		HttpSession session = request.getSession();
		Integer userId		= (Integer) session.getAttribute("userId");
		User user 			= loginService.getUserInfo(userId);
		
		List<Zone> list = zoneService.getZoneList(user.getCompanyId());
		
		modelMap.put("zone", list);
		
		LogUtil.clearGroup();
		return "/pc/zone/zone_list_page";
	}
	
	@RequestMapping(value="/zoneInsertPage", method = {RequestMethod.GET})
	public String zoneInsertPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("zoneInsertPage");

		LogUtil.clearGroup();
		return "/pc/zone/zone_insert_page";
	}
	
	@RequestMapping(value="/zoneUpdatePage", method = {RequestMethod.GET})
	public String zoneUpdatePage(HttpServletRequest request ,ModelMap modelMap, Zone req) throws Exception {
		LogUtil.setGroup("zoneUpdatePage");

		Zone zone = zoneService.getZone(req.zoneId);
		
		modelMap.put("zone", zone);
		
		LogUtil.clearGroup();
		return "/pc/zone/zone_update_page";
	}
	
	@RequestMapping(value="/zoneList", method = {RequestMethod.POST})
	@ResponseBody
	public Response zoneList(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response) throws Exception {
		LogUtil.setGroup("zoneList");
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		 
		User user = loginService.getUserInfo(userIds);
		
		List<Zone> list = zoneService.getZoneList(user.getCompanyId());
		
		result.put("zone", list);
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	@RequestMapping(value="/zoneInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response zoneInsert(HttpServletRequest request, HttpServletResponse response, @RequestBody Zone req) throws Exception {
		LogUtil.setGroup("zoneInsert");
		
		HttpSession session =  request.getSession();
		Integer userId 		= (Integer) session.getAttribute("userId");
		User user			= loginService.getUserInfo(userId);

		req.companyId = user.getCompanyId();
		req.createId = user.getUserId();
		req.updateId = user.getUserId();
		
		logger.info("OL REQ ::: " + req);
				
		zoneService.insertZone(req);
		
		LogUtil.clearGroup();
		
		return new Response();
	}
	
	@RequestMapping(value="/zoneUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response zoneUpdate(HttpServletRequest request, HttpServletResponse response, @RequestBody Zone req) throws Exception {
		LogUtil.setGroup("zoneUpdate");
		
		HttpSession session =  request.getSession();
		Integer userId 		= (Integer) session.getAttribute("userId");
		User user			= loginService.getUserInfo(userId);

		req.updateId = user.getUserId();
		
		logger.info("OL REQ ::: " + req);
		
		zoneService.updateZone(req);
		
		LogUtil.clearGroup();
		
		return new Response();
	}
	
	@RequestMapping(value="/zoneDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response zoneDelete(HttpServletRequest request, HttpServletResponse response, @RequestBody Zone req) throws Exception {
		LogUtil.setGroup("zoneDelete");
		
		logger.info("REQ ::: " + req);
				
		zoneService.deleteZone(req.getZoneId());
		
		LogUtil.clearGroup();
		
		return new Response();
	}
	
}
