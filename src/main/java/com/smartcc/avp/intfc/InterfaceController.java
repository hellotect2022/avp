package com.smartcc.avp.intfc;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.AESUtils;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.intfc.location.service.LocationService;
import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.CountStatisticRequest;
import com.smartcc.avp.intfc.model.request.ImageInsertRequest;
import com.smartcc.avp.intfc.model.request.InitRequest;
import com.smartcc.avp.intfc.model.request.IntfEventListRequest;
import com.smartcc.avp.intfc.model.request.IntfcEmergencyReportRequest;
import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest;
import com.smartcc.avp.intfc.model.request.IntfcLoginRequest;
import com.smartcc.avp.intfc.model.request.IntfcProductListPage;
import com.smartcc.avp.intfc.model.request.IntfcShopDetailRequest;
import com.smartcc.avp.intfc.model.request.IntfcShopListRequest;
import com.smartcc.avp.intfc.model.request.IntfcTokenSubmitRequest;
import com.smartcc.avp.intfc.model.request.MasterLoginApplyRequest;
import com.smartcc.avp.intfc.model.request.SeacrhShopRequestList;
import com.smartcc.avp.intfc.model.request.ShopScoreInsertRequest;
import com.smartcc.avp.intfc.model.request.StatisticBeaconData;
import com.smartcc.avp.intfc.model.request.StatisticTagData;
import com.smartcc.avp.intfc.model.request.StorageRequest;
import com.smartcc.avp.intfc.model.request.TokenInsertRequest;
import com.smartcc.avp.intfc.model.request.UserSecessionApplyRequest;
import com.smartcc.avp.intfc.model.request.ar.IntfcArRequest;
import com.smartcc.avp.intfc.model.request.auth.IntfcAuthUserRequest;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyInsert;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyUpdate;
import com.smartcc.avp.intfc.model.request.item.IntfcItemDetailRequest;
import com.smartcc.avp.intfc.model.request.location.IntfcLocationHist;
import com.smartcc.avp.intfc.model.request.location.IntfcLocationRequest;
import com.smartcc.avp.intfc.model.request.management.ReqManagement;
import com.smartcc.avp.intfc.model.request.management.ReqManagementDB;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderProcessComp;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderlistRequest;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderlistSuccess;
import com.smartcc.avp.intfc.model.request.zone.IntfcZoneReco;
import com.smartcc.avp.intfc.model.response.IntfcEmergencyReportResponse;
import com.smartcc.avp.intfc.model.response.ShopListFromAddressResponse;
import com.smartcc.avp.intfc.model.response.UserInfoResponse;
import com.smartcc.avp.intfc.model.response.auth.IntfcAuthUserResponse;
import com.smartcc.avp.intfc.model.response.emergency.EmergencyHist;
import com.smartcc.avp.intfc.model.response.location.IntfcLocationResponse;
import com.smartcc.avp.intfc.version.model.VersionResponse;
import com.smartcc.avp.intfc.version.service.VersionService;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.ar.service.ArService;
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.company.service.CompanyService;
import com.smartcc.avp.pc.device.model.Device;
import com.smartcc.avp.pc.device.service.DeviceService;
import com.smartcc.avp.pc.group.model.GroupListResponse;
import com.smartcc.avp.pc.group.service.GroupService;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.orderlist.model.Orderlist;
import com.smartcc.avp.pc.orderlist.service.OrderlistService;
import com.smartcc.avp.pc.product.model.Product;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.service.ProductService;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;
import com.smartcc.avp.pc.shop.service.ShopService;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;
import com.smartcc.avp.pc.user.service.UserService;
import com.smartcc.avp.pc.work.model.request.ReqWorkLoc;
import com.smartcc.avp.pc.work.service.WorkService;
import com.smartcc.avp.pc.zone.service.ZoneService;

import lombok.Setter;

/**
 * Application Interface
 * 
 * @author JS.LEE
 */
