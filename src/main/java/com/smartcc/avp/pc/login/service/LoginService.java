package com.smartcc.avp.pc.login.service;

import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.model.request.LoginSubRequest;

public interface LoginService {

	public User getUserInfo(LoginRequest req);
	public int insertUser(LoginRequest req) throws Exception;
	public int updateUserData(LoginSubRequest req) throws Exception;
	public int updateUser(LoginRequest req) throws Exception;
	public int  intfcUpdateUser(String accessToken,
			String snsId,
			String snsType,
			String nickName,
			String profileImageUrl,
			String thumbnailImageUrl,
			String gender,
			String email,
			Integer	userId,
			String couponOne,
			String couponTwo,
			String couponThree
			) throws Exception;
	 public int intfcInsertUser(String accessToken,
				String snsId,
				String snsType,
				String nickName,
				String profileImageUrl,
				String thumbnailImageUrl,
				String phone
				) throws Exception;
	 
	 User getUserInfo(Integer userId)throws Exception;
	 
	 long getAllUserStorage(String ym)throws Exception;
	 
	 long getSellerUserStorage(String ym, Integer companyId, String groupDbName) throws Exception;		// Add 2017. 09. 15. JBum | 부가 정보 신청용량 체크(판매자) 
	 long getAdminUserStorage(String ym, Integer companyId, String groupDbName) throws Exception;		// Add 2017. 09. 15. JBum | 부가 정보 신청용량 체크(관리자)
	 
	 User getMasterUser(String email,String pwd) throws Exception;
 	int updateSecession(Integer userId) throws Exception;

}
