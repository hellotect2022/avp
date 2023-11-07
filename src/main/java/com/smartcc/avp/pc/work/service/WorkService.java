package com.smartcc.avp.pc.work.service;

import java.util.List;

import com.smartcc.avp.pc.work.model.Work;
import com.smartcc.avp.pc.work.model.request.ReqWorkLoc;

public interface WorkService {

	int insertWorkLoc(ReqWorkLoc req) throws Exception;
	
	List<Work> getWorkerLoc(int companyId) throws Exception;
	
}
