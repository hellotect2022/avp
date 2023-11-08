package com.smartcc.avp.pc.ar.service;

import java.util.List;

import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.intfc.model.request.ar.IntfcArRequest;
import com.smartcc.avp.pc.ar.model.ArInfo;
import com.smartcc.avp.pc.ar.model.request.ArListRequest;
import com.smartcc.avp.pc.ar.model.request.ArUpdatePageRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.company.model.Company;
import com.smartcc.avp.pc.product.FileDTO;

public interface ArService {

	int insertAr(String tableName, ArInfo dto) throws Exception;

	List<ArListResponse> getArList(String tableName, ArListRequest req) throws Exception;

	ArInfo arDetailPage(String tableName, int arId) throws Exception;

	ArInfo arDetailPageNew(String tableName, int arId) throws Exception;

	int updateAr(String tableName, ArUpdatePageRequest req) throws Exception;
	int updateArNew(String tableName, ArInfo req) throws Exception;

	int deleteAr(String tableName, Integer arId, Integer userId) throws Exception;

	int checkAr(String tableName, User user, Integer Id) throws Exception;

	int deleteArArr(String tableName, List<Integer> list) throws Exception;

	int deleteFromUserId(String tableName, Integer userId) throws Exception;

	
	int insertArCount(IntfcArRequest req) throws Exception;
	
	int getArCount(IntfcArRequest req) throws Exception;
}
