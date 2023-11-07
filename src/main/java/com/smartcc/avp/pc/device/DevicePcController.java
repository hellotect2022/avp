package com.smartcc.avp.pc.device;

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

import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.device.model.Device;
import com.smartcc.avp.pc.device.service.DeviceService;
import com.smartcc.avp.pc.login.service.LoginService;

import lombok.Setter;

/**
 * @author J.B Choi
 */
@Controller
@RequestMapping(value="/pc/device")
public class DevicePcController {
	
	private static final Logger logger = LoggerFactory.getLogger(DevicePcController.class);
	
	@Setter
	@Resource DeviceService deviceService;
	
	@Setter
	@Resource LoginService loginService;
	
	/**
	 * 디바이스 목록 페이지 이동 
	 * @return /pc/device/device_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/deviceListPage", method = {RequestMethod.GET})
	public String deviceListPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("deviceListPage");
		
		LogUtil.clearGroup();
		return "/pc/device/device_list_page";
	}
	
	/**
	 * 디바이스 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/deviceList", method = {RequestMethod.POST})
	@ResponseBody
	public Response deviceList(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid Device req) throws Exception {
		LogUtil.setGroup("deviceList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		 
		String ym = DateUtil.getMonth();
		User user = loginService.getUserInfo(userIds);
		
		req.setCompanyId(user.getCompanyId());
		req.setBranchId(user.getBranchId());
		
		// 상품 리스트 목록 가져오기
		List<Device> deviceList = deviceService.getDeviceList(req);
				
		result.put("devices", deviceList);
		result.put("pageInfo", req.getPageInfo());
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 디바이스 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/deviceListFromOther", method = {RequestMethod.POST})
	@ResponseBody
	public Response deviceListFromOther(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid Device req) throws Exception {
		LogUtil.setGroup("deviceListFromOther");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		 
		User user = loginService.getUserInfo(userIds);
		
		req.setCompanyId(user.getCompanyId());
		
		// 상품 리스트 목록 가져오기
		List<Device> deviceList = deviceService.getDeviceList(req);
				
		result.put("devices", deviceList);
		result.put("pageInfo", req.getPageInfo());
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 작업리스트 페이지 이동 
	 * @return /pc/orderlist/orderlist_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/deviceDetailPage", method = {RequestMethod.GET})
	public String deviceDetailPage(HttpServletRequest request ,ModelMap modelMap, Device req) throws Exception {
		LogUtil.setGroup("deviceDetailPage");

		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);		
		
		Device device = deviceService.getDevice(req.getDeviceId());

		String updateYn = "Y";
		if(CommonCode.USER_TYPE.WORKER.code.equals(user.getUserType()) || "SUPER".equals(user.getUserType())) {
			updateYn = "N";
			if(user.getUserId() == device.getCreateId()) {
				updateYn = "Y";
			}
		}	
		
		modelMap.put("device", device);
		modelMap.put("updateYn", updateYn);
		
		LogUtil.clearGroup();
		return "/pc/device/device_detail_page";
	}
	
	/**
	 * 디바이스 등록ㄴ 페이지 이동 
	 * @return /pc/device/device_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/deviceInsertPage", method = {RequestMethod.GET})
	public String deviceInsertPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("deviceInsertPage");
		
		HttpSession session =  request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		modelMap.put("user", user);
		
		LogUtil.clearGroup();
		return "/pc/device/device_insert_page";
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/deviceInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response deviceInsert(HttpServletRequest request, HttpServletResponse response, Device req) throws Exception {
		LogUtil.setGroup("deviceInsert");
		
		HttpSession session =  request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);

		req.setCompanyId(user.getCompanyId());
		req.setCreateId(userId);
		req.setUpdateId(userId);
		
		logger.info("OL REQ ::: " + req);
				
		deviceService.insertDevice(req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 디바이스 등록ㄴ 페이지 이동 
	 * @return /pc/device/device_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/deviceUpdatePage", method = {RequestMethod.GET})
	public String deviceUpdatePage(HttpServletRequest request ,ModelMap modelMap, Device req) throws Exception {
		LogUtil.setGroup("deviceUpdatePage");
		
		HttpSession session =  request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userId);
		
		Device device = deviceService.getDevice(req.getDeviceId());		
		
		modelMap.put("device", device);
		modelMap.put("user", user);
		
		LogUtil.clearGroup();
		return "/pc/device/device_update_page";
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/deviceUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response deviceUpdate(HttpServletRequest request, HttpServletResponse response, Device req) throws Exception {
		LogUtil.setGroup("deviceUpdate");
		
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		User user			 = loginService.getUserInfo(userId);

		req.setCompanyId(user.getCompanyId());
		req.setUpdateId(userId);
		
		logger.info("OL REQ ::: " + req);
				
		deviceService.updateDevice(req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/deviceDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response deviceDelete(HttpServletRequest request, HttpServletResponse response, @RequestBody Device req) throws Exception {
		LogUtil.setGroup("deviceDelete");
		
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		User user			 = loginService.getUserInfo(userId);
		
		logger.info("DELETE REQ ::: " + req);
				
		deviceService.deleteDevice(userId, req.getDeviceId());
		
		LogUtil.clearGroup();
		
		return new Response();
	}
	
}
