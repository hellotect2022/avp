package com.smartcc.avp.pc.product.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.product.dao.ProductDAO;
import com.smartcc.avp.pc.product.model.request.ProductInsertRequest;
import com.smartcc.avp.pc.product.model.request.ProductListRequest;
import com.smartcc.avp.pc.product.model.request.ProductUpdateRequest;
import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;

@Service
public class ProductServiceImpl  implements ProductService{

	
	@Inject ProductDAO productDAO;

	@Override
	public String getProdList() {
		// TODO Auto-generated method stub
		return productDAO.getProdList();
	}

	@Override
	public List<ProductListResponse> getProductList(String tableName, ProductListRequest req) throws Exception {
		
		List<ProductListResponse> list  =new ArrayList<ProductListResponse>();
		if("ADMIN".equals(req.getUserType()))
		{
			int count = productDAO.getProductListCountForAdmin(tableName, req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId());
			list = productDAO.getProductListForAdmin(tableName, req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId());
			if(req.getPageInfo() != null){
				req.getPageInfo().setTotalCount(count);
				req.getPageInfo().setResultCount(list.size());
				}
		}
		else if("WORKER".equals(req.getUserType()))
		{
			int count = productDAO.getProductListCountForSeller(tableName, req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getUserId());
			list = productDAO.getProductListForSeller(tableName, req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getUserId());
			if(req.getPageInfo() != null){
				req.getPageInfo().setTotalCount(count);
				req.getPageInfo().setResultCount(list.size());
				}
		}
		else
		{
			int count = productDAO.getProductListCount(tableName, req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getUserId(),req.getUserType(),req.getCompanyId());
			list = productDAO.getProductList(tableName, req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getUserId(),req.getUserType(),req.getCompanyId());
			if(req.getPageInfo() != null){
				req.getPageInfo().setTotalCount(count);
				req.getPageInfo().setResultCount(list.size());
			}
		}
			
		return list;
	}

	@Override
	public int insertProduct(String tableName, ProductInsertRequest req) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.insertProduct(tableName, req);
	}

	@Override
	public ProductDetailResponse productDetailPage(String tableName, Integer productId) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.productDetailPage(tableName, productId);
	}

	@Override
	public int updateProduct(String tableName, ProductUpdateRequest req) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.updateProduct(tableName, req);
	}

	@Override
	public int deleteProduct(String tableName, Integer userId, Integer productId) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.deleteProduct(tableName, userId, productId);
	}

	@Override
	public int checkProduct(String tableName, User req,Integer productId) throws Exception {
		int cnt = 0;
		// admin 이면
		if(CommonCode.USER_TYPE.ADMIN.code.equals(req.getUserType()))
		{
			cnt =productDAO.checkProductFromAdmin(tableName, req.getCompanyId(),productId);
		}
		else if(CommonCode.USER_TYPE.SELLER.code.equals(req.getUserType()))
		{
			cnt =productDAO.checkProductFromSeller(tableName, req.getUserId(),productId);
		}else if(CommonCode.USER_TYPE.SUPER.code.equals(req.getUserType()))
		{
			cnt = 1;
		}
		// TODO Auto-generated method stub
		return cnt;
	}

	@Override
	public int deleteProductArr(String tableName, List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.deleteProductArr(tableName, list);
	}

	@Override
	public int deleteFromUserId(String tableName, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductListResponse> getProductListFromShopId(String tableName, Integer shopId) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.getProductListFromShopId(tableName, shopId);
	}
	
	@Override
	public List<String> getBarcodeTypeList() throws Exception {
		// TODO Auto-generated method stub
		return productDAO.getBarcodeTypeList();
	}
	
	@Override
	public List<ProductListResponse> getProductListByBranch(String tableName, ProductListRequest req) throws Exception {
		
		List<ProductListResponse> list  =new ArrayList<ProductListResponse>();

		int count = productDAO.getProductListByBranchCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(), req.getBranchId());
		list = productDAO.getProductListByBranch(req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(), req.getBranchId());
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
			
		return list;
	}
}
