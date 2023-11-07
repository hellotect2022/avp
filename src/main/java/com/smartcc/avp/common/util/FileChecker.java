package com.smartcc.avp.common.util;

import com.smartcc.avp.common.code.CommonCode;

public class FileChecker {

	
	public static String fileSizeCheck(long mylimitSize,long monthlyLimitSize,long mySaveSize,long allUserSaveSize ,long insertFileSize)
	{
		
		 // 내가 한달동안 사용할수 있는 용량  < 현재 상점 등록시 필요한 파일 사이즈 + 요번달 내가 사용항 용량 
		 if(mylimitSize < insertFileSize + mySaveSize)
		 {
			 return CommonCode.FILE_VALID.MY_SIZE_OVER.code;
		 }
		 
		 if(monthlyLimitSize < insertFileSize + allUserSaveSize)
		 {
			 return CommonCode.FILE_VALID.S3_SIZE_OVER.code;
		 }
		return "SUCCESS";
	}
	
}
