package com.smartcc.avp.pc.member.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer userId;
	private Integer comfirmUserId;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
*  </pre>
 */
@Data
public class MemberUpdateRequest {
	
	private Integer userId;
	private Integer comfirmUserId;
	private String	memberViewAuth;
	private String	shopUpdateAuth;
	private String	productUpdateAuth;
	
}
