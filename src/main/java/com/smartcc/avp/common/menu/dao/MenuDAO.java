
package com.smartcc.avp.common.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smartcc.avp.common.menu.model.Menu;


public interface MenuDAO {
	
	public List<Menu> getMenus() throws Exception;
	
	public List<Menu> getMenusFromSuper() throws Exception;
	
	public List<Menu> getMenusFromAdmin() throws Exception;
	
	public List<Menu> getMenusFromWorker() throws Exception;
	
}
