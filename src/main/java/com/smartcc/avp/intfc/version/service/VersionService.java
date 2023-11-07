package com.smartcc.avp.intfc.version.service;

import com.smartcc.avp.intfc.version.model.VersionResponse;

public interface VersionService {
	VersionResponse getVersion(String tableName) throws Exception;
	
	int updateVersion(String tableName, String version) throws Exception;
}
