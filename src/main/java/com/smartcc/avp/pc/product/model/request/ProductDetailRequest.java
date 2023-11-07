package com.smartcc.avp.pc.product.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer productId;
	private Integer	userId;
	private Integer	shopId;
*  </pre>
 */
@Data
public class ProductDetailRequest {
	private Integer productId;
	private Integer	userId;
	private Integer	shopId;
	
	/*
	 * Add. 2017. 09. 07. JBum
	 * 그룹 관리용 변수 추가
	 */
	private Integer 	groupId;
	private String		groupName;
	private String		groupDbName;
}
