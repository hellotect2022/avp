package com.smartcc.avp.common;


public interface BaseConst {
	
	public class Code {
		// From ApiConstants
		public final static int SUCCESS = 200;
		public final static String API_SUCCESS_MSG = "OK";
		 
		public final static int CREATED = 201;
		public final static String API_CREATED_MSG = "CREATED";
		
		public final static int SHOWING = 207;
		
		public final static int INVALID_ERROR = 400;
		
		public final static int INVALID_TYPE_ERROR = 401;
		
		public final static int SIGN_KEY_FAIL = 407;
		
		public final static int AUTH_TOKEN_EXPIRED = 408;

		public final static int FULL_LOGIN_ERROR_COUNT=409;
		
		public final static int ACCESS_DENIED = 500;
		
		public final static int NETWORK_ERROR = 600;
		
		public final static int SYSTEM_ERROR = 900;		

		// New Defined
		public final static int NOT_FOUND = 404;
	}
	
	public class ErrorCode {
		
		public final static int UPLOAD_COUPON_EXCEL_FAIL	=	1000;
		public final static int COUPON_EXCEL_FORMAT_ERR		=	1001;
		public final static int INVALID_PARAMETER			=	1002;
		public final static int COUPON_CREATE_FAIL			= 2000;
		public final static int DB_FAIL 					= 9999;
		

		public final static int UNKNOWN_USERKEY_FROM_HEIMDALL 	= 910;			// 	userKey 찾기 실패

	}

	
	public class SessionInfo {
		public	final	static	String	ADMIN_SESSION_USER	=	"smarttour_admin_user";
	}
	
	public class Words{
		public final static String HELP_DESK = "";
	}
	
}
