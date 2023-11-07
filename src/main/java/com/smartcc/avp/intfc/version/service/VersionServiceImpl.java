package com.smartcc.avp.intfc.version.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.intfc.version.dao.VersionDAO;
import com.smartcc.avp.intfc.version.model.VersionResponse;

@Service
public class VersionServiceImpl implements VersionService {

	@Inject VersionDAO versionDAO;
	
	@Override
	public VersionResponse getVersion(String tableName) throws Exception {
		// TODO Auto-generated method stub
		return versionDAO.getVersion(tableName);
	}

	@Override
	public int updateVersion(String tableName, String version) throws Exception {
		// TODO Auto-generated method stub
		return versionDAO.updateVersion(tableName, version);
	}
	
}
