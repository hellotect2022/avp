package com.smartcc.avp.pc.shop.model.response;

import com.smartcc.avp.pc.shop.model.Shop;

import lombok.Data;
/**
 * <pre>
	private String	companyName;
	private String	userName;
*  </pre>
 */
@Data
public class ShopListResponse extends Shop {
	private String	companyName;
	private String	userName;
	private Integer branchId;
	private String branchName;
	private String branchAddr;
	private int userCount;
	private String delYn;
	
}