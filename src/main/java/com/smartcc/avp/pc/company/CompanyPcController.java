package com.smartcc.avp.pc.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.FileUtil;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
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
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.company.model.request.CompanyDetailRequest;
import com.smartcc.avp.pc.company.model.request.CompanyInsertRequest;
import com.smartcc.avp.pc.company.model.request.CompanyListRequest;
import com.smartcc.avp.pc.company.model.request.CompanyUpdateRequest;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.company.service.CompanyService;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.product.service.ProductService;
import com.smartcc.avp.pc.shop.ShopPcController;
import com.smartcc.avp.pc.shop.model.request.ShopInsertRequest;
import com.smartcc.avp.pc.shop.model.request.ShopListRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;
import com.smartcc.avp.pc.shop.service.ShopService;

import lombok.Setter;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.RequestToken;
/**
 * PC > Company Class
 * @author JS.LEE
 */
@Controller
@RequestMapping(value="/pc/company")
public class CompanyPcController  extends BaseController {
	public static   	String ym = DateUtil.getMonth();
	private static final Logger logger = LoggerFactory.getLogger(CompanyPcController.class);
	@Value("#{config['s3.bucket']}")
	private String bucketName;
	@Setter
	@Resource CompanyService companyService;
		
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource ShopService shopService;
		
	@Setter
	@Resource FileService fileService;

	@Setter
	@Resource ArService arService;
		
	@Setter
	@Resource ProductService productService;
	
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
		@Value("#{config['schema.chum']}")
		private String chumSchema;
		
		@Value("#{config['schema.scgp']}")
		private String scgpSchema;
		
		@Value("#{config['schema.bogoga']}")
		private String bogogaSchema;
		// End of
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @return /pc/company/company_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/companyListPage", method = {RequestMethod.GET})
	public String companyListPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("companyListPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		LogUtil.clearGroup();
		return "/pc/company/company_list_page";
	}
	
