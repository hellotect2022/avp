package com.smartcc.avp.pc.shop.model.request;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;
/**
 * <pre>
	private Integer		shopId;
*  </pre>
 */
@Data
public class ShopDetailRequest {
	private Integer		branchId;
	private Integer		shopId;
	private Integer 	userId;
	
}
