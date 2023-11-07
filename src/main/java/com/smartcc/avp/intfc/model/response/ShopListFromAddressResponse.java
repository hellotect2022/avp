package com.smartcc.avp.intfc.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer shopId;
	private String	shopName;
	private String	shop;
 *  </pre>
 */
@Data
public class ShopListFromAddressResponse {
	private Integer eventId;
	private Integer shopId;
	private String 	shopName;
	private String	shopXLocation;
	private String	shopYLocation;
	private String	shopAddress;
	private Integer	eventDistance;
}
