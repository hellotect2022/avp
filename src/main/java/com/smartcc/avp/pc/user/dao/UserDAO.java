package com.smartcc.avp.pc.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest;
import com.smartcc.avp.intfc.model.request.IntfcTokenSubmitRequest;
import com.smartcc.avp.intfc.model.request.TokenInsertRequest;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyInsert;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyUpdate;
import com.smartcc.avp.intfc.model.request.management.ReqManagement;
import com.smartcc.avp.intfc.model.request.management.ReqManagementDB;
import com.smartcc.avp.intfc.model.response.UserInfoResponse;
import com.smartcc.avp.intfc.model.response.emergency.EmergencyHist;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.user.model.request.ChangeQuotasRequest;
import com.smartcc.avp.pc.user.model.request.SecessionListRequest;
import com.smartcc.avp.pc.user.model.request.UserDeleteRequest;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;

public interface UserDAO {

	
	int getUserListCount(@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName) throws Exception;


	List<UserListResponse> getUserList(@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName) throws Exception;
	
	
	UserDetailResponse getUserInfo(@Param("userId") Integer userId, @Param("dbName") String dbName) throws Exception;

	public int delUser(UserDeleteRequest req) throws Exception ;

	
	int getSecessionListCount(							  @Param("period") Period period,
							  @Param("searchCategory") String searchCategory,
							  @Param("searchName") String searchName) throws Exception;


	List<UserListResponse> getSecessionList(
								
								@Param("pageInfo") PageInfo pageInfo,
								@Param("period") Period period,
								@Param("searchCategory") String searchCategory,
								@Param("searchName") String searchName) throws Exception;

	
	int updateMyInfo(@Param("userId") Integer userId,
								@Param("email") String email,
								@Param("phone") String phone) throws Exception;
	
	int updateSecession(@Param("userId") Integer userId,
						@Param("restoreId") Integer restoreId,
						@Param("delYn") String delYn) throws Exception;
	
	int updateQuotas(@Param("userId") Integer userId,												// *>-- Add. 2017. 05. 18. JBum
						@Param("storageSize") String storageSize) throws Exception;					// *>-- Add. 2017. 05. 18. JBum
	
	int requestQuotas(@Param("userId") Integer userId,
						@Param("storageSize") String storageSize) throws Exception;
	
	int getRequestQuotasCount(@Param("userId") Integer userId) throws Exception;
	
	String getUserQuotas(@Param("userId") Integer userId,											// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
						@Param("storageSize") String storageSize) throws Exception;					// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가

	List<UserListResponse> getUserListByDB(@Param("dbName")String dbName, @Param("userType")String userType) throws Exception;				// *>-- Add. 2018. 10. 11. JBum | DB 스키마 별 User 목록 조회
	
	int updateUserToken(									// *>-- Add. 2018. 10. 12. JBum | client token submit
			@Param("dbName")String dbName,
			@Param("req")TokenInsertRequest req
			) throws Exception;
	
	User getUserInfoByPhone(					// *>-- Add. 2018. 10. 12. JBum | get client info
			@Param("dbName")String dbName,
			@Param("userType")String userType,
			@Param("phoneNumber")String phoneNumber
			) throws Exception;
	
	int insertEmergency(
			@Param("dbName")String dbName,
			@Param("req")EmergencyInsert req
			) throws Exception;
	
	int selectEmergency(
			@Param("dbName")String dbName,
			@Param("req")EmergencyInsert req
			) throws Exception;
	
	int updateEmergency(
			@Param("dbName")String dbName,
			@Param("req")EmergencyUpdate req
			) throws Exception;
	
	EmergencyHist getEmergencyHist(
			@Param("dbName")String dbName,
			@Param("req")EmergencyInsert req
			) throws Exception;
	
	List<EmergencyHist> getEmergencyHistAll(
			@Param("dbName")String dbName
			) throws Exception;
	
	int insertManagement(@Param("dbName")String dbName, @Param("req")ReqManagementDB req) throws Exception;
	int updateManagement(@Param("dbName")String dbName, @Param("req")ReqManagementDB req) throws Exception;
	int deleteManagement(@Param("dbName")String dbName, @Param("req")ReqManagementDB req) throws Exception;
	int selectUserByPhone(@Param("dbName")String dbName, @Param("phone")String phoneNumber, @Param("userType")String userType) throws Exception;
	int selectUserByPhoneNumber(@Param("dbName")String dbName, @Param("phone")String phoneNumber, @Param("userType")String userType) throws Exception;
	int selectAdminUser(@Param("dbName")String dbName);
}
