package com.smartcc.avp.pc.orderlist;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.orderlist.model.Orderlist;
import com.smartcc.avp.pc.orderlist.service.OrderlistService;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.product.service.ProductService;

import lombok.Setter;

@Controller
@RequestMapping(value="/pc/orderlist")
public class OrderListPcController {
	
	private static final Logger logger = LoggerFactory.getLogger(OrderListPcController.class);
	
	@Setter
	@Resource ProductService productService;
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource OrderlistService orderlistService;

	/**
	 * 작업리스트 페이지 이동 
	 * @return /pc/orderlist/orderlist_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/orderlistListPage", method = {RequestMethod.GET})
	public String orderlistListPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("orderlistListPage");

		LogUtil.clearGroup();
		return "/pc/orderlist/orderlist_list_page";
	}
	
	/**
	 * 상품 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/orderlistList", method = {RequestMethod.POST})
	@ResponseBody
	public Response orderlistList(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		String ym = DateUtil.getMonth();
		User user = loginService.getUserInfo(userIds);
		
		req.setCompanyId(user.getCompanyId());
		req.setBranchId(user.getBranchId());
		
		// 상품 리스트 목록 가져오기
		List<Orderlist> orderlists = orderlistService.getOrderlistList(req);
		
		// 상품 종류, 상품 총 수량 계산
		for (int i = 0; i < orderlists.size(); i++) {
			String itemIds = orderlists.get(i).getItemIds();
			String quantities = orderlists.get(i).getQuantities();
			
			String[] splitedItem = itemIds.split(",");
			String[] splitedQty = quantities.split(",");
			
			orderlists.get(i).setItemType(splitedItem.length);
			
			int wholeQty = 0;
			for (int j = 0; j < splitedQty.length; j++) {
				wholeQty += Integer.valueOf(splitedQty[j]);
			}
			orderlists.get(i).setWholeQty(wholeQty);
		}
		
		result.put("orderlists", orderlists);
		result.put("pageInfo", req.getPageInfo());
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 작업리스트 페이지 이동 
	 * @return /pc/orderlist/orderlist_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/orderlistDetailPage", method = {RequestMethod.GET})
	public String orderlistDetailPage(HttpServletRequest request ,ModelMap modelMap, Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistDetailPage");

		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);		
		
		Orderlist orderlist = orderlistService.getOrderlist(req.getOrderlistId());

		String[] items = orderlist.getItemIds().split(",");
		
		String itemNm = "";
		
		for (int i = 0 ; i < items.length; i++) {
			
			if(i == items.length - 1) {
				itemNm += productService.productDetailPage(tableName, Integer.valueOf(items[i])).getItemName();
			} else {
				itemNm += productService.productDetailPage(tableName, Integer.valueOf(items[i])).getItemName() + ",";
			}
			
		}
		
		orderlist.setItemNames(itemNm);
		
		String updateYn = "Y";
		if(CommonCode.USER_TYPE.WORKER.code.equals(user.getUserType()) || "SUPER".equals(user.getUserType())) {
			updateYn = "N";
			if(user.getUserId() == orderlist.getCreateId()) {
				updateYn = "Y";
			}
		}	
		
		modelMap.put("orderlist", orderlist);
		modelMap.put("updateYn", updateYn);
		
		LogUtil.clearGroup();
		return "/pc/orderlist/orderlist_detail_page";
	}
	
	/**
	 * 작업리스트 페이지 이동 
	 * @return /pc/orderlist/orderlist_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/orderlistInsertPage", method = {RequestMethod.GET})
	public String orderlistInsertPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("orderlistInsertPage");

		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		
		modelMap.put("today", currentDate());
		modelMap.put("userType", user.getUserType());
		modelMap.put("user", user);
		
		LogUtil.clearGroup();
		return "/pc/orderlist/orderlist_insert_page";
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/orderlistInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response orderlistInsert(HttpServletRequest request, HttpServletResponse response, Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistInsertPage");
		
		Map<String, Object> result = new HashMap<>();
        String ym = DateUtil.getMonth();
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		User user			 = loginService.getUserInfo(userId);

		req.setCompanyId(user.getCompanyId());
		req.setCreateId(userId);

		req.setStartDt(req.getStartDt().replace("-", ""));
		req.setEndDt(req.getEndDt().replace("-", ""));
		
		logger.info("OL REQ ::: " + req);
				
		orderlistService.insertOrderlist(req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 작업리스트 페이지 이동 
	 * @return /pc/orderlist/orderlist_update_page
	 * @throws Exception
	 */
	@RequestMapping(value="/orderlistUpdatePage", method = {RequestMethod.GET})
	public String orderlistUpdatePage(HttpServletRequest request ,ModelMap modelMap, Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistUpdatePage");

		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		User user			 = loginService.getUserInfo(userId);
		
		Orderlist orderlist = orderlistService.getOrderlist(req.getOrderlistId());
		
		orderlist.setStartDt(orderlist.getStartDt().replace("-", ""));
		orderlist.setEndDt(orderlist.getEndDt().replace("-", ""));
		
		modelMap.put("orderlist", orderlist);
		modelMap.put("user", user);
		
		LogUtil.clearGroup();
		return "/pc/orderlist/orderlist_update_page";
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/orderlistUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response orderlistUpdate(HttpServletRequest request, HttpServletResponse response, Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistUpdate");
		
		Map<String, Object> result = new HashMap<>();
        String ym = DateUtil.getMonth();
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		User user			 = loginService.getUserInfo(userId);

		req.setCompanyId(user.getCompanyId());
		req.setUpdateId(user.getUserId());

		req.setStartDt(req.getStartDt().replace("-", ""));
		req.setEndDt(req.getEndDt().replace("-", ""));
		
		logger.info("OL REQ ::: " + req);
				
		orderlistService.updateOrderlist(req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 작업리스트 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/orderlistDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response orderlistDelete(HttpServletRequest request, HttpServletResponse response, @RequestBody Orderlist req) throws Exception {
		LogUtil.setGroup("orderlistDelete");
		
		Map<String, Object> result = new HashMap<>();
        String ym = DateUtil.getMonth();
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		User user			 = loginService.getUserInfo(userId);

		req.setCompanyId(user.getCompanyId());
		req.setCreateId(userId);

		req.setStartDt(req.getStartDt().replace("-", ""));
		req.setEndDt(req.getEndDt().replace("-", ""));
		
		logger.info("OL REQ ::: " + req);
				
		orderlistService.deleteOrderlist(userId, req.getOrderlistId());
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 현재시간 구하기
	 * @return string 
	 */
	private String currentDate() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String formattedDate = format.format(new Date());
		
		return formattedDate;
	}
	
}
