package com.smartcc.avp.pc.login.dao;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.model.request.LoginSubRequest;

public interface LoginDAO {

	public User getUserInfo(@Param("req") LoginRequest req);
	public int insertUser(LoginRequest req) throws Exception;
	public int updateUserData(LoginSubRequest req) throws Exception;
	public int updateUser(LoginRequest req) throws Exception;
	public int intfcInsertUser(@Param("accessToken")String accessToken, 
			@Param("snsId")String snsId,
			@Param("snsType")String snsType, 
			@Param("nickName")String nickName,
			@Param("profileImageUrl")	String profileImageUrl, 
			@Param("thumbnailImageUrl")	String thumbnailImageUrl,
			@Param("phone")	String phone
			) throws Exception;
	
	public int intfcUpdateUser(@Param("accessToken")String accessToken, 
							@Param("snsId")String snsId,
							@Param("snsType")String snsType, 
							@Param("nickName")String nickName,
							@Param("profileImageUrl")	String profileImageUrl, 
							@Param("thumbnailImageUrl")	String thumbnailImageUrl,
							@Param("gender")			String gender,
							@Param("email")			String email,
							@Param("userId")	Integer userId,
							@Param("couponOne") String couponOne,
							@Param("couponTwo") String couponTwo,
							@Param("couponThree") String couponThree) throws Exception;
	
	User	getUserInfoFromUserId(@Param("userId")	Integer userId) throws Exception;
	
	public long getAllUserStorage(@Param("ym")	String ym) throws Exception;
	
	public long getSellerUserStorage(@Param("ym") String ym, @Param("companyId") Integer companyId, @Param("groupDbName") String groupDbName) throws Exception;		// Add 2017. 09. 15. JBum | 부가 정보 신청용량 체크(판매자)
	
	public long getAdminUserStorage(@Param("ym") String ym, @Param("companyId") Integer companyId, @Param("groupDbName") String groupDbName) throws Exception;		// Add 2017. 09. 15. JBum | 부가 정보 신청용량 체크(관리자)

	public User getMasterUser(@Param("email") String email, @Param("pwd")String pwd) throws Exception ;
	
	public int updateSecession(@Param("userId")Integer userId) throws Exception ;
	
}
