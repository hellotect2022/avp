package com.smartcc.avp.pc.group.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.pc.group.model.GroupListResponse;

public interface GroupDAO {
	
	List<GroupListResponse> getGroupList() throws Exception;

	// Add. 2017. 09. 11. JBum | 그룹 이름을 통해 DB 이름을 가져오는 Logic
	GroupListResponse getGroupDetail(@Param("groupName") String groupName) throws Exception; // Add. 2017. 09. 11
}
