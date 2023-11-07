package com.smartcc.avp.pc.user.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
*  </pre>
 */
@Data
public class SecessionListRequest {
	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
}
