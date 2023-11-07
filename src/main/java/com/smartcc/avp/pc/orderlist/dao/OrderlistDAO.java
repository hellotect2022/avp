package com.smartcc.avp.pc.orderlist.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.intfc.model.request.orderlist.ReqOrderProcessComp;
import com.smartcc.avp.pc.orderlist.model.Orderlist;

public interface OrderlistDAO {

	List<Orderlist> getOrderlistList(
			@Param("pageInfo") PageInfo pageInfo,
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId
		) throws Exception;
	
	int getOrderlistListCount(
			@Param("period") Period period,
			@Param("searchCategory") String searchCategory,
			@Param("searchName") String searchName,
			@Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId
		) throws Exception;	
	
	int insertOrderlist(@Param("orderlistInsert")Orderlist req) throws Exception;
	
	int updateOrderlist(@Param("orderlistUpdate")Orderlist req) throws Exception;
	
	int updateOrderlistWorkRate(@Param("orderlistUpdate")Orderlist req) throws Exception;
	
	int deleteOrderlist(@Param("userId") Integer userId, @Param("orderlistId") Integer orderlistId) throws Exception;
	
	List<Orderlist> getIntfcOrderlistList(
			@Param("companyId") Integer companyId,
			@Param("branchId") Integer branchId,
			@Param("serial") String serial
		) throws Exception;
	
	Orderlist getOrderlist(
			@Param("orderlistId") Integer orderlistId
		) throws Exception;
		
	int insertOrderProcessComp(@Param("orderProcessCompInsert")ReqOrderProcessComp req) throws Exception;
	
	List<Integer> getOrderProcessComp(Integer orderListId) throws Exception;
	
	List<Orderlist> getTodayOrderlistList(@Param("todayDt") String todayDt) throws Exception;
	
}
