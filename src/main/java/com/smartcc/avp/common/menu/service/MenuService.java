package com.smartcc.avp.common.menu.service;

import java.util.List;

import com.smartcc.avp.common.menu.model.Menu;



public interface MenuService {
	
	public List<Menu> getMenus(String userType) throws Exception;

}
