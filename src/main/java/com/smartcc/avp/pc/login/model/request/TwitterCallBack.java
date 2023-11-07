package com.smartcc.avp.pc.login.model.request;

import lombok.Data;
/**
 * <pre>
	private String	oauth_token;
	private String	oauth_verifier;
*  </pre>
 */
@Data
public class TwitterCallBack {
	private String	oauth_token;
	private String	oauth_verifier;
}
