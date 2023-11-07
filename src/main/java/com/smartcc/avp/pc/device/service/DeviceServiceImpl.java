package com.smartcc.avp.pc.device.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.device.dao.DeviceDAO;
import com.smartcc.avp.pc.device.model.Device;
import com.smartcc.avp.pc.orderlist.model.Orderlist;

@Service
public class DeviceServiceImpl implements DeviceService {
	
	@Inject DeviceDAO deviceDAO;

	@Override
	public List<Device> getDeviceList(Device req) throws Exception {
		// TODO Auto-generated method stub
		List<Device> list = new ArrayList<>();
		
		int count = deviceDAO.getDeviceListCount(req.getPeriod(), req.getSearchCategory(), req.getSearchName(), req.getCompanyId(), req.getBranchId());
		list = deviceDAO.getDeviceList(req.getPageInfo(), req.getPeriod(), req.getSearchCategory(), req.getSearchName(), req.getCompanyId(), req.getBranchId());
		if(req.getPageInfo() != null) {
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
		
		return list;
	}

	@Override
	public int insertDevice(Device req) throws Exception {
		// TODO Auto-generated method stub
		return deviceDAO.insertDevice(req);
	}

	@Override
	public int updateDevice(Device req) throws Exception {
		// TODO Auto-generated method stub
		return deviceDAO.updateDevice(req);
	}

	@Override
	public int deleteDevice(Integer userId, Integer deviceId) throws Exception {
		// TODO Auto-generated method stub
		return deviceDAO.deleteDevice(userId, deviceId);
	}

	@Override
	public Device getDevice(Integer deviceId) throws Exception {
		// TODO Auto-generated method stub
		return deviceDAO.getDevice(deviceId);
	}

	@Override
	public Device intfcGetDevice(String serial) throws Exception {
		// TODO Auto-generated method stub
		return deviceDAO.intfcGetDevice(serial);
	}

}
