package com.smartcc.avp.pc.shop;

import java.io.File;
import java.io.FileNotFoundException;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.FileChecker;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.common.util.PermissionUtil;
import com.smartcc.avp.intfc.version.model.VersionResponse;
import com.smartcc.avp.intfc.version.service.VersionService;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.ar.model.request.ArUpdatePageRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.product.service.ProductService;
import com.smartcc.avp.pc.shop.model.Shop;
import com.smartcc.avp.pc.shop.model.request.ShopDetailRequest;
import com.smartcc.avp.pc.shop.model.request.ShopInsertRequest;
import com.smartcc.avp.pc.shop.model.request.ShopListRequest;
import com.smartcc.avp.pc.shop.model.request.ShopUpdateRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;
import com.smartcc.avp.pc.shop.service.ShopService;

import lombok.Setter;
/**
 * pc > shop
 * @author JBum
 */
@Controller
@RequestMapping(value="/pc/shop")
public class ShopPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ShopPcController.class);
	public static String awsFolder = "ljs-test-folder";
	@Value("#{config['s3.bucket']}")
	private String bucketName;
	public static  String ym = DateUtil.getMonth();

	@Setter
	@Resource ShopService shopService;
		
	@Value("#{config['upload.image.path']}")
	private String UPLOAD_IMAGE_PATH;
	
	@Setter
	@Resource FileService fileService;
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource VersionService versionService;
	
	@Setter
	@Resource ProductService productService;
	@Value("#{config['s3.upload.monthly.fileput']}")
	private String MONTHLY_FILE_PUT;
	
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
	 * 상점 등록 페이지 이동 
	 * @return /pc/shop/shop_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/shopInsertPage", method = {RequestMethod.GET})
	public String shopinsertpage(ModelMap modelMap ,HttpServletRequest request, HttpServletResponse response,Shop req) throws Exception {
		LogUtil.setGroup("shopInsertPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		modelMap.put("userType",user.getUserType());
		modelMap.put("companyId",user.getCompanyId());
		modelMap.put("companyShopName",user.getCompanyShopName());
		String ymd = DateUtil.getMonth();
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			// 이미 저장 되어 있는경우
			return "/pc/auth/permission_not_accept";
		}		
		
		LogUtil.clearGroup();
		return "/pc/shop/shop_insert_page";
	}
	/**
	 * 소속 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/shopInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response shopinsert(HttpServletRequest request, HttpServletResponse response, @RequestBody ShopInsertRequest req) throws Exception {
		LogUtil.setGroup("shopInsert");
		
		Map<String, Object> result = new HashMap<>();
        String ym = DateUtil.getMonth();
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		User user			 = loginService.getUserInfo(userId);

		if (shopService.isOverlapBranch(req.getBranchName(), user.getCompanyId(), null)) {
			return new Response(new ApiException(900, "중복된 지점명입니다."));
		}
		
		req.setCreateId(userId);
		long insertFileSize = 0;
		req.setCompanyId(user.getCompanyId());
		
		shopService.insertShop(tableName, req);
		
		// version up
		// 2018. 11. 08. JBum
//		try {
//			VersionResponse version = versionService.getVersion(tableName);
//			
//			int versionInt = Integer.valueOf(version.getVersion());
//			versionInt++;
//			versionService.updateVersion(tableName, String.valueOf(versionInt));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		 
		// 이미 저장 되어 있는경우
		
		 LogUtil.clearGroup();
		return new Response();
	}
	/**
	 * 상점 목록 페이지 이동 
	 * @return /pc/shop/shop_list_page
	 * @throws Exception
	 */	
	@RequestMapping(value="/shopListPage", method = {RequestMethod.GET})
	public String shopListPage(HttpServletRequest request,HttpServletResponse response,Shop req) throws Exception {
		LogUtil.setGroup("branchListPage");
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		String ymd = DateUtil.getMonth();
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		LogUtil.clearGroup();
		return "/pc/shop/shop_list_page";
	}
	
	/**
	 * 상점 목록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/shopList", method = {RequestMethod.POST})
	@ResponseBody
	public Response shopList(HttpServletRequest request,HttpServletResponse response,@RequestBody @Valid ShopListRequest req) throws Exception {
		LogUtil.setGroup("shopList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		
		logger.info("user Type :: "+ user.getUserType());
		req.setUserId(user.getUserId());
		// 유저타입의 따라 where 조건이 달라ㄱ지기 때문에 셋팅 
		req.setUserType(user.getUserType());
		// 유저타입이 admin일경우 shopid 가져오기 위해 저장
		req.setCompanyId(user.getCompanyId());
		
		req.setGroupDbName(user.getDivision());
		
		// 지점 리스트 목록 가져오기
		List<ShopListResponse> list	=	shopService.getShopList(tableName, req);
		String ymd = DateUtil.getMonth();
		
		result.put("pageInfo", req.getPageInfo());
		result.put("shops", list);

		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 특정 소속의 대한 상점 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */	
	@RequestMapping(value="/companyShopList", method = {RequestMethod.POST})
	@ResponseBody
	public Response companyshopList(HttpServletRequest request,HttpServletResponse response,@RequestBody @Valid ShopListRequest req) throws Exception {
		LogUtil.setGroup("Shop(Branch)List");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		Integer userId =(Integer)session.getAttribute("userId");
		String tableName = "";
		//req.setUserType(CommonCode.USER_TYPE.ADMIN.code);
		req.setUserId(userId);
		// 상점 리스트 목록 가져오기
		List<ShopListResponse> list	=	shopService.getShopList(tableName, req);
		String ymd = DateUtil.getMonth();
		
		result.put("pageInfo", req.getPageInfo());
		result.put("branches", list);
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	
	/**
	 * 상점 상세 페이지 이동 
	 * @return /pc/shop/shop_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/shopDetailPage", method = {RequestMethod.GET})
	public String shopDetailPage(HttpServletRequest request,ModelMap modelMap ,ShopDetailRequest req) throws Exception {
		LogUtil.setGroup("shopDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		// 상점 리스트 목록 가져오기
		String ymd = DateUtil.getMonth();
			
		ShopDetailResponse branch = shopService.shopDetailPage(tableName, req.getBranchId());
		
		modelMap.put("branch", branch);
		
		LogUtil.clearGroup();
		return "/pc/shop/shop_detail_page";
	}
	
	
	/**
	 * 상점 수정 페이지 이동 
	 * @return /pc/shop/shop_update_page
	 * @throws Exception
	 */
	@RequestMapping(value="/shopUpdatePage", method = {RequestMethod.GET})
	public String shopUpdatePage(HttpServletRequest request,ModelMap modelMap , ShopDetailRequest req) throws Exception {
		LogUtil.setGroup("shopUpdatePage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

//		String userAgent =(String)session.getAttribute("userAgent");
//		statisticsService.insertUserAction(userIds,userAgent,CommonCode.ACTION_TYPE.USER_LIST.code);
		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		String ymd = DateUtil.getMonth();
			
		ShopDetailResponse branch = shopService.shopDetailPage(tableName, req.getBranchId());
		
		modelMap.put("branch", branch);
		
		LogUtil.clearGroup();
		return "/pc/shop/shop_update_page";
	}
	
	/**
	 * 상점 수정하기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/shopUpdate", method = {RequestMethod.POST})
	@ResponseBody
    public Response shopUpdate(HttpServletRequest request, @RequestBody ShopUpdateRequest req)  throws Exception {
		LogUtil.setGroup("shopUpdate");
				
		HttpSession session =  request.getSession();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		User user = loginService.getUserInfo(userId);
		
    	String ym = DateUtil.getMonth();

    	if (shopService.isOverlapBranch(req.getBranchName(), user.getCompanyId(), req.getBranchId())) {
			return new Response(new ApiException(900, "중복된 지점명입니다."));
		} 
    	
 		req.setCreateId(userId); 		
	   	req.setUpdateId(userId);
	   	
		shopService.shopUpatePageUpdate(tableName, req);
				
		// version up
		// 2018. 11. 08. JBum
//		try {
//			VersionResponse version = versionService.getVersion(tableName);
//			
//			int versionInt = Integer.valueOf(version.getVersion());
//			versionInt++;
//			versionService.updateVersion(tableName, String.valueOf(versionInt));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		LogUtil.clearGroup();
		return new Response();
    }
	/**
	 * 상점 삭제하기  AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/shopDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response shopDelete(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, @RequestBody Shop req) throws Exception {
		LogUtil.setGroup("shopDelete");
		logger.info("############ 상점 삭제 시작 ################");
		List<Integer> list = new ArrayList<Integer>();
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

			if(null == userIds)
			{
				 return new Response(new ApiException(997, "session 만료"));
			}
			ShopDetailResponse shop = shopService.shopDetailPage(tableName, req.getShopId());

//			ProductListRequest prodListReq = new ProductListRequest();
//			prodListReq.setUserType("ADMIN");
//			prodListReq.setCompanyId(req.getCompanyId());
//			List<ProductListResponse> prodList = productService.getProductListFromShopId(tableName, req.getShopId());
//			
//			List<Integer>  productIdDelArr = new ArrayList<Integer>();
//			List<Integer>  productFileDelArr = new ArrayList<Integer>();
//			
//			if(null != prodList)
//			{
//				for(ProductListResponse prodData : prodList)
//				{
//					
//					ProductDetailResponse product = productService.productDetailPage(tableName, prodData.getProductId());
//					logger.debug("product : " , product);
//					
//					productIdDelArr.add(prodData.getProductId());
//					productFileDelArr.add(product.getProductImageId());
//					FileData prodFile = fileService.getFile(product.getProductImageId());
//					
//					if(null != prodFile)
//					{
////						s3.fileDelete(bucketName+"/"+"user_"+prodFile.getCreateId(), prodFile.getFileName());
//						statisticsService.deletePreInsertUserData(prodFile.getCreateId(),ym,prodFile.getFileSize());
//						
//					}
//				}
//				rdsCnt = rdsCnt + 2;
//				List<List<Integer>>  productIdDelArrByPartition =   Lists.partition(productIdDelArr, 10000);
//				List<List<Integer>>  productFileIdDelArrByPartition =   Lists.partition(productFileDelArr, 10000);
//
//				
//				long time1TotalTime = 0;
//				long time1LoopCount = 0;
//				for(List<Integer> item : productIdDelArrByPartition)
//				{
//					long startTime1 = System.currentTimeMillis();
//					productService.deleteProductArr(tableName, item);
//					Thread.sleep(1000);
//					long time1 = (System.currentTimeMillis() - startTime1) * 1000;
//					logger.debug("time1 : " + time1 );
//					time1TotalTime += time1;
//				}
//				
//				logger.debug("time1 finished !! totalTime : {}, totalCount : {}" , time1TotalTime, time1LoopCount );
//				
//				
//				for(List<Integer> item : productFileIdDelArrByPartition)
//				{
//					fileService.deleteFileArr(item);
//					Thread.sleep(1000);
//				}
////				productService.deleteProductArr(productIdDelArr);
////				fileService.deleteFileArr(productFileDelArr);
//			}
			
			shopService.deleteShop(tableName, req.getShopId(), userIds);

			// version up
			// 2018. 11. 08. JBum
//			try {
//				VersionResponse version = versionService.getVersion(tableName);
//				
//				int versionInt = Integer.valueOf(version.getVersion());
//				versionInt++;
//				versionService.updateVersion(tableName, String.valueOf(versionInt));
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
			
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	

}
