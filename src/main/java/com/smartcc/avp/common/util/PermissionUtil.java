package com.smartcc.avp.common.util;

import com.smartcc.avp.pc.user.model.User;

public class PermissionUtil {

//	--------------------------------------pc----------------------------------------
	private static final String pcSecessionListUrl 			= "/pc/user/secessionListPage";
	private static final String pcSecessionDetailUrl 		= "/pc/user/secessionDetailPage";
	private static final String pcMemberAuthApplyDetailPage 		= "/pc/member/memberAuthApplyDetailPage";
	private static final String pcMemberAuthApplyListPage 		= "/pc/member/memberAuthApplyListPage";
	private static final String pcMemberAuthApplyConfirmUpdatePage 		= "/pc/member/memberAuthApplyConfirmUpdate";
	
	private static final String pcMemberAuthUpdate 		= "/pc/member/memberAuthUpdate";
	
	private static final String pcArListUrl 	= "/pc/ar/arListPage";
	private static final String pcArInsertUrl	= "/pc/ar/arInsertPage";
	private static final String pcArUpdateUrl	= "/pc/ar/arUpdatePage";
	private static final String pcArDetailUrl	= "/pc/ar/arDetailPage";
	
	
	private static final String pcCompanyListUrl 	= "/pc/company/companyListPage";
	private static final String pcCompanyInsertUrl	= "/pc/company/companyInsertPage";
	private static final String pcCompanyUpdateUrl	= "/pc/company/companyUpdatePage";
	private static final String pcCompanyDetailUrl	= "/pc/company/companyDetailPage";
	private static final String pcCompanyDeleteUrl	= "/pc/company/companyDelete";
	private static final String pcCompanyReqListUrl	= "/pc/company/companyReqListPage";
	private static final String pcCompanyReqDetailUrl	= "/pc/company/companyReqDetailPage";

	private static final String pcShopListUrl			= "/pc/shop/shopListPage";
	private static final String pcShopInsertUrl		= "/pc/shop/shopInsertPage";
	private static final String pcShopUpdateUrl		= "/pc/shop/shopUpdatePage";
	private static final String pcShopDetailUrl		= "/pc/shop/shopDetailPage";
	
	private static final String pcProductListUrl		= "/pc/product/productListPage";
	private static final String pcProductInsertUrl	= "/pc/product/productInsertPage";
	private static final String pcProductInsertAjaxUrl	= "/pc/product/productInsert";
	private static final String pcProductUpdateUrl	= "/pc/product/productUpdatePage";
	private static final String pcProductUpdateAjaxUrl	= "/pc/product/productUpdate";
	private static final String pcProductDetailUrl	= "/pc/product/productDetailPage";
	
	private static final String pcUserListUrl			= "/pc/user/userListPage";
	private static final String pcUserDetailUrl			= "/pc/user/userDetailPage";
	
	private static final String pcMemberListUrl		= "/pc/member/memberListPage";
	private static final String pcMemberDetailUrl		= "/pc/member/memberDetailPage";
	private static final String pcMemberUpdateUrl		= "/pc/member/memberUpdate";


	private static final String pcMemberAuthListUrl		= "/pc/member/memberApplyListPage";
	private static final String pcMemberAuthDetailUrl		= "/pc/member/memberApplyDetailPage";
	
	private static final String pcEventListUrl		= "/pc/company/companyUpdatePage";
	private static final String pcEventInsertUrl		= "/pc/company/companyUpdatePage";
	private static final String pcEventUpdateUrl		= "/pc/company/companyUpdatePage";
	private static final String pcEventDetailUrl		= "/pc/company/companyUpdatePage";
	
	private static final String pcStatisticsUrl		= "/pc/statistics/statisticsPage";
	private static final String pcStatisticsMapUrl	= "/pc/statistics/statisticsMapPage";
	
	
//	--------------------------------------webview----------------------------------------
	private static final String companyListUrl 		= "/opr/company/companyListPage";
	private static final String companyInsertUrl	= "/opr/company/companyInsertPage";
	private static final String companyUpdateUrl	= "/opr/company/companyUpdatePage";
	private static final String companyDetailUrl	= "/opr/company/companyDetailPage";
	private static final String companyDeleteUrl	= "/opr/company/companyDelete";

	private static final String shopListUrl			= "/opr/shop/shopListPage";
	private static final String shopInsertUrl		= "/opr/shop/shopInsertPage";
	private static final String shopUpdateUrl		= "/opr/shop/shopUpdatePage";
	private static final String shopDetailUrl		= "/opr/shop/shopDetailPage";
	
	private static final String productListUrl		= "/opr/product/productListPage";
	private static final String productInsertUrl	= "/opr/product/productInsertPage";
	private static final String productUpdateUrl	= "/opr/product/productUpdatePage";
	private static final String productDetailUrl	= "/opr/product/productDetailPage";
	
	private static final String userListUrl			= "/opr/user/userListPage";
	private static final String userDetailUrl			= "/opr/user/userDetailPage";
	
	private static final String memberListUrl		= "/opr/member/memberListPage";
	private static final String memberDetailUrl		= "/opr/member/memberDetailPage";
	private static final String memberUpdateUrl		= "/opr/member/memberUpdate";
	
	private static final String memberAuthListUrl		= "/opr/member/memberAuthListPage";
	private static final String memberAuthDetailUrl		= "/opr/member/memberAuthPagePage";
	
	private static final String eventListUrl		= "/opr/company/companyUpdatePage";
	private static final String eventInsertUrl		= "/opr/company/companyUpdatePage";
	private static final String eventUpdateUrl		= "/opr/company/companyUpdatePage";
	private static final String eventDetailUrl		= "/opr/company/companyUpdatePage";
	
	
	
