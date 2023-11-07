package com.smartcc.avp.pc.user;

import java.util.ArrayList;

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
import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.reauest.webviewRequest;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.common.util.PermissionUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.ar.model.ArInfo;
import com.smartcc.avp.pc.ar.model.request.ArListRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.ar.service.ArService;
import com.smartcc.avp.pc.ar.vuforia.util.DeleteTarget;
import com.smartcc.avp.pc.company.model.request.CompanyListRequest;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.company.service.CompanyService;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.model.request.LoginSubRequest;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.member.service.MemberService;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.product.service.ProductService;
import com.smartcc.avp.pc.shop.model.request.ShopListRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;
import com.smartcc.avp.pc.shop.service.ShopService;
import com.smartcc.avp.pc.user.model.request.ChangeQuotasRequest;
import com.smartcc.avp.pc.user.model.request.MyInfoUpdateRequest;
import com.smartcc.avp.pc.user.model.request.SecessionListRequest;
import com.smartcc.avp.pc.user.model.request.UserDeleteRequest;
import com.smartcc.avp.pc.user.model.request.UserListRequest;
import com.smartcc.avp.pc.user.model.request.UserUpdateRequest;
import com.smartcc.avp.pc.user.model.request.insertMyAuthApplyRequest;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;
import com.smartcc.avp.pc.user.service.UserService;

import lombok.Setter;
/**
 * pc > user
 * @author JS.LEE
 */
