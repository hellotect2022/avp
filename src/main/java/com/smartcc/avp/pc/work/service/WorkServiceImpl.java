package com.smartcc.avp.pc.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.pc.work.dao.WorkDAO;
import com.smartcc.avp.pc.work.model.Work;
import com.smartcc.avp.pc.work.model.request.ReqWorkLoc;

@Service
public class WorkServiceImpl implements WorkService {

	@Inject WorkDAO workDAO;

	@Override
	public int insertWorkLoc(ReqWorkLoc req) throws Exception {
		// TODO Auto-generated method stub
		return workDAO.insertWorkLoc(req);
	}

	@Override
	public List<Work> getWorkerLoc(int companyId) throws Exception {
		// TODO Auto-generated method stub
		return workDAO.getWorkerLoc(companyId);
	}
	
}
