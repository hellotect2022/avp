package com.smartcc.avp.pc.orderlist.service;

import java.util.List;

import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderProcessComp;
import com.smartcc.avp.intfc.model.request.orderlist.IntfcOrderlistRequest;
import com.smartcc.avp.pc.orderlist.model.Orderlist;

public interface OrderlistService {

	int insertOrderProcessComp(IntfcOrderProcessComp req) throws Exception;
	
	int insertOrderlist(Orderlist req) throws Exception;

	int updateOrderlist(Orderlist req) throws Exception;
	
	int updateOrderlistWorkRate(Orderlist req) throws Exception;
	
	int deleteOrderlist(Integer userId, Integer orderlistId) throws Exception;
	
	List<Orderlist> getOrderlistList(Orderlist req) throws Exception;
	
	List<Orderlist> getIntfcOrderlistList(IntfcOrderlistRequest req) throws Exception;
	
	Orderlist getOrderlist(Integer orderlistId) throws Exception;
	
	List<Integer> getOrderProcessComp(Integer orderListId) throws Exception;
	
	
	List<Orderlist> getTodayOrderlistList() throws Exception;
}
