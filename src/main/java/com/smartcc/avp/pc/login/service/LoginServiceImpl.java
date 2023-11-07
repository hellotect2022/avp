package com.smartcc.avp.pc.login.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.login.dao.LoginDAO;
import com.smartcc.avp.pc.login.model.LoginRequest;
import com.smartcc.avp.pc.login.model.request.LoginSubRequest;
import com.smartcc.avp.pc.product.dao.ProductDAO;

@Service
public class LoginServiceImpl implements LoginService {

	
	@Inject LoginDAO loginDAO;

	@Override
	public User getUserInfo(LoginRequest req) {
		// TODO Auto-generated method stub
		return loginDAO.getUserInfo(req);
	}

	@Override
	public int insertUser(LoginRequest req) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.insertUser(req);
	}

	@Override
	public int updateUserData(LoginSubRequest req) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.updateUserData(req);
	}

	@Override
	public int updateUser(LoginRequest req) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.updateUser(req);
	}

	@Override
	public int intfcInsertUser(String accessToken, String snsId, String snsType, String nickName,
			String profileImageUrl, String thumbnailImageUrl,String phone) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.intfcInsertUser(accessToken,snsId,snsType,nickName,profileImageUrl,thumbnailImageUrl,phone);
	}

	@Override
	public int intfcUpdateUser(String accessToken, String snsId, String snsType, String nickName,
			String profileImageUrl, String thumbnailImageUrl,String gender, String email,Integer userId, String couponOne, String couponTwo, String couponThree) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.intfcUpdateUser(accessToken,snsId,snsType,nickName,profileImageUrl,thumbnailImageUrl,gender,email,userId,couponOne, couponTwo, couponThree);
	}

	@Override
	public User getUserInfo(Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getUserInfoFromUserId(userId);
	}

	@Override
	public long getAllUserStorage(String ym) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getAllUserStorage(ym);
	}
	/*
	 * Add 2017. 09. 15. JBum
	 * 부가 정보 신청용량 체크(판매자)
	 */
	@Override
	public long getSellerUserStorage(String ym, Integer companyId, String groupDbName) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getSellerUserStorage(ym, companyId, groupDbName);
	}
	/*
	 * Add 2017. 09. 15. JBum
	 * 부가 정보 신청용량 체크(관리자)
	 */
	@Override
	public long getAdminUserStorage(String ym, Integer companyId, String groupDbName) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getAdminUserStorage(ym, companyId, groupDbName);
	}

	@Override
	public User getMasterUser(String email, String pwd) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getMasterUser(email,pwd);
	}

	@Override
	public int updateSecession(Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.updateSecession(userId);
	}


	
}
