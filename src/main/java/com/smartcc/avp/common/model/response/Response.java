package com.smartcc.avp.common.model.response;

import java.io.Serializable;

import com.smartcc.avp.common.model.ApiException;

import lombok.Data;

/**
 * Common API Response Form For BLE: made by dothx
 * 
 * {
 * 	"response": {		<-- Response Class
 * 		"header": {		<-- Header Class
 * 			"statusCode":	<-- If result is not successful, BleApiException Related Code will place hear 
 * 			"statusMessage"	<-- same case like above line	
 * 		},					<-- Until this line, ResponseHeader Class
 * 		"body": {			<-- Until this line, ResponseBocy Class
 * 			Object
 * 		}
 *   }
 * }
 * 
 */
@Data
public class Response implements Serializable {

	private static final long serialVersionUID = 8847032513833637900L;
	
	private Payload response;
	
	public Response() {
		response = new ResponseHeader();
	}
	
	public Response(ApiException e){
		response = new ResponseHeader(e);

	}

	public Response(Object object){
		response = new ResponseBody(object);
	}
}
