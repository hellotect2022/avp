package com.smartcc.avp.pc.beacon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.beacon.model.Beacon;
import com.smartcc.avp.pc.beacon.service.BeaconService;
import com.smartcc.avp.pc.login.service.LoginService;

import lombok.Setter;

@Controller
@RequestMapping(value="/pc/beacon")
public class BeaconPcController extends BaseController {

	@Setter
	@Resource BeaconService beaconService;
	
	@Setter
	@Resource LoginService loginService;
	
	@RequestMapping(value="/beaconListPage", method = {RequestMethod.GET})
	public String beaconListPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("beaconListPage");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		List<Beacon> list = beaconService.getBeaconList(user.getCompanyId());
		
		modelMap.put("beacon", list);
		
		LogUtil.clearGroup();
		return "/pc/beacon/beacon_list_page";
	}
	
	@RequestMapping(value="/beaconInsertPage", method = {RequestMethod.GET})
	public String beaconInsertPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("beaconInsertPage");
		
		LogUtil.clearGroup();
		return "/pc/beacon/beacon_insert_page";
	}
	
	@RequestMapping(value="/beaconInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response beaconInsert(HttpServletRequest request, ModelMap modelMap, @RequestBody Beacon req) throws Exception {
		LogUtil.setGroup("beaconInsert");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		req.setCompanyId(user.getCompanyId());
		req.setCreateId(user.getUserId());
		
		beaconService.insertBeacon(req);
				
		LogUtil.clearGroup();
		return new Response();
	}
	
	@RequestMapping(value="/beaconUpdatePage", method = {RequestMethod.GET})
	public String beaconUpdatePage(HttpServletRequest request, ModelMap modelMap, Beacon req) throws Exception {
		LogUtil.setGroup("beaconUpdatePage");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		Beacon beacon = beaconService.getBeacon(req.getBeaconId());
		
		modelMap.put("beacon", beacon);
		
		LogUtil.clearGroup();
		return "/pc/beacon/beacon_update_page";
	}
	
	@RequestMapping(value="/beaconUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response beaconUpdate(HttpServletRequest request, ModelMap modelMap, @RequestBody Beacon req) throws Exception {
		LogUtil.setGroup("beaconUpdate");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		req.setUpdateId(user.getUserId());
		
		beaconService.updateBeacon(req);
				
		LogUtil.clearGroup();
		return new Response();
	}
	
	@RequestMapping(value="/beaconDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response beaconDelete(HttpServletRequest request, ModelMap modelMap, @RequestBody Beacon req) throws Exception {
		LogUtil.setGroup("beaconDelete");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		Map<String, Object> result = new HashMap<>();
		
		beaconService.deleteBeacon(req.getBeaconId(), user.getUserId());
				
		LogUtil.clearGroup();
		return new Response(result);
	}
	
}
