package com.smartcc.avp.pc.member.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.member.dao.MemberDAO;
import com.smartcc.avp.pc.member.model.request.MemberListRequest;
import com.smartcc.avp.pc.member.model.response.MemberListResponse;

@Service
public class MemberServiceImpl implements  MemberService{

	@Inject MemberDAO	memberDAO;

	@Override
	public List<MemberListResponse> getMemberList(MemberListRequest req) throws Exception {
		int count = memberDAO.getMemberListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId());
		List<MemberListResponse> list = memberDAO.getMemberList(req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserId());
		
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
			}
			
		return list;
	}

	@Override
	public int memberAuthUpdate(Integer userId, String memberViewAuth, String shopUpdateAuth, String productUpdateAuth,String secessionYn)
			throws Exception {
		// TODO Auto-generated method stub
		return memberDAO.memberAuthUpdate(userId,memberViewAuth,shopUpdateAuth,productUpdateAuth,secessionYn);
	}

	@Override
	public List<MemberListResponse> getMemberApplyList(MemberListRequest req) throws Exception {
		int count = 0;
		List<MemberListResponse> list = new ArrayList<>();
		
		if(req.getUserType().equalsIgnoreCase("SUPER")) {
			count = memberDAO.getMemberApplyListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
			list = memberDAO.getMemberApplyList(req.getGroupDbName(),req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
		} else if(req.getUserType().equalsIgnoreCase("ADMIN")) {
			count = memberDAO.getMemberApplyListCountForAdmin(req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
			list = memberDAO.getMemberApplyListForAdmin(req.getGroupDbName(),req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
		}				
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
			
		return list;
	}

	@Override
	public int memberAppplyUpdate(Integer userId, Integer confirmUserId) throws Exception {
		// TODO Auto-generated method stub
		return memberDAO.memberAppplyUpdate(userId,confirmUserId);
	}

	
	
	@Override
	public List<MemberListResponse> getMemberAuthApplyList(MemberListRequest req) throws Exception {
		
		
		List<MemberListResponse> list = new ArrayList<MemberListResponse>();
		
			int count = memberDAO.getMemberAuthApplyListCount(req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
			list = memberDAO.getMemberAuthApplyList(req.getGroupDbName(),req.getPageInfo(),req.getPeriod(),req.getSearchCategory(),req.getSearchName(),req.getCompanyId(),req.getUserType());
		
		
		if(req.getPageInfo() != null){
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
			}
			
		return list;
	}

	@Override
	public int memberDelete(Integer userId, Integer delId) throws Exception {
		// TODO Auto-generated method stub
		return memberDAO.memberDelete(userId, delId);
	}
	
	
}
