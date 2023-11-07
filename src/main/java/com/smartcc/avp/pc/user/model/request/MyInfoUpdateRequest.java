package com.smartcc.avp.pc.user.model.request;

import lombok.Data;
/**
 * <pre>
	private String email;
	private String phone;
	private Integer userId;
*  </pre>
 */
@Data
public class MyInfoUpdateRequest {

	private String email;
	private String phone;
	private Integer userId;
}
