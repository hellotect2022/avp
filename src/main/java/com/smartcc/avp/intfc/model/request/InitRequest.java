package com.smartcc.avp.intfc.model.request;

import org.springframework.web.multipart.MultipartFile;

import com.smartcc.avp.intfc.model.Header;
import com.smartcc.avp.intfc.model.request.IntfcShopDetailRequest.Body;
import com.smartcc.avp.pc.ar.model.ArInfo;

import lombok.Data;

/**
 * <pre>
	public class Body
	{
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
 *  </pre>
 */
@Data
public class InitRequest {

	@Data
	public class Body
	{
		private Integer	userId;
	}
	
	private Body body;
	private Header	header;
}
