package com.smartcc.avp.pc.ar.model.response;

import lombok.Data;
/**
 * <pre>
	private int		arId;
	private String	targetName;
	private String	createDate;
	private String	shopName;
*  </pre>
 */
@Data
public class ArListResponse {

	private String	targetName;
	private String	createDate;
	private String	shopName;
	
	private Integer arId;
	private String	itemName;
	private String	arName;
}
