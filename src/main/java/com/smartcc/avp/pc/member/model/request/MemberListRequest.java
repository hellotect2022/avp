package com.smartcc.avp.pc.member.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		companyId;
	private String		userType;
	private String		applyUserView
*  </pre>
 */
@Data
public class MemberListRequest {
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		companyId;
	private Integer		userId;
	private String		userType;
	private String		applyUserView = "N";
	
	private Integer		groupId;
	private String		groupName;
	private String		groupDbName;
}
