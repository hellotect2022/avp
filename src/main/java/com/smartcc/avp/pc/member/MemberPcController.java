package com.smartcc.avp.pc.member;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.reauest.webviewRequest;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.common.util.PermissionUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.member.model.request.MemberApplyUpdateRequest;
import com.smartcc.avp.pc.member.model.request.MemberDetailRequest;
import com.smartcc.avp.pc.member.model.request.MemberListRequest;
import com.smartcc.avp.pc.member.model.request.MemberUpdateRequest;
import com.smartcc.avp.pc.member.model.response.MemberListResponse;
import com.smartcc.avp.pc.member.service.MemberService;
import com.smartcc.avp.pc.shop.service.ShopService;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.service.UserService;

import lombok.Setter;
/**
 * pc > member
 * @author JS.LEE
 */
@Controller
@RequestMapping(value="/pc/member")
public class MemberPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(MemberPcController.class);

	@Setter
	@Resource ShopService shopService;

	@Setter
	@Resource FileService fileService;
	
	@Setter
	@Resource MemberService memberService;
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource UserService userService;
	
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
			@Value("#{config['schema.chum']}")
			private String chumSchema;
			
			@Value("#{config['schema.scgp']}")
			private String scgpSchema;
			
			@Value("#{config['schema.bogoga']}")
			private String bogogaSchema;
			// End of	
			
	public static String ym = DateUtil.getMonth();
	
	/**
	 * 회원 가입 신청한 유저목록 페이지 이동
	 * @return /pc/member/member_auth_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/memberApplyListPage", method = {RequestMethod.GET , RequestMethod.POST})
	public String memberApplyListPage(HttpServletRequest request ,ModelMap modelMap,HttpServletResponse response,webviewRequest req) throws Exception {
		LogUtil.setGroup("memberApplyListPage");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}
		
		modelMap.put("userId",req.getUserId());
//		return new Response(resData);
//		return new Response(resData);
		LogUtil.clearGroup();
		return "/pc/member/member_auth_list_page";
	}


	/**
	 * 권한신청한 유저 목록 관련 페이지 이동
	 * @return /pc/member/member_authapply_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/memberAuthApplyListPage", method = {RequestMethod.GET , RequestMethod.POST})
	public String memberAuthApplyListPage(HttpServletRequest request ,ModelMap modelMap,HttpServletResponse response,webviewRequest req) throws Exception {
		LogUtil.setGroup("memberAuthApplyListPage");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}
		
		modelMap.put("userId",req.getUserId());
//		return new Response(resData);
//		return new Response(resData);
		LogUtil.clearGroup();
		return "/pc/member/member_authapply_list_page";
	}

	/**
	 * 회원 권한 신청 목록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/memberAuthApplyList", method = {RequestMethod.POST})
	@ResponseBody
	public Response authApplyMemberList(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberListRequest req) throws Exception {
		LogUtil.setGroup("memberAuthApplyList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		req.setCompanyId(user.getCompanyId());
		req.setApplyUserView("Y");
		req.setUserType(user.getUserType());
		req.setGroupDbName(user.getDivision());
		List<MemberListResponse> list	=	memberService.getMemberAuthApplyList(req);
		
		result.put("pageInfo", req.getPageInfo());
		result.put("members", list);
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}

	
	/**
	 * 회원 권한 신청 목록 > 상세 페이지 이동
	 * @return /pc/member/member_authapply_detail_page
	 * @throws exception
	 */
	@RequestMapping(value="/memberAuthApplyDetailPage", method = {RequestMethod.GET})
	public String memberAuthApplyDetailPage(ModelMap modelMap,HttpServletRequest request ,  HttpServletResponse response,MemberDetailRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User me 				= loginService.getUserInfo(userIds);
		UserDetailResponse user = userService.getUserInfo(req.getUserId(), me.getDivision());
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),me);
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}

		Integer rdsCnt = 3;
		
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}
		
		modelMap.put("confirmUserId", userIds);
		modelMap.put("user", user);