@Controller
@RequestMapping(value="/pc/user")
public class UserPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(UserPcController.class);

	public static  String ym = DateUtil.getMonth();
	
	@Setter
	@Resource UserService userService;
	
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource FileService fileService;
	
	@Setter
	@Resource CompanyService companyService;
		
	@Setter
	@Resource ShopService shopService;
		
	@Setter
	@Resource ArService arService;
	
	
	@Setter
	@Resource MemberService memberService;
	
	
	@Setter
	@Resource ProductService productService;
	
	@Value("#{config['s3.bucket']}")
	private String bucketName;
	
	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;
	
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
			@Value("#{config['schema.chum']}")
			private String chumSchema;
			
			@Value("#{config['schema.scgp']}")
			private String scgpSchema;
			
			@Value("#{config['schema.bogoga']}")
			private String bogogaSchema;
			// End of	
	
	/**
	 * 탈퇴신청 하기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/insertSecession", method = {RequestMethod.POST})
	@ResponseBody
	public Response updateSecession(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response) throws Exception {
		LogUtil.setGroup("updateSecession");
		HttpSession session =  request.getSession();
		Integer userId =(Integer)session.getAttribute("userId");
		
		User user = loginService.getUserInfo(userId);
		
        if("Y".equals(user.getSecessionYn()))
        {
			 return new Response(new ApiException(997, "이미 탈퇴 하였습니다."));
        }
        else
        {
        	loginService.updateSecession(userId);
        }
	        
		Map<String, Object> result = new HashMap<>();
		
		LogUtil.clearGroup();
		
		return new Response(result);
	}
	
	/**
	 * 사용량 변경 페이지 이동  Add. 2017. 05. 18. JBum
	 * @return /pc/user/quotas
	 * @throws Exception
	 */
	@RequestMapping(value="/quotas", method = {RequestMethod.GET})
	public String quotas(HttpServletRequest request ,ModelMap modelMap, ChangeQuotasRequest req/* Add. 2017. 05. 22. JBum */) throws Exception {
		/*
		//LogUtil.setGroup("JBum");
		//Integer customId = (int) (Math.random() * 15) + 4;											// *>-- Add. 2017. 05. 22. JBum
		//User user = new User();																		// *>-- Add. 2017. 05. 22. JBum
//		System.out.println("test :: " +testService.getList());
		HttpSession session =  request.getSession();
		//user = loginService//.getUserInfo(
		//user = loginService.getUserInfo(customId);													// *>-- Add. 2017. 05. 22. JBum
		//session.setAttribute("userId", customId);													// *>-- Add. 2017. 05. 22. JBum
		//session.setAttribute("user", user);															// *>-- Add. 2017. 05. 22. JBum
		Integer userIds =(Integer)session.getAttribute("userId");
		//user = loginService.getUserInfo(userIds);
		String ym = DateUtil.getMonth();
		//UserDetailResponse userDetail	=	userService.getUserInfo(userIds, user.getDivision());
		//modelMap.put("user",userDetail);

		//long reqSize = (int) (Math.random() * 1000) + 1;													// *>-- Add. 2017. 05. 22. JBum
		//req.setUserId(customId);																			// *>-- Add. 2017. 05. 22. JBum
		//req.setStorageSize(String.valueOf(reqSize));														// *>-- Add. 2017. 05. 22. JBum
		//int i = userService.updateQuotas(req); 																// *>-- Add. 2017. 05. 22. JBum
		
		//logger.info("JBum | CustomId : " + customId);
		//logger.info("JBum | Quotas Before : " + userDetail.getStorageSize());
		//logger.info("JBum | Quotas Request : " + reqSize);
		//System.out.println("JBum | Quotas After : " + );
		
		Integer cnt = statisticsService.getStatisticAWS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym);
		Integer rdsCnt = 3;
		if(null != cnt)
		{
			rdsCnt = rdsCnt +1;
			statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,rdsCnt);
		}
		else
		{
			rdsCnt = rdsCnt +1;
			statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,rdsCnt);
		}
		*/
		//LogUtil.clearGroup();
		return "/pc/mypage/changequotas";
	}
	
	/**
	 * 사용량 변경 저장 AJAX Add. 2017. 05. 18. JBum 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/updateQuotas", method = {RequestMethod.POST})
	@ResponseBody
	public Response updateQuotas(HttpServletRequest request,ModelMap modelMap ,@RequestBody ChangeQuotasRequest req) throws Exception {
		LogUtil.setGroup("updateQuotas");
		// 한달 제한
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		req.setUserId(userId);
		long monthlyLimitSize = Long.valueOf(MONTHLY_LIMIT_SIZE).longValue();
		Integer rdsCnt = 1;
		User user = loginService.getUserInfo(userId);														// *>-- Add. 2017. 05. 22. JBum
		
		long reqSize =Long.valueOf(req.getStorageSize()).longValue();
		//long reqSize = (int) (Math.random() * 1000) + 1;													// *>-- Add. 2017. 05. 22. JBum
		req.setStorageSize(String.valueOf(reqSize));														// *>-- Add. 2017. 05. 22. JBum
		long allUserStorage = loginService.getAllUserStorage(ym);
		
		if(monthlyLimitSize < allUserStorage + reqSize)
		{
			 return new Response(new ApiException(999, "이번달 s3 사용할수 있는 용량 초과."));
		}
		
		int i =	userService.updateQuotas(req);
						
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 사용량 변경 요청 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/requestQuotas", method = {RequestMethod.POST})
	@ResponseBody
	public Response requestQuotas(HttpServletRequest request,ModelMap modelMap ,@RequestBody ChangeQuotasRequest req) throws Exception {
		LogUtil.setGroup("requestQuotas");
		// 한달 제한
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		req.setUserId(userId);
		
		User user = loginService.getUserInfo(userId);														// *>-- Add. 2017. 05. 22. JBum
		
		long reqSize =Long.valueOf(req.getStorageSize()).longValue();
		//long reqSize = (int) (Math.random() * 1000) + 1;													// *>-- Add. 2017. 05. 22. JBum
		req.setStorageSize(String.valueOf(reqSize));														// *>-- Add. 2017. 05. 22. JBum
		
		int exist = userService.getRequestQuotasCount(req);
		if (exist > 0) {
			return new Response(new ApiException(900, "승인 대기 중입니다."));
		}
		
		int i =	userService.requestQuotas(req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 내정보 페이지 이동
	 * @return /pc/user/myPage
	 * @throws Exception
	 */
	@RequestMapping(value="/myPage", method = {RequestMethod.GET})
	public String myPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("My Page");

