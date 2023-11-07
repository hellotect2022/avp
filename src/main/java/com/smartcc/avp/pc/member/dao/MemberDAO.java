package com.smartcc.avp.pc.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.pc.member.model.response.MemberListResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;

public interface MemberDAO {


	int getMemberListCount(@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId
			) throws Exception;


	List<MemberListResponse> getMemberList(
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("companyId") Integer companyId,
								@Param("userId") Integer userId) throws Exception;
	
	int getMemberApplyListCount(@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("companyId") Integer companyId,
								@Param("userType") String userType) throws Exception;

	int getMemberApplyListCountForAdmin(@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("userType") String userType) throws Exception;	

	List<MemberListResponse> getMemberApplyList(
								@Param("dbName") String dbName,
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("companyId") Integer companyId,
								@Param("userType") String userType) throws Exception;
	
	List<MemberListResponse> getMemberApplyListForAdmin(
			@Param("dbName") String dbName,
			@Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("userType") String userType) throws Exception;
	
	
	int memberAuthUpdate(@Param("userId") Integer userId, 
						@Param("memberViewAuth") String memberViewAuth, 
						@Param("shopUpdateAuth") String shopUpdateAuth, 
						@Param("productUpdateAuth") String productUpdateAuth ,
						@Param("authApplyYn") String authApplyYn) throws Exception;
	
	int memberAppplyUpdate(@Param("userId") Integer userId, @Param("confirmUserId") Integer confirmUserId) throws Exception ;

	

	int getMemberAuthApplyListCount(@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("userType") String userType
			) throws Exception;


	List<MemberListResponse> getMemberAuthApplyList(
								@Param("dbName") String dbName,
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName,
								@Param("companyId") Integer companyId,
								@Param("userType") String userType) throws Exception;
	
	int memberDelete(@Param("userId") Integer userId, @Param("delId") Integer delId) throws Exception;
	
}
