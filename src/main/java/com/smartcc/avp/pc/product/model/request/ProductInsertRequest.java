package com.smartcc.avp.pc.product.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private Integer proudctId;
	private Integer	shopId;
	private Integer	userId;
	private String	productName;
	private String	productDesc;
	private Integer	productImageId;
	private String productFileName;
	private String	productFilePath;
	private Integer	createId;
*  </pre>
 */
@Data
public class ProductInsertRequest {
	private Integer proudctId;
	private Integer	shopId;
	private Integer	userId;
	private String	productName;
	private String	productDesc;
	private Integer	productImageId;
	private String productFileName;
	private String	productFilePath;
	private Integer	createId;
	
	private Integer companyId;
	private Integer branchId;
	private String	itemName;
	private String	barcode;
	private String	barcodeType;
	private String	zone;
	private String	local;
	private String	location;
	
}
