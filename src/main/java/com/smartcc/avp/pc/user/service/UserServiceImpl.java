package com.smartcc.avp.pc.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.intfc.model.request.IntfcLoginCheckRequest;
import com.smartcc.avp.intfc.model.request.IntfcTokenSubmitRequest;
import com.smartcc.avp.intfc.model.request.TokenInsertRequest;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyInsert;
import com.smartcc.avp.intfc.model.request.emergency.EmergencyUpdate;
import com.smartcc.avp.intfc.model.request.management.ReqManagement;
import com.smartcc.avp.intfc.model.request.management.ReqManagementDB;
import com.smartcc.avp.intfc.model.response.UserInfoResponse;
import com.smartcc.avp.intfc.model.response.emergency.EmergencyHist;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.user.dao.UserDAO;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.user.model.request.ChangeQuotasRequest;
import com.smartcc.avp.pc.user.model.request.MyInfoUpdateRequest;
import com.smartcc.avp.pc.user.model.request.SecessionListRequest;
import com.smartcc.avp.pc.user.model.request.UserDeleteRequest;
import com.smartcc.avp.pc.user.model.request.UserListRequest;
import com.smartcc.avp.pc.user.model.request.UserUpdateRequest;
import com.smartcc.avp.pc.user.model.response.UserDetailResponse;
import com.smartcc.avp.pc.user.model.response.UserListResponse;


@Service
public class UserServiceImpl implements UserService{
	@Inject	UserDAO	userDAO;
	
	
	@Override
	public List<UserListResponse> getUserList(UserListRequest req) throws Exception {
		// TODO Auto-generated method stub
		
		int count = userDAO.getUserListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		List<UserListResponse> list = userDAO.getUserList(req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
			}
			
		
		return list;
	}


	@Override
	public UserDetailResponse getUserInfo(Integer userId, String tableName) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUserInfo(userId, tableName);
	}


	@Override
	public int delUser(UserDeleteRequest req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.delUser(req);
	}


	@Override
	public List<UserListResponse> getSecessionList(SecessionListRequest req) throws Exception {
		// TODO Auto-generated method stub
		
		int count = userDAO.getSecessionListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		List<UserListResponse> list = userDAO.getSecessionList(req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName());
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
			}
			
		
		return list;
	}


	@Override
	public int updateMyInfo(MyInfoUpdateRequest req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.updateMyInfo(req.getUserId(),req.getEmail(),req.getPhone());
	}

	@Override
	public int updateSecession(UserUpdateRequest req) throws Exception {
		return userDAO.updateSecession(req.getUpdateId(), req.getRestoreId(), req.getDelYn());
	}
	
	@Override																							// *>-- Add. 2017. 05. 18. JBum
	public int updateQuotas(ChangeQuotasRequest req) throws Exception {									// *>-- Add. 2017. 05. 18. JBum
		// TODO Auto-generated method stub																// *>-- Add. 2017. 05. 18. JBum
		return userDAO.updateQuotas(req.getUserId(), req.getStorageSize());								// *>-- Add. 2017. 05. 18. JBum
	}																									// *>-- Add. 2017. 05. 18. JBum
	
	@Override
	public int requestQuotas(ChangeQuotasRequest req) throws Exception {
		return userDAO.requestQuotas(req.getUserId(), req.getStorageSize());
	}
	
	@Override
	public int getRequestQuotasCount(ChangeQuotasRequest req) throws Exception {
		return userDAO.getRequestQuotasCount(req.getUserId());
	}
	
	@Override																							// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
	public String getUserQuotas(ChangeQuotasRequest req) throws Exception {								// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
		// TODO Auto-generated method stub																// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
		return userDAO.getUserQuotas(req.getUserId(), req.getStorageSize());							// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
	}																									// *>-- Add. 2017. 05. 24. JBum | 변경 후 사용량 조회를 위해 추가
	
	/**
	 * Add. 2018. 10. 11. JBum
	 * DB 스키마 별 User 목록 조회
	 */
	@Override
	public List<UserListResponse> getUserListByDB(String tableName, String userType) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUserListByDB(tableName, userType);
	}
	
	/**
	 * Add. 2018. 10. 12. JBum
	 * Client token submit
	 */
	@Override
	public int updateUserToken(String tableName, TokenInsertRequest req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.updateUserToken(tableName, req);
	}
	
	/**
	 * Add. 2018. 10. 12. JBum
	 * Get client info
	 */
	@Override
	public User getUserInfoByPhone(String tableName, String userType, String phoneNumber) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUserInfoByPhone(tableName, userType, phoneNumber);
	}
	
	@Override
	public int insertEmergency(String tableName, EmergencyInsert req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.insertEmergency(tableName, req);
	}
	
	@Override
	public int selectEmergency(String tableName, EmergencyInsert req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.selectEmergency(tableName, req);
	}
	
	@Override
	public int updateEmergency(String tableName, EmergencyUpdate req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.updateEmergency(tableName, req);
	}
	
	@Override
	public EmergencyHist getEmergencyHist(String tableName, EmergencyInsert req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getEmergencyHist(tableName, req);
	}
	
	@Override
	public List<EmergencyHist> getEmergencyHistAll(String tableName) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getEmergencyHistAll(tableName);
	}
	
	@Override
	public int insertManagement(String tableName, ReqManagementDB req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.insertManagement(tableName, req);
	}
	
	@Override
	public int updateManagement(String tableName, ReqManagementDB req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.updateManagement(tableName, req);
	}
	
	@Override
	public int deleteManagement(String tableName, ReqManagementDB req) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.deleteManagement(tableName, req);
	}
	
	@Override
	public int selectUserByPhone(String tableName, String phoneNumber, String userType) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.selectUserByPhone(tableName, phoneNumber, userType);
	}
	
	@Override
	public int selectUserByPhoneNumber(String tableName, String phoneNumber, String userType) throws Exception {
		return userDAO.selectUserByPhoneNumber(tableName, phoneNumber, userType);
	}
	
	@Override
	public int selectAdminUser(String tableName) throws Exception{
		return userDAO.selectAdminUser(tableName);
	}
}
