package com.smartcc.avp.pc.work.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.pc.work.model.Work;
import com.smartcc.avp.pc.work.model.request.ReqWorkLoc;

public interface WorkDAO {

	int insertWorkLoc(@Param("workLocInsert")ReqWorkLoc req) throws Exception;
	
	List<Work> getWorkerLoc(@Param("companyId")int companyId) throws Exception;
	
}
