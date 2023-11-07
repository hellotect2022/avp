package com.smartcc.avp.pc.shop.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.dao.FileDAO;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.intfc.model.request.IntfcShopListRequest;
import com.smartcc.avp.intfc.model.request.ShopScoreInsertRequest;
import com.smartcc.avp.intfc.model.response.ShopListFromAddressResponse;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.product.dao.ProductDAO;
import com.smartcc.avp.pc.product.model.Product;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;
import com.smartcc.avp.pc.shop.dao.ShopDAO;
import com.smartcc.avp.pc.shop.model.Shop;
import com.smartcc.avp.pc.shop.model.request.ShopInsertRequest;
import com.smartcc.avp.pc.shop.model.request.ShopListRequest;
import com.smartcc.avp.pc.shop.model.request.ShopUpdateRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;

@Service
public class ShopServiceImpl implements ShopService {
	private static final Logger logger = LoggerFactory.getLogger(ShopServiceImpl.class);
	public static Integer pageLimitSize	=	100;
	
	@Inject ShopDAO shopDAO;

	@Inject FileDAO fileDAO;
	
	@Inject ProductDAO productDAO;
	
	@Value("#{config['s3.bucket']}")
	private String bucketName;	
	public static  String ym = DateUtil.getMonth();
	
	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
		@Value("#{config['schema.chum']}")
		private String chumSchema;
		
		@Value("#{config['schema.scgp']}")
		private String scgpSchema;
		
		@Value("#{config['schema.bogoga']}")
		private String bogogaSchema;
		// End of

	
	@Override
	public List<ShopListResponse> getShopList(String tableName, ShopListRequest req) throws Exception {
		
		List<ShopListResponse> list  =new ArrayList<ShopListResponse>();
		
		logger.info("userType :::::: " + req.getUserType());
				
		/*
		if("ADMIN".equals(req.getUserType()))
		{
			int count = shopDAO.getShopListCountForAdmin(req.getGroupDbName(), req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId());
			list = shopDAO.getShopListForAdmin(req.getGroupDbName(), req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId());
			if(req.getPageInfo() != null){
				req.getPageInfo().setTotalCount(count);
				req.getPageInfo().setResultCount(list.size());
				}
		}
		else if("WORKER".equals(req.getUserType()))
		{
			int count = shopDAO.getShopListCountForSeller(req.getCompanyId());
			list = shopDAO.getShopListForSeller(req.getCompanyId());

			if(req.getPageInfo() != null){
				req.getPageInfo().setTotalCount(count);
				req.getPageInfo().setResultCount(list.size());
				}
		}
		
		else
		{*/

		int count = shopDAO.getShopListCount(req.getGroupDbName(), req.getPeriod(),req.getSearchCategory(),req.getSearchName(), req.getUserId());
		list = shopDAO.getShopList(req.getGroupDbName(), req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(), req.getUserId());
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
		
		//}
			
		return list;
	}

	@Override
	public int insertShop(String tableName, ShopInsertRequest req) throws Exception {
		// TODO Auto-generated method stub
		
		return shopDAO.insertShop(tableName, req);
	}