//		System.out.println("test :: " +testService.getList());
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		
		String ym = DateUtil.getMonth();
		UserDetailResponse userDetail	=	userService.getUserInfo(userIds, user.getDivision());
		modelMap.put("user",userDetail);

		LogUtil.clearGroup();
		
		return "/pc/mypage/mypage";
	}
	
	
	/**
	 * 권한 신청하기 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/insertMyAuthApply", method = {RequestMethod.POST})
	@ResponseBody
	public Response insertMyAuthApply(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid insertMyAuthApplyRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String ym = DateUtil.getMonth();
		User user = loginService.getUserInfo(userIds);

		// 회원탈퇴 신청시 
		if("sece".equals(req.getInsertGubun()))
		{
	        if("Y".equals(user.getSecessionYn()))
	        {
				 return new Response(new ApiException(997, "이전에 신청한 유저."));
	        }
	        else
	        {
	        	loginService.updateSecession(user.getUserId());
	        }
		}
		else
		{	
			if(CommonCode.USER_TYPE.SELLER.code.equals(user.getUserType()))
			{
				memberService.memberAuthUpdate(user.getUserId(),req.getMemberViewAuth(),req.getShopUpdateAuth(),req.getProductUpdateAuth(),"N");
			}
		}
	
		
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 전체 회원 목록 페이지 이동
	 * @return /pc/user/user_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/userListPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String twitter(HttpServletRequest request ,ModelMap modelMap,webviewRequest req) throws Exception {
		LogUtil.setGroup("userListPage");
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
//		statisticsService.insertUserAction(userIds,userAgent,CommonCode.ACTION_TYPE.USER_LIST.code);
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		
		logger.info("userId ::::::" + req.getUserId());
		modelMap.put("userId",req.getUserId());
//		System.out.println("test :: " +testService.getList());
		LogUtil.clearGroup();
		return "/pc/user/user_list_page";
	}
	
	
	/**
	 * 전체 회원 목록 가져오기 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/userList", method = {RequestMethod.POST})
	@ResponseBody
	public Response productList(ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid UserListRequest req) throws Exception {
		LogUtil.setGroup("userList");
		
		List<UserListResponse> users = userService.getUserList(req);
		Map<String, Object> result = new HashMap<>();
		
		result.put("users", users);
		result.put("pageInfo", req.getPageInfo());
		
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 회원목록 > 회원상세 페이지 이동
	 * @return /pc/user/user_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/userDetailPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String userDetailPage(HttpServletRequest request ,ModelMap modelMap,LoginRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		String ym = DateUtil.getMonth();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		Integer rdsCnt = 3;
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}

		
		rdsCnt = rdsCnt +1;
		UserDetailResponse userDetail	=	userService.getUserInfo(req.getUserId(), user.getDivision());
		
		
		  // 지금까지 내가쓴 총 용량 
	
		long monthlyLimitSize			=	Long.valueOf(MONTHLY_LIMIT_SIZE).longValue();
		
		long myLimitSize = 0;
		if(null != userDetail.getStorageSize())
		{
			myLimitSize				=	Long.valueOf(userDetail.getStorageSize()).longValue();
		}
		rdsCnt = rdsCnt +1;
	
		  // 지금까지 내가쓴 총 용량 
		modelMap.put("user",userDetail);
		modelMap.put("monthlyLimitSize",monthlyLimitSize);
		modelMap.put("myLimitSize",myLimitSize);
			
		modelMap.put("userId",req.getUserId());
		modelMap.put("user",userDetail);
		LogUtil.clearGroup();
		return "/pc/user/user_detail_page";
	}
	
	
	/**
	 * 유저 삭제 하기 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/userDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response userDelete(HttpServletRequest request,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid UserDeleteRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(req.getDelUserId());
		Integer rdsCnt = 2;
		boolean permissionResult = PermissionUtil.sessionCheck(request.getRequestURI(),user);
		DeleteTarget vuforiaDel = new DeleteTarget();
		CompanyListRequest companyListreq = new CompanyListRequest();
		companyListreq.setUserId(req.getDelUserId());
		companyListreq.setUserType(user.getUserType());
		List<CompanyListResponse> companyList	=	companyService.getCompanyList(tableName, companyListreq);

		
		List<Integer>  arIdDelArr = new ArrayList<Integer>();
		List<Integer>  shopIdDelArr = new ArrayList<Integer>();
		List<Integer>  productIdDelArr = new ArrayList<Integer>();
		List<Integer>  eventIdDelArr = new ArrayList<Integer>();
		List<Integer>  companyIdDelArr = new ArrayList<Integer>();
		
		
		List<Integer>  shopFileDelArr = new ArrayList<Integer>();
		List<Integer>  productFileDelArr = new ArrayList<Integer>();
		List<Integer>  arFileDelArr = new ArrayList<Integer>();
		List<Integer>  eventFileDelArr = new ArrayList<Integer>();
//		d---------------------------------------------------------------------------------------------

		if(!permissionResult)
		{
			if(CommonCode.USER_TYPE.ADMIN.code.equals(user.getUserType()))
			{
				if(null != companyList)
				{
					for(CompanyListResponse companyData : companyList)
					{
						
						ShopListRequest shopListreq = new ShopListRequest();
						shopListreq.setUserType("ADMIN");
						shopListreq.setCompanyId(companyData.getCompanyId());
						List<ShopListResponse> shopList	=	shopService.getShopList(tableName, shopListreq);
						
						
						ProductListRequest prodListReq = new ProductListRequest();
						prodListReq.setUserType("ADMIN");
						prodListReq.setCompanyId(companyData.getCompanyId());
						List<ProductListResponse> prodList = productService.getProductList(tableName, prodListReq);
						
						
						ArListRequest arListReq = new ArListRequest();
						prodListReq.setUserType("ADMIN");
						prodListReq.setCompanyId(companyData.getCompanyId());
						List<ArListResponse> arList = arService.getArList(tableName, arListReq);
						
						if(null != shopList)
						{
							for(ShopListResponse shopData : shopList)
							{
								rdsCnt = rdsCnt + 5;
								shopIdDelArr.add(shopData.getShopId());
								ShopDetailResponse shop = shopService.shopDetailPage(tableName, shopData.getShopId());
								
								FileData shopFile = fileService.getFile(Integer.parseInt(shop.getShopImageId()));					// Need to split 2017. 09. 14. JBum | String value need to split -> 14,134,314,13
								FileData thumbnailFile = fileService.getFile(shop.getThumbnailImageId());
								FileData voiceFile = fileService.getFile(shop.getVoiceFileId());
								FileData vrFile = fileService.getFile(shop.getVrVideoId());
								
								
								if(null != shopFile)
								{
									shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));									// Need to split 2017. 09. 14. JBum | String value need to split -> 356,3416,4513,13 
									rdsCnt = rdsCnt +1;
								}
								
								
								if(null != thumbnailFile)
								{
									shopFileDelArr.add(shop.getThumbnailImageId());
									rdsCnt = rdsCnt +1;
								}
								if(null != voiceFile)
								{
									shopFileDelArr.add(shop.getVoiceFileId());
									rdsCnt = rdsCnt +1;
								}
								if(null != vrFile)
								{
									shopFileDelArr.add(shop.getVrVideoId());
									rdsCnt = rdsCnt +1;
								}
							}
							rdsCnt = rdsCnt + 2;
							shopService.deleteShopArr(tableName, shopIdDelArr);
							fileService.deleteFileArr(shopFileDelArr);
						}
						
						if(null != prodList)
						{
							for(ProductListResponse prodData : prodList)
							{
								rdsCnt = rdsCnt + 2;
				
								ProductDetailResponse product = productService.productDetailPage(tableName, prodData.getProductId());
								
								productIdDelArr.add(prodData.getProductId());
								productFileDelArr.add(product.getProductImageId());
								FileData prodFile = fileService.getFile(product.getProductImageId());
							}
							rdsCnt = rdsCnt + 2;
				
							productService.deleteProductArr(tableName, productIdDelArr);
							fileService.deleteFileArr(productFileDelArr);
						}
						
						
						if(null != arList)
						{
							for(ArListResponse arData : arList)
							{
								rdsCnt = rdsCnt + 3;
								ArInfo ar = arService.arDetailPage(tableName, arData.getArId());
								arIdDelArr.add(ar.getArId());
								arFileDelArr.add(ar.getTargetFileId());
								arFileDelArr.add(ar.getObjectFileId());
								FileData targetFile = fileService.getFile(ar.getTargetFileId());
								FileData objFile = fileService.getFile(ar.getObjectFileId());
								
								vuforiaDel.deactivateThenDeleteTarget(ar.getTargetId());
							}
							rdsCnt = rdsCnt + 2;
				
							arService.deleteArArr(tableName, arIdDelArr);
							fileService.deleteFileArr(arFileDelArr);			
						}
						
					}
					companyService.companyDelete(tableName, user.getCompanyId());
				}
				userService.delUser(req);
			}
			else
			{
				ShopListRequest shopListReq = new ShopListRequest();
				shopListReq.setUserId(req.getDelUserId());
				shopListReq.setUserType(user.getUserType());
				List<ShopListResponse> shopList	=	shopService.getShopList(tableName, shopListReq);
				
				ProductListRequest prodListReq = new ProductListRequest();
				prodListReq.setUserId(req.getDelUserId());
				prodListReq.setUserType(user.getUserType());
				List<ProductListResponse> prodList = productService.getProductList(tableName, prodListReq);
				
				ArListRequest arListReq = new ArListRequest();
				arListReq.setUserId(req.getDelUserId());
				arListReq.setUserType(user.getUserType());		
				List<ArListResponse> arList = arService.getArList(tableName, arListReq);
				
				if(null != shopList)
				{
					for(ShopListResponse shopData : shopList)
					{
						rdsCnt = rdsCnt + 5;
						shopIdDelArr.add(shopData.getShopId());
						ShopDetailResponse shop = shopService.shopDetailPage(tableName, shopData.getShopId());
						
						FileData shopFile = fileService.getFile(Integer.parseInt(shop.getShopImageId()));					// Need to split 2017. 09. 14. JBum | String value need to split -> 124554,113413,135,31
						FileData thumbnailFile = fileService.getFile(shop.getThumbnailImageId());
						FileData voiceFile = fileService.getFile(shop.getVoiceFileId());
						FileData vrFile = fileService.getFile(shop.getVrVideoId());
						
						
						if(null != shopFile)
						{
							shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));									// Need to split 2017. 09. 14. JBum | String value need to split -> 246,246246,246,123
							rdsCnt = rdsCnt +1;

						}
						
						if(null != thumbnailFile)
						{
							shopFileDelArr.add(shop.getThumbnailImageId());
							rdsCnt = rdsCnt +1;

						}
						if(null != voiceFile)
						{
							shopFileDelArr.add(shop.getVoiceFileId());
							rdsCnt = rdsCnt +1;

						}
						if(null != vrFile)
						{
							shopFileDelArr.add(shop.getVrVideoId());
							rdsCnt = rdsCnt +1;

						}
					}
					rdsCnt = rdsCnt + 2;
					shopService.deleteShopArr(tableName, shopIdDelArr);
					fileService.deleteFileArr(shopFileDelArr);
				}
				
				if(null != prodList)
				{
					for(ProductListResponse prodData : prodList)
					{
						rdsCnt = rdsCnt + 2;
		
						ProductDetailResponse product = productService.productDetailPage(tableName, prodData.getProductId());
						
						productIdDelArr.add(prodData.getProductId());
						productFileDelArr.add(product.getProductImageId());
						FileData prodFile = fileService.getFile(product.getProductImageId());
						rdsCnt = rdsCnt +1;
		            	
					}
					rdsCnt = rdsCnt + 2;
		
					productService.deleteProductArr(tableName, productIdDelArr);
					fileService.deleteFileArr(productFileDelArr);
				}
				
				if(null != arList)
				{
					for(ArListResponse arData : arList)
					{
						rdsCnt = rdsCnt + 3;
						ArInfo ar = arService.arDetailPage(tableName, arData.getArId());
						arIdDelArr.add(ar.getArId());
						arFileDelArr.add(ar.getTargetFileId());
						arFileDelArr.add(ar.getObjectFileId());
						FileData targetFile = fileService.getFile(ar.getTargetFileId());
						FileData objFile = fileService.getFile(ar.getObjectFileId());
						
						vuforiaDel.deactivateThenDeleteTarget(ar.getTargetId());
					}
					rdsCnt = rdsCnt + 2;
					arService.deleteArArr(tableName, arIdDelArr);
					fileService.deleteFileArr(arFileDelArr);			
				}
								
				userService.delUser(req);
				
			}
			
		}
		else
		{
			return new Response(new ApiException(999, "접근권한없음."));
			
		}

//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	


	/**
	 * 탈퇴 목록 페이지 이동
	 * @return /pc/user/secession_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/secessionListPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String secessionListPage(HttpServletRequest request ,ModelMap modelMap,webviewRequest req) throws Exception {
		LogUtil.setGroup("secessionListPage");
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
//		statisticsService.insertUserAction(userIds,userAgent,CommonCode.ACTION_TYPE.USER_LIST.code);
		User user = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		
		logger.info("userId ::::::" + req.getUserId());
		modelMap.put("userId",req.getUserId());
//		System.out.println("test :: " +testService.getList());
		LogUtil.clearGroup();
		return "/pc/user/secession_list_page";
	}
	
	/**
	 * 탈퇴 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */

	@RequestMapping(value="/secessionList", method = {RequestMethod.POST})
	@ResponseBody
	public Response secessionList(ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid SecessionListRequest req) throws Exception {
		LogUtil.setGroup("secessionList");
		
		List<UserListResponse>  users= userService.getSecessionList(req);
		Map<String, Object> result = new HashMap<>();
		
		result.put("users", users);
		result.put("pageInfo", req.getPageInfo());
		
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**

	/**
	 * 탈퇴 목록 > 탈퇴 회원 상세 페이지 이동
	 * @return /pc/user/secession_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/secessionDetailPage", method = {RequestMethod.POST,RequestMethod.GET})
	public String secessionDetailPage(HttpServletRequest request ,ModelMap modelMap,webviewRequest req) throws Exception {
		LogUtil.setGroup("secessionDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(req.getUserId());
		User me = loginService.getUserInfo(userIds);
		session.setAttribute("user",user);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),me);
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		
		logger.info("userId ::::::" + req.getUserId());
		modelMap.put("userId",req.getUserId());
		modelMap.put("user", user);

		LogUtil.clearGroup();
		return "/pc/user/secession_detail_page";
	}
	
	/**
	 * 탈퇴 상세 > 복구
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/secessionUserUpdate", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Response secessionUserUpdate(HttpServletRequest request ,ModelMap modelMap,@RequestBody UserUpdateRequest req) throws Exception {
		LogUtil.setGroup("secessionUserUpdate");
		
		HttpSession session =  request.getSession();
		
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(req.getUpdateId());
		User me = loginService.getUserInfo(userIds);
		
		req.setRestoreId(me.getUserId());
		req.setDelYn("N");
		
		int i = userService.updateSecession(req);

		Map<String, Object> result = new HashMap<>();
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 탈퇴 승인 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/secessionUserDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response secessionUserDelete(HttpServletRequest request,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid UserDeleteRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(req.getDelUserId());

		Integer rdsCnt = 2;
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		DeleteTarget vuforiaDel = new DeleteTarget();
		CompanyListRequest companyListreq = new CompanyListRequest();
		companyListreq.setUserId(req.getDelUserId());
		companyListreq.setUserType(user.getUserType());
		List<CompanyListResponse> companyList	=	companyService.getCompanyList(tableName, companyListreq);

		
		List<Integer>  arIdDelArr = new ArrayList<Integer>();
		List<Integer>  shopIdDelArr = new ArrayList<Integer>();
		List<Integer>  productIdDelArr = new ArrayList<Integer>();
		List<Integer>  eventIdDelArr = new ArrayList<Integer>();
		List<Integer>  companyIdDelArr = new ArrayList<Integer>();
		
		
		List<Integer>  shopFileDelArr = new ArrayList<Integer>();
		List<Integer>  productFileDelArr = new ArrayList<Integer>();
		List<Integer>  arFileDelArr = new ArrayList<Integer>();
		List<Integer>  eventFileDelArr = new ArrayList<Integer>();
//		d---------------------------------------------------------------------------------------------

		if(!permissionResult)
		{
			if(CommonCode.USER_TYPE.ADMIN.code.equals(user.getUserType()))
			{
				if(null != companyList)
				{
					for(CompanyListResponse companyData : companyList)
					{
						
						ShopListRequest shopListreq = new ShopListRequest();
						shopListreq.setUserType("ADMIN");
						shopListreq.setCompanyId(companyData.getCompanyId());
						List<ShopListResponse> shopList	=	shopService.getShopList(tableName, shopListreq);
						
						
						ProductListRequest prodListReq = new ProductListRequest();
						prodListReq.setUserType("ADMIN");
						prodListReq.setCompanyId(companyData.getCompanyId());
						List<ProductListResponse> prodList = productService.getProductList(tableName, prodListReq);
						
						
						ArListRequest arListReq = new ArListRequest();
						prodListReq.setUserType("ADMIN");
						prodListReq.setCompanyId(companyData.getCompanyId());
						List<ArListResponse> arList = arService.getArList(tableName, arListReq);
						
						if(null != prodList)
						{
							for(ProductListResponse prodData : prodList)
							{
								rdsCnt = rdsCnt + 2;
				
								ProductDetailResponse product = productService.productDetailPage(tableName, prodData.getProductId());
								
								productIdDelArr.add(prodData.getProductId());
								FileData prodFile = fileService.getFile(product.getProductImageId());
								if(null != prodFile)
								{
									productFileDelArr.add(product.getProductImageId());
								}
							}
							rdsCnt = rdsCnt + 2;
				
							productService.deleteProductArr(tableName, productIdDelArr);
							fileService.deleteFileArr(productFileDelArr);
						}
						
						
						if(null != arList)
						{
							for(ArListResponse arData : arList)
							{
								rdsCnt = rdsCnt + 3;
								ArInfo ar = arService.arDetailPage(tableName, arData.getArId());
								arIdDelArr.add(ar.getArId());
								arFileDelArr.add(ar.getTargetFileId());
								arFileDelArr.add(ar.getObjectFileId());
								FileData targetFile = fileService.getFile(ar.getTargetFileId());
								FileData objFile = fileService.getFile(ar.getObjectFileId());
								
								vuforiaDel.deactivateThenDeleteTarget(ar.getTargetId());
							}
							rdsCnt = rdsCnt + 2;
				
							arService.deleteArArr(tableName, arIdDelArr);
							fileService.deleteFileArr(arFileDelArr);			
						}		
						
						if(null != shopList)
						{
							for(ShopListResponse shopData : shopList)
							{
								rdsCnt = rdsCnt + 5;
								shopIdDelArr.add(shopData.getShopId());
								ShopDetailResponse shop = shopService.shopDetailPage(tableName, shopData.getShopId());
								
								FileData shopFile = fileService.getFile(Integer.parseInt(shop.getShopImageId()));						// Need to split 2017. 09. 14. JBum | String value need to split -> 54612,16,1,51
								FileData thumbnailFile = fileService.getFile(shop.getThumbnailImageId());
								FileData voiceFile = fileService.getFile(shop.getVoiceFileId());
								FileData vrFile = fileService.getFile(shop.getVrVideoId());
								
								
								if(null != shopFile)
								{
									shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));										// Need to split 2017. 09. 14. JBum | String value need to split -> 56124,13516,1,14
								
								}
								
								if(null != thumbnailFile)
								{
									shopFileDelArr.add(shop.getThumbnailImageId());
								
								}
								if(null != voiceFile)
								{
									shopFileDelArr.add(shop.getVoiceFileId());
								
								}
								if(null != vrFile)
								{
									shopFileDelArr.add(shop.getVrVideoId());
								
								}
							}
							shopService.deleteShopArr(tableName, shopIdDelArr);
							fileService.deleteFileArr(shopFileDelArr);
						}
						
					}
					companyService.companyDelete(tableName, user.getCompanyId());
				}
				userService.delUser(req);
			}
			else
			{
				ShopListRequest shopListReq = new ShopListRequest();
				shopListReq.setUserId(req.getDelUserId());
				shopListReq.setUserType(user.getUserType());
				List<ShopListResponse> shopList	=	shopService.getShopList(tableName, shopListReq);
				
				ProductListRequest prodListReq = new ProductListRequest();
				prodListReq.setUserId(req.getDelUserId());
				prodListReq.setUserType(user.getUserType());
				List<ProductListResponse> prodList = productService.getProductList(tableName, prodListReq);
				
				ArListRequest arListReq = new ArListRequest();
				arListReq.setUserId(req.getDelUserId());
				arListReq.setUserType(user.getUserType());		
				List<ArListResponse> arList = arService.getArList(tableName, arListReq);
				
				if(null != prodList)
				{
					for(ProductListResponse prodData : prodList)
					{
						rdsCnt = rdsCnt + 2;
		
						ProductDetailResponse product = productService.productDetailPage(tableName, prodData.getProductId());
						
						productIdDelArr.add(prodData.getProductId());
						productFileDelArr.add(product.getProductImageId());
						FileData prodFile = fileService.getFile(product.getProductImageId());

					}
					rdsCnt = rdsCnt + 2;
		
					productService.deleteProductArr(tableName, productIdDelArr);
					fileService.deleteFileArr(productFileDelArr);
				}
				
				if(null != arList)
				{
					for(ArListResponse arData : arList)
					{
						rdsCnt = rdsCnt + 3;
						ArInfo ar = arService.arDetailPage(tableName, arData.getArId());
						arIdDelArr.add(ar.getArId());
						arFileDelArr.add(ar.getTargetFileId());
						arFileDelArr.add(ar.getObjectFileId());
						FileData targetFile = fileService.getFile(ar.getTargetFileId());
						FileData objFile = fileService.getFile(ar.getObjectFileId());
						
						vuforiaDel.deactivateThenDeleteTarget(ar.getTargetId());
					}
					rdsCnt = rdsCnt + 2;
					arService.deleteArArr(tableName, arIdDelArr);
					fileService.deleteFileArr(arFileDelArr);			
				}
				
				if(null != shopList)
				{
					for(ShopListResponse shopData : shopList)
					{
						rdsCnt = rdsCnt + 5;
						shopIdDelArr.add(shopData.getShopId());
						ShopDetailResponse shop = shopService.shopDetailPage(tableName, shopData.getShopId());
						
						FileData shopFile = fileService.getFile(Integer.parseInt(shop.getShopImageId()));					// Need to split 2017. 09. 14. JBum | String value need to split -> 5345,13,53,14
						FileData thumbnailFile = fileService.getFile(shop.getThumbnailImageId());
						FileData voiceFile = fileService.getFile(shop.getVoiceFileId());
						FileData vrFile = fileService.getFile(shop.getVrVideoId());
						
						
						if(null != shopFile)
						{
							shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));									// Need to split 2017. 09. 14. JBum | String value need to split -> 12345,13513,5131,3
						}
						
						
						if(null != thumbnailFile)
						{
							shopFileDelArr.add(shop.getThumbnailImageId());
						}
						if(null != voiceFile)
						{
							shopFileDelArr.add(shop.getVoiceFileId());
						}
						if(null != vrFile)
						{
							shopFileDelArr.add(shop.getVrVideoId());
						}
					}
					rdsCnt = rdsCnt + 2;
					shopService.deleteShopArr(tableName, shopIdDelArr);
					fileService.deleteFileArr(shopFileDelArr);
				}
				
				userService.delUser(req);
				
			}
			
		}
		else
		{
			return new Response(new ApiException(999, "접근권한없음."));
			
		}

//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 내정보 수정하기 AJAX 
	 * @param  {@link com.smartcc.avp.pc.ar.model.ArInfo}
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 뷰포리아 관련 에러 및 request 제한 초과 에러
	 */
	@RequestMapping(value="/updateUserData", method = {RequestMethod.POST})
	@ResponseBody
	public Response updateUserData(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid MyInfoUpdateRequest req) throws Exception {
		LogUtil.setGroup("updateUserData");
		
		HttpSession session =  request.getSession();
		Integer userId =(Integer)session.getAttribute("userId");
		req.setUserId(userId);
		userService.updateMyInfo(req);
		
		LogUtil.clearGroup();
		return new Response();
	}

}
