package com.smartcc.avp.pc.product;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileDTO {
   private Integer			shopId;
   private String 			targetName;
   private MultipartFile 	uploadfile;
   private String			encodingData;
   private MultipartFile 	targetfile;
   private Integer			targetSize;
   private String			objectType;
   private Integer			objectFileId;
   private Integer			fileType;
   private Integer			targetFileId;
   private String			targetId;
   private String			metaData;
   private Integer			createId;
   private String			useStatus;
}
