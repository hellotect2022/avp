package com.smartcc.avp.pc.user.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer userId;
	private String	 insertGubun;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	private String	secessionYn;
*  </pre>
 */

@Data
public class insertMyAuthApplyRequest {
	
	private Integer userId;
	private String	 insertGubun;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	private String	secessionYn;
	
}
