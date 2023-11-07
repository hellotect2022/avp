package com.smartcc.avp.pc.product.service;

import java.util.List;

import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.product.model.request.ProductInsertRequest;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.request.ProductUpdateRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;

public interface ProductService {

	String getProdList();

	List<ProductListResponse> getProductList(String tableName, ProductListRequest req)throws Exception;
	
	int insertProduct(String tableName, ProductInsertRequest req) throws Exception;
	
	ProductDetailResponse productDetailPage(String tableName, Integer productId)throws Exception;
	
	int	updateProduct(String tableName, ProductUpdateRequest req) throws Exception;	
	
	int	deleteProduct(String tableName, Integer userId, Integer productId) throws Exception;	
	 
	int checkProduct(String tableName, User req,Integer proudctId) throws Exception;
	
	int deleteProductArr(String tableName, List<Integer> list)throws Exception;

	int deleteFromUserId(String tableName, Integer userId) throws Exception;

	
	List<ProductListResponse> getProductListFromShopId(String tableName, Integer shopId)throws Exception;
	
	
	List<String> getBarcodeTypeList() throws Exception;
	
	List<ProductListResponse> getProductListByBranch(String tableName, ProductListRequest req)throws Exception;
}
