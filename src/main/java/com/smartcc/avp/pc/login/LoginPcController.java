package com.smartcc.avp.pc.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.common.util.SHA256;
import com.smartcc.avp.intfc.InterfaceController;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.company.model.request.CompanyInsertRequest;
import com.smartcc.avp.pc.company.service.CompanyService;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.model.request.LoginMasterRequest;
import com.smartcc.avp.pc.login.model.request.LoginSubRequest;
import com.smartcc.avp.pc.login.service.LoginService;

import lombok.Setter;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
/**
 * pc > login 
 * @author JS.LEE
 */
@Controller
@RequestMapping(value="/pc")
public class LoginPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(LoginPcController.class);

	
	@Setter
	@Resource LoginService loginService;
	
	@Setter
	@Resource CompanyService companyService;
	
	public static String ym = DateUtil.getMonth();

	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;
	
	@Value("#{config['twitter.consumer.key']}")
	private String TWITTER_CONSUMER_KEY;

	@Value("#{config['twitter.secret.key']}")
	private String TWITTER_SECRET_KEY;
	
	public static String KAKAO	=	"kakao";
	public static String FACEBOOK	=	"facebook";
		
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
			@Value("#{config['schema.chum']}")
			private String chumSchema;
			
			@Value("#{config['schema.scgp']}")
			private String scgpSchema;
			
			@Value("#{config['schema.bogoga']}")
			private String bogogaSchema;
			// End of	
	
	
	/**
	 * 마스터 로그인 페이지 이동
	 * @return /pc/master_login
	 * @throws Exception
	 */
	@RequestMapping(value="/masterLoginPage")
	public String masterLoginPage(HttpServletRequest request) throws Exception {
		return "/pc/master_login";
	}

	/**
	 * 마스터 로그인 하기 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/masterLogin", method = {RequestMethod.POST})
	@ResponseBody
	public Response masterLogin(HttpServletRequest request,@RequestBody LoginMasterRequest req) throws Exception {
		LogUtil.setGroup("Super Login");
		logger.debug("req ::" + req);
		HttpSession session =  request.getSession ();
		Map<String, Object> result = new HashMap<>();

		String encPwd = SHA256.encSHA256(req.getUserPassword());	
		
		logger.debug("encPwd ::" + encPwd);
		User masterInfo = loginService.getMasterUser(req.getEmail(),encPwd);

		if(null != masterInfo)
		{
			session.setAttribute("user", masterInfo);
			session.setAttribute("userId", masterInfo.getUserId());
		}
		else
		{
			 return new Response(new ApiException(999, "이메일 또는 패스워드를 확인해주세요."));

		}
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	/**
	 * 트위터 버튼 클릭시 요청되는 트위터 앱 체크 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/twitterAppCheck", method = {RequestMethod.POST})
	@ResponseBody
	public Response twitterAppCheck(HttpServletRequest request) throws Exception {
		LogUtil.setGroup("twitterAppCheck");
		logger.info("twitter :: 트위터 info");
		logger.debug("twitter :: 트위터 debug");
		logger.error("twitter :: 트위터 error");
		logger.trace("twitter :: 트위터 trace");
		
		HttpSession session =  request.getSession ();
		Twitter twitter = new TwitterFactory().getInstance();
		Map<String, Object> result = new HashMap<>();

		//twitter로 접근한다.
		twitter.setOAuthConsumer(TWITTER_CONSUMER_KEY, TWITTER_SECRET_KEY);
			

			//성공시 requestToken에 해당정보를 담겨져온다.
		RequestToken requestToken  = twitter.getOAuthRequestToken();
			
		String tokenSecret	= requestToken.getTokenSecret();
		String token 		= requestToken.getToken();
		String authUrl 		= requestToken.getAuthorizationURL();
		
		logger.debug("token :::" , token);
		logger.debug("tokenSecret :::" , tokenSecret);
		logger.debug("authUrl :::" , authUrl);
		//CallBack 페이지에서 이용하기 위하여 토큰 비밀번호를 세션에 저장한다.
		session.setAttribute("requestToken", requestToken);
		
		result.put("authUrl",authUrl);
		result.put("token",token);
	logger.info("twitter ::트위터 앱인증 END");
	LogUtil.clearGroup();
	return new Response(result);
	}
	
	
	/**
	 * 트위터 앱체크에서 장상적이면 요청하는 call back url
	 * @return /pc/dashboard/dashboardPage or 
	 * 			/pc/login
	 * @throws Exception
	 */
	@RequestMapping(value="/twitterCallBack", method = {RequestMethod.GET})
	public void twitterCallBack(HttpServletResponse reponse,HttpServletRequest request,HttpServletResponse response,
							@RequestParam("oauth_token") String oauthToken,
							@RequestParam("oauth_verifier") String oauthVerifier) throws Exception {
		logger.debug("twitter:: 인증 완료 후 콜백 START");
		LogUtil.setGroup("twitterCallBack");
		HttpSession session = request.getSession();
		Map<String, Object> result = new HashMap<>();
		String validChek = "";
		Integer	rdsCnt = 0;
		User user = new User();
		Twitter twitter = new TwitterFactory().getInstance();			
		twitter.setOAuthConsumer(TWITTER_CONSUMER_KEY, TWITTER_SECRET_KEY); //저장된 consumerKey, consumerSecret
		AccessToken accessToken = null;		
		String oauth_verifier = oauthVerifier;

		//트위터 로그인 연동시 담은 requestToken 의 세션값을 가져온다.
		RequestToken requestToken = (RequestToken )request.getSession().getAttribute("requestToken");			
		accessToken = twitter.getOAuthAccessToken(requestToken, oauth_verifier);			
		twitter.setOAuthAccessToken(accessToken);

		String snsId =  Long.toString(accessToken.getUserId());
		String	nickName = accessToken.getScreenName();

		LoginRequest req = new LoginRequest();
		req.setSnsId(snsId);
		req.setNickName(nickName);
		req.setSnsType("twitter");
		//해당 트위터 사용자의 이름과 아이디를 가져온다.
		
		rdsCnt++;
		user = loginService.getUserInfo(req);
		if(null == user)
		{
			user = new User();
			rdsCnt++;
			loginService.insertUser(req);
			user.setUserId(req.getUserId());
			user.setConfirmYn("N");
			validChek = "FIRST";
		}
		else
		{
			validChek = "FIRSTNOT";
		}
		rdsCnt++;
		
		session.setAttribute("user", user);
		session.setAttribute("userId", user.getUserId());
		result.put("validChek", validChek);
		
		logger.debug("user :::" + user);
		if(CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()))
		{
			logger.debug("twitter:: DB 검색 결과 SUPER 유저 && 대쉬 보드 페이지 이동");
//			url  = "/pc/dashboard/dashboardPage";
//			return "redirect:"+url;
			response.sendRedirect("/pc/dashboard/dashboardPage");
//			return "/pc/login_sub";
		}
		else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null == user.getCompanyId())
		{
			logger.debug("twitter:: DB 검색 결과  로그인 부가정보를 안받은 상태 ");
			response.sendRedirect("/pc/loginSub");
//			url  = "/pc/loginSub";
//			return "redirect:"+url;
		}
		else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null != user.getCompanyId() && "Y".equals(user.getConfirmYn()))
		{
			logger.debug("twitter:: dahboard page 이동");
			response.sendRedirect("/pc/dashboard/dashboardPage");
//			url  = "/pc/dashboard/dashboardPage";
//			return "redirect:"+url;
		}
		else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null != user.getCompanyId() && "N".equals(user.getConfirmYn()))
		{
			logger.debug("twitter:: 가입 승인을 받지 않은 상태");
			response.sendRedirect("/pc/login?twitterValid=already");

//			url  = "/pc/login?twitterValid=ddd";
//			return "redirect:"+url;
		}
		LogUtil.clearGroup();
	}
	
	
	/**
	 * 로그인아웃 - ajax
	 * @throws Exception
	 */
	@RequestMapping(value="/logoutChk")
	public String logoutChk(HttpServletRequest request) throws Exception {
		LogUtil.setGroup("logoutChk");

		logger.info("logout:: 로그아웃 START ");

		request.getSession().invalidate();

		request.getSession().removeAttribute("userId");
		request.getSession().removeAttribute("user");
		
		
		logger.info("logout:: 로그아웃 END");
		LogUtil.clearGroup();
		return "/pc/login";
	}
	
	
	/**
	 * 로그인 페이지 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login", method = {RequestMethod.GET})
	public String login(HttpServletResponse response, HttpServletRequest request,ModelMap modelMap , LoginRequest req) throws Exception {
		LogUtil.setGroup("login");
		logger.info("req ::::" + req);
		logger.info("before valid ::: " + req.getTwitterValid());
		/*
		if(req.getTwitterValid() == "already") {
			logger.info("valid ::: " + req.getTwitterValid());
			response.setCharacterEncoding("EUC-KR");
		    PrintWriter writer = response.getWriter();
		    writer.println("<script type='text/javascript'>");
		    writer.println("alert('이미 신청 하셨습니다');");
		    writer.println("</script>");
		    writer.flush();
		}
		*/
	
		LogUtil.clearGroup();
		
		return "/pc/login";
	}
		
	/**
	 * 로그인 부가 정보 입력 페이지로 이동
	 * @return /pc/company/company_list_page
	 * @throws Exception
	 */
	@RequestMapping(value="/loginSub", method = {RequestMethod.GET})
	public String loginSub(HttpServletResponse reponse, HttpServletRequest request,ModelMap modelMap) throws Exception {
//		System.out.println("test :: " +testService.getList());
		LogUtil.setGroup("loginSub");
		LogUtil.clearGroup();

		return "/pc/login_sub";
	}
	
	/**
	 * 로그인 부가정보 저장 AJAX 
	 * @return 
	 * response Type : JSON
	 * @throws exception
	 */
	@RequestMapping(value="/insertSubData", method = {RequestMethod.POST})
	@ResponseBody
	public Response insertSubData(HttpServletRequest request,ModelMap modelMap ,@RequestBody LoginSubRequest req) throws Exception {
		LogUtil.setGroup("insertSubData");
		// 한달 제한
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		req.setUserId(userId);
		/* 
		 * Need to modify 2017. 09. 11. JBum
		 * monthlyLImitSize : 한달 S3 사용량을 기준으로 하는 것이 아니라 할당 받은 ADMIN의 사이즈를 체크해서 비교해야 함
		 */
		long monthlyLimitSize = Long.valueOf(MONTHLY_LIMIT_SIZE).longValue(); // 여기 2017. 09. 11.
		Integer rdsCnt = 1;
		User user = loginService.getUserInfo(userId);
		
		long reqSize = Long.valueOf(req.getStorageSize()).longValue();
		long allUserStorage = loginService.getAllUserStorage(ym);
		
		//String userType = (String)user.getUserType();				// 신청 안했기 때문에 NULL
		String userType = (String)req.getUserType();
		String groupDbName = (String)req.getGroupDbName();
		logger.info("::::::::: userType : " + userType + " :::::: groupDbName : " + groupDbName + " ::::: reqsize : " + reqSize);
		
		// Company 직접 입력
		// Company Insert 후 companyId return
		// req 에 companyId set
		if(req.getCompanyDirect().length() > 0 || !req.getCompanyDirect().equals("")) {
			CompanyInsertRequest comReq = new CompanyInsertRequest();
			
			comReq.setCompanyName(req.getCompanyDirect());
			comReq.setCreateId(userId);
			comReq.setWholeStorage(req.getStorageSize());
			
			companyService.companyInsert("", comReq);
			
			int companyId = companyService.getCompanyIdByName(req.getCompanyDirect());
			
			req.setCompanyId(companyId);
		}
		
		
		if(userType.equals("WORKER"))
		{
			long companyStorage = loginService.getAdminUserStorage(ym, req.getCompanyId(), groupDbName);
			long sellerStorage = loginService.getSellerUserStorage(ym, req.getCompanyId(), groupDbName);
			logger.info(":::::::::::: companyStorage : " + companyStorage + " sellerStorage : " + sellerStorage);
			if(companyStorage < sellerStorage + reqSize) {
				return new Response(new ApiException(999,"신청량이 소속 한도를 초과했습니다"));
			}
		}
		
		if(userType.equals("ADMIN"))
		{
			long companyStorage = loginService.getAdminUserStorage(ym, req.getCompanyId(), groupDbName);
			logger.info(":::::::::::: companyStorage : " + companyStorage);
			if(1073741824 < companyStorage + reqSize)
			{
				return new Response(new ApiException(999, "신청량이 그룹 한도를 초과했습니다."));
			}
		}
		
		if(null != user.getCompanyId())
		{
			 return new Response(new ApiException(998, "이전에 부가정보를 등록하였습니다.로그인 페이지로 이동합니다."));
		}
		
		int i =	loginService.updateUserData(req);

//		System.out.println("test :: " +testService.getList());
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/logintemp", method = {RequestMethod.GET})
	public String logintemp(HttpServletResponse reponse, HttpServletRequest request,ModelMap modelMap) throws Exception {
		
		
//		System.out.println("test :: " +testService.getList());
		return "/pc/login_temp";
	}
	
	
	
	/**
	 * 페이스북, 카카오톡 클릭시 user 정보 체크 AJAX
	 * @throws Exception
	 */
	@RequestMapping(value="/appLoginData", method = {RequestMethod.POST})
	@ResponseBody
	public Response appLoginData(HttpServletRequest request,ModelMap modelMap ,@RequestBody LoginRequest req) throws Exception {
		LogUtil.setGroup("App Login");
		logger.info("@@@@@@@@@@@@@@@@@@@ FACEBOOK , KAKAO 로그인  START @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		HttpSession session = request.getSession();
		Map<String, Object> result = new HashMap<>();
		String validChek = "";
		User user = new User();

			user = loginService.getUserInfo(req);
			if(null == user)
			{
				logger.info("@@@@@@@@@@@@@@@@@@@ 최초 USER @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				user = new User();
				
				String phone = req.getPhone();
				if (phone != null) {
					phone.replace("+82", "0");
				}
				
				req.setPhone(phone);
				req.setConfirmYn("N");
				
				loginService.insertUser(req);

				user = loginService.getUserInfo(req);
				
				validChek = "FIRST";
			}
			else
			{
				logger.info("@@@@@@@@@@@@@@@@@@@ DB 검색 결과 SUPER 유저 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				if(CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()))
				{
					validChek = "SUPER";	
				}
				else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null == user.getCompanyId())
				{
					logger.info("@@@@@@@@@@@@@@@@@@@ DB 검색 결과  로그인 부가정보를 안받은 상태@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
					validChek = "MOVELOGINSUB";	
				}
				else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null != user.getCompanyId() && "Y".equals(user.getConfirmYn()))
				{
					validChek = "NORMAL";	
				}
				else if(!CommonCode.USER_TYPE.SUPER.code.equals(user.getUserType()) && null != user.getCompanyId() && "N".equals(user.getConfirmYn()))
				{
					validChek = "NOTNORMAL";	
				}
					
			}
			
		result.put("valid", validChek);
		result.put("userId", user.getUserId());
		result.put("user", user);
		session.setAttribute("userId",user.getUserId());
		session.setAttribute("user",user);
		session.setAttribute("division", user.getDivision());
		
		logger.info("facebook kakao ::  로그인  END ");
		LogUtil.clearGroup();
		return new Response(result);
	}
	
	   @RequestMapping(value="/kakaoLogin",produces ="application/json", method = {RequestMethod.POST , RequestMethod.GET})
		public String kakaoLogin(HttpServletRequest request,ModelMap modelMap ,@RequestParam("code") String req) throws Exception {
			System.out.println("sessionId :::"+req);
			return "";
		}
	   
	   
	   @RequestMapping(value="/facebookLogin", method = {RequestMethod.POST , RequestMethod.GET})
		public String facebookLogin(HttpServletRequest request,ModelMap modelMap ,@RequestParam("code") String req) throws Exception {
			System.out.println("sessionId :::"+req);
			return "";
		}

	

}
