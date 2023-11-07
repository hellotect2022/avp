package com.smartcc.avp.pc.group.service;

import java.util.List;

import com.smartcc.avp.pc.group.model.GroupListResponse;

public interface GroupService {

	public List<GroupListResponse> getGroupList() throws Exception;
	
	// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
	public GroupListResponse getGroupDetail(String groupName) throws Exception; // Add. 2017. 09. 11
}