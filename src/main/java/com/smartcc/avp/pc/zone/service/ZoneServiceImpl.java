package com.smartcc.avp.pc.zone.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.intfc.model.request.zone.IntfcZoneReco;
import com.smartcc.avp.pc.zone.dao.ZoneDAO;
import com.smartcc.avp.pc.zone.model.Zone;

@Service
public class ZoneServiceImpl implements ZoneService {

	@Inject ZoneDAO zoneDAO;

	@Override
	public List<Zone> getZoneList(int companyId) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.getZoneList(companyId);
	}

	@Override
	public Zone getZone(int zoneId) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.getZone(zoneId);
	}
	
	@Override
	public int insertZone(Zone req) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.insertZone(req);
	}

	@Override
	public int updateZone(Zone req) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.updateZone(req);
	}

	@Override
	public int deleteZone(int zoneId) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.deleteZone(zoneId);
	}

	@Override
	public int insertZoneReco(IntfcZoneReco req) throws Exception {
		// TODO Auto-generated method stub
		return zoneDAO.insertZoneReco(req);
	}
	
}
