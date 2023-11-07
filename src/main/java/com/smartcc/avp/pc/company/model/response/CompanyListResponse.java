package com.smartcc.avp.pc.company.model.response;

import lombok.Data;
/**
 * <pre>
	private int		companyId;
	private String	companyName;
	private String	companyCreateDate;
*  </pre>
 */
@Data
public class CompanyListResponse {

	private int		companyId;
	private String	companyName;
	private String 	userName;
	private String	companyCreateDate;
}
