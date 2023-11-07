package com.smartcc.avp.pc.company.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.company.dao.CompanyDAO;
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.company.model.request.CompanyInsertRequest;
import com.smartcc.avp.pc.company.model.request.CompanyListRequest;
import com.smartcc.avp.pc.company.model.request.CompanyUpdateRequest;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;

@Service
public class CompanyServiceImpl implements CompanyService {

	@Inject CompanyDAO companyDAO;
	
	@Override
	public List<CompanyListResponse> getAllCompanyList(String tableName, CompanyListRequest req) throws Exception {
		return companyDAO.getAllCompanyList(req.getGroupDbName(), req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName());
	}
	
	@Override
	public List<CompanyListResponse> getCompanyList(String tableName, CompanyListRequest req) throws Exception{
		List<CompanyListResponse> list  =new ArrayList<CompanyListResponse>();
			
		int count = companyDAO.getCompanyListCount(tableName, req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		list = companyDAO.getCompanyList(tableName, req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName());
			
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
		
		return list;
	}

	@Override
	public List<CompanyListResponse> getCompanyReqList(CompanyListRequest req) throws Exception{
		List<CompanyListResponse> list  =new ArrayList<CompanyListResponse>();
			
		int count = companyDAO.getCompanyReqListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		list = companyDAO.getCompanyReqList(req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName());
			
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
		
		return list;
	}
	
	@Override
	public int companyInsert(String tableName, CompanyInsertRequest req) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyInsert(tableName, req);
	}

	@Override
	public Company companyDetailPage(String tableName, int companyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyDetailPage(tableName, companyId);
	}
	
	@Override
	public Company companyReqDetailPage(int companyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyReqDetailPage(companyId);
	}

	@Override
	public int companyUpdate(String tableName, CompanyUpdateRequest req) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyUpdate(tableName, req);
	}
	
	@Override
	public int companyReqUpdate(CompanyUpdateRequest req) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyReqUpdate(req);
	}

	@Override
	public int companyDelete(String tableName, Integer companyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.companyDelete(tableName, companyId);
	}

	@Override
	public int deleteFromUserId(String tableName, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getCompanyIdByName(String companyName) throws Exception {
		return companyDAO.getCompanyIdByName(companyName);
	}

	@Override
	public Company getCompanyIntfc(Integer companyId) throws Exception {
		// TODO Auto-generated method stub
		return companyDAO.getCompanyIntfc(companyId);
	}

	@Override
	public int updateCompanyIntfc(Integer capacityAr, Integer companyId) {
		// TODO Auto-generated method stub
		return companyDAO.updateCompanyIntfc(capacityAr, companyId);
	}
	
}
