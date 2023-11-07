package com.smartcc.avp.common.code;

public class CommonCode {
	
	public class STATISTIC_TYPE {
	public final static String code="STATISTIC_TYPE";
		public class CLOUD_RECOS {
			public final static String code="CLOUD_RECOS";
			public final static String name="타겟인식횟수";
			public final static String val="CLOUD_RECOS";
		}
		public class CLOUD_TARGETS {
			public final static String code="CLOUD_TARGETS";
			public final static String name="타겟등록횟수";
			public final static String val="CLOUD_TARGETS";
		}
		public class TMAP_AUTH {
			public final static String code="TMAP_AUTH";
			public final static String name="티맵인증";
			public final static String val="TMAP_AUTH";
		}
		public class TMAP_VIEW {
			public final static String code="TMAP_VIEW";
			public final static String name="티맵지도보기";
			public final static String val="TMAP_VIEW";
		}
		public class TMAP_ROADINFO {
			public final static String code="TMAP_ROADINFO";
			public final static String name="티맵길안내";
			public final static String val="TMAP_ROADINFO";
		}
		public class AWS_FILEGET {
			public final static String code="AWS_FILEGET";
			public final static String name="S3 데이터 저장";
			public final static String val="AWS_FILEGET";
		}
		public class AWS_FILEPUT {
			public final static String code="AWS_FILEPUT";
			public final static String name="S3 데이터 불러오기";
			public final static String val="AWS_FILEPUT";
		}
		public class RDS_QUERY {
			public final static String code="RDS_QUERY";
			public final static String name="RDS I/O";
			public final static String val="RDS_QUERY";
		}
	}
	public class EVENT_TYPE {
	public final static String code="EVENT_TYPE";
		public class LOCATION {
			public final static String code="LOCATION";
			public final static String name="location";
			public final static String val="location";
		}
		public class TIME {
			public final static String code="TIME";
			public final static String name="time";
			public final static String val="time";
		}
	}
	public class USER_TYPE {
		public final static String code="USER_TYPE";
			public class ADMIN {
				public final static String code="ADMIN";
				public final static String name="관리자";
				public final static String val="ADMIN";
			}
			public class SUPER {
				public final static String code="SUPER";
				public final static String name="마스터";
				public final static String val="SUPER";
			}
			public class NORMAL {
				public final static String code="NORMAL";
				public final static String name="일반사용자";
				public final static String val="NORMAL";
			}
			public class SELLER {
				public final static String code="SELLER";
				public final static String name="판매자";
				public final static String val="SELLER";
			}
			public class WORKER {
				public final static String code="WORKER";
				public final static String name="작업자";
				public final static String val="WORKER";
			}
		}
	public class FILE_VALID {
		public final static String code="MY_SIZE_OVER";
			public class MY_SIZE_OVER {
				public final static String code="MY_SIZE_OVER";
				public final static String name="내가 사용할수 있는 파일용량이 초과되었습니다.";
				public final static String val="MY_SIZE_OVER";
			}
			public class S3_SIZE_OVER {
				public final static String code="S3_SIZE_OVER";
				public final static String name="한달에 사용할수 있는 s3 용량이 초과되었습니다.";
				public final static String val="S3_SIZE_OVER";
			}
		}
	
	public class RDS_VALID {
			public class RDS_QUERY_OVER {
				public final static String code="RDS_QUERY_OVER";
				public final static String name="사용할수 없습니다.관리자에게 문의해 주세요.";
				public final static String val="RDS_QUERY_OVER";
			}
		}
	
	
	public class EVENT_AFTER_TYPE {
	public final static String code="EVENT_AFTER_TYPE";
		public class ROADINFORMATION {
			public final static String code="ROADINFORMATION";
			public final static String name="ROADINFORMATION";
			public final static String val="ROADINFORMATION";
		}
		public class AFTEREVENT {
			public final static String code="AFTEREVENT";
			public final static String name="AFTEREVENT";
			public final static String val="AFTEREVENT";
		}
	}
	
	public class USE_STATUS {
	public final static String code="USE_STATUS";
		public class USE_Y {
			public final static String code="USE_Y";
			public final static String name="사용";
			public final static String val="Y";
		}
		public class USE_N {
			public final static String code="USE_N";
			public final static String name="미사용";
			public final static String val="N";
		}
	}
	
