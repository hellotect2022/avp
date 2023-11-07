package com.smartcc.avp.pc.management.model;

import lombok.Data;

@Data
public class Onm {

	public Integer arCount;
	public Integer remainAr;
	public float successWorkRate;
	public float remainWorkRate;
	
	public Onm() {
		
	}
	
	public Onm(int arCount, int remainAr, float successWorkRate, float remainWorkRate) {
		this.arCount = arCount;
		this.remainAr = remainAr;
		this.successWorkRate = successWorkRate;
		this.remainWorkRate = remainWorkRate;
	}
	
}
