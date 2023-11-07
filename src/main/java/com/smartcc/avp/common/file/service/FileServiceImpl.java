package com.smartcc.avp.common.file.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import com.smartcc.avp.common.file.FileUtil;
import com.smartcc.avp.pc.product.FileDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.file.dao.FileDAO;
import com.smartcc.avp.common.model.ApiException;

@Service
public class FileServiceImpl implements FileService {
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	private static final SimpleDateFormat timeFormat = new SimpleDateFormat("HHmmssSSS");

	public final static int IMAGE_FILE_UPLOAD_FAIL = 9999;

	public final static int UPLOAD_COUPON_EXCEL_FAIL = 1000;
	public final static int COUPON_EXCEL_FORMAT_ERR = 1001;

	@Inject
	FileDAO fileDAO;

	// upload.image.path=/usr/local/tomcat/fileStorage/upload/
	@Value("#{config['upload.image.path']}")
	private String UPLOAD_IMAGE_PATH;

	// upload.image.url=/fileStorage/upload/
	@Value("#{config['upload.image.url']}")
	private String UPLOAD_IMAGE_URL;

	@Value("#{config['upload.video.path']}")
	private String UPLOAD_VIDEO_PATH;

	// upload.image.url=/fileStorage/upload/
	@Value("#{config['upload.video.url']}")
	private String UPLOAD_VIDEO_URL;

	@Value("#{config['upload.tts.path']}")
	private String UPLOAD_TTS_PATH;

	// upload.image.url=/fileStorage/upload/
	@Value("#{config['upload.tts.url']}")
	private String UPLOAD_TTS_URL;

	@Value("#{config['upload.image.user.url']}")
	private String UPLOAD_IMAGE_USER_URL;

	@Value("#{config['upload.image.user.path']}")
	private String UPLOAD_IMAGE_USER_PATH;

//	@Override
//	public int fileCheck(FileData fileData) throws Exception {
//		return fileDAO.checkFile(fileData);
//	}
//
//	@Override
//	public int updateFile(FileData fileData) throws Exception {
//		return fileDAO.updateFile(fileData);
//	}

	@Override
//	@Transactional
	public FileData fileUpload(MultipartFile file, Integer userId) throws Exception {
		String url = UPLOAD_IMAGE_URL;
		String dirPath = UPLOAD_IMAGE_PATH;
		String date = dateFormat.format(Calendar.getInstance().getTime()) + "/";

//		dirPath = dirPath+date;
//		url = url+date;

		dirPath = UPLOAD_IMAGE_USER_PATH + "user_" + userId + "/";
		url = UPLOAD_IMAGE_USER_URL + "user_" + userId + "/";

		FileData rtn = new FileData();
		try {

			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				// 디렉토리 생성 실패
				if (!dirFile.mkdirs()) {
					// 에러 처리
				}
			}
			String fileName = timeFormat.format(Calendar.getInstance().getTime()) + "_" + file.getOriginalFilename();
//				String fileSavePath = UPLOAD_IMAGE_PATH + dirPath + fileName;

			FileData fileData = new FileData();
			fileData.setFileName(fileName);
			fileData.setOriginalFileName(file.getOriginalFilename());
			fileData.setFileSize(file.getSize());
			fileData.setFileSavePath(dirPath + fileName);
			fileData.setFileUrl(url + fileName);
			fileData.setUserId(userId);

			fileDAO.insertFile(fileData);

			File test = new File(dirPath + fileName);
			file.transferTo(test);

			rtn = fileData;

			rtn.setRtnFile(test);

			return rtn;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public FileData fileUploadNotInsert(MultipartFile file, Integer userId) throws Exception {
		String url = UPLOAD_IMAGE_URL;
		String dirPath = UPLOAD_IMAGE_PATH;
		String date = dateFormat.format(Calendar.getInstance().getTime()) + "/";

//		dirPath = dirPath+date;
//		url = url+date;

		dirPath = UPLOAD_IMAGE_USER_PATH + "user_" + userId + "/";
		url = UPLOAD_IMAGE_USER_URL + "user_" + userId + "/";

		FileData rtn = new FileData();
		try {

			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				// 디렉토리 생성 실패
				if (!dirFile.mkdirs()) {
					// 에러 처리
				}
			}
			String fileName = timeFormat.format(Calendar.getInstance().getTime()) + "_" + file.getOriginalFilename();
//				String fileSavePath = UPLOAD_IMAGE_PATH + dirPath + fileName;

			FileData fileData = new FileData();
			fileData.setFileName(fileName);
			fileData.setOriginalFileName(file.getOriginalFilename());
			fileData.setFileSize(file.getSize());
			fileData.setFileSavePath(dirPath + fileName);
			fileData.setFileUrl(url + fileName);
			fileData.setUserId(userId);

			System.out.println("fileData ::" + fileData);

			File test = new File(dirPath + fileName);
			file.transferTo(test);

			rtn = fileData;

			rtn.setRtnFile(test);

			return rtn;

		} catch (Exception e) {

		}
		return null;
	}