//		return new Response(resData);
		LogUtil.clearGroup();
		return "/pc/member/member_authapply_detail_page";
	}

	
	/**
	 * 회원 가입 신청 목록 > 상세 페이지 이동
	 * @return /pc/member/member_apply_detail_page
	 * @throws exception
	 */
	@RequestMapping(value="/memberApplyDetailPage", method = {RequestMethod.GET})
	public String memberApplyDetailPage(ModelMap modelMap,HttpServletRequest request ,  HttpServletResponse response,MemberDetailRequest req) throws Exception {
		LogUtil.setGroup("memberApplyDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User me = loginService.getUserInfo(userIds);
		UserDetailResponse user = userService.getUserInfo(req.getUserId(), me.getDivision());
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),me);
		
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}

		Integer rdsCnt = 3;
		
		if(!permissionResult)
		{
			
			return "/pc/auth/permission_not_accept";
		}
		
		modelMap.put("confirmUserId", userIds);
		modelMap.put("user", user);
		LogUtil.clearGroup();
		return "/pc/member/member_auth_detail_page";
	}
	
	/**
	 * 회원 가입 신청 목록 > 상세 페이지 이동 > 권한 승인 하기 AJAX
	 * @throws exception
	 */
	@RequestMapping(value="/memberAuthApplyConfirmUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberAuthApplyConfirmUpdate(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberUpdateRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "권한이 없습니다."));
		}

		logger.info("req ::: " + req);
		memberService.memberAuthUpdate(req.getUserId(),null,null,null,"Y");
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	/**
	 * 회원 가입 목록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/memberApplyList", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberApplyList(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberListRequest req) throws Exception {
		LogUtil.setGroup("memberApplyList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		req.setCompanyId(user.getCompanyId());
		req.setApplyUserView("Y");
		req.setUserType(user.getUserType());
		req.setGroupDbName(user.getDivision());
		List<MemberListResponse> list	=	memberService.getMemberApplyList(req);
				
		result.put("pageInfo", req.getPageInfo());
		result.put("members", list);
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 소속별 유저 목록 리스트 페이지 이동 
	 * @return /pc/member/member_list_page
	 * @throws exception
	 */
	@RequestMapping(value="/memberListPage", method = {RequestMethod.GET , RequestMethod.POST})
	public String memberListPage(HttpServletRequest request ,ModelMap modelMap,HttpServletResponse response,webviewRequest req) throws Exception {
		LogUtil.setGroup("memberListPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		
		modelMap.put("userId",userIds);

		LogUtil.clearGroup();
		return "/pc/member/member_list_page";
	}
	
	/**
	 * 소속별 유저 목록 리스트 페이지 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */	
	@RequestMapping(value="/memberList", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberList(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberListRequest req) throws Exception {
		LogUtil.setGroup("memberList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		req.setCompanyId(user.getCompanyId());
		req.setUserId(userIds);
		
		List<MemberListResponse> list	=	memberService.getMemberList(req);
		
		result.put("pageInfo", req.getPageInfo());
		result.put("members", list);

		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 회원 가입 승인 하기 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */	
	@RequestMapping(value="/memberAppplyUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberAppplyUpdate(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberApplyUpdateRequest req) throws Exception {
		LogUtil.setGroup("PC");

		memberService.memberAppplyUpdate(req.getUserId(),req.getConfirmUserId());
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	
	
	
	/**
	 * 소속별 회원 목록 > 상세 페이지 
	 * @return /pc/member/member_detail_page
	 * @throws exception
	 */	
	@RequestMapping(value="/memberDetailPage", method = {RequestMethod.GET})
	public String memberDetailPage(ModelMap modelMap,HttpServletRequest request ,  HttpServletResponse response,MemberDetailRequest req) throws Exception {
		LogUtil.setGroup("memberDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User myInfo = loginService.getUserInfo(userIds);
		UserDetailResponse user = userService.getUserInfo(req.getUserId(), myInfo.getDivision());
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),myInfo);

		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		modelMap.put("user", user);
		modelMap.put("confirmUserId", userIds);
		modelMap.put("userId",req.getUserId());
		
		LogUtil.clearGroup();
		
		return "/pc/member/member_detail_page";
	}
	
	
	
	
	@RequestMapping(value="/memberAuthUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberAuthUpdate(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberUpdateRequest req) throws Exception {
		LogUtil.setGroup("PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "권한이 없습니다."));
		}

		memberService.memberAuthUpdate(req.getUserId(),req.getMemberViewAuth(),req.getShopUpdateAuth(),req.getProductUpdateAuth(),"Y");
		
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 권한 수정 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/memberUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberUpdate(HttpServletRequest request ,  HttpServletResponse response,@RequestBody @Valid MemberUpdateRequest req) throws Exception {
		LogUtil.setGroup("PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "권한이 없습니다."));
		}

		memberService.memberAuthUpdate(req.getUserId(),req.getMemberViewAuth(),req.getShopUpdateAuth(),req.getProductUpdateAuth(),"Y");

		LogUtil.clearGroup();
		return new Response();
	}
	
	
	/**
	 * 멤버 삭제 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/memberDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response memberDelete(HttpServletRequest request ,  HttpServletResponse response, @RequestBody @Valid MemberUpdateRequest req) throws Exception {
		LogUtil.setGroup("memberDelete");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "권한이 없습니다."));
		}
		
		memberService.memberDelete(req.getUserId(), userIds);
		
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response();
	}
	

}
