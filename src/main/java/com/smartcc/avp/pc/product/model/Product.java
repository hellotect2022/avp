package com.smartcc.avp.pc.product.model;

import com.smartcc.avp.pc.product.model.response.ProductDetailResponse;

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
*  </pre>
 */
@Data
public class Product {
		private Integer	productId;
		private Integer	shopId;
		private String	productName;
		private String	productDesc;
		private String	shopName;
		private String	productImageUrl;
		private Integer	productImageId;
		private String	createDate;
}
