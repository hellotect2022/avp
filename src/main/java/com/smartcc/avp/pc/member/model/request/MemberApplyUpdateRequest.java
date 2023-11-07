package com.smartcc.avp.pc.member.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer	confirmUserId;
	private Integer	userId;
*  </pre>
 */
@Data
public class MemberApplyUpdateRequest {

	private Integer	confirmUserId;
	private Integer	userId;
}
