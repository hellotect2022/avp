package com.smartcc.avp.common.menu.model;

import java.util.List;

import com.google.common.collect.Lists;

import lombok.Data;

@Data
public class Menu {
	
	private	String		menuId;
	private	String	systemCode;
	private int		depth;
	private int		seq;
	private String	parentMenuId;
	private String	menuName;
	private String	linkUrl;
	private String	createId;
	private String	createDate;
	private String	updateId;
	private String	updateDate;
	
	private List<Menu> subMenus;
	
	public void addSubMenu(Menu menu)
	{
		if(subMenus == null)
		{
			subMenus = Lists.newArrayList();
		}
		
		subMenus.add(menu);
	}
	
}
