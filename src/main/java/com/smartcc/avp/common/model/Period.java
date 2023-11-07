
package com.smartcc.avp.common.model;

import org.springframework.web.bind.MethodArgumentNotValidException;

import com.smartcc.avp.common.model.reauest.BaseRequest;

import lombok.Data;

@Data
public class Period implements BaseRequest {
	private String startYmd;
	private String endYmd;
	
	@Override
	public void validate() throws MethodArgumentNotValidException, ApiException {
	}
}
