package com.smartcc.avp.intfc.model;

import lombok.Data;
/**
 * <pre>
	private String appVersion;
	private String modelName;
	private String osVersion;
	private String networkOpr;
 *  </pre>
 */
@Data
public class Header {
	private String appVersion;
	private String modelName;
	private String osVersion;
	private String networkOpr;
	private String phoneNumber;		// Add 2017. 09. 15. JBum | Phone Number
	private String latitude;
	private String longitude;
	private String serial;
	private String authKey;
}
