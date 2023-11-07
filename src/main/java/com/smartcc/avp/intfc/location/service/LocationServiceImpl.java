package com.smartcc.avp.intfc.location.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.intfc.location.dao.LocationDAO;
import com.smartcc.avp.intfc.model.request.location.IntfcLocationHist;

@Service
public class LocationServiceImpl implements LocationService{

	@Inject LocationDAO locationDAO;

	@Override
	public int insertBeacon(IntfcLocationHist req) throws Exception {
		// TODO Auto-generated method stub
		return locationDAO.insertBeacon(req);
	}

	@Override
	public List<IntfcLocationHist> getListBeacon(Integer deviceId) throws Exception {
		// TODO Auto-generated method stub
		return locationDAO.getListBeacon(deviceId);
	}
	
}