	public class ACTION_TYPE {
		public final static String code="ACTION_TYPE";
			public class COMPANY_LIST {
				public final static String code="COMPANY_LIST";
			}
			public class COMPANY_INSERT {
				public final static String code="COMPANY_INSERT";
			}
			public class COMPANY_INSERT_PAGE {
				public final static String code="COMPANY_INSERT_PAGE";
			}
			public class COMPANY_DETAIL {
				public final static String code="COMPANY_DETAIL";
			}
			public class COMPANY_UPDATE_PAGE {
				public final static String code="COMPANY_UPDATE_PAGE";
			}
			public class COMPANY_UPDATE {
				public final static String code="COMPANY_UPDATE";
			}
			public class COMPANY_DELETE {
				public final static String code="COMPANY_DELETE";
			}
			
			public class SHOP_LIST {
				public final static String code="SHOP_LIST";
			}
			public class SHOP_INSERT{
				public final static String code="SHOP_INSERT";
			}
			public class SHOP_INSERT_PAGE{
				public final static String code="SHOP_INSERT_PAGE";
			}
			public class SHOP_DETAIL {
				public final static String code="SHOP_DETAIL";
			}
			public class SHOP_UPDATE {
				public final static String code="SHOP_UPDATE";
			}
			public class SHOP_UPDATE_PAGE {
				public final static String code="SHOP_UPDATE_PAGE";
			}
			public class SHOP_DELETE {
				public final static String code="SHOP_DELETE";
			}
			
			public class EVENT_LIST {
				public final static String code="EVENT_LIST";
			}
			public class EVENT_INSERT {
				public final static String code="EVENT_INSERT";
			}
			public class EVENT_INSERT_PAGE {
				public final static String code="EVENT_INSERT_PAGE";
			}
			public class EVENT_DETAIL {
				public final static String code="EVENT_DETAIL";
			}
			public class EVENT_UPDATE_PAGE {
				public final static String code="EVENT_UPDATE_PAGE";
			}
			public class EVENT_UPDATE {
				public final static String code="EVENT_UPDATE";
			}
			public class EVENT_DELETE {
				public final static String code="EVENT_DELETE";
			}
			
			public class PRODUCT_LIST {
				public final static String code="PRODUCT_LIST";
			}
			public class PRODUCT_INSERT {
				public final static String code="PRODUCT_INSERT";
			}
			public class PRODUCT_INSERT_PAGE {
				public final static String code="PRODUCT_INSERT_PAGE";
			}
			public class PRODUCT_DETAIL {
				public final static String code="PRODUCT_DETAIL";
			}
			public class PRODUCT_UPDATE {
				public final static String code="PRODUCT_UPDATE";
			}
			public class PRODUCT_UPDATE_PAGE {
				public final static String code="PRODUCT_UPDATE_PAGE";
			}
			public class PRODUCT_DELETE {
				public final static String code="PRODUCT_DELETE";
			}
			
			public class AR_LIST {
				public final static String code="AR_LIST";
			}
			public class AR_INSERT {
				public final static String code="AR_INSERT";
			}
			public class AR_INSERT_PAGE {
				public final static String code="AR_INSERT_PAGE";
			}
			public class AR_DETAIL {
				public final static String code="AR_DETAIL";
			}
			public class AR_UPDATE {
				public final static String code="AR_UPDATE";
			}
			public class AR_UPDATE_PAGE {
				public final static String code="AR_UPDATE_PAGE";
			}
			public class AR_DELETE {
				public final static String code="AR_DELETE";
			}
			
			public class USER_LIST {
				public final static String code="USER_LIST_PAGE";
			}
			public class USER_DETAIL {
				public final static String code="USER_DETAIL";
			}
			public class MEMBER_LIST {
				public final static String code="MEMBER_LIST_PAGE";
			}
			public class MEMBER_DETAIL {
				public final static String code="MEMBER_DETAIL_PAGE";
			}
			public class MEMBER_AUTH_UPDATE {
				public final static String code="MEMBER_AUTH_UPDATE";
			}
			public class MEMBER_APPLY_LIST {
				public final static String code="MEMBER_APPLY_LIST";
			}
			public class LOGIN {
				public final static String code="LOGIN";
			}
			public class INIT {
				public final static String code="INIT";
			}
			public class SHOP_SCORE {
				public final static String code="SHOP_SCORE";
			}
			public class SHOP_SEARCH {
				public final static String code="SHOP_SEARCH";
			}
		}
}
