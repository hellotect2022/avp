package com.smartcc.avp.pc.company.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		userId;
	private String		userType;
*  </pre>
 */
@Data
public class CompanyListRequest {
	
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		userId;
	private String		userType;
	
	private Integer		groupId;
	private String		groupName;
	private String		groupDbName;
}
