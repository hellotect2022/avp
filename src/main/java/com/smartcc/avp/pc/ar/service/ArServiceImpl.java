package com.smartcc.avp.pc.ar.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.intfc.model.request.ar.IntfcArRequest;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.ar.dao.ArDAO;
import com.smartcc.avp.pc.ar.model.ArInfo;
import com.smartcc.avp.pc.ar.model.request.ArListRequest;
import com.smartcc.avp.pc.ar.model.request.ArUpdatePageRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.company.model.response.CompanyListResponse;
import com.smartcc.avp.pc.product.FileDTO;
import com.smartcc.avp.pc.product.model.response.ProductListResponse;

@Service
public class ArServiceImpl implements ArService {

	@Inject
	ArDAO arDao;

	@Override
	public int insertAr(String tableName, ArInfo dto) throws Exception {
		// TODO Auto-generated method stub
		return arDao.insertAr(tableName, dto);
	}

	@Override
	public List<ArListResponse> getArList(String tableName, ArListRequest req) throws Exception {
		List<ArListResponse> list = new ArrayList<ArListResponse>();
		int count = 0;
		if ("ADMIN".equals(req.getUserType())) {
			count = arDao.getArListCountForAdmin(tableName, req.getPeriod(), req.getSearchCategory(),
					req.getSearchName(), req.getCompanyId());
			list = arDao.getArListForAdmin(tableName, req.getPageInfo(), req.getPeriod(), req.getSearchCategory(),
					req.getSearchName(), req.getCompanyId());
		} else if ("WORKER".equals(req.getUserType())) {
			count = arDao.getArListCountForSeller(tableName, req.getPeriod(), req.getSearchCategory(),
					req.getSearchName(), req.getUserId());
			list = arDao.getArListForSeller(tableName, req.getPageInfo(), req.getPeriod(), req.getSearchCategory(),
					req.getSearchName(), req.getUserId());
		} else {
			count = arDao.getArListCount(tableName, req.getPeriod(), req.getSearchCategory(), req.getSearchName());
			list = arDao.getArList(tableName, req.getPageInfo(), req.getPeriod(), req.getSearchCategory(),
					req.getSearchName());

		}

		if (req.getPageInfo() != null) {
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}

		return list;
	}

	@Override
	public ArInfo arDetailPage(String tableName, int arId) throws Exception {
		// TODO Auto-generated method stub
		return arDao.arDetailPage(tableName, arId);
	}

	@Override
	public ArInfo arDetailPageNew(String tableName, int arId) throws Exception {
		// TODO Auto-generated method stub
		return arDao.arDetailPageNew(tableName, arId);
	}

	@Override
	public int updateAr(String tableName, ArUpdatePageRequest req) throws Exception {
		// TODO Auto-generated method stub
		return arDao.updateAr(tableName, req);
	}

/*	@Override
	public int updateArNew(String tableName, ArInfo req) throws Exception {
		return arDao.updateArNew(tableName, req);
	}*/

	@Override
	public int deleteAr(String tableName, Integer arId, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return arDao.deleteAr(tableName, arId, userId);
	}

	@Override
	public int checkAr(String tableName, User req, Integer arId) throws Exception {
		int cnt = 0;
		// admin 이면
		if (CommonCode.USER_TYPE.ADMIN.code.equals(req.getUserType())) {
			cnt = arDao.checkArFromAdmin(tableName, req.getCompanyId(), arId);
		} else if (CommonCode.USER_TYPE.SELLER.code.equals(req.getUserType())) {
			cnt = arDao.checkArFromSeller(tableName, req.getUserId(), arId);
		}
		// TODO Auto-generated method stub
		return cnt;
	}

	@Override
	public int deleteArArr(String tableName, List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		return arDao.deleteArArr(tableName, list);
	}

	@Override
	public int deleteFromUserId(String tableName, Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertArCount(IntfcArRequest req) throws Exception {
		// TODO Auto-generated method stub
		return arDao.insertArCount(req);
	}

	@Override
	public int getArCount(IntfcArRequest req) throws Exception {
		// TODO Auto-generated method stub
		return arDao.getArCount(req.body.companyId);
	}

}
