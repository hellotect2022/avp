package com.smartcc.avp.pc.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.product.model.request.ProductInsertRequest;
import com.smartcc.avp.pc.product.model.request.ProductUpdateRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;

public interface ProductDAO {

	String getProdList();
	int getProductListCount(@Param("dbName")String tableName,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("userId") Integer userId,
			@Param("userType") String userType,
			@Param("companyId") Integer companyId
			) throws Exception;


	List<ProductListResponse> getProductList(@Param("dbName")String tableName,
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("userId") Integer userId,
								@Param("userType") String userType,
								@Param("companyId") Integer companyId
							) throws Exception;
	
	int getProductListCountForAdmin(@Param("dbName")String tableName,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId
			) throws Exception;


	List<ProductListResponse> getProductListForAdmin(@Param("dbName")String tableName,
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("companyId") Integer companyId
							) throws Exception;
	
	
	int getProductListCountForSeller(@Param("dbName")String tableName,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("userId") Integer userId
			) throws Exception;


	List<ProductListResponse> getProductListForSeller(@Param("dbName")String tableName,
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("userId") Integer userId
							) throws Exception;
	
	
	 int insertProduct(@Param("dbName")String tableName, @Param("itemInsert")ProductInsertRequest req) throws Exception;

	ProductDetailResponse productDetailPage(@Param("dbName")String tableName, @Param("productId")Integer productId) throws Exception;

	int updateProduct(@Param("dbName")String tableName, @Param("prodUpdate")ProductUpdateRequest req) throws Exception;

	public int deleteProduct(@Param("dbName")String tableName, @Param("userId") Integer userId, @Param("productId") Integer productId) throws Exception ;
	
	int	checkProductFromAdmin(@Param("dbName")String tableName, @Param("companyId")Integer companyId,@Param("productId")Integer productId)throws Exception ;
		
	int	checkProductFromSeller(@Param("dbName")String tableName, @Param("userId")Integer userId,@Param("productId")Integer productId)throws Exception ;
	
	public int deleteProductArr(@Param("dbName")String tableName, @Param("list") List<Integer> list) throws Exception;
	
	List<ProductListResponse> getProductListFromShopId(@Param("dbName")String tableName, @Param("shopId") Integer shopId)throws Exception;

	List<String> getBarcodeTypeList() throws Exception;
	
	int getProductListByBranchCount(
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId
			) throws Exception;
	
	List<ProductListResponse> getProductListByBranch(
			@Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId
		) throws Exception;
	
}
