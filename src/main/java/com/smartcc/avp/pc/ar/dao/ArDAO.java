package com.smartcc.avp.pc.ar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.intfc.model.request.ar.IntfcArRequest;
import com.smartcc.avp.pc.ar.model.ArInfo;
import com.smartcc.avp.pc.ar.model.request.ArUpdatePageRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.product.FileDTO;

public interface ArDAO {

	int insertAr(@Param("dbName") String tableName, @Param("arInfo") ArInfo dto) throws Exception;

	int getArListCount(@Param("dbName") String tableName, @Param("period") Period period,
			@Param("searchCategory") String searchCategory, @Param("searchName") String searchName) throws Exception;

	List<ArListResponse> getArList(@Param("dbName") String tableName, @Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period, @Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName) throws Exception;

	int getArListCountForAdmin(@Param("dbName") String tableName, @Param("period") Period period,
			@Param("searchCategory") String searchCategory, @Param("searchName") String searchName,
			@Param("companyId") Integer companyId) throws Exception;

	List<ArListResponse> getArListForAdmin(@Param("dbName") String tableName, @Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period, @Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName, @Param("companyId") Integer companyId) throws Exception;

	int getArListCountForSeller(@Param("dbName") String tableName, @Param("period") Period period,
			@Param("searchCategory") String searchCategory, @Param("searchName") String searchName,
			@Param("userId") Integer userId) throws Exception;

	List<ArListResponse> getArListForSeller(@Param("dbName") String tableName, @Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period, @Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName, @Param("userId") Integer userId) throws Exception;

	ArInfo arDetailPage(@Param("dbName") String tableName, @Param("arId") int arId) throws Exception;

	ArInfo arDetailPageNew(@Param("dbName") String tableName, @Param("arId") int arId) throws Exception;

	int updateAr(@Param("dbName") String tableName, @Param("arUpdate") ArUpdatePageRequest req) throws Exception;
//	int updateArNew(@Param("dbName") String tableName, @Param("arInfo") ArInfo dto) throws Exception;

	public int deleteAr(@Param("dbName") String tableName, @Param("arId") Integer arId, @Param("userId") Integer userId) throws Exception;

	int checkArFromAdmin(@Param("dbName") String tableName, @Param("companyId") Integer companyId,
			@Param("arId") Integer arId) throws Exception;

	int checkArFromSeller(@Param("dbName") String tableName, @Param("userId") Integer userId,
			@Param("arId") Integer arId) throws Exception;

	public int deleteArArr(@Param("dbName") String tableName, @Param("list") List<Integer> list) throws Exception;

	
	int insertArCount(@Param("insertArCount") IntfcArRequest req) throws Exception;
	
	int getArCount(@Param("companyId") Integer companyId) throws Exception;
	
}
