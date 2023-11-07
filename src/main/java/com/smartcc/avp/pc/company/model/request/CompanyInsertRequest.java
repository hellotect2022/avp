package com.smartcc.avp.pc.company.model.request;


import lombok.Data;
/**
 * <pre>
	private int		companyId;
	private String 	companyName ;
	private String 	companyDesc ;
	private String 	companyBranch ;
	private Integer	userId;
	private String 	companyLocation;
	private Integer	createId;
*  </pre>
 */
@Data
public class CompanyInsertRequest {
	private int		companyId;
	private String 	companyDesc ;
	private String 	companyBranch ;
	private Integer	userId;
	private String 	companyLocation;

	private String	companyName;
	private String	capacityAr;
	private String	capacityStorage;
	private String	wholeStorage;
	private String	regConfirm;
	private Integer	createId;
	private String	createDttm;
	
}
