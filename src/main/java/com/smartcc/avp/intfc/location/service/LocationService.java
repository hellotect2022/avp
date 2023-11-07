package com.smartcc.avp.intfc.location.service;

import java.util.List;

import com.smartcc.avp.intfc.model.request.location.IntfcLocationHist;

public interface LocationService {

	int insertBeacon(IntfcLocationHist req) throws Exception;
	
	List<IntfcLocationHist> getListBeacon(Integer deviceId) throws Exception;
	
}
