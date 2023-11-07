package com.smartcc.avp.pc.member.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	snsType;
	private String	phone;
	private Integer	companyId;
	private String	userType;
	private String	createDate;
	private String	companyShopName;
*  </pre>
 */
@Data
public class MemberListResponse {
	private Integer	userId;
	private String	nickName;
	private String	userName;
	private String	snsType;
	private String	phone;
	private Integer	companyId;
	private String	userType;
	private String	createDttm;
	private String	companyShopName;
	private String	storageSize;
}
