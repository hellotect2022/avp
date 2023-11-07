package com.smartcc.avp.pc.product.model.request;

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
	private Integer		companyId;
*  </pre>
 */
@Data
public class ProductListRequest {

	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		userId;
	private String		userType;
	private Integer		companyId;
	private Integer		branchId;
	
	/* 
	 * Add. 2017. 09. 07. JBum
	 * 그룹 관리용 변수 추가 
	 */
	private Integer		groupId;
	private String		groupName;
	private String		groupDbName;
	
}
