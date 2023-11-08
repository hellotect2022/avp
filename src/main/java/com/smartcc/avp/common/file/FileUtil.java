package com.smartcc.avp.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;

import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.file.dao.FileDAO;

public class FileUtil {
	
	
	@Inject
	static FileDAO fileDAO;
	
	
		@Value("#{config['upload.image.path']}")
		private String UPLOAD_IMAGE_PATH;
		
		
		@Value("#{config['upload.image.url']}")
		private String UPLOAD_IMAGE_URL;

	private static String fileUrl = "https://s3.ap-northeast-2.amazonaws.com/smartcctests3/ljs-test-folder/";
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	private static final SimpleDateFormat timeFormat = new SimpleDateFormat("HHmmssSSS");
	public static  FileData fileUploadNew(MultipartFile file, String dirPath) {
		FileData rtn = new FileData();
		try
		{
//			String date = dateFormat.format(Calendar.getInstance().getTime()) + "/";
//			dirPath = dirPath+"/"+date;

			File dirFile = new File(dirPath);
			if(!dirFile.exists())
			{
				//디렉토리 생성 실패
				if(!dirFile.mkdirs())
				{
					//에러 처리
				}
			}
			//String fileName = timeFormat.format(Calendar.getInstance().getTime()) + "_" + file.getOriginalFilename();
			String fileName = file.getOriginalFilename();
//				String fileSavePath = UPLOAD_IMAGE_PATH + dirPath + fileName;

			FileData fileData = new FileData();
			fileData.setFileName(file.getOriginalFilename());
			fileData.setOriginalFileName(file.getOriginalFilename());
			fileData.setFileSize(file.getSize());
			fileData.setFileSavePath(dirPath + fileName);
			fileData.setFileUrl(fileUrl+file.getOriginalFilename());

			System.out.println("fileData ::" + fileData);
			//fileDAO.insertFile(fileData);

			File test =new File(dirPath+fileName);
			file.transferTo(test);

			rtn = fileData;

			rtn.setRtnFile(test);


			return rtn;

		}
		catch(Exception e)
		{
			return null;
		}

	}


	   public static  FileData fileUpload(MultipartFile file, String dirPath) {
		   FileData rtn = new FileData();
			try
			{
				String date = dateFormat.format(Calendar.getInstance().getTime()) + "/";
				
				dirPath = dirPath+"/"+date;
				File dirFile = new File(dirPath);
				if(!dirFile.exists())
				{
					//디렉토리 생성 실패
					if(!dirFile.mkdirs())
					{
						//에러 처리
					}
				}
				String fileName = timeFormat.format(Calendar.getInstance().getTime()) + "_" + file.getOriginalFilename();
//				String fileSavePath = UPLOAD_IMAGE_PATH + dirPath + fileName;
				
				FileData fileData = new FileData();
				fileData.setFileName(fileName);
				fileData.setOriginalFileName(file.getOriginalFilename());
				fileData.setFileSize(file.getSize());
				fileData.setFileSavePath(dirPath + fileName);
				fileData.setFileUrl(fileUrl+fileName);
				
				System.out.println("fileData ::" + fileData);
				fileDAO.insertFile(fileData);
				
				File test =new File(dirPath+fileName);
				file.transferTo(test);
				
				rtn = fileData;
				
				rtn.setRtnFile(test);

				   
				return rtn;
				
			}
			catch(Exception e)
			{
			}
			return null;
			
	   }

	public static ResponseEntity fileDownload(String fileName) throws IOException {
		String filePath = fileName;
		System.out.println("filePath:::"+filePath);
		File file = new File(filePath);
		System.out.println("fileName:::"+file.getName());

		// 파일이 존재하는지 확인하고 InputStreamResource로 변환
		InputStreamResource resource = new InputStreamResource(new FileInputStream(file));

		// 다운로드할 때 파일명 설정
		HttpHeaders headers = new HttpHeaders();
		String encodedFileName = URLEncoder.encode(file.getName(), StandardCharsets.UTF_8.toString());

		headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + encodedFileName);

		// 파일의 MIME 타입에 따라 Content-Type 설정
		String contentType = "application/octet-stream"; // 기본적으로는 이진 파일로 설정
		Path path = Paths.get(filePath);
		if (path != null) {
			contentType = Files.probeContentType(path);
		}

		// ResponseEntity를 이용하여 파일 다운로드 응답 생성
		return ResponseEntity.ok()
				.headers(headers)
				.contentLength(file.length())
				.contentType(MediaType.parseMediaType(contentType))
				.body(resource);
	}
}
