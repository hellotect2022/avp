package com.smartcc.avp.intfc.version.dao;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.intfc.version.model.VersionResponse;

public interface VersionDAO {
	VersionResponse getVersion(@Param("dbName")String tableName) throws Exception;
	
	int updateVersion(@Param("dbName")String tableName, @Param("version")String version) throws Exception;
}
