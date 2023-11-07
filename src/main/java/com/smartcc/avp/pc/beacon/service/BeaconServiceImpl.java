package com.smartcc.avp.pc.beacon.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.beacon.dao.BeaconDAO;
import com.smartcc.avp.pc.beacon.model.Beacon;

@Service
public class BeaconServiceImpl implements BeaconService {

	@Inject BeaconDAO beaconDAO;

	@Override
	public List<Beacon> getBeaconList(Integer companyId) throws Exception {
		// TODO Auto-generated method stub
		return beaconDAO.getBeaconList(companyId);
	}

	@Override
	public Beacon getBeacon(Integer beaconId) throws Exception {
		// TODO Auto-generated method stub
		return beaconDAO.getBeacon(beaconId);
	}

	@Override
	public int insertBeacon(Beacon beacon) throws Exception {
		// TODO Auto-generated method stub
		return beaconDAO.insertBeacon(beacon);
	}

	@Override
	public int updateBeacon(Beacon beacon) throws Exception {
		// TODO Auto-generated method stub
		return beaconDAO.updateBeacon(beacon);
	}

	@Override
	public int deleteBeacon(Integer beaconId, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return beaconDAO.deleteBeacon(beaconId, userId);
	}
	
}