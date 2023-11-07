package com.smartcc.avp.pc.user.model.request;

import lombok.Data;

@Data
public class UserUpdateRequest {

	private Integer updateId;
	private Integer restoreId;
	private String  restoreDttm;
	private String	delYn;
	
}
