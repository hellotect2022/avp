package com.smartcc.avp.pc.shop.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private Integer 	userId;
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	
	private Period		period;
	private Integer		companyId;
	private String		userType;
*  </pre>
 */
@Data
public class ShopListRequest {
	private Integer 	userId;
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	
	private Period		period;
	private Integer		companyId;
	private String		userType;
	
	private Integer		groupId;
	private String		groupName;
	private String		groupDbName;
	
}
