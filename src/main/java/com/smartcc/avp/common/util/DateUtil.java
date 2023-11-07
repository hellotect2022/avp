package com.smartcc.avp.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	private static final SimpleDateFormat monthFormat = new SimpleDateFormat("yyyyMM");
	
	
	public static String getMonth() {
		Calendar cal2 = Calendar.getInstance();
		   Date date = new Date();
		cal2.setTime(date);
		String ymd = monthFormat.format(cal2.getTime());
		
		return ymd;
	}
	
	public static String getDay() {
		Calendar cal2 = Calendar.getInstance();
		   Date date = new Date();
		cal2.setTime(date);
		String ymd = dateFormat.format(cal2.getTime());
		
		return ymd;
	}
}
