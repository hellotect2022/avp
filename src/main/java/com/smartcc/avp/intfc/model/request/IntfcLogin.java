package com.smartcc.avp.intfc.model.request;

import lombok.Data;

/**
 * <pre>
	private String	snsType;
	private String	snsId;
	private String	nickname;
	private String	profileImage;
	private String	thumbnailImage;
 *  </pre>
 */
@Data
public class IntfcLogin {
	private String	snsType;
	private String	snsId;
	private String	nickname;
	private String	profileImage;
	private String	thumbnailImage;

}
