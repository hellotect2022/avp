package com.smartcc.avp.pc.orderlist.model;

import java.util.List;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;

@Data
public class Orderlist {

	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	
	private Integer	orderlistId;
	private String	orderlistName;
	private Integer	companyId;
	private Integer	branchId;
	private String	startDt;
	private String	endDt;
	private Integer	deviceId;
	private String	deviceName;
	private String	itemIds;
	private String  itemNames;
	private Integer	itemType;
	private String	quantities;
	private Integer	wholeQty;
	private String	successYn;
	private Integer	workRate;
	private Integer	delId;
	private String	delYn;
	private Integer	createId;
	private String	createUser;
	private String	createDttm;
	private Integer	updateId;
	private String	updateUser;
	private String	updateDttm;
	
	List<Integer> compItems;
	
}
