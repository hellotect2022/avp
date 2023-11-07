package com.smartcc.avp.pc.device.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.pc.device.model.Device;

public interface DeviceDAO {

	List<Device> getDeviceList(@Param("pageInfo") PageInfo pageInfo, @Param("period") Period period,
			@Param("searchCategory") String searchCategory, @Param("searchName") String searchName,
			@Param("companyId") Integer companyId, @Param("branchId") Integer branchId) throws Exception;

	int getDeviceListCount(@Param("period") Period period, @Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName, @Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId) throws Exception;

	int insertDevice(@Param("deviceInsert") Device req) throws Exception;

	int updateDevice(@Param("deviceUpdate") Device req) throws Exception;

	int deleteDevice(@Param("userId") Integer userId, @Param("deviceId") Integer deviceId) throws Exception;

	Device getDevice(@Param("deviceId") Integer deviceId) throws Exception;

	Device intfcGetDevice(@Param("serial") String serial) throws Exception;
	
}
