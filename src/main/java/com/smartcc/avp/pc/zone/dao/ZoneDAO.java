package com.smartcc.avp.pc.zone.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.intfc.model.request.zone.IntfcZoneReco;
import com.smartcc.avp.pc.zone.model.Zone;

public interface ZoneDAO {

	List<Zone> getZoneList(@Param("companyId") Integer companyId) throws Exception;
	
	Zone getZone(@Param("zoneId") Integer zoneId) throws Exception;
	
	int insertZone(@Param("zoneInsert")Zone req) throws Exception;
	
	int updateZone(@Param("zoneUpdate")Zone req) throws Exception;
	
	int deleteZone(@Param("zoneId") Integer zoneId) throws Exception;
	
	int insertZoneReco(@Param("zoneRecoInsert")IntfcZoneReco req) throws Exception;
	
}