	/**
	 * 소속 목록 AJAX 
	 * @return 
	 * response Type : JSON
	 * response Body : list -{@link CompanyListResponse}
	 * @throws Exception
	 * 	 
	*/
	@RequestMapping(value="/companyList", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyList(HttpServletRequest request, HttpServletResponse response,@RequestBody @Valid CompanyListRequest req) throws Exception {
		LogUtil.setGroup("companyList");
		HttpSession session =  request.getSession();
		Map<String, Object> result = new HashMap<>();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		
		req.setUserId(userIds);
		req.setUserType(user.getUserType());
		List<CompanyListResponse> cmpgns = companyService.getCompanyList(tableName, req);
		result.put("companys", cmpgns);
		result.put("pageInfo", req.getPageInfo());

		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 소속등록신청 목록을 조회한다.
	 * @return /pc/company/company_req_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/companyReqListPage", method = {RequestMethod.GET})
	public String companyReqListPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("companyReqListPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		LogUtil.clearGroup();
		return "/pc/company/company_req_list_page";
	}
	
	/**
	 * 소속등록신청 목록 AJAX 
	 * @return 
	 * response Type : JSON
	 * response Body : list -{@link CompanyListResponse}
	 * @throws Exception
	 * 	 
	*/
	@RequestMapping(value="/companyReqList", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyReqList(HttpServletRequest request, HttpServletResponse response,@RequestBody @Valid CompanyListRequest req) throws Exception {
		LogUtil.setGroup("companyReqList");
		HttpSession session =  request.getSession();
		Map<String, Object> result = new HashMap<>();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		
		req.setUserId(userIds);
		req.setUserType(user.getUserType());
		List<CompanyListResponse> cmpgns = companyService.getCompanyReqList(req);
		result.put("companys", cmpgns);
		result.put("pageInfo", req.getPageInfo());

		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 로그인 부가 정보 page에서소속을 가져오기 위한 ajax
	 * @param  {@link CompanyListRequest} 
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 request 제한 초과 에러
	 * response Body   : list - {@link CompanyListResponse} 
	 * @throws Exception
	 */
	@RequestMapping(value="/allCompanyList", method = {RequestMethod.POST})
	@ResponseBody
	public Response allCompanyList(HttpServletRequest request, HttpServletResponse response,@RequestBody @Valid CompanyListRequest req) throws Exception {
		LogUtil.setGroup("All Company List");
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		String tableName = req.getGroupDbName();
		
		req.setUserType(CommonCode.USER_TYPE.SUPER.code);
		List<CompanyListResponse> cmpgns = companyService.getAllCompanyList(tableName, req);
		result.put("companys", cmpgns);

		LogUtil.clearGroup();
		return new Response(result);
	}
	
	
	/**
	 * 소속 등록 페이지  이동
	 * @return /pc/company/company_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/companyInsertPage", method = {RequestMethod.GET})
	public String twitter(HttpServletRequest request,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		LogUtil.clearGroup();		
		return "/pc/company/company_insert_page";
	}

	/**
	 * 소속 등록 Ajax
	 * @param  {@link CompanyInsertRequest} 
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 request 제한 초과 에러
	 * @throws Exception
	 */
	@RequestMapping(value="/companyInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyInsert(HttpServletRequest request, HttpServletResponse response,@RequestBody @Valid CompanyInsertRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		req.setCreateId(userIds);
		companyService.companyInsert(tableName, req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	/**
	 * 소속 상세 페이지 이동.
	 *  @param  {@link CompanyDetailRequest}
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/companyDetailPage", method = {RequestMethod.GET})
	public String companyDetailPage(HttpServletRequest request, ModelMap modelMap , CompanyDetailRequest req) throws Exception {
		LogUtil.setGroup("companyDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		
		if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()))
		{
			if(!permissionResult)
			{
				return "/pc/auth/permission_not_accept";
			}
			else
			{
				if(null == user.getCompanyId())
				{
					return "/pc/auth/permission_not_accept";
				}
				
				if(req.getCompanyId() != user.getCompanyId())
				{
					return "/pc/auth/permission_not_accept";
				}
			}
		}
		
		Company company = companyService.companyDetailPage(tableName, req.getCompanyId());
		modelMap.put("company", company);
		modelMap.put("userType",user.getUserType());
		
		LogUtil.clearGroup();
		return "/pc/company/company_detail_page";
	}	
	
	/**
	 * 소속등록신청 상세 페이지 이동.
	 *  @param  {@link CompanyDetailRequest}
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/companyReqDetailPage", method = {RequestMethod.GET})
	public String companyReqDetailPage(HttpServletRequest request, ModelMap modelMap , CompanyDetailRequest req) throws Exception {
		LogUtil.setGroup("companyReqDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);

		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		
		if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()))
		{
			if(!permissionResult)
			{
				return "/pc/auth/permission_not_accept";
			}
			else
			{
				if(null == user.getCompanyId())
				{
					return "/pc/auth/permission_not_accept";
				}
				
				if(req.getCompanyId() != user.getCompanyId())
				{
					return "/pc/auth/permission_not_accept";
				}
			}
		}
		
		Company company = companyService.companyReqDetailPage(req.getCompanyId());
		modelMap.put("company", company);
		modelMap.put("userType",user.getUserType());
		
		LogUtil.clearGroup();
		return "/pc/company/company_req_detail_page";
	}	

	/**
	 * 소속정보 메뉴 이동.
	 *  @param  {@link CompanyDetailRequest}
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/myCompanyDetailPage", method = {RequestMethod.GET})
	public String myCompanyDetailPage(HttpServletRequest request, ModelMap modelMap , CompanyDetailRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);

		Company company  = new Company();
		ShopDetailResponse shop = new ShopDetailResponse();
		if(null == user.getCompanyId())
		{
			return "/pc/auth/permission_not_accept";
		}
		
		if(CommonCode.USER_TYPE.SELLER.code.equals(user.getUserType()))
		{
			shop = shopService.shopDetailPage(tableName, user.getShopId());
		}
		company = companyService.companyDetailPage(tableName, user.getCompanyId());
		modelMap.put("shop", shop);
		modelMap.put("company", company);
		
		modelMap.put("userType",user.getUserType());
		
		LogUtil.clearGroup();
		return "/pc/company/my_detail_page";
	}
	
	/**
	 *  소속 수정 페이지 이동.
	 *  @param  {@link CompanyDetailRequest}
	 * @return /pc/company/company_update_page
	 * @throws Exception
	 */
	@RequestMapping(value="/companyUpdatePage", method = {RequestMethod.GET})
	public String companyUpdatePage(HttpServletRequest request,ModelMap modelMap , CompanyDetailRequest req) throws Exception {
//		modelMap.addAttribute("tagId", tagId);
		LogUtil.setGroup("companyUpdatePage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		User user = loginService.getUserInfo(userIds);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/opr/auth/permission_not_accept";
		}
		
		Company company = companyService.companyDetailPage(tableName, req.getCompanyId());
		
		modelMap.put("company", company);
		
		LogUtil.clearGroup();	
		return "/pc/company/company_update_page";
	}
	
	
	/**
	 * 소속 수정  AJAX
	 * @param  {@link CompanyUpdateRequest} 
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 request 제한 초과 에러
	 * @throws Exception
	 */
	@RequestMapping(value="/companyUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyUpdate(HttpServletRequest request,HttpServletResponse response,@RequestBody @Valid CompanyUpdateRequest req) throws Exception {
		LogUtil.setGroup("PC");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		User user = loginService.getUserInfo(userIds);
		Map<String, Object> result = new HashMap<>();

//		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
//		
//		if(!permissionResult)
//		{
//			 return new Response(new ApiException(9999, "접근 권한이 없습니다."));
//		}
//		
		
		req.setUserId(user.getUserId());

		int i = companyService.companyUpdate(tableName, req);
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 소속 수정  AJAX
	 * @param  {@link CompanyUpdateRequest} 
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 request 제한 초과 에러
	 * @throws Exception
	 */
	@RequestMapping(value="/companyReqUpdate", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyReqUpdate(HttpServletRequest request,HttpServletResponse response,@RequestBody @Valid CompanyUpdateRequest req) throws Exception {
		LogUtil.setGroup("companyReqUpdate");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		User user = loginService.getUserInfo(userIds);
		Map<String, Object> result = new HashMap<>();
		
		req.setUserId(user.getUserId());
		
		int i = companyService.companyReqUpdate(req);
		
		Company company = companyService.companyDetailPage(tableName, req.getCompanyId());
		
		ShopInsertRequest insertReq = new ShopInsertRequest();
		
		insertReq.setBranchName("본부");
		insertReq.setCompanyId(req.getCompanyId());
		insertReq.setBranchAddr("");
		insertReq.setCreateId(company.getCreateId());
		
		shopService.insertShop("", insertReq);
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 소속 삭제  AJAX
	 * @param  {@link CompanyUpdateRequest} 
	 * @return 
	 * response Type : JSON
	 * response Header : 200 정상
	 * 		           : 900 나머지 예외 사항 에러  
	 * 				   : 999 request 제한 초과 에러
	 * @throws Exception
	 */
	@RequestMapping(value="/companyDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyDelete(HttpServletRequest request,  HttpServletResponse response,@RequestBody @Valid CompanyUpdateRequest req) throws Exception {
		LogUtil.setGroup("companyDelete");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		if(null == userIds)
		{
			 return new Response(new ApiException(997, "session 만료"));
		}
		User user = loginService.getUserInfo(userIds);
		Map<String, Object> result = new HashMap<>();
		DeleteTarget vuforiaDel = new DeleteTarget();
		Integer rdsCnt = 2;
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		if(!permissionResult)
		{
			 return new Response(new ApiException(9999, "접근 권한이 없습니다."));
		}
		else
		{
			if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()))
			{
				if(req.getCompanyId() != user.getCompanyId())
				{
					return new Response(new ApiException(9999, "접근 권한이 없습니다."));
				}
			}
		}

		ShopListRequest shopListreq = new ShopListRequest();
		shopListreq.setUserType("ADMIN");
		shopListreq.setCompanyId(req.getCompanyId());
		List<ShopListResponse> shopList	=	shopService.getShopList(tableName, shopListreq);
		
		
		ProductListRequest prodListReq = new ProductListRequest();
		prodListReq.setUserType("ADMIN");
		prodListReq.setCompanyId(req.getCompanyId());
		List<ProductListResponse> prodList = productService.getProductList(tableName, prodListReq);
		
		
		ArListRequest arListReq = new ArListRequest();
		prodListReq.setUserType("ADMIN");
		prodListReq.setCompanyId(req.getCompanyId());
		List<ArListResponse> arList = arService.getArList(tableName, arListReq);
		
		List<Integer>  arIdDelArr = new ArrayList<Integer>();
		List<Integer>  shopIdDelArr = new ArrayList<Integer>();
		List<Integer>  productIdDelArr = new ArrayList<Integer>();
		
		
		List<Integer>  shopFileDelArr = new ArrayList<Integer>();
		List<Integer>  productFileDelArr = new ArrayList<Integer>();
		List<Integer>  arFileDelArr = new ArrayList<Integer>();
		rdsCnt = rdsCnt + 3;
	
		
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
					
					rdsCnt = rdsCnt + 1;
				productFileDelArr.add(product.getProductImageId());
				}
			}
			rdsCnt = rdsCnt + 2;
			
//			productService.deleteProductArr(productIdDelArr);

			List<List<Integer>>  productIdDelArrByPartition =   Lists.partition(productIdDelArr, 10000);
			for(List<Integer> item : productIdDelArrByPartition)
			{
				logger.debug("size : "+item.size());
				productService.deleteProductArr(tableName, item);
				Thread.sleep(1000);
			}
			
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
				
				rdsCnt = rdsCnt + 2;
				
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
				rdsCnt = rdsCnt + 6;
				shopIdDelArr.add(shopData.getShopId());
				ShopDetailResponse shop = shopService.shopDetailPage(tableName, shopData.getShopId());
				
				FileData shopFile = fileService.getFile(Integer.parseInt(shop.getShopImageId()));						// Need to split 2017. 09. 14. JBum | String value need to split -> 153,135,2461,35
				FileData thumbnailFile = fileService.getFile(shop.getThumbnailImageId());
				FileData voiceFile = fileService.getFile(shop.getVoiceFileId());
				FileData vrFile = fileService.getFile(shop.getVrVideoId());
				
				shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));											// Need to split 2017. 09. 14. JBum | String value need to split -> 12463,1235123,51,13
				
				if(null != shopFile)
				{
					rdsCnt = rdsCnt + 1;
					shopFileDelArr.add(Integer.parseInt(shop.getShopImageId()));										// Need to split 2017. 09. 14. JBum | String value need to split -> 125,53135,135153,13
				}
				
				if(null != thumbnailFile)
				{
					rdsCnt = rdsCnt + 1;
					shopFileDelArr.add(shop.getThumbnailImageId());

				}
				if(null != voiceFile)
				{
					rdsCnt = rdsCnt + 1;
					shopFileDelArr.add(shop.getVoiceFileId());

				}
				if(null != vrFile)
				{
					rdsCnt = rdsCnt + 1;
					shopFileDelArr.add(shop.getVrVideoId());

				}
			}
			rdsCnt = rdsCnt + 2;
			shopService.deleteShopArr(tableName, shopIdDelArr);
			fileService.deleteFileArr(shopFileDelArr);
		}
		rdsCnt = rdsCnt + 3;
		companyService.companyDelete(tableName, req.getCompanyId());
		
		LogUtil.clearGroup();
		return new Response(result);
	}

}
