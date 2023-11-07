package com.smartcc.avp.pc.orderlist.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderProcessComp;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderlistRequest;
import com.smartcc.avp.intfc.model.request.orderlist.ReqOrderProcessComp;
import com.smartcc.avp.pc.orderlist.dao.OrderlistDAO;
import com.smartcc.avp.pc.orderlist.model.Orderlist;

@Service
public class OrderlistServiceImpl implements OrderlistService {

	@Inject OrderlistDAO orderlistDAO;

	@Override
	public int insertOrderlist(Orderlist req) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.insertOrderlist(req);
	}

	@Override
	public List<Orderlist> getOrderlistList(Orderlist req) throws Exception {
		// TODO Auto-generated method stub
		List<Orderlist> list = new ArrayList<>();
		
		int count = orderlistDAO.getOrderlistListCount(req.getPeriod(), req.getSearchCategory(), req.getSearchName(), req.getCompanyId(), req.getBranchId());
		list = orderlistDAO.getOrderlistList(req.getPageInfo(), req.getPeriod(), req.getSearchCategory(), req.getSearchName(), req.getCompanyId(), req.getBranchId());
		if(req.getPageInfo() != null) {
			req.getPageInfo().setTotalCount(count);
			req.getPageInfo().setResultCount(list.size());
		}
		
		return list;
	}

	@Override
	public List<Orderlist> getIntfcOrderlistList(IntfcOrderlistRequest req) throws Exception {
		// TODO Auto-generated method stub
		List<Orderlist> list = new ArrayList<>();
		
		list = orderlistDAO.getIntfcOrderlistList(req.getBody().getCompanyId(), req.getBody().getBranchId(), req.getHeader().getSerial());

		return list;
	}

	@Override
	public Orderlist getOrderlist(Integer orderlistId) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.getOrderlist(orderlistId);
	}

	@Override
	public int updateOrderlist(Orderlist req) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.updateOrderlist(req);
	}

	@Override
	public int deleteOrderlist(Integer userId, Integer orderlistId) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.deleteOrderlist(userId, orderlistId);
	}

	@Override
	public int updateOrderlistWorkRate(Orderlist req) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.updateOrderlistWorkRate(req);
	}

	@Override
	public int insertOrderProcessComp(IntfcOrderProcessComp req) throws Exception {
		// TODO Auto-generated method stub				
		return orderlistDAO.insertOrderProcessComp(new ReqOrderProcessComp(req));
	}

	@Override
	public List<Integer> getOrderProcessComp(Integer orderListId) throws Exception {
		// TODO Auto-generated method stub
		return orderlistDAO.getOrderProcessComp(orderListId);
	}

	@Override
	public List<Orderlist> getTodayOrderlistList() throws Exception {
		// TODO Auto-generated method stub
		List<Orderlist> list = new ArrayList<>();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		
		String todayDt = dateFormat.format(new Date());

		list = orderlistDAO.getTodayOrderlistList(todayDt);
		
		return list;
	}
	
}
