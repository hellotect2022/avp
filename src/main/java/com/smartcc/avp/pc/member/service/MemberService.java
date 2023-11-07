package com.smartcc.avp.pc.member.service;

import java.util.List;

import com.smartcc.avp.pc.member.model.request.MemberListRequest;
import com.smartcc.avp.pc.member.model.response.MemberListResponse;

public interface MemberService {


	List<MemberListResponse> getMemberList(MemberListRequest req)throws Exception;
	
	
	
	List<MemberListResponse> getMemberApplyList(MemberListRequest req)throws Exception;
	
	List<MemberListResponse> getMemberAuthApplyList(MemberListRequest req)throws Exception;
	
	int memberAuthUpdate(Integer userId,String memberViewAuth,String shopUpdateAuth,String productUpdateAuth, String secessionYn)throws Exception;
	
	int memberAppplyUpdate(Integer userId,Integer confirmUserId)throws Exception;
	
	int memberDelete(Integer userId, Integer delId)throws Exception;
}
