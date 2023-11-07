package com.smartcc.avp.intfc.location.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.intfc.model.request.location.IntfcLocationHist;

public interface LocationDAO {

	int insertBeacon(@Param("beacon") IntfcLocationHist req) throws Exception;
	
	List<IntfcLocationHist> getListBeacon(@Param("deviceId") Integer deviceId) throws Exception;
	
}
