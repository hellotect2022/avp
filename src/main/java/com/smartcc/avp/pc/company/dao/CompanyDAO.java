package com.smartcc.avp.pc.company.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.company.model.request.CompanyInsertRequest;
import com.smartcc.avp.pc.company.model.request.CompanyListRequest;
import com.smartcc.avp.pc.company.model.request.CompanyUpdateRequest;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;

public interface CompanyDAO {
	
	List<CompanyListResponse> getAllCompanyList(@Param("dbName")String tableName,
							@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName
							) throws Exception;
	
	int getCompanyListCount(@Param("dbName")String tableName,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName
							) throws Exception;

	
	List<CompanyListResponse> getCompanyList(@Param("dbName")String tableName,
							@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName
							) throws Exception;
	
	int getCompanyReqListCount(@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName
							) throws Exception;
	
	List<CompanyListResponse> getCompanyReqList(@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName
							) throws Exception;
	
	int getCompanyListCountForAdmin(@Param("dbName")String tableName,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("userId") Integer userId
							) throws Exception;


	List<CompanyListResponse> getCompanyListForAdmin(@Param("dbName")String tableName,
							@Param("pageInfo") PageInfo pageInfo,
							@Param("period") Period period,
							@Param("searchCategory") String searchCategory,
							@Param("searchName") String searchName,
							@Param("userId") Integer userId
							) throws Exception;


	int companyInsert(@Param("dbName")String tableName, @Param("comInsert")CompanyInsertRequest req);
	
	Company companyDetailPage(@Param("dbName")String tableName, @Param("companyId") int companyId);
	
	Company companyReqDetailPage(@Param("companyId") int companyId);

	int companyUpdate(@Param("dbName")String tableName, @Param("company") CompanyUpdateRequest req);
	
	int companyReqUpdate(@Param("company") CompanyUpdateRequest req);
	
	int companyDelete(@Param("dbName")String tableName, @Param("companyId") Integer companyId) throws Exception;
	
//	public int deleteFromUserId(@Param("userId") Integer userId) throws Exception ;

	int getCompanyIdByName(@Param("companyName") String companyName) throws Exception;
	
	Company getCompanyIntfc(@Param("companyId") Integer companyId) throws Exception;
	
	int updateCompanyIntfc(@Param("capacityAr") Integer capacityAr, @Param("companyId") Integer companyId);
	
}
