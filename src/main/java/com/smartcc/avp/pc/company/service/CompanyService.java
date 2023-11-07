package com.smartcc.avp.pc.company.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.company.model.request.CompanyInsertRequest;
import com.smartcc.avp.pc.company.model.request.CompanyListRequest;
import com.smartcc.avp.pc.company.model.request.CompanyUpdateRequest;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;

public interface CompanyService {
	
	public List<CompanyListResponse> getCompanyList(String tableName, CompanyListRequest req)throws Exception;
	
	public List<CompanyListResponse> getCompanyReqList(CompanyListRequest req)throws Exception;
	
	public List<CompanyListResponse> getAllCompanyList(String tableName, CompanyListRequest req)throws Exception;
	
	public int companyInsert(String tableName, CompanyInsertRequest req) throws Exception;
	
	public Company companyDetailPage(String tableName, int companyId) throws Exception;
	
	public Company companyReqDetailPage(int companyId) throws Exception;

	public int	companyUpdate(String tableName, CompanyUpdateRequest req) throws Exception;
	
	public int	companyReqUpdate(CompanyUpdateRequest req) throws Exception;
	
	int companyDelete(String tableName, Integer companyId) throws Exception;
	
	int deleteFromUserId(String tableName, Integer userId) throws Exception;
	
	int getCompanyIdByName(String companyName) throws Exception;
	
	Company getCompanyIntfc(Integer companyId) throws Exception;
	
	int updateCompanyIntfc(Integer capacityAr, Integer companyId);
}
