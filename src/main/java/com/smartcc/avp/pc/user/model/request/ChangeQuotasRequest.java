/**
 * 사용량 변경 Request Java
 * Add. 2017. 05. 18. JBum
 */

package com.smartcc.avp.pc.user.model.request;

import lombok.Data;

@Data
public class ChangeQuotasRequest {
	private Integer userId;
	private String storageSize;
	
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setStorageSize(String storageSize) {
		this.storageSize = storageSize;
	}
	public String getStorageSize() {
		return storageSize;
	}
}
