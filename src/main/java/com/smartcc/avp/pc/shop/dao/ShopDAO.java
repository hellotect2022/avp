package com.smartcc.avp.pc.shop.dao;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.intfc.model.response.ShopListFromAddressResponse;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.product.model.Product;
import com.smartcc.avp.pc.shop.model.request.ShopInsertRequest;
import com.smartcc.avp.pc.shop.model.request.ShopUpdateRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;

public interface ShopDAO {
	
	
	int getShopListCount(@Param("dbName")String tableName,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("userId") Integer userId
							) throws Exception;


	List<ShopListResponse> getShopList(@Param("dbName")String tableName,
							@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("userId") Integer userId
							) throws Exception;
	
	int getShopListCountForSeller(@Param("companyId")Integer companyId
							) throws Exception;


	List<ShopListResponse> getShopListForSeller(@Param("companyId")Integer companyId
							) throws Exception;

	int getShopListCountForAdmin(@Param("dbName")String tableName,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("companyId") Integer companyId
							) throws Exception;


	List<ShopListResponse> getShopListForAdmin(@Param("dbName")String tableName,
							@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("companyId") Integer companyId
							) throws Exception;

	

	int insertShop(@Param("dbName")String tableName, 
							@Param("shopInsert")ShopInsertRequest req
							) throws Exception;

	int updateShop(@Param("dbName")String tableName, 
							@Param("shopInsert")ShopInsertRequest req
							) throws Exception;
	
	ShopDetailResponse shopDetailPage(@Param("dbName")String tableName, 
							@Param("branchId") Integer shopId
							) throws Exception;

	int shopUpatePageUpdate(@Param("dbName")String tableName, 
							@Param("branchUpdate")ShopUpdateRequest req
							) throws Exception;
	
	List<ShopListResponse> getIntfcShopList(@Param("dbName") String tableName,
							@Param("startRowNum") Integer startRow , 
							@Param("size") Integer size,
							@Param("host") String host,
							@Param("list") String[] urlArray
							) throws Exception ;

	ShopDetailResponse shopIntfcDetailPage(
							@Param("dbName") String dbName,
							@Param("shopId") Integer shopId,
							@Param("host") String host,
							@Param("userId") Integer userId
							) throws Exception;

	List<Product> getIntfcShopProdList(
							@Param("shopId")Integer shopId,
							@Param("host") String host,
							@Param("startRowNum") Integer startRow,
							@Param("size") Integer size
							) throws Exception ;

	int insertShopScore(@Param("dbName")String tableName, 
							@Param("userId")Integer userId,
							@Param("shopId")Integer shopId,
							@Param("score") String score
							) throws Exception;

	public int deleteShop(@Param("dbName")String tableName, 
							@Param("branchId")Integer branchId,
							@Param("userId") Integer userId
							) throws Exception;

	public List<ShopListResponse> getIntfcSearchShopList(
							@Param("dbName") String dbName,
							@Param("host") String host, 
							@Param("searchName") String searchName,
							@Param("startRowNum") Integer startRow, 
							@Param("size") Integer size
							) throws Exception;

	public String getScore(@Param("dbName")String tableName, 
							@Param("shopId")Integer shopId,
							@Param("userId")Integer userId
							) throws Exception ;

	int checkProduct(@Param("dbName")String tableName,
							@Param("user")User user,
							@Param("shopId")Integer shopId
							) throws Exception ;
	
	int deleteShopArr(@Param("dbName")String tableName,
							@Param("list") List<Integer> list
							) throws Exception;

	List<ShopListFromAddressResponse> getIntfcShopListFromAddress(
							@Param("dbName") String dbName,
							@Param("searchName") String searchName
							) throws Exception ;
	
	List<ShopListFromAddressResponse> getIntfcShopListFromEventId(
							@Param("dbName") String dbName,
							@Param("serachName") String searchName
							) throws Exception;
	
	List<ShopListResponse> getShopListFromArr(@Param("dbName")String tableName, 
							@Param("list")String[] array
							) throws Exception;
	
	String getFileUrl(
				@Param("dbName") String dbName,
				@Param("host") String host,
				@Param("imageId") String imageId
			) throws Exception;
	
	String shopDetailImage(
				@Param("fileId") Integer fileId
			) throws Exception;
	
	int isOverlapBranch(@Param("branchName") String branchName, @Param("companyId") Integer companyId, @Param("branchId") Integer branchId) throws Exception;
	
}
