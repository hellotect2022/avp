package com.smartcc.avp.pc.beacon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.pc.beacon.model.Beacon;

public interface BeaconDAO {

	List<Beacon> getBeaconList(@Param("companyId") Integer companyId) throws Exception;
	Beacon getBeacon(@Param("beaconId") Integer beaconId) throws Exception;
	int insertBeacon(@Param("beaconInsert") Beacon beacon) throws Exception;
	int updateBeacon(@Param("beaconUpdate") Beacon beacon) throws Exception;
	int deleteBeacon(@Param("beaconId") Integer beaconId, @Param("userId") Integer userId) throws Exception;
	
}
