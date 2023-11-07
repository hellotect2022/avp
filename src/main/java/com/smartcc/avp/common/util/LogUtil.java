package com.smartcc.avp.common.util;

import org.slf4j.MDC;

public class LogUtil {
	public static void setGroup(String userMark) {
		StackTraceElement[] trace = Thread.currentThread().getStackTrace();
		if(trace != null && trace.length > 2)
		{
			MDC.put("group", userMark+" "+trace[2].getClassName());
			MDC.put("action", trace[2].getMethodName());
		}
	}
	
	public static void clearGroup() {
		MDC.clear();
	}

}
