
package com.smartcc.avp.common.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class ApiException extends Exception {

	private static final long serialVersionUID = 8451002067678880278L;
	
	private int httpCode;
	private int errorCode;
	private String errorMessage;
	
	
	public ApiException(int httpCode , int errorCode , String errorMessage){
		this.httpCode = httpCode;
		this.errorCode = errorCode;
		this.errorMessage = errorMessage;
	}

	public ApiException(int errorCode , String errorMessage){
		this.errorCode = errorCode;
		this.errorMessage = errorMessage;
	}
	
	@Override
	public String getMessage() {
		if(super.getMessage() != null)
		{
			return errorMessage + " " + super.getMessage();
		}
		return errorMessage;
	}
}
