package com.smartcc.avp.pc.device.service;

import java.util.List;

import com.smartcc.avp.pc.device.model.Device;

public interface DeviceService {

	List<Device> getDeviceList(Device req) throws Exception;
	
	Device getDevice(Integer deviceId) throws Exception;
	
	int insertDevice(Device req) throws Exception;
	
	int updateDevice(Device req) throws Exception;
	
	int deleteDevice(Integer userId, Integer deviceId) throws Exception;
	
	Device intfcGetDevice(String serial) throws Exception;
	
}
