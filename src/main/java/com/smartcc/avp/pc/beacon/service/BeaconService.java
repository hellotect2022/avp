package com.smartcc.avp.pc.beacon.service;

import java.util.List;

import com.smartcc.avp.pc.beacon.model.Beacon;

public interface BeaconService {

	List<Beacon> getBeaconList(Integer companyId) throws Exception;
	Beacon getBeacon(Integer beaconId) throws Exception;
	int insertBeacon(Beacon beacon) throws Exception;
	int updateBeacon(Beacon beacon) throws Exception;
	int deleteBeacon(Integer beaconId, Integer userId) throws Exception;
	
}
