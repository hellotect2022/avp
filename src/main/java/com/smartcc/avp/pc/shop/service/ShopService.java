package com.smartcc.avp.pc.shop.service;

import java.math.BigDecimal;
import java.util.List;

import org.apache.poi.openxml4j.util.Nullable;

import com.smartcc.avp.intfc.model.request.IntfcShopListRequest;
import com.smartcc.avp.intfc.model.request.ShopScoreInsertRequest;
import com.smartcc.avp.intfc.model.response.ShopListFromAddressResponse;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.product.model.Product;
import com.smartcc.avp.pc.shop.model.Shop;
import com.smartcc.avp.pc.shop.model.request.ShopInsertRequest;
import com.smartcc.avp.pc.shop.model.request.ShopListRequest;
import com.smartcc.avp.pc.shop.model.request.ShopUpdateRequest;
import com.smartcc.avp.pc.shop.model.response.ShopDetailResponse;
import com.smartcc.avp.pc.shop.model.response.ShopListResponse;

public interface ShopService {

	public List<ShopListResponse> getShopList(String tableName, ShopListRequest req) throws Exception;

	int insertShop(String tableName, ShopInsertRequest req) throws Exception;

	ShopDetailResponse shopDetailPage(String tableName, Integer branchId) throws Exception;
	
	int updateShop(String tableName, ShopInsertRequest req) throws Exception;
	
	int shopUpatePageUpdate(String tableName, ShopUpdateRequest req) throws Exception;

	List<ShopListResponse>	getIntfcShopList(String tableName, IntfcShopListRequest req ,String host, String[] urlArray)throws Exception;		
	List<ShopListResponse>	getIntfcSearchShopList(String tableName, String host,String searchName,Integer pageNo)throws Exception;		
	List<ShopListFromAddressResponse>	getIntfcShopListFromAddress(String tableName, String searchName)throws Exception;
	List<ShopListFromAddressResponse>	getIntfcShopListFromEventId(String tableName, String searchName)throws Exception;
	ShopDetailResponse shopIntfcDetailPage(String dbName, Integer shopId,String host,Integer userId) throws Exception;		

	List<Product> getIntfcShopProdList(Integer shopId,String host,Integer pageNo) throws Exception;		
	
    int insertShopScore(String tableName, Integer userId , Integer shopId, String score) throws Exception;	

	int deleteShop(String tableName, Integer branchId, Integer userId) throws Exception;
	
	String	getScore(String tableName, Integer shopId,Integer userId) throws Exception;
	
	int checkProduct(String tableName, User user,Integer shopId)throws Exception;
	int deleteShopArr(String tableName, List<Integer> list)throws Exception;

	int deleteFromUserId(String tableName, Integer userId) throws Exception;
	int webviewDeleteShop(String tableName, Integer userId ,Shop req) throws Exception;
	
	List<ShopListResponse> getShopListFromArr(String tableName, String[] array) throws Exception;
	
	String getFileUrl(String tableName, String host, String imageId) throws Exception; // Add 2017. 09. 19. JBum | 여러 사진 등록용
	
	String shopDetailImage(Integer fileId) throws Exception;
	
	boolean isOverlapBranch(String branchName, Integer companyId, Integer branchId) throws Exception;
	
}