	@Override
	public int updateShop(String tableName, ShopInsertRequest req) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.updateShop(tableName, req);
	}

	@Override
	public ShopDetailResponse shopDetailPage(String tableName, Integer branchId) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.shopDetailPage(tableName, branchId);
	}

	@Override
	public int shopUpatePageUpdate(String tableName, ShopUpdateRequest req) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.shopUpatePageUpdate(tableName, req);
	}

	@Override
	public List<ShopListResponse> getIntfcShopList(String tableName, IntfcShopListRequest req, String host, String[] urlArray) throws Exception {
		// TODO Auto-generated method stub
		Integer startPageNo;
		
		if(1 < req.getBody().getPageNo())
		{
			startPageNo = req.getBody().getPageNo() * pageLimitSize;
		}
		else
		{
			startPageNo = 0;
		}
		
		return shopDAO.getIntfcShopList(tableName, startPageNo, pageLimitSize, host, urlArray);
	}

	@Override
	public ShopDetailResponse shopIntfcDetailPage(String dbName, Integer shopId,String host,Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.shopIntfcDetailPage(dbName, shopId,host,userId);
	}

	@Override
	public List<Product> getIntfcShopProdList(Integer shopId,String host,Integer pageNo) throws Exception {
		// TODO Auto-generated method stub
		
		Integer startPageNo;
		
		if(1 < pageNo)
		{
			startPageNo = pageNo * pageLimitSize;
		}
		else
		{
			startPageNo = 0;
		}
		
		
		return shopDAO.getIntfcShopProdList(shopId,host,startPageNo,pageLimitSize);
	}

	@Override
	public int insertShopScore(String tableName, Integer userId , Integer shopId, String score) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.insertShopScore(tableName, userId,shopId,score);
	}

	@Override
	public int deleteShop(String tableName, Integer branchId, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.deleteShop(tableName, branchId, userId);	
	}

	@Override
	public List<ShopListResponse> getIntfcSearchShopList(String tableName, String host, String searchName,Integer pageNo) throws Exception {
		Integer startPageNo;
		
//		if(1 < pageNo)
//		{
//			startPageNo = pageNo * pageLimitSize;
//		}
//		else
//		{
			startPageNo = 0;
//		}
		// TODO Auto-generated method stub
		return shopDAO.getIntfcSearchShopList(tableName, host,searchName,startPageNo,pageLimitSize);	
	}

	@Override
	public String getScore(String tableName, Integer shopId,Integer userId) throws Exception {
		// TODO Auto-generated method stub
		
		return shopDAO.getScore(tableName, shopId,userId);	
	}

	@Override
	public int checkProduct(String tableName, User user, Integer shopId) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.checkProduct(tableName, user,shopId);	
	}

	@Override
	public int deleteShopArr(String tableName, List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.deleteShopArr(tableName, list);	
	}

	@Override
	public int deleteFromUserId(String tableName, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ShopListFromAddressResponse> getIntfcShopListFromAddress(String tableName, String searchName) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.getIntfcShopListFromAddress(tableName, searchName);	
	}

	@Override
	public List<ShopListFromAddressResponse> getIntfcShopListFromEventId(String tableName, String searchName) throws Exception {
		// TODO Auto-generated method stub
		return shopDAO.getIntfcShopListFromEventId(tableName, searchName);	
	}
	
	@Override
	@Transactional
	public int webviewDeleteShop(String tableName, Integer userId,Shop req) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> list = new ArrayList<Integer>();
			Integer rdsCnt = 7;
			ShopDetailResponse shop = shopDAO.shopDetailPage(tableName, req.getShopId());
			FileData shopFile = fileDAO.getFile(Integer.parseInt(shop.getShopImageId()));					// Need to split 2017. 09. 14. JBum | String value need to split -> 135,512345,13452,5
			FileData thumbnailFile = fileDAO.getFile(shop.getThumbnailImageId());
			FileData voiceFile = fileDAO.getFile(shop.getVoiceFileId());
			FileData vrFile = fileDAO.getFile(shop.getVrVideoId());
			
			ProductListRequest prodListReq = new ProductListRequest();
			prodListReq.setUserType("ADMIN");
			
			
			prodListReq.setCompanyId(req.getCompanyId());
			List<ProductListResponse> prodList = productDAO.getProductListFromShopId(tableName, req.getShopId());
			logger.info(":::::::::: prodList " + prodList);
			List<Integer>  productIdDelArr = new ArrayList<Integer>();
			List<Integer>  productFileDelArr = new ArrayList<Integer>();
			
			if(null != shopFile)
			{
				rdsCnt = rdsCnt + 1;
				list.add(Integer.parseInt(shop.getShopImageId()));											// Need to split 2017. 09. 14. JBum | String value need to split -> 1246,644236,62,1235
			}
			
			
			if(null != thumbnailFile)
			{
				rdsCnt = rdsCnt + 1;
				list.add(shop.getThumbnailImageId());
			}
			if(null != voiceFile)
			{
				rdsCnt = rdsCnt + 1;
				list.add(shop.getVoiceFileId());
			}
			if(null != vrFile)
			{
				rdsCnt = rdsCnt + 1;
				list.add(shop.getVrVideoId());			
			}
			rdsCnt = rdsCnt + 2;
			
			//if(null != prodList)
			if(prodList.size() > 0)
			{
				for(ProductListResponse prodData : prodList)
				{
					rdsCnt = rdsCnt + 3;
					ProductDetailResponse product = productDAO.productDetailPage(tableName, prodData.getProductId());
					
					productIdDelArr.add(prodData.getProductId());
					FileData prodFile = fileDAO.getFile(product.getProductImageId());
					if(null != prodFile)
					{
						productFileDelArr.add(product.getProductImageId());
					}
				}
				rdsCnt = rdsCnt + 2;
				productDAO.deleteProductArr(tableName, productIdDelArr);
				fileDAO.deleteFileArr(productFileDelArr);
			}
			
			fileDAO.deleteFileArr(list);
//			shopDAO.deleteShop(tableName, req.getShopId());	

		return 0;
	}

	@Override
	public List<ShopListResponse> getShopListFromArr(String tableName, String[] array) throws Exception {
		// TODO Auto-generated method stub
		return 	shopDAO.getShopListFromArr(tableName, array);	
	}

	/*
	 * Add 2017. 09. 19. JBum
	 * 여러 사진 등록용
	 */
	@Override
	public String getFileUrl(String tableName, String host, String imageId) throws Exception {
		// TODO Auto-generated method stub
		return 	shopDAO.getFileUrl(tableName, host, imageId);	
	}
	// End of 2017. 09. 19. JBum
	
	@Override
	public String shopDetailImage(Integer fileId) throws Exception {
		// TODO Auto-generated method stub
		return 	shopDAO.shopDetailImage(fileId);	
	}
	
	@Override
	public boolean isOverlapBranch(String branchName, Integer companyId, Integer branchId) throws Exception {
		int i = shopDAO.isOverlapBranch(branchName, companyId, branchId);
		
		if (i > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}
