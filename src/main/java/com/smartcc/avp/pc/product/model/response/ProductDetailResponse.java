package com.smartcc.avp.pc.product.model.response;

import lombok.Data;
/**
 * <pre>
	private Integer	productId;
	private Integer	shopId;
	private String	productName;
	private String	productDesc;
	private String	shopName;
	private String	productImageUrl;
	private Integer	productImageId;
	private String	createDate;
	private Integer	createId;
*  </pre>
 */
@Data
public class ProductDetailResponse {
	private Integer	productId;
	private Integer	shopId;
	private String	productName;
	private String	productDesc;
	private String	shopName;
	private String	productImageUrl;
	private Integer	productImageId;
	private String	createDate;
	
	//
	private Integer	itemId;
	private	Integer	companyId;
	private Integer branchId;
	private String	companyName;
	private String	branchName;
	private String	itemName;
	private String	barcode;
	private String	barcodeType;
	private String	zone;
	private String	local;
	private String	location;
	private Integer delId;
	private String	delYn;
	private Integer createId;
	private String	createName;
	private String	createDttm;
	private Integer	updateId;
	private String	updateName;
	private String	updateDttm;
	
	Integer quantity;
}
