package com.smartcc.avp.pc.group.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.group.dao.GroupDAO;
import com.smartcc.avp.pc.group.model.GroupListResponse;

import java.util.List;

import javax.inject.Inject;

@Service
public class GroupServiceImpl implements GroupService{

	private static final Logger logger = LoggerFactory.getLogger(GroupServiceImpl.class);
	
	@Inject GroupDAO groupDAO;
	
	@Override
	public List<GroupListResponse> getGroupList() throws Exception {
		// TODO Auto-generated method stub
		return groupDAO.getGroupList();
	}

	// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
	@Override
	public GroupListResponse getGroupDetail(String groupName) throws Exception {
		// TODO Auto-generated method stub
		return groupDAO.getGroupDetail(groupName);
	}
	// End of 2017. 09. 11.
}
