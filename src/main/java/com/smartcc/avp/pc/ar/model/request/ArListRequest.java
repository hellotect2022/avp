package com.smartcc.avp.pc.ar.model.request;

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
public class ArListRequest {
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	private Integer		userId;
	private String		userType;
	private Integer		companyId;
}
