package com.smartcc.avp.pc.device.model;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;

import lombok.Data;

@Data
public class Device {

	private PageInfo	pageInfo;
	private String		searchName;
	private String		searchCategory;
	private Period		period;
	
	private Integer	companyId;
	private String	companyName;
	private Integer	branchId;
	private String	branchName;
	private Integer	deviceId;
	private String	deviceName;
	private String	serial;
	private String  latitude;
	private String	longitude;
	private Integer workRate;
	private Integer	delId;
	private String	delYn;
	private Integer	createId;
	private String	createUser;
	private String	createDttm;
	private Integer	updateId;
	private String	updateUser;
	private String	updateDttm;
	private String	orderlistName;
	
}
