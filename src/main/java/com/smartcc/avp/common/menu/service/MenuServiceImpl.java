package com.smartcc.avp.common.menu.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.menu.dao.MenuDAO;
import com.smartcc.avp.common.menu.model.Menu;

@Service
public class MenuServiceImpl implements MenuService {

	@Inject MenuDAO menuDAO;
	
	public List<Menu> getMenus(String userType) throws Exception
	{
		List<Menu> menus = Lists.newArrayList();
		List<Menu> dbMenus = Lists.newArrayList();
		
		HashMap<String, Menu> menuMap = new HashMap<>(); 
		
		if(CommonCode.USER_TYPE.SUPER.code.equals(userType))
		{
			System.out.println("userType1 ::" + userType);
			dbMenus = menuDAO.getMenusFromSuper();
		}
		else if(CommonCode.USER_TYPE.ADMIN.code.equals(userType))
		{
			System.out.println("userType2 ::" + userType);
			dbMenus = menuDAO.getMenusFromAdmin();
		}
		else if(CommonCode.USER_TYPE.WORKER.code.equals(userType))
		{
			System.out.println("userType3 ::" + userType);
			dbMenus = menuDAO.getMenusFromWorker();
		}
		
		for(Menu menu : dbMenus)
		{
			if(menu.getDepth() == 1)
			{
				menus.add(menu);
				menuMap.put(menu.getMenuId(), menu);
			}
			else
			{
				Menu parentMenu = menuMap.get(menu.getParentMenuId());
				if(parentMenu != null)
				{
					parentMenu.addSubMenu(menu);
				}
			}
		}
		System.out.println("userType ::" + userType);
		System.out.println("menus ::" + menus);
		return menus;
	}

}
