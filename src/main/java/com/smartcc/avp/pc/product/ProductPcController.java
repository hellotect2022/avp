package com.smartcc.avp.pc.product;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.product.model.Product;
import com.smartcc.avp.pc.product.model.request.ProductDetailRequest;
import com.smartcc.avp.pc.product.model.request.ProductInsertRequest;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.request.ProductUpdateRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.product.service.ProductService;
import com.smartcc.avp.pc.shop.service.ShopService;

import lombok.Setter;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.RequestToken;
/**
 * pc > product
 */
@Controller
@RequestMapping(value="/pc/product")
public class ProductPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ProductPcController.class);

	
	@Value("#{config['s3.bucket']}")
	private String bucketName;
//	public static  String bucketName = "smartcctests3";
	
	public static  String ym = DateUtil.getMonth();

	@Setter
	@Resource ProductService productService;

	@Setter
	@Resource ShopService shopService;
		
	@Value("#{config['upload.image.path']}")
	private String UPLOAD_IMAGE_PATH;
	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource FileService fileService;
	
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
			@Value("#{config['schema.chum']}")
			private String chumSchema;
			
			@Value("#{config['schema.scgp']}")
			private String scgpSchema;
			
			@Value("#{config['schema.bogoga']}")
			private String bogogaSchema;
			// End of	
			
	public static long total = 0; 
	
	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;

	@Value("#{config['s3.upload.monthly.fileput']}")
	private String MONTHLY_FILE_PUT;
	
	
	@RequestMapping(method = { RequestMethod.POST }, value = { "/chunk" })
	@ResponseBody
	public Response uploadTest(
	                @RequestParam(required = true, value = "test") MultipartFile file)
	{
		boolean fullFile = false;
		File theFile = new File("C:/Users/ljs/Documents/workspace-sts-3.8.2.RELEASE/smartTour/src/main/webapp/resources/upload/dsdtdsts.mp4");
		
		//LOGGER.info(file.getSize() + " bytes " + name + ", " + chunks + ", " + chunk);
		

		total += file.getSize();
		System.out.println("file.getSize() :: " + file.getSize());
		System.out.println("total :: " + total);
		
		if(file.getSize() == 1000000)
		{
			try {
				FileUtils.writeByteArrayToFile(theFile, file.getBytes(), true);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else
		{
			try {
				FileUtils.writeByteArrayToFile(theFile, file.getBytes(), true);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return new Response();
	}
	
	/**
	 * 상품 리스트 페이지 이동 
	 * @return /pc/product/product_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/productListPage", method = {RequestMethod.GET})
	public String twitter(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("productListPage");

//		statisticsService.insertUserAction(userIds,userAgent,CommonCode.ACTION_TYPE.USER_LIST.code);
//		
//		User user = loginService.getUserInfo(userIds);
//		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
//		
//		if(!permissionResult)
//		{
//			return "/pc/auth/permission_not_accept";
//		}
//		System.out.println("test :: " +testService.getList());
		LogUtil.clearGroup();
		return "/pc/product/product_list_page";
	}
	
	
	/**
	 * 상품 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/productList", method = {RequestMethod.POST})
	@ResponseBody
	public Response productList(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid ProductListRequest req) throws Exception {
		LogUtil.setGroup("productList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		String ym = DateUtil.getMonth();
		User user = loginService.getUserInfo(userIds);
		req.setUserId(user.getUserId());
		// 유저타입의 따라 where 조건이 달라ㄱ지기 때문에 셋팅 
		req.setUserType(user.getUserType());
		// 유저타입이 admin일경우 shopid 가져오기 위해 저장
		req.setCompanyId(user.getCompanyId());
		
		// 상품 리스트 목록 가져오기
		List<ProductListResponse> products = productService.getProductList(tableName, req);
		
		result.put("products", products);
		result.put("pageInfo", req.getPageInfo());
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 상품 목록 가져오기 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/productListByBranch", method = {RequestMethod.POST})
	@ResponseBody
	public Response productListByBranch(HttpServletRequest request ,ModelMap modelMap, HttpServletResponse response,@RequestBody @Valid ProductListRequest req) throws Exception {
		LogUtil.setGroup("productListByBranch");
		Map<String, Object> result = new HashMap<>();
		HttpSession session =  request.getSession();
		String userAgent =(String)session.getAttribute("userAgent");
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		 
		String ym = DateUtil.getMonth();
		User user = loginService.getUserInfo(userIds);
		req.setUserId(user.getUserId());
		// 유저타입의 따라 where 조건이 달라ㄱ지기 때문에 셋팅 
		req.setUserType(user.getUserType());
		// 유저타입이 admin일경우 shopid 가져오기 위해 저장
		req.setCompanyId(user.getCompanyId());
		
		// 상품 리스트 목록 가져오기
		List<ProductListResponse> products = productService.getProductListByBranch(tableName, req);
		
		result.put("products", products);
		result.put("pageInfo", req.getPageInfo());
		
		LogUtil.clearGroup();
		return new Response(result);
	}
		
	/**
	 * 캠페인 등록 페이지 이동
	 * @return /pc/product/product_insert_page
	 * @throws Exception
	 */
	@RequestMapping(value="/productInsertPage", method = {RequestMethod.GET})
	public String productInsertPage(HttpServletRequest request,ModelMap modelMap) throws Exception {
		LogUtil.setGroup("productInsertPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);

		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);

		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
		
		List<String> barcodeList = productService.getBarcodeTypeList();
		
		modelMap.put("userType", user.getUserType());
		modelMap.put("user", user);
		modelMap.put("barcodeList", barcodeList);
		
		LogUtil.clearGroup();
		
		return "/pc/product/product_insert_page";
	}
	
	
	
	/**
	 * 상품 등록 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/productInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response productInsert(ModelMap modelMap, HttpServletResponse response, ProductInsertRequest req, HttpServletRequest request) throws Exception {
		LogUtil.setGroup("productInsert");
		HttpSession session =  request.getSession();
		Map<String, Object> result = new HashMap<>();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);

		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "접근 권한이 없습니다."));
		}
        
		req.setCompanyId(user.getCompanyId());
        req.setCreateId(userIds);
        productService.insertProduct(tableName, req);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	/**
	 * 상품 상세 페이지 이동 
	 * @return /pc/product/product_detail_page
	 * @throws Exception
	 */
	@RequestMapping(value="/productDetailPage", method = {RequestMethod.GET})
	public String productDetailPage(HttpServletRequest request ,ModelMap modelMap , ProductDetailRequest req) throws Exception {
		LogUtil.setGroup("productDetailPage");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);		
		
		ProductDetailResponse product = productService.productDetailPage(tableName, req.getProductId());

		String updateYn = "Y";
		if(CommonCode.USER_TYPE.WORKER.code.equals(user.getUserType()) || "SUPER".equals(user.getUserType())) {
			updateYn = "N";
			if(user.getUserId() == product.getCreateId()) {
				updateYn = "Y";
			}
		}		
		
		modelMap.put("updateYn", updateYn);
		modelMap.put("product", product);
		
		LogUtil.clearGroup();
		return "/pc/product/product_detail_page";
	}
	
	
	
	/**
	 * 상품 수정 페이지 이동 
	 * @return /pc/product/product_update_page
	 * @throws Exception
	 */
	@RequestMapping(value="/productUpdatePage", method = {RequestMethod.GET})
	public String productUpdatePage(HttpServletRequest request ,ModelMap modelMap , ProductDetailRequest req) throws Exception {
		LogUtil.setGroup("productUpdatePage");
		HttpSession session = request.getSession();
		Integer userIds = (Integer)session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");

		User user = loginService.getUserInfo(userIds);
		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			return "/pc/auth/permission_not_accept";
		}
				
		ProductDetailResponse product = productService.productDetailPage(tableName, req.getProductId());
		
		List<String> barcodeList = productService.getBarcodeTypeList();
		
		String updateYn = "Y";
		if(CommonCode.USER_TYPE.WORKER.code.equals(user.getUserType()) || "SUPER".equals(user.getUserType()))
		{
			updateYn = "N";
		}
		
		modelMap.put("userType", user.getUserType());
		modelMap.put("updateYn", updateYn);
		modelMap.put("product", product);
		modelMap.put("barcodeList", barcodeList);
		
		LogUtil.clearGroup();
		return "/pc/product/product_update_page";
	}
	
	/**
	 * 상품 수정 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/productUpdate", method = {RequestMethod.POST})
	@ResponseBody
    public Response productUpdate(HttpServletRequest request, ProductUpdateRequest req)  throws Exception {
		LogUtil.setGroup("productUpdate");
		HttpSession session =  request.getSession ();
		Integer userId 	= (Integer) session.getAttribute("userId");
		String tableName = (String)session.getAttribute("division");
		
		User user = loginService.getUserInfo(userId);

		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
		
		if(!permissionResult)
		{
			 return new Response(new ApiException(999, "접근 권한이 없습니다."));
		}
		
		req.setUpdateId(user.getUserId());
		productService.updateProduct(tableName, req);
		
		LogUtil.clearGroup();
		 return new Response();
    }
	
	
	@RequestMapping(value="/twitterAppCheck", method = {RequestMethod.POST})
	@ResponseBody
	public Response twitterAppCheck(ModelMap modelMap, HttpServletResponse response) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		Map<String, Object> resData = new HashMap<>();
		Twitter twitter = new TwitterFactory().getInstance();
		//twitter로 접근한다.
		twitter.setOAuthConsumer("9y5FBEOdNj1j93uSwhr5sghrt", "2gCyX184DKHj9I8Tvb1CNc9MwatWjz2mvWn7u7KJLs7V5ocXAM");
		

		//성공시 requestToken에 해당정보를 담겨져온다.
		RequestToken requestToken  = null;
		try {
			requestToken = twitter.getOAuthRequestToken();
			
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		resData.put("requestToken", requestToken);
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(resData);
	}
	
	
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/kakao", method = {RequestMethod.GET})
	public String kako(ModelMap modelMap) throws Exception {
		
		modelMap.put("prodData", productService.getProdList());
//		System.out.println("test :: " +testService.getList());
		return "/pc/product/kakao";
	}
	
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/facebook", method = {RequestMethod.GET})
	public String facebook(ModelMap modelMap) throws Exception {
		
//		System.out.println("test :: " +testService.getList());
		return "/pc/product/facebook";
	}
	
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list", method = {RequestMethod.GET})
	public String list(HttpServletRequest request,ModelMap modelMap) throws Exception {
		
//		modelMap.put("prodData", productService.getProdList());
//		System.out.println("test :: " +testService.getList());
		return "/pc/product/vuforia";
	}

	
	@RequestMapping(value="/fileInsert", method = {RequestMethod.POST})
    public String fileSubmit(HttpServletRequest request, FileDTO dto) {
		 MultipartFile uploadfile = dto.getUploadfile();
         MultipartFile targetfile = dto.getTargetfile();
	        
	         
	        // 첫번째 Bucket
	        String bucketName = "smartcctests3";
	        
	        // 파일 업로드
//	     	String fileName = "C:/images/"+uploadfile.getOriginalFilename();
//	        String fileName = UPLOAD_IMAGE_PATH+targetfile.getOriginalFilename();

//	        File obj = FileUtil.fileUpload(dto.getUploadfile(),UPLOAD_IMAGE_PATH);
//			File target = FileUtil.fileUpload(dto.getTargetfile(),UPLOAD_IMAGE_PATH);
			
//			 PostNewTarget p = new PostNewTarget();
//			try {
//				s3.fileUpload(bucketName+"/"+awsFolder, obj);
//			} catch (FileNotFoundException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			 System.out.println("target :::"+target);
//			 System.out.println("dto.getTargetName() :"+dto.getTargetName());
//			 p.postTargetThenPollStatus(target,dto.getTargetName(),obj.getName());
        
        
		
        return "";
    }
	
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/kitkat", method = {RequestMethod.GET})
	public String kitkat(ModelMap modelMap) throws Exception {
		
		modelMap.put("prodData", productService.getProdList());
//		System.out.println("test :: " +testService.getList());
		return "/pc/product/vuforia_kitkat";
	}
	
	

	/**
	 * 상품 삭제 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/productDelete", method = {RequestMethod.POST})
	@ResponseBody
	public Response productDelete(ModelMap modelMap, 
			HttpServletResponse response ,
			HttpServletRequest request , @RequestBody Product req
			) throws Exception {
		LogUtil.setGroup("productDelete");
		HttpSession session =  request.getSession();
		Integer userIds =(Integer)session.getAttribute("userId");
		
		String tableName = (String)session.getAttribute("division");

		if(null == userIds)
		{
			 return new Response(new ApiException(997, "session 만료"));
		}
		
		productService.deleteProduct(tableName, userIds, req.getProductId());
		
		LogUtil.clearGroup();
		return new Response();
	}
	
}
