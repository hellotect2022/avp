package com.smartcc.avp.pc.company.model.request;

import lombok.Data;
/**
 * <pre>
	private int		companyId;
	private Integer userId;
	private String	companyName;
	private String	companyDesc;
	private String	companyBranch;
	private String	companyLocation;
	private String	companyCreateDate;
	private int		userCount;
*  </pre>
 */
@Data
public class CompanyUpdateRequest {
	private int		companyId;
	private Integer userId;
	private String	companyName;
	private String	companyDesc;
	private String	companyBranch;
	private String	companyLocation;
	private String	companyCreateDate;
	private int		userCount;
}
