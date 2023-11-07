package com.smartcc.avp.pc.user.service;

import java.util.List;

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
import com.smartcc.avp.pc.user.model.request.MyInfoUpdateRequest;
import com.smartcc.avp.pc.user.model.request.SecessionListRequest;
import com.smartcc.avp.pc.user.model.request.UserDeleteRequest;
import com.smartcc.avp.pc.user.model.request.UserListRequest;
import com.smartcc.avp.pc.user.model.request.UserUpdateRequest;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;

public interface UserService {

	List<UserListResponse>  getUserList(UserListRequest req)throws Exception;

	UserDetailResponse 		getUserInfo(Integer userId, String tableName)throws Exception;
	
	int delUser(UserDeleteRequest req)throws Exception;

	List<UserListResponse>  getSecessionList(SecessionListRequest req) throws Exception;

	int updateMyInfo(MyInfoUpdateRequest  req)throws Exception;
	
	int updateSecession(UserUpdateRequest req) throws Exception;
	
	int updateQuotas(ChangeQuotasRequest req) throws Exception;			// *>-- Add. 2017. 05. 18. JBum
	
	int requestQuotas(ChangeQuotasRequest req) throws Exception;
	
	int getRequestQuotasCount(ChangeQuotasRequest req) throws Exception;
	
	String getUserQuotas(ChangeQuotasRequest req) throws Exception;		// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
	
	List<UserListResponse> getUserListByDB(String tableName, String userType) throws Exception;		//	*>-- Add. 2018. 10. 11. JBum | DB 스키마 별 User 목록 조회
	
	int updateUserToken(			// *>-- Add. 2018. 10. 12. JBum | Client Token Submit
			String tableName,
			TokenInsertRequest req
			) throws Exception;
	
	User getUserInfoByPhone(String tableName, String userType, String phoneNumber) throws Exception;	// *>-- Add. 2018. 10. 12. JBum | Get client info
	
	int insertEmergency(String tableName, EmergencyInsert req) throws Exception;
	
	int selectEmergency(String tableName, EmergencyInsert req) throws Exception;	
	
	int updateEmergency(String tableName, EmergencyUpdate req) throws Exception;
	
	EmergencyHist getEmergencyHist(String tableName, EmergencyInsert req) throws Exception;
	
	List<EmergencyHist> getEmergencyHistAll(String tableName) throws Exception;
	
	int insertManagement(String tableName, ReqManagementDB req) throws Exception;
	
	int updateManagement(String tableName, ReqManagementDB req) throws Exception;
	
	int deleteManagement(String tableName, ReqManagementDB req) throws Exception;
	
	int selectUserByPhone(String tableName, String phoneNumber, String userType) throws Exception;
	
	int selectUserByPhoneNumber(String tableName, String phoneNumber, String userType) throws Exception;
	
	int selectAdminUser(String tableName) throws Exception;
}
