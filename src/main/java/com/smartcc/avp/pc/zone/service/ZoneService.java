package com.smartcc.avp.pc.zone.service;

import java.util.List;

import com.smartcc.avp.intfc.model.request.zone.IntfcZoneReco;
import com.smartcc.avp.pc.zone.model.Zone;

public interface ZoneService {

	List<Zone> getZoneList(int companyId) throws Exception;
	
	Zone getZone(int zoneId) throws Exception;
	
	int insertZone(Zone req) throws Exception;
	
	int updateZone(Zone req) throws Exception;
	
	int deleteZone(int zoneId) throws Exception;
	
	int insertZoneReco(IntfcZoneReco req) throws Exception;
	
}
