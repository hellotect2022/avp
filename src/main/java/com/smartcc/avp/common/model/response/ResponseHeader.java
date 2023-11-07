package com.smartcc.avp.common.model.response;

import java.io.Serializable;

import com.smartcc.avp.common.model.ApiException;

import lombok.Data;

@Data
public class ResponseHeader implements Payload, Serializable {

	private static final long serialVersionUID = 8009272581530140412L;
	
	private Header header;
	
	public ResponseHeader(){
		this.header = new Header();

	}

	public ResponseHeader(ApiException e) {
		this.header = new Header();
		header.setStatusCode(e.getErrorCode());
		header.setStatusMessage(e.getErrorMessage());
	} 
}
