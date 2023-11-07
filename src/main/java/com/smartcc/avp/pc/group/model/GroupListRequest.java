package com.smartcc.avp.pc.group.model;

import lombok.Data;

@Data
public class GroupListRequest {
	private int		groupId;
	private String	groupName;
	private String	groupDbName;
}