	private static final String ROOT		= "ROOT";
	private static final String SUPER		= "SUPER";
	private static final String SELLER		= "SELLER";
	private static final String ADMIN		= "ADMIN";
	private static final String NORMAL		= "NORMAL";
	public static boolean sessionCheck(String reqUrl,User user)
	{
	
		if(NORMAL.equals(user.getUserType()))
		{
			return false;
		}
		if("N".equals(user.getConfirmYn()))
		{
			return false;
		}
		
		boolean result = false;
		switch (reqUrl)
		{
			case companyListUrl :
					if(SUPER.equals(user.getUserType()))
					{
						return true;
					}
				break;
			case companyInsertUrl :
					if(SUPER.equals(user.getUserType()))
					{
						return true;
					}
			case companyUpdateUrl :
					if(!SELLER.equals(user.getUserType()))
					{
						return true;
					}
					break;
			case companyDetailUrl :
					if(!SELLER.equals(user.getUserType()))
					{
						return true;
					}
					break;
			case companyDeleteUrl :
				if(!SELLER.equals(user.getUserType()))
				{
					return true;
				}
				break;
//	---------------------------------상푸-------------------------------------------------------------------------------
			case productUpdateUrl:
					if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
					{
						return true;
					}
					if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
					{
						return true;
					}
					break;
			case pcProductUpdateAjaxUrl :
					if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
					{
						return true;
					}
					if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
					{
						return true;
					}
					break;
			case productInsertUrl :
					if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
					{
						return true;
					}
					if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
					{
						return true;
					}
					break;
//	---------------------------------상푸-------------------------------------------------------------------------------
			// 상점 관리
			case shopInsertUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getShopUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;		
			case shopDetailUrl :
					return true;
			case shopUpdateUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getShopUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;			
			// 신청대기 리스트 
			case memberAuthListUrl :
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case memberAuthDetailUrl :
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case memberListUrl:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getMemberViewAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;
			case memberDetailUrl:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getMemberViewAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;
			// 회원관리
			case userListUrl :
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			default : 
				break;
		}
//		logger.info("reqUrl :: "+reqUrl);
		
		return false;
	}
	
	public static boolean pcSessionCheck(String reqUrl,User user)
	{
	
		if(NORMAL.equals(user.getUserType()))
		{
			return false;
		}
		if("N".equals(user.getConfirmYn()))
		{
			return false;
		}
		
		boolean result = false;
		switch (reqUrl)
		{
			case pcMemberAuthApplyConfirmUpdatePage:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcMemberAuthUpdate:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcMemberAuthApplyListPage:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcMemberAuthApplyDetailPage:
				if(!SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcSecessionDetailUrl:
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcSecessionListUrl:
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcStatisticsUrl :
				if(SUPER.equals(user.getUserType())/* Add 2017. 09. 15. JBum | 루트 계정 추가 */ || ROOT.equals(user.getUserType()))
				{
					return true;
				}
			break;
			case pcStatisticsMapUrl:
				if(SUPER.equals(user.getUserType()) || ROOT.equals(user.getUserType()))
				{
					return true;
				}
				break;				
			case pcCompanyDeleteUrl :
				if(!SELLER.equals(user.getUserType()))
				{
					return true;
				}
			break;
			case pcCompanyListUrl :
					if(SUPER.equals(user.getUserType()))
					{
						return true;
					}
				break;
			case pcCompanyReqListUrl:
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcCompanyReqDetailUrl:
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcCompanyInsertUrl :
					if(SUPER.equals(user.getUserType()))
					{
						return true;
					}
					break;
			case pcCompanyUpdateUrl :
					if(!SELLER.equals(user.getUserType()))
					{
						return true;
					}
					break;
			case pcCompanyDetailUrl :
					return true;
			case pcArListUrl :
					return true;
			case pcArInsertUrl :
					return true;
			case pcArDetailUrl :
					return true;
			case pcArUpdateUrl :
					return true;
//------------------------------------------상품 start------------------------------------------------------------------------------------------
			case pcProductListUrl :
					return true;
			case pcProductInsertUrl :
					if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
					{
						return true;
					}
					if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
					{
						return true;
					}
					break;
			case pcProductInsertAjaxUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;
			case pcProductDetailUrl :
					return true;
			case pcProductUpdateUrl :
					if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
					{
						return true;
					}
					
					if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
					{
						return true;
					}
					break;
			case pcProductUpdateAjaxUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getProductUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;		
//------------------------------------------상품 END------------------------------------------------------------------------------------------
			// 상점 관리
			case pcShopInsertUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getShopUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;		
			case pcShopListUrl :
					return true;
			case pcShopDetailUrl :
					return true;
			case pcShopUpdateUrl :
				if(SUPER.equals(user.getUserType()) || ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getShopUpdateAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;		
			// 신청대기 리스트 
			case pcMemberAuthListUrl :
				if(!SELLER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcMemberAuthDetailUrl :
				if(!SELLER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcMemberListUrl:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getMemberViewAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;
			case pcMemberDetailUrl:
				if(ADMIN.equals(user.getUserType()))
				{
					return true;
				}
				if(SELLER.equals(user.getUserType()) && "Y".equals(user.getMemberViewAuth()) && "Y".equals(user.getAuthApplyYn()))
				{
					return true;
				}
				break;
			case pcMemberUpdateUrl:
				if(!SELLER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			// 회원관리
			case pcUserListUrl :
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;
			case pcUserDetailUrl :
				if(SUPER.equals(user.getUserType()))
				{
					return true;
				}
				break;	
				
			default : 
				break;
		}
//		logger.info("reqUrl :: "+reqUrl);
		
		return false;
	}
	
	
	
	
}
