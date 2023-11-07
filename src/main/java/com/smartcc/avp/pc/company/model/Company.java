package com.smartcc.avp.pc.company.model;

import lombok.Data;
/**
 * <pre>
	private int		companyId;
	private String	companyName;
	private Integer	userId;
	private String	companyDesc;
	private String	companyBranch;
	private String	companyLocation;
	private String	companyCreateDate;
	private int		userCount;
	private int		shopCount;
*  </pre>
 */
@Data
public class Company {
	private int		companyId;
	private String	companyName;
	private Integer	userId;
	private String	companyDesc;
	private String	companyBranch;
	private String	companyLocation;
	private String	companyCreateDate;
	private int		userCount;
	private int		shopCount;
	
	private int		adminCount;
	private String	nickName;
	private int		createId;
	
	private Integer capacityAr;
	private Integer	capacityStorage;
	private Integer	wholeStorage;
	
}
