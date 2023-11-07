package com.smartcc.avp.pc.product.model.request;

import lombok.Data;
/**
 * <pre>
	private Integer productId;
	private Integer	userId;
	private Integer	shopId;
	private String	productName;
	private String	productDesc;
	private Integer	productImageId;
	private String	productFileName;
	private String	productFilePath;
	
	private Integer	preProductImageId;
	
	private Integer	updateId;
*  </pre>
 */
@Data
public class ProductUpdateRequest {
	private Integer productId;
	private Integer	userId;
	private Integer	shopId;
	private String	productName;
	private String	productDesc;
	private Integer	productImageId;
	private String	productFileName;
	private String	productFilePath;
	
	private Integer	preProductImageId;
		
	private Integer itemId;
	private Integer branchId;
	private String	itemName;
	private String 	barcode;
	private String 	barcodeType;
	private String	zone;
	private String	local;
	private String	location;
	private Integer	updateId;
	private String	updateDttm;
	
}