	@Override
	public FileData additionalUploadNotInsert(MultipartFile file, Integer userId) throws Exception {
		String url = UPLOAD_IMAGE_URL;
		String dirPath = UPLOAD_IMAGE_PATH;
		String date = dateFormat.format(Calendar.getInstance().getTime()) + "/";

//		dirPath = dirPath+date;
//		url = url+date;

		dirPath = UPLOAD_IMAGE_USER_PATH + "user_" + userId + "/";
		url = UPLOAD_IMAGE_USER_URL + "user_" + userId + "/";

		FileData rtn = new FileData();
		try {

			File dirFile = new File(dirPath);
			if (!dirFile.exists()) {
				// 디렉토리 생성 실패
				if (!dirFile.mkdirs()) {
					// 에러 처리
				}
			}
			String fileName = file.getOriginalFilename();
//				String fileSavePath = UPLOAD_IMAGE_PATH + dirPath + fileName;

			FileData fileData = new FileData();
			fileData.setFileName(fileName);
			fileData.setOriginalFileName(file.getOriginalFilename());
			fileData.setFileSize(file.getSize());
			fileData.setFileSavePath(dirPath + fileName);
			fileData.setFileUrl(url + fileName);
			fileData.setUserId(userId);

			System.out.println("fileData ::" + fileData);

			File test = new File(dirPath + fileName);
			file.transferTo(test);

			rtn = fileData;

			rtn.setRtnFile(test);

			return rtn;

		} catch (Exception e) {

		}
		return null;
	}

	@Override
	public int insertFileData(FileData data) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.insertFile(data);
	}

	@Override
	public boolean validImage(MultipartFile file) throws ApiException {

		if (!isJpgOrPng(file)) {
			throw new ApiException(IMAGE_FILE_UPLOAD_FAIL, "컨텐츠타입을 확인해 주세요.");
		}
//		
//		long kByte = file.getSize() / 1024;
//		
//		try {
//			BufferedImage bi = ImageIO.read( file.getInputStream() );
//			if(bi.getWidth() > REWARD_IMAGE_LIMIT_SIZE[0] || bi.getHeight() > REWARD_IMAGE_LIMIT_SIZE[1] )
//			{
//				LOGGER.error("허용되는 file size {} * {} " , REWARD_IMAGE_LIMIT_SIZE[0], REWARD_IMAGE_LIMIT_SIZE[1]);
//				LOGGER.error("error : image width over or height over {} * {}", bi.getWidth() , bi.getHeight());
//				throw new ApiException(IMAGE_FILE_UPLOAD_FAIL, "이미지 사이즈가 너무 큽니다. "+ bi.getWidth()+"*"+bi.getHeight());
//			}
//			if(kByte > REWARD_IMAGE_LIMIT_KBYTE)
//			{
//				LOGGER.error("error : image size over", file.getSize() );
//				throw new ApiException(IMAGE_FILE_UPLOAD_FAIL, "이미지 용량이 너무 큽니다. " +  kByte);
//			}
//			
//		} 
//		catch (IOException e) 
//		{
//			LOGGER.error("error occured", e);
//			throw new ApiException(IMAGE_FILE_UPLOAD_FAIL, e.getMessage());
//		} 
//		catch (ApiException me) 
//		{
//			LOGGER.error("error occured", me);
//			throw me;
//		}

		return true;
	}

	private boolean isJpgOrPng(MultipartFile file) {

		if (file.getContentType().equals("image/jpeg") || file.getContentType().equals("image/png")
				|| file.getContentType().equals("image/jpg")) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public int deleteFile(Integer fileId) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.deleteFile(fileId);
	}

	@Override
	public FileData getFile(Integer fileId) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.getFile(fileId);
	}

	@Override
	public int deleteFileArr(List<Integer> list) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.deleteFileArr(list);
	}

	@Override
	public long getMonthlyUsedSize(String startDay, String endDay) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.getMonthlyUsedSize(startDay, endDay);
	}

	@Override
	public long getMyUsedSize(Integer userId) throws Exception {
		// TODO Auto-generated method stub
		return fileDAO.getMyUsedSize(userId);
	}

	@Override
	public FileData getFileByName(String fileName) throws Exception {
		return fileDAO.getFileByName(fileName);
	}

}
