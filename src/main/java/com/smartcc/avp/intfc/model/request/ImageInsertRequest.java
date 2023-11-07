package com.smartcc.avp.intfc.model.request;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * <pre>
	private MultipartFile imgFile;
	private Integer		userId;
	private String		fileType;
*  </pre>
 */
@Data
public class ImageInsertRequest {
	private MultipartFile imgFile;
	private Integer		userId;
	private String		fileType;
}