@Controller
@RequestMapping("/intfc")
public class InterfaceController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(InterfaceController.class);
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	private static final SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMM");

	String ym = DateUtil.getMonth();
	String ymd = DateUtil.getDay();
	/**
	 * INTFC - INTERFACE String Variable 사용안됨
	 */
	public static String INTFC = "INTERFACE";

	public static String KAKAO = "kakao";
	public static String FACEBOOK = "facebook";
	public static String TWITTER = "twitter";
	public static String WECHAT = "wechat";

	public String phoneNumber;

	@Setter
	@Resource
	CompanyService companyService;
	
	@Setter
	@Resource
	DeviceService deviceService;
	
	@Setter
	@Resource
	LocationService locationService;

	@Setter
	@Resource
	ProductService productService;

	@Setter
	@Resource
	OrderlistService orderlistService;

	@Setter
	@Resource
	ShopService shopService;

	@Setter
	@Resource
	VersionService versionService;

	@Value("#{config['aws.ec2.url']}")
	private String awsUrl;

	@Value("#{config['s3.bucket']}")
	private String bucketName;

	@Value("#{config['upload.image.path']}")
	private String UPLOAD_IMAGE_PATH;

	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;

	@Setter
	@Resource
	FileService fileService;

	@Setter
	@Resource
	LoginService loginService;

	@Setter
	@Resource
	GroupService groupService;

	@Setter
	@Resource
	UserService userService;

	@Setter
	@Resource
	ArService arService;
	
	@Setter
	@Resource
	ZoneService zoneService;
	
	@Setter
	@Resource
	WorkService workService;
	
	@Value("#{config['s3.upload.monthly.fileput']}")
	private String MONTHLY_FILE_PUT;

	@Value("#{config['s3.upload.monthly.fileget']}")
	private String MONTHLY_FILE_GET;

	@Value("#{config['s3.upload.path']}")
	private String s3;

	@Value("#{config['s3.event.upload.path']}")
	private String eventS3;

	@Value("#{config['rds.limit.count']}")
	private String rdsLimitCnt;

	@Value("#{config['s3.upload.monthly.tmap.auth']}")
	private String TMAP_LIMIT_AUTH;

	@Value("#{config['s3.upload.monthly.tmap.mapview']}")
	private String TMAP_LIMIT_MAPVIEW;

	@Value("#{config['s3.upload.monthly.tmap.loadinfo']}")
	private String TMAP_LIMIT_ROADINFO;

	@Value("#{config['s3.upload.monthly.vuforia.cloudrecos']}")
	private String VUFORIA_LIMIT_RESCOS;

	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
	@Value("#{config['schema.chum']}")
	private String chumSchema;

	@Value("#{config['schema.scgp']}")
	private String scgpSchema;

	@Value("#{config['schema.bogoga']}")
	private String bogogaSchema;
	// End of

	private boolean getHeader(Header header, String mehtodName) throws Exception {

		logger.debug("Header ::::::: " + header);

		String authKey = header.getAuthKey();
		String phoneNum = header.getPhoneNumber();
		String latitude = header.getLatitude();
		String longitude = header.getLongitude();

		if (authKey != null) {
			return true;
		}

		if (phoneNum == null || phoneNum.length() <= 0) {
			return false;
		}

		try {
			phoneNum = AESUtils.Decrypt(phoneNum);
		} catch (Exception e) {

		}

		if (phoneNum.indexOf("+82") >= 0) {
			phoneNum = phoneNum.replace("+82", "0");
		}

		this.phoneNumber = phoneNum;

		return true;
	}

	/**
	 * 회원탈퇴 신청
	 */
	@RequestMapping(value = "/userSecessionApply", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response userSecessionApply(HttpServletRequest request, HttpServletResponse response,
			@RequestBody UserSecessionApplyRequest req) throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("phoneNumber:" + this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");

		Map<String, Object> result = new HashMap<>();
		String ymd = DateUtil.getMonth();
		HttpSession session = request.getSession();
		int rdsCnt = 0;
		rdsCnt = rdsCnt + 1;
		
		User user = loginService.getUserInfo(req.getBody().getUserId());

		if ("Y".equals(user.getSecessionYn())) {
			return new Response(new ApiException(997, "이전에 신청한 유저."));
		} else {
			loginService.updateSecession(req.getBody().getUserId());
		}
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 마스터 로그인
	 */
	@RequestMapping(value = "/masterLogin", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response masterLogin(HttpServletRequest request, HttpServletResponse response,
			@RequestBody MasterLoginApplyRequest req) throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("phoneNumber:" + this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");
		Map<String, Object> result = new HashMap<>();
		result.put("rdsValidYn", "Y");
		result.put("validYn", "Y");
		String ymd = DateUtil.getMonth();
		HttpSession session = request.getSession();
		int rdsCnt = 0;
		rdsCnt = rdsCnt + 1;

		User masterInfo = loginService.getMasterUser(req.getBody().getEmail(), req.getBody().getUserPassword());

		if (null != masterInfo) {
			session.setAttribute("user", masterInfo);
			session.setAttribute("userId", masterInfo.getUserId());
			session.setAttribute("division", masterInfo.getDivision());
			result.put("user", masterInfo);

		} else {
			return new Response(new ApiException(998, "이메일 또는 패스워드를 확인해주세요."));
		}
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 초기화 전문
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */

	@RequestMapping(value = "/init", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response init(HttpServletRequest request, HttpServletResponse response, @RequestBody InitRequest req)
			throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("phoneNumber:" + this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");
		Map<String, Object> result = new HashMap<>();
		result.put("rdsValidYn", "Y");
		result.put("validYn", "Y");
		String ymd = DateUtil.getMonth();
		HttpSession session = request.getSession();

		if (null != req.getBody().getUserId()) {
			session.setAttribute("userId", req.getBody().getUserId());
		}

		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 상점 리스트
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/shopList", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response shopListshopList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcShopListRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
		GroupListResponse group = groupService.getGroupDetail(req.getBody().getDbName());
		String tableName = group.getGroupDbName();
		// End of 2017. 09. 11.

		LogUtil.setGroup("phoneNumber:" + this.phoneNumber + "|" + tableName);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		Map<String, Object> result = new HashMap<>();
		result.put("rdsValidYn", "Y");
		result.put("validYn", "Y");
		String ymd = DateUtil.getMonth();
		HttpSession session = request.getSession();

		if (null != req.getBody().getUserId()) {
			session.setAttribute("userId", req.getBody().getUserId());
		}

		// Add. 2018. 01. 11. JBum | Data version check
		try {
			VersionResponse version = versionService.getVersion(tableName);
			Integer clientDbVersion = req.getBody().getDbVersion();

			logger.info("version : " + version + " clientdbversion : " + clientDbVersion);
			logger.info("equals true ? : " + version.getVersion().equals(String.valueOf(clientDbVersion)));

			if (version.getVersion().equals(String.valueOf(clientDbVersion))) {
				return new Response(new ApiException(850, "최신 데이터/" + version.getVersion()));
			} else {
				result.put("latelyDb", version.getVersion());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// End of 2018. 01. 11.

		String[] array = new String[] {};
		List<ShopListResponse> list = shopService.getIntfcShopList(tableName, req, s3, array); // Need to modify 2017.
																								// 09. 15. JBum | 여러 장
																								// 사진 URL 주소를 제공해줘야함
																								// None operate now. |
																								// Clear. 2017. 09. 19.
																								// JBum
		/*
		 * Add 2017. 09. 19. JBum 여러 장 사진 URL 제공하기 위한 코드
		 */
		List<String> imageIdList = new ArrayList<String>(); // 상점 별 이미지 ID를 저장하는 Array
		for (int i = 0; i < list.size(); i++) {
			imageIdList.add(list.get(i).getShopImageId()); // 상점 별 이미지 ID 저장
//			logger.info("imageIdList :::::::::::::::: " + list.get(i).getShopImageId());
		}
//		logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		for (int i = 0; i < imageIdList.size(); i++) {
			if (!imageIdList.get(i).contains(","))
				continue;

			String[] tmpImageIds = imageIdList.get(i).split(","); // 상점 별 이미지 ID를 구분자(,)로 구분하여 tmpImageIds에 저장
			String tmpConcat = ""; // 인터페이싱으로 URL이 제공될 때 구분자(,)가 있어야 하므로 임시적으로 저장하는 String 변수
//			logger.info("tmpImageIds :::::::::::::::::::::::::: " + tmpImageIds.length);
			for (int j = 0; j < tmpImageIds.length; j++) // 상점 별 이미지 ID 수 만큼 for문 구동
			{
				String tmpUrl = shopService.getFileUrl(tableName, s3, tmpImageIds[j]); // fileId에 맞는 URL을 구함
				if (tmpConcat.isEmpty())
					tmpConcat = tmpUrl; // 값이 ',asdf,asdf,adasf' 되는 것을 방지하기 위해 처음 시작은 바로 대입
				else
					tmpConcat = tmpConcat + "," + tmpUrl; // 구분자(,)를 통해 Concat
			}
//			logger.info("tmpConcat :::::::::::::::::::::::::::" + tmpConcat);
			list.get(i).setShopImageUrl(tmpConcat); // 최초 구한 상점 목록(list) array에 shopImageUrl 값을 concat한 URL 값으로 Set
		}
		// End of Add 2017. 09. 19. JBum

		result.put("list", list);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 상점 상세
	 * 
	 * @param Body { private Integer shopId } Body body Header header
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */

	@RequestMapping(value = "/shopDetail", method = { RequestMethod.POST })
	@ResponseBody
	public Response shopDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcShopDetailRequest req) throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
		GroupListResponse group = groupService.getGroupDetail(req.getBody().getDbName());
		String tableName = group.getGroupDbName();
		// End of 2017. 09. 11.

		LogUtil.setGroup("phoneNumber:" + this.phoneNumber + "|" + tableName);

//		LogUtil.setGroup("phoneNumber:"+this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");

		Map<String, Object> result = new HashMap<>();
		ShopDetailResponse shop = new ShopDetailResponse();

		/*
		 * Delete 2017. 09. 11. JBum | 잘못된 디비 네임 파싱으로 인한 제거 String tableName = "test";
		 * String division = req.getBody().getDbName(); switch (division) { case
		 * "MASTER": break; case "CHUM": tableName = chumSchema; break; case "SCGP":
		 * tableName = scgpSchema; break; case "BOGOGA": tableName = bogogaSchema;
		 * break; }
		 */
		// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
//		GroupListResponse group = groupService.getGroupDetail(req.getBody().getDbName());
//		String tableName = group.getGroupDbName();
		// End of 2017. 09. 11.
		shop = shopService.shopIntfcDetailPage(tableName, req.getBody().getShopId(), s3, req.getBody().getUserId());
		String score = "";
		if (null != req.getBody().getUserId()) {
			score = shopService.getScore(tableName, req.getBody().getShopId(), req.getBody().getUserId());
			logger.info("score :::: " + score);
//				shop.setScore(score);
		}
		/*
		 * Add 2017. 09. 19. JBum 여러 장 사진 URL 제공하기 위한 코드
		 */
		String imageIdList = ""; // 상점 별 이미지 ID를 저장하는 String

		imageIdList = shop.getShopImageId(); // 상점 이미지 ID 저장
		logger.info("imageIdList :::::::::::::::: " + shop.getShopImageId());

		String[] tmpImageIds = imageIdList.split(","); // 상점 별 이미지 ID를 구분자(,)로 구분하여 tmpImageIds에 저장
		String tmpConcat = ""; // 인터페이싱으로 URL이 제공될 때 구분자(,)가 있어야 하므로 임시적으로 저장하는 String 변수
		logger.info("tmpImageIds :::::::::::::::::::::::::: " + tmpImageIds.length);
		for (int j = 0; j < tmpImageIds.length; j++) // 상점 별 이미지 ID 수 만큼 for문 구동
		{
			String tmpUrl = shopService.getFileUrl(tableName, s3, tmpImageIds[j]); // fileId에 맞는 URL을 구함
			if (tmpConcat.isEmpty())
				tmpConcat = tmpUrl; // 값이 ',asdf,asdf,adasf' 되는 것을 방지하기 위해 처음 시작은 바로 대입
			else
				tmpConcat = tmpConcat + "," + tmpUrl; // 구분자(,)를 통해 Concat
		}
		logger.info("tmpConcat :::::::::::::::::::::::::::" + tmpConcat);
		shop.setShopImageUrl(tmpConcat); // 최초 구한 상점 목록(list) array에 shopImageUrl 값을 concat한 URL 값으로 Set

		// End of Add 2017. 09. 19. JBum
		result.put("shop", shop);
		result.put("score", score);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 상픔 리스트
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/productList", method = { RequestMethod.POST })
	@ResponseBody
	public Response productList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcProductListPage req) throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

//		LogUtil.setGroup("phoneNumber:"+this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");

		Map<String, Object> result = new HashMap<>();
		result.put("rdsValidYn", "Y");
		result.put("validYn", "Y");
		ShopDetailResponse shop = new ShopDetailResponse();

		List<Product> prodlist = shopService.getIntfcShopProdList(req.getBody().getShopId(), s3,
				req.getBody().getPageNo());
		result.put("prodlist", prodlist);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 상픔 리스트
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/permissionChk", method = { RequestMethod.POST })
	@ResponseBody
	public Response permissionChk(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcLoginCheckRequest req) throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

//		LogUtil.setGroup("phoneNumber:"+this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");

		Map<String, Object> result = new HashMap<>();
		result.put("rdsValidYn", "Y");
		result.put("validYn", "Y");
		LoginRequest data = new LoginRequest();
		User user = new User();

		data.setUserId(req.getBody().getUserId());
		user = loginService.getUserInfo(data);

		result.put("user", user);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * SNS 로그인
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/login", method = { RequestMethod.POST })
	@ResponseBody
	public Response login(HttpServletRequest request, HttpServletResponse response, @RequestBody IntfcLoginRequest req)
			throws Exception {
		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

//		LogUtil.setGroup("phoneNumber:"+this.phoneNumber);

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		// LogUtil.setGroup("JS.LEE INTERFACE");
		logger.info("req :: " + req);
		User user = new User();
		LoginRequest data = new LoginRequest();
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("rdsValidYn", "Y");
		rtnMap.put("validYn", "Y");
		data.setSnsId(req.getBody().getSnsId());
		data.setUserId(req.getBody().getUserId());
		
		user = loginService.getUserInfo(data);
		
		if (null == user) {
			data.setAccessToken(req.getBody().getAccessToken());
			data.setSnsType(req.getBody().getSnsType());
			data.setNickName(req.getBody().getNickName());
			data.setGender(req.getBody().getGender());
			data.setEmail(req.getBody().getEmail());
			data.setProfileImageUrl(req.getBody().getProfileImageUrl());
			data.setThumbnailImageUrl(req.getBody().getThumbnailImageUrl());
			data.setPhone(req.getBody().getPhone());
			int i = loginService.insertUser(data);
			if (i < 0) {
				logger.info("@@>> LoginController :: 유저 정보 등록중 오류 발생");
				return new Response(new ApiException(999, "회원 가입 실패하였습니다.."));
			}
			data.setSnsId(null);
			user = loginService.getUserInfo(data);
			String ym = DateUtil.getMonth();
		} else {
			int j = loginService.intfcUpdateUser(req.getBody().getAccessToken(), req.getBody().getSnsId(),
					req.getBody().getSnsType(), req.getBody().getNickName(), req.getBody().getProfileImageUrl(),
					req.getBody().getThumbnailImageUrl(), req.getBody().getGender(), req.getBody().getEmail(),
					req.getBody().getUserId(), req.getBody().getCouponOne(), req.getBody().getCouponTwo(),
					req.getBody().getCouponThree());
			if (j < 0) {
				logger.info("@@>> LoginController :: 유저 정보 업데이트중 오류 발생");
				return new Response(new ApiException(999, "회원 업데이트 실패하였습니다.."));
			}
			user = loginService.getUserInfo(data);

		}
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		session.setAttribute("userId", user.getUserId());
		user.setSessionId(session.getId());
		rtnMap.put("user", user);
		LogUtil.clearGroup();
		return new Response(rtnMap);
	}

	public int sum(int n1, int n2) {
		return n1 + n2;
	}

	/**
	 * 작업리스트 목록
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/orderList", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response getOrderList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcOrderlistRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		Map<String, Object> result = new HashMap<>();

		// 상품 리스트 목록 가져오기
		List<Orderlist> orderlists = orderlistService.getIntfcOrderlistList(req);

		if(orderlists.size() <= 0) {
			return new Response(new ApiException(900, "작업이 없는 디바이스입니다."));
		}
		
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
			
			orderlists.get(i).setCompItems(orderlistService.getOrderProcessComp(orderlists.get(i).getOrderlistId()));
		}

		result.put("list", orderlists);

		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 작업 성공 처리
	 * 
	 * @param orderListId, itemId
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 */
	@RequestMapping(value = "/orderProcessComp", method = { RequestMethod.POST})
	@ResponseBody
	public Response orderProcessComp(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcOrderProcessComp req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 작업리스트 가져와서 피킹해야할 상품인지 아닌지 판단
		Orderlist orderList = orderlistService.getOrderlist(req.body.orderListId);

		// 작업 완료 목록 itemId
		List<Integer> successIdList = orderlistService.getOrderProcessComp(req.body.orderListId);
		
		String[] items = orderList.getItemIds().split(",");
		
		boolean isExist = false;
		
		for (String item : items) {
			if (item.equals(String.valueOf(req.body.itemId))) {
				isExist = true;
			}
		}
		
		if (!isExist) return new Response(new ApiException(902, "작업해야할 상품과 일치하지 않습니다."));
		
		// 작업 완료 중복 처리
		for (int itemId : successIdList) {
			if (itemId == req.body.itemId) return new Response(new ApiException(903, "이미 처리된 상품입니다."));
		}
		
		// 작업 히스토리 삽입
		int result = orderlistService.insertOrderProcessComp(req);
		
		if (result != 1) {
			return new Response(new ApiException(901, "정상적으로 처리되지 않았습니다."));
		}
		
		float workRate = 0;
		
		workRate = ((float) (successIdList.size() + 1) / (float) items.length) * 100;
		
		orderList.setWorkRate((int) workRate);
		if (workRate >= 100) orderList.setSuccessYn("Y");
		
		orderlistService.updateOrderlistWorkRate(orderList);
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * 작업리스트 성공
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/orderListSuccess", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response orderListSuccess(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcOrderlistSuccess req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		Orderlist orderlist = orderlistService.getOrderlist(req.getBody().getOrderlistId());
		
		String[] items = orderlist.getItemIds().split(",");
		double rate = 1 / items.length;
		
		logger.debug("ITEM size ::: " + items.length);
		logger.debug("rate ::: " + rate);
		
		orderlist.setWorkRate(orderlist.getWorkRate() + (int) rate);
		
		if(orderlist.getWorkRate() >= 100) {
			orderlist.setSuccessYn("Y");
		} else {
			orderlist.setSuccessYn("N");
		}
		
		orderlistService.updateOrderlistWorkRate(orderlist);

		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * Zone 인식
	 * 
	 * @param orderListId, itemId
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 */
	@RequestMapping(value = "/zoneReco", method = { RequestMethod.POST})
	@ResponseBody
	public Response zoneReco(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcZoneReco req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		zoneService.insertZoneReco(req);
		
		// 임시로 작업자 위치 저장
		workService.insertWorkLoc(new ReqWorkLoc(req.body.companyId, req.body.deviceId, req.body.zone));
		
		LogUtil.clearGroup();
		return new Response();
	}
	
	/**
	 * AR COUNT
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 */
	@RequestMapping(value = "/arCount", method = { RequestMethod.POST})
	@ResponseBody
	public Response arCount(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcArRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		arService.insertArCount(req);
		
		int arCapacity = arService.getArCount(req);
		
		if(arCapacity >= 1000) {
			return new Response(new ApiException(900, "AR 인식 횟수를 초과했습니다."));
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("count", arCapacity);
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * AR COUNT
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 */
	@RequestMapping(value = "/arStatus", method = { RequestMethod.POST})
	@ResponseBody
	public Response arStatus(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcArRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리
		
		int arCapacity = arService.getArCount(req);
		
		if(arCapacity >= 1000) {
			return new Response(new ApiException(900, "AR 인식 횟수를 초과했습니다."));
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("count", arCapacity);
		
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 상품 정보
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/itemDetail", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response itemDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcItemDetailRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		// API 사용 등록 쿼리

		Map<String, Object> result = new HashMap<>();

		String[] itemIds = req.getBody().getItemIds().split(",");
		String[] quantities = req.getBody().getQuantities().split(",");
		
		if (itemIds.length != quantities.length) {
			return new Response(new ApiException(901, "작업 품목과 수량이 일치하지 않습니다\n관리자에게 문의하세요."));
		}
		
		List<ProductDetailResponse> list = new ArrayList<>();
		
		for (int i = 0; i < itemIds.length; i++) {

			// 상품 정보 가져오기
			ProductDetailResponse product = productService.productDetailPage("", Integer.valueOf(itemIds[i]));
			
			product.setQuantity(Integer.valueOf(quantities[i]));
			
			list.add(product);
			
		}			
		
		result.put("list", list);

		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 사용자 인증
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/authUser", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response authUser(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcAuthUserRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

		// 1. 로그 스타일
		// 2. MinNum,
		// 3. Log Message;
		// 4. 샘플
		// LogUtil.setGroup("01012341234");
		// logger.info("imageIdList size ::::::::::::::::: " + imageIdList.size());
		// LogUtil.clearGroup();

		IntfcAuthUserResponse auth = new IntfcAuthUserResponse();
		
		Device device = deviceService.intfcGetDevice(req.getHeader().getSerial());

		auth.setCompanyId(device.getCompanyId());
		auth.setBranchId(device.getBranchId());
		
		LogUtil.clearGroup();
		return new Response(auth);
	}
	
	/**
	 * 작업리스트 목록
	 * 
	 * @return * response Type : JSON * response Header - 200 정상 , 900 나머지 예외 사항 에러
	 *         , 996 rds count 에러
	 */
	@RequestMapping(value = "/getCalLocation", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Response getCalLocation(HttpServletRequest request, HttpServletResponse response,
			@RequestBody IntfcLocationRequest req) throws Exception {

		if (getHeader(req.getHeader(), new Object() {
		}.getClass().getEnclosingMethod().getName()) == false)
			return new Response(new ApiException(900, "필수 파라메타가 없습니다."));

		LogUtil.setGroup("authKey:" + req.getHeader().getAuthKey());

//		  pseudo code
//		  req 의 beacon id, rssi 값을 가져와서
//		  ,(comma) 구분자로 나누고
		String[] beaconIds = req.getBody().getBeaconIds().split(",");
		String[] rssis = req.getBody().getBeaconRssis().split(",");

		logger.debug("beaconIds.length:::" + beaconIds.length);
		logger.debug("rssis.length:::" + rssis.length);
		
		if (beaconIds.length != rssis.length) {
			return new Response(new ApiException(900, "비콘의 수와 RSSI 의 수가 다릅니다"));
		}

//		  3개의 각 값을 DB에 저장
		IntfcLocationHist loc = null;

		for (int i = 0; i < beaconIds.length; i++) {
			loc = new IntfcLocationHist();

			loc.setDeviceId(req.getBody().getDeviceId());
			loc.setBeaconId(Integer.valueOf(beaconIds[i]));
			loc.setRssi(Integer.valueOf(rssis[i]));

			locationService.insertBeacon(loc);
		}

//		  현재시간 기준으로 5초 안에 있는 비콘 데이터를 가져옴
		List<IntfcLocationHist> locHist = locationService.getListBeacon(req.getBody().getDeviceId());

		logger.debug("locHist.size:::" + locHist.size());
		
//		 해당 데이터 사이즈는 3개 비콘 기준 5초에 1초 버퍼 3 x 4 이상
		if (locHist.size() < 12) {
			return new Response(new ApiException(900, "비콘 정보가 더 필요합니다"));
		}

//		  가장 많은 비콘 top 3 선별
		Map<Integer, Integer> beaconCounting = new HashMap<>();
		List<Integer> beaconList = new ArrayList<>();

		for (int i = 0; i < locHist.size(); i++) {
			IntfcLocationHist tmp = locHist.get(i);

			int bId = tmp.getBeaconId();

			logger.debug("bId:::" + bId);
			
			if (beaconCounting.containsKey(bId)) {
				int bValue = beaconCounting.get(bId);
				bValue++;
				beaconCounting.put(bId, bValue);
			} else {
				beaconCounting.put(bId, 1);
			}
		}

		Iterator iterator = sortByValue(beaconCounting).iterator();

		int count = 0;

		while (count < 3) {
			int temp = (Integer) iterator.next();
			beaconList.add(temp);
			count++;
		}

		beaconCounting.clear();

//		 top 3 의 각 rssi 평균값 구함
		Map<Integer, Integer> beaconRssi = new HashMap<>();
		int count41 = 0;
		int count42 = 0;
		int count43 = 0;

		for (int i = 0; i < locHist.size(); i++) {

			int tmp = 0;

			logger.debug("locHist.getBeaconId:::" + locHist.get(i).getBeaconId());
			
			if (beaconList.get(0) == locHist.get(i).getBeaconId()) {

				if (beaconRssi.containsKey(beaconList.get(0))) {
					tmp = beaconRssi.get(beaconList.get(0));
					tmp += locHist.get(i).getRssi();
					beaconRssi.put(beaconList.get(0), tmp);
				} else {
					beaconRssi.put(beaconList.get(0), locHist.get(i).getRssi());
				}
				
				logger.debug("beaconRssi.id:::" + beaconList.get(0));
				logger.debug("beaconRssi.rssi:::" + beaconRssi.get(beaconList.get(0)));
				
				count41++;

			} else if (beaconList.get(1) == locHist.get(i).getBeaconId()) {

				if (beaconRssi.containsKey(beaconList.get(1))) {
					tmp = beaconRssi.get(beaconList.get(1));
					tmp += locHist.get(i).getRssi();
					beaconRssi.put(beaconList.get(1), tmp);
				} else {
					beaconRssi.put(beaconList.get(1), locHist.get(i).getRssi());
				}
				
				logger.debug("beaconRssi.id:::" + beaconList.get(1));
				logger.debug("beaconRssi.rssi:::" + beaconRssi.get(beaconList.get(1)));
				
				count42++;
			} else if (beaconList.get(2) == locHist.get(i).getBeaconId()) {

				if (beaconRssi.containsKey(beaconList.get(2))) {
					tmp = beaconRssi.get(beaconList.get(2));
					tmp += locHist.get(i).getRssi();
					beaconRssi.put(beaconList.get(2), tmp);
				} else {
					beaconRssi.put(beaconList.get(2), locHist.get(i).getRssi());
				}
				
				logger.debug("beaconRssi.id:::" + beaconList.get(2));
				logger.debug("beaconRssi.rssi:::" + beaconRssi.get(beaconList.get(2)));
				
				count43++;
			}
		}
		
		int wholeRssi = 0;
		
		logger.debug("beaconRssi counting1:::" + count41);
		logger.debug("beaconRssi counting2:::" + count42);
		logger.debug("beaconRssi counting3:::" + count43);
		
		wholeRssi = beaconRssi.get(beaconList.get(0));
		beaconRssi.put(beaconList.get(0), (wholeRssi / count41));
		
		wholeRssi = beaconRssi.get(beaconList.get(1));
		beaconRssi.put(beaconList.get(1), (wholeRssi / count42));
		
		wholeRssi = beaconRssi.get(beaconList.get(2));
		beaconRssi.put(beaconList.get(2), (wholeRssi / count43));
		
//		 rssi 값이 가장 큰 비콘을 기준으로 공식 대입
		sortByValue(beaconRssi);
		
		for(Map.Entry<Integer, Integer> map : beaconRssi.entrySet()) {
			logger.debug("map.entry.key:::" + map.getKey());
			logger.debug("map.entry.value:::" + map.getValue());
		}
		
//		 L = 20 log10 ( 4 * pie * d / 파장)
//		  파장 = c / f
		
//		  거리 d = 광속(c) / 4 * pie * 주파수(f) * 10 ^ L/20
//		  광속 c = 3 * 10 ^ 8
//		  주파수 f = 2.4
//		 PIE = 3.14
//		  피타고라스 정리에 의해 거리 d^2 = (x-x1)^2 + (y-y1)^2
//		 x, y == 현재 위치

		IntfcLocationResponse locRes = new IntfcLocationResponse();

		locRes.setCalLatitude(0);
		locRes.setCalLongitude(0);

		LogUtil.clearGroup();
		return new Response(locRes);
	}

	// HashMap sorting
	public static List sortByValue(final Map map) {
		List<Integer> list = new ArrayList();
		list.addAll(map.keySet());

		Collections.sort(list, new Comparator() {

			@Override
			public int compare(Object o1, Object o2) {
				// TODO Auto-generated method stub
				Object v1 = map.get(o1);
				Object v2 = map.get(o2);

				return ((Comparable) v2).compareTo(v1);
			}

		});

		Collections.reverse(list);

		return list;
	}

}