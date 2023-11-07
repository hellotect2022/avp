package com.smartcc.avp.common.model.response;

import java.io.Serializable;

import com.smartcc.avp.common.BaseConst;

public class Header implements Serializable {

	private static final long serialVersionUID = 4514879141116752635L;

	private int statusCode = BaseConst.Code.SUCCESS;
	
	private String statusMessage = BaseConst.Code.API_SUCCESS_MSG;

	public Header() {}

	public String getStatusMessage() {
		return statusMessage;
	}

	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
}
