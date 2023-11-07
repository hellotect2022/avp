package com.smartcc.avp.pc.ar;

import java.io.FileNotFoundException;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.smartcc.avp.common.file.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.FileData;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.file.service.FileService;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.PageInfo;
import com.smartcc.avp.common.model.Period;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.FileChecker;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.ar.model.ArInfo;
import com.smartcc.avp.pc.ar.model.request.ArDetailPageRequest;
import com.smartcc.avp.pc.ar.model.request.ArInsertRequest;
import com.smartcc.avp.pc.ar.model.request.ArListRequest;
import com.smartcc.avp.pc.ar.model.request.ArUpdatePageRequest;
import com.smartcc.avp.pc.ar.model.response.ArListResponse;
import com.smartcc.avp.pc.ar.service.ArService;
import com.smartcc.avp.pc.ar.vuforia.model.VuforiaResponse;
import com.smartcc.avp.pc.ar.vuforia.util.DeleteTarget;
import com.smartcc.avp.pc.ar.vuforia.util.PostNewTarget;
import com.smartcc.avp.pc.ar.vuforia.util.UpdateTarget;
import com.smartcc.avp.pc.login.service.LoginService;
import com.smartcc.avp.pc.product.service.ProductService;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import lombok.Setter;

/**
 * PC > Ar Class
 * 
 * @author JS.LEE
 */
@Controller
@RequestMapping(value = "/pc/ar")
public class ArPcController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ArPcController.class);

	@Value("#{config['s3.bucket']}")
	private String bucketName;

	public static String ym = DateUtil.getMonth();

	@Setter
	@Resource
	ProductService productService;

	@Setter
	@Resource
	FileService fileService;

	@Setter
	@Resource
	ArService arService;

	@Setter
	@Resource
	LoginService loginService;

	@Value("#{config['s3.upload.monthly.limitsize']}")
	private String MONTHLY_LIMIT_SIZE;

	@Value("#{config['s3.upload.monthly.vuforia.cloudtargets']}")
	private String VUFORIA_LIMIT_TARGETS;

	@Value("#{config['s3.upload.monthly.fileput']}")
	private String MONTHLY_FILE_PUT;

	@Value("#{config['rds.limit.count']}")
	private String rdsLimitCnt;

	// Add 2017. 08. 23. JBum | 계정관리용 스키마 추가
	@Value("#{config['schema.chum']}")
	private String chumSchema;

	@Value("#{config['schema.scgp']}")
	private String scgpSchema;

	@Value("#{config['schema.bogoga']}")
	private String bogogaSchema;
	// End of
	@Value("#{config['upload.resource.path']}")
	private String UPLOAD_RESOURCE_PATH;


	/**
	 * 타겟 등록 페이지 이동
	 * 
	 * @return response Type : String return page : /pc/ar/ar_insert_page
	 */
	@RequestMapping(value = "/arInsertPage", method = { RequestMethod.GET })
	public String arInsertPage(HttpServletRequest request, ModelMap modelMap) throws Exception {
		LogUtil.setGroup("arInsertPage");

//		LogUtil.setGroup("ddd");
//		LogUtil.clearGroup();

		LogUtil.clearGroup();
		return "/pc/ar/ar_insert_page";
	}

	/**
	 * 타겟등록 AJAX
	 * 
	 * @param {@link com.smartcc.avp.pc.ar.model.ArInfo}
	 * @return response Type : JSON response Header : 200 정상 : 900 나머지 예외 사항 에러 :
	 *         999 뷰포리아 관련 에러 및 request 제한 초과 에러
	 */
	@RequestMapping(value = "/arInsert", method = { RequestMethod.POST })
	@ResponseBody
	public Response arInsert(HttpServletRequest request, ArInfo dto,
			@RequestParam(value = "recogImg", required = false) MultipartFile uploadfile,
			@RequestParam(value = "arImg", required = false) MultipartFile targetFile,
			 @RequestParam(value = "arVideo", required = false) MultipartFile videofile,
			 @RequestParam(value = "arTts", required = false) MultipartFile ttsfile,
			@RequestParam(value = "arScript", required = false) String arScript,
			/* @RequestBody @Valid */ ArInsertRequest arReq) throws Exception {
		LogUtil.setGroup("arInsert");
		HttpSession session = request.getSession();
		// S3Util s3 = new S3Util();
		long insertFileSize = 0;
		Integer userId = (Integer) session.getAttribute("userId");
		Integer rdsCnt = 1;

		User user = loginService.getUserInfo(userId);
//
//		InetAddress localHost = InetAddress.getLocalHost();
//
//		// 호스트 이름과 IP 주소를 출력합니다.
//		System.out.println("호스트 이름: " + localHost.getHostName());
//		System.out.println("IP 주소: " + localHost.getHostAddress());

//		FileData file1 = FileUtil.fileUploadNew(targetFile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
//		file1.setFileName(dto.getArName());
//		file1.setUserId(userId);
//		file1.setFileSrc("image");
//		if (fileService.fileCheck(file1)>0){
//			fileService.updateFile(file1);
//		}else {
//			fileService.insertFileData(file1);
//		}
//
//		FileData file2= FileUtil.fileUploadNew(videofile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
//		file2.setFileName(dto.getArName());
//		file2.setUserId(userId);
//		file2.setFileSrc("video");
//		if (fileService.fileCheck(file2)>0){
//			fileService.updateFile(file2);
//		}else {
//			fileService.insertFileData(file2);
//		}
//
//		fileService.insertFileData(file2);
//		FileData file3 = FileUtil.fileUploadNew(ttsfile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
//		file3.setFileName(dto.getArName());
//		file3.setUserId(userId);
//		file3.setFileSrc("tts");
//		if (fileService.fileCheck(file3)>0){
//			fileService.updateFile(file3);
//		}else {
//			fileService.insertFileData(file3);
//		}

		dto.setCompanyId(user.getCompanyId());
		dto.setBranchId(user.getBranchId());
		dto.setCreateId(userId);
		dto.setUpdateId(userId);
		String tableName = (String) session.getAttribute("division");
		dto.setArScript(arScript);
		//dto.setFileDataList(files);
		arService.insertAr(tableName, dto);

//	 		long mylimitSize =Long.valueOf(user.getStorageSize()).longValue();
//	 		long monthlyLimitSize =Long.valueOf(MONTHLY_LIMIT_SIZE).longValue();
//	 		long mySaveSize = statisticsService.getMyFileSize(userId,ym);
//	 		long allUserSaveSize = statisticsService.getMyFileSize(null,ym);
//	        Integer awsFileistCount = 0;
//			int vuforiaLimitCnt = Integer.parseInt(VUFORIA_LIMIT_TARGETS);
//			int filePutLimitCnt = Integer.parseInt(MONTHLY_FILE_PUT);
//			 insertFileSize = uploadfile.getSize();
//			 insertFileSize = insertFileSize + uploadfile.getSize();
//			 String rtnStr = FileChecker.fileSizeCheck(mylimitSize,monthlyLimitSize,mySaveSize,allUserSaveSize ,insertFileSize);
//			 
//			 if(CommonCode.FILE_VALID.MY_SIZE_OVER.code.equals(rtnStr))
//			 {
//				// 이미 저장 되어 있는경우
//				if(null != cnt)
//				{
//					statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,5);
//				}
//				else
//				{
//					statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,5);
//				}
//				 return new Response(new ApiException(999, CommonCode.FILE_VALID.MY_SIZE_OVER.name));
//			 }
//			 else if(CommonCode.FILE_VALID.S3_SIZE_OVER.code.equals(rtnStr))
//			 {
//				// 이미 저장 되어 있는경우
//					if(null != cnt)
//					{
//						statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,5);
//					}
//					else
//					{
//						statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,5);
//					}
//				 return new Response(new ApiException(999, CommonCode.FILE_VALID.S3_SIZE_OVER.name));
//			 }
//			 else
//			 {
//				 
//			 }

		/*
		 * Integer vuforiaCnt =
		 * statisticsService.getStatisticVuforia(CommonCode.STATISTIC_TYPE.CLOUD_TARGETS
		 * .code,ym); logger.debug("PC AR :: 지금까지 저장된 뷰포리아 카운트  ::" + vuforiaCnt);
		 * if(null != vuforiaCnt) { if(vuforiaLimitCnt < vuforiaCnt + 1) { if(null !=
		 * cnt) {
		 * statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code
		 * ,ym,5); } else {
		 * statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code
		 * ,ym,5); } return new Response(new ApiException(999,
		 * "뷰포리아 등록회수 초과 하였습니다. ")); } }
		 */

//-------------------------------------------파일 풋  확인 --------------------------------------------------------------------
		/*
		 * Integer filePutCnt =
		 * statisticsService.getStatisticAWS(CommonCode.STATISTIC_TYPE.AWS_FILEPUT.code,
		 * ym); logger.debug("PC AR :: filePutCnt ::" + filePutCnt); if(null !=
		 * filePutCnt) { if(filePutLimitCnt < filePutCnt + 2) { if(null != cnt) {
		 * statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code
		 * ,ym,5); } else {
		 * statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code
		 * ,ym,5); } return new Response(new ApiException(999,
		 * "파일 등록회수 초과 하였습니다. ")); } }
		 */
//-------------------------------------------파일 풋  확인  END------------------------------------------------------------------

//		FileData obj = fileService.fileUploadNotInsert(uploadfile, userId);
//		FileData tartget = fileService.fileUploadNotInsert(targetFile, userId);
//
//		logger.debug("PC AR :: obj FileData ::" + obj);
//		logger.debug("PC AR :: tartget FileData ::" + tartget);
//
//		PostNewTarget p = new PostNewTarget();

//			 VuforiaResponse res = p.postTargetThenPollStatus(tartget.getRtnFile(), dto.getTargetName(), "");
//		VuforiaResponse res = p.postTargetThenPollStatus(tartget.getRtnFile(), dto.getArName(),
//				/*Meradata*/"user_" + userId + "/" + obj.getRtnFile().getName() + "," + arReq.getItemId());
//
//		logger.debug("PC AR :: Vuforia Cloud DB Insert Result ::" + res);
//		// s3.fileUpload(bucketName+"/"+"user_"+user.getUserId(), obj.getRtnFile());
//		if ("TargetCreated".equals(res.getResultCode()) || "Success".equals(res.getResultCode())) {
//			fileService.insertFileData(obj);
//			fileService.insertFileData(tartget);
//
//			dto.setCompanyId(user.getCompanyId());
//			dto.setBranchId(user.getBranchId());

//			dto.setRecogImgId(obj.getFileId());
//			dto.setArImgId(tartget.getFileId());
//			dto.setMetaData(obj.getRtnFile().getName());
//			dto.setTargetId(res.getUniqueTargetId());
//			dto.setCreateId(userId);
//			dto.setUpdateId(userId);
////
//			String tableName = (String) session.getAttribute("division");
//
//			logger.debug("PC AR :: TB_TOUR_AR TB INSERT REQ DATA ::" + dto);
//
//			arService.insertAr(tableName, dto);
//		} else {
//			if ("AuthenticationFailure".equals(res.getResultCode())) {
//				return new Response(new ApiException(999, "권환 실패 "));
//			} else if ("RequestTimeTooSkewed".equals(res.getResultCode())) {
//				return new Response(new ApiException(999, "업로드중 타임아웃이 발생되었습니다."));
//			} else if ("TargetNameExist".equals(res.getResultCode())) {
//				return new Response(new ApiException(999, "AR 명이 존재합니다."));
//			} else if ("BadImage".equals(res.getResultCode())) {
//				return new Response(new ApiException(999, "선택하신 이미지는 지원되지 않습니다."));
//			} else if ("MetadataTooLarge".equals(res.getResultCode())) {
//				return new Response(new ApiException(999, "사이즈가 너무 큽니다."));
//			} else {
//				return new Response(new ApiException(Integer.parseInt(res.getResultCode()), "업로드 실패하였습니다."));
//			}
//
//		}
		logger.info("PC AR :: arInsert Ajax End");
		LogUtil.clearGroup();
		return new Response();
	}

	/**
	 * 타겟 목록 리스트 페이지 이동
	 * 
	 * @return /pc/ar/ar_list_page
	 */
	@RequestMapping(value = "/arListPage", method = { RequestMethod.GET })
	public String arListPage(ModelMap modelMap) throws Exception {
		LogUtil.setGroup("arListPage");
		LogUtil.clearGroup();

		return "/pc/ar/ar_list_page";
	}

	/**
	 * 타겟 목록 AJAX response Type : JSON response Header : 200 정상 : 900 나머지 예외 사항 에러 :
	 * 999 request 제한 초과 에러 response Body : list - {@link ArListResponse}
	 */
	@RequestMapping(value = "/arList", method = { RequestMethod.POST })
	@ResponseBody
	public Response arList(HttpServletRequest request, HttpServletResponse response,
			@RequestBody @Valid ArListRequest req) throws Exception {
		LogUtil.setGroup("arList");
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userIds = (Integer) session.getAttribute("userId");
		Integer rdsCnt = 1;

		User user = loginService.getUserInfo(userIds);

		req.setUserId(user.getUserId());
		// 유저타입의 따라 where 조건이 달라ㄱ지기 때문에 셋팅
		req.setUserType(user.getUserType());
		// 유저타입이 admin일경우 shopid 가져오기 위해 저장
		req.setCompanyId(user.getCompanyId());

		String tableName = (String) session.getAttribute("division");

		List<ArListResponse> ars = arService.getArList(tableName, req);
		logger.info("PC AR :: ars ResponseDAta :" + ars);

		result.put("ars", ars);
		result.put("pageInfo", req.getPageInfo());

//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}

	/**
	 * 타겟 상세 페이지 이동
	 * 
	 * @param {@link ArDetailPageRequest}
	 * @return response Type : String return page : /pc/ar/ar_detail_page
	 */
	@RequestMapping(value = "/arDetailPage", method = { RequestMethod.GET })
	public String arDetailPage(HttpServletRequest request, ModelMap modelMap, ArDetailPageRequest req)
			throws Exception {
		LogUtil.setGroup("arDetailPage");
		HttpSession session = request.getSession();
		Integer userIds = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);

//		boolean permissionResult = PermissionUtil.pcSessionCheck(request.getRequestURI(),user);
//		
//		if(!permissionResult)
//		{
//			return "/pc/auth/permission_not_accept";
//		}
		String tableName = (String) session.getAttribute("division");

//		int count = arService.checkAr(tableName, user,req.getArId());
//		logger.debug("PC AR :: checkAr :" + count);
//		if(count < 0)
//		{
//			if(null != cnt)
//			{
//				statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,4);
//			}
//			else
//			{
//				statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code,ym,4);
//			}
//			return "/pc/auth/permission_not_accept";
//		}

		//ArInfo ar = arService.arDetailPage(tableName, req.getArId());
		ArInfo ar = arService.arDetailPageNew(tableName, req.getArId());
		logger.debug("PC AR :: get Ar Detail  :" + ar);

		modelMap.put("ar", ar);
		logger.info("PC AR :: arDetailPage End");
		LogUtil.clearGroup();
		return "/pc/ar/ar_detail_page";
	}

	/**
	 * 타겟 수정 페이지 이동
	 * 
	 * @param {@link ArDetailPageRequest}
	 * @return return page : /pc/ar/ar_update_page
	 */
	@RequestMapping(value = "/arUpdatePage", method = { RequestMethod.GET })
	public String arUpdatePage(HttpServletRequest request, ModelMap modelMap, ArDetailPageRequest req)
			throws Exception {
		LogUtil.setGroup("arUpdatePage");
		HttpSession session = request.getSession();
		Integer userIds = (Integer) session.getAttribute("userId");
		User user = loginService.getUserInfo(userIds);
		String tableName = (String) session.getAttribute("division");

//		int count = arService.checkAr(tableName, user,req.getArId());

//		ArInfo ar = arService.arDetailPage(tableName, req.getArId());
		ArInfo ar = arService.arDetailPageNew(tableName, req.getArId());

		modelMap.put("ar", ar);

		LogUtil.clearGroup();
		return "/pc/ar/ar_update_page";
	}

	/**
	 * 타겟수정 AJAX
	 * 
	 * @param {@link ArUpdatePageRequest}
	 * @return response Header : 200 정상 : 900 나머지 예외 사항 에러 : 999 뷰포리아 , request
	 *         count 에러
	 */
	@RequestMapping(value = "/arUpdate", method = { RequestMethod.POST }, headers = "content-type=multipart/*")
	@ResponseBody
	public Response arUpdate(HttpServletRequest request,ArInfo dto,
			@RequestParam(value = "arImg", required = false) MultipartFile targetfile,
			@RequestParam(value = "recogImg", required = false) MultipartFile uploadfile,
			@RequestParam(value = "arVideo", required = false) MultipartFile videofile,
			@RequestParam(value = "arTts", required = false) MultipartFile ttsfile,
			@RequestParam(value = "arScript", required = false) String arScript,
			ArUpdatePageRequest req)
			throws Exception {
//		LogUtil.setGroup("arUpdate");
//		HttpSession session = request.getSession();
//		Integer userId = (Integer) session.getAttribute("userId");
//
//		req.setUpdateId(userId);
//
//		UpdateTarget vrUpdate = new UpdateTarget();
//
//		FileData obj = new FileData();
//		FileData tartget = new FileData();
//
//		String metaFileName = req.getPreRecogImgName();
//
//		List<Integer> fileDelList = new ArrayList<Integer>();
//
//		// 1.업로드된 파일이 있나 확인
////		String ym = DateUtil.getMonth();
////		long insertFileSize = 0;
//
//		User user = loginService.getUserInfo(userId);
//
////		Integer cnt = statisticsService.getStatisticAWS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym);
////		long mylimitSize = Long.valueOf(user.getStorageSize()).longValue();
////		long monthlyLimitSize = Long.valueOf(MONTHLY_LIMIT_SIZE).longValue();
////		long mySaveSize = statisticsService.getMyFileSize(userId, ym);
////		long allUserSaveSize = statisticsService.getMyFileSize(null, ym);
////		int filePutLimitCnt = Integer.parseInt(MONTHLY_FILE_PUT);
//
////		int awsFileistCount = 0;
//
//		if (null != uploadfile) {
//			obj = fileService.fileUploadNotInsert(uploadfile, userId);
////			insertFileSize = uploadfile.getSize();
//			metaFileName = obj.getRtnFile().getName();
//			req.setObjectFileId(req.getPreObjectFileId());
////			awsFileistCount = awsFileistCount + 1;
//		}
//		if (null != targetfile) {
//			tartget = fileService.fileUploadNotInsert(targetfile, userId);
////			insertFileSize = insertFileSize + uploadfile.getSize();
////			awsFileistCount = awsFileistCount + 1;
//		}
////		String rtnStr = FileChecker.fileSizeCheck(mylimitSize, monthlyLimitSize, mySaveSize, allUserSaveSize,
////				insertFileSize);
//
////		if (CommonCode.FILE_VALID.MY_SIZE_OVER.code.equals(rtnStr)) {
////			if (null != cnt) {
////				statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 6);
////			} else {
////				statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 6);
////			}
////			return new Response(new ApiException(999, CommonCode.FILE_VALID.MY_SIZE_OVER.name));
////		} else if (CommonCode.FILE_VALID.MY_SIZE_OVER.code.equals(rtnStr)) {
////			if (null != cnt) {
////				statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 6);
////			} else {
////				statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 6);
////			}
////
////			return new Response(new ApiException(999, CommonCode.FILE_VALID.S3_SIZE_OVER.name));
////		} else {
////
////		}
//
//		int vuforiaLimitCnt = Integer.parseInt(VUFORIA_LIMIT_TARGETS);
//				// 1.AR 파일 확인
//		if (null != targetfile) {
//			String updateMeta = "/user_" + userId + "/" + metaFileName;
////
//			String res = vrUpdate.intiUpdateTarget(req.getTargetId(), req.getTargetName(), tartget.getRtnFile(),
//					updateMeta);
//
//			logger.info("VF RES :::: " + res);
//
//			if ("TargetCreated".equals(res) || "Success".equals(res) || "TargetStatusNotSuccess".equals(res)) {
////				fileService.insertFileData(tartget);
//				try {
//					// 타겟
//					FileData targetPreFile = fileService.getFile(req.getPreArImgId());
////							 fileService.deleteFile(req.getPreTargetFileId());
//					fileDelList.add(req.getPreArImgId());
//
//					if (userId == targetPreFile.getCreateId()) {
////						mySaveSize = mySaveSize - targetPreFile.getFileSize() + tartget.getFileSize();
//
//					}
//					// 현재 등록하는 사람이 이전에 등록한 사람과 다르면
//					else {
//						// 이전에 등록한 유저의 대해서 파일 사이즈는 지워 준다.
////						statisticsService.deletePreInsertUserData(targetPreFile.getCreateId(), ym,
////								tartget.getFileSize());
////						mySaveSize = mySaveSize + tartget.getFileSize();
//					}
////					req.setMetaData(obj.getRtnFile().getName());
//					req.setMetaData(metaFileName);
//				} catch (FileNotFoundException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//				fileService.insertFileData(tartget);
//				req.setArImgId(tartget.getFileId());
//
//			} else {
//				if ("AuthenticationFailure".equals(res)) {
//					return new Response(new ApiException(999, "권환 실패 "));
//				} else if ("RequestTimeTooSkewed".equals(res)) {
//					return new Response(new ApiException(999, "AR 업로드중 타임아웃이 발생되었습니다."));
//				} else if ("TargetNameExist".equals(res)) {
//					return new Response(new ApiException(999, "AR명이 존재합니다."));
//				} else if ("BadImage".equals(res)) {
//					return new Response(new ApiException(999, "선택하신 이미지는 지원되지 않습니다."));
//				} else if ("MetadataTooLarge".equals(res)) {
//					return new Response(new ApiException(999, "사이즈가 너무 큽니다."));
//				} else {
//					return new Response(new ApiException(9999, "업로드 실패하였습니다."));
//				}
//			}
//		} else {
//			req.setArImgId(req.getPreArImgId());
//		}
//
//		// Recog File Check
//		if (null != uploadfile) {
//			fileService.insertFileData(obj);
//			FileData objPreFile = fileService.getFile(req.getPreRecogImgId());
////				fileService.deleteFile(req.getPreObjectFileId());
//			fileDelList.add(req.getPreRecogImgId());
//
//			req.setRecogImgId(obj.getFileId());
//
//			if (userId == objPreFile.getCreateId()) {
////				mySaveSize = mySaveSize - objPreFile.getFileSize() + obj.getFileSize();
//			}
//			// 현재 등록하는 사람이 이전에 등록한 사람과 다르면
//			else {
//				// 이전에 등록한 유저의 대해서 파일 사이즈는 지워 준다.
////				statisticsService.deletePreInsertUserData(objPreFile.getCreateId(), ym, objPreFile.getFileSize());
////				mySaveSize = mySaveSize + obj.getFileSize();
//			}
//		} else {
//			req.setRecogImgId(req.getPreRecogImgId());
//		}
//
//		if (fileDelList.size() > 0) {
//			fileService.deleteFileArr(fileDelList);
//		}
		LogUtil.setGroup("arUpdate");
		HttpSession session = request.getSession();
		// S3Util s3 = new S3Util();
		long insertFileSize = 0;
		Integer userId = (Integer) session.getAttribute("userId");
		Integer rdsCnt = 1;

		User user = loginService.getUserInfo(userId);


		FileData file1 = FileUtil.fileUploadNew(targetfile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
		file1.setFileName(dto.getArName());
		file1.setUserId(userId);
		file1.setFileSrc("image");
//		if (fileService.fileCheck(file1)>0){
//			fileService.updateFile(file1);
//		}else {
//			fileService.insertFileData(file1);
//		}


//		FileData file2= FileUtil.fileUploadNew(videofile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
//		file2.setFileName(dto.getArName());
//		file2.setUserId(userId);
//		file2.setFileSrc("video");
//		if (fileService.fileCheck(file2)>0){
//			fileService.updateFile(file2);
//		}else {
//			fileService.insertFileData(file2);
//		}
//
//
//		fileService.insertFileData(file2);
//		FileData file3 = FileUtil.fileUploadNew(ttsfile,UPLOAD_RESOURCE_PATH+dto.getArName()+"/");
//		file3.setFileName(dto.getArName());
//		file3.setUserId(userId);
//		file3.setFileSrc("tts");
//		if (fileService.fileCheck(file3)>0){
//			fileService.updateFile(file3);
//		}else {
//			fileService.insertFileData(file3);
//		}


		dto.setCompanyId(user.getCompanyId());
		dto.setBranchId(user.getBranchId());
		dto.setCreateId(userId);
		dto.setUpdateId(userId);
		String tableName = (String) session.getAttribute("division");
		dto.setArScript(arScript);

		arService.updateAr(tableName, req);
		//arService.updateArNew(tableName, dto);
//		statisticsService.updateS3UploadTB(userId, ym, mySaveSize);
		logger.info("PC AR :: arUpdate Ajax End");
		LogUtil.clearGroup();
		return new Response();
	}

	/**
	 * @param {@link ArInfo} 타겟 삭제 AJAX
	 * @return response Type : JSON response Header : 200 정상 : 900 나머지 예외 사항 에러 :
	 *         900 exception 에러
	 */
	@RequestMapping(value = "/arDelete", method = { RequestMethod.POST })
	@ResponseBody
	public Response arDelete(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request,
			@RequestBody ArInfo req) throws Exception {
		LogUtil.setGroup("arDelete");
		logger.info("############ AR 삭제 시작 ################");
		HttpSession session = request.getSession();
		Integer userIds = (Integer) session.getAttribute("userId");
		String tableName = (String) session.getAttribute("division");

		if (null == userIds) {
			return new Response(new ApiException(997, "session 만료"));
		}
		List<Integer> list = new ArrayList<Integer>();
		
		ArInfo ar = arService.arDetailPage(tableName, req.getArId());

		FileData targetFile = fileService.getFile(ar.getArImgId());
		FileData objFile = fileService.getFile(ar.getRecogImgId());

		list.add(ar.getArImgId());
		list.add(ar.getRecogImgId());

//		statisticsService.deletePreInsertUserData(targetFile.getCreateId(), ym, targetFile.getFileSize());
//		statisticsService.deletePreInsertUserData(objFile.getCreateId(), ym, objFile.getFileSize());

		DeleteTarget vuforiaDel = new DeleteTarget();
		
		try {
			vuforiaDel.deleteTargetFromVF(ar.getTargetId());
		} catch (Exception e) {
			e.printStackTrace();
		}

//		vuforiaDel.deactivateThenDeleteTarget(ar.getTargetId());

		fileService.deleteFileArr(list);
		arService.deleteAr(tableName, req.getArId(), userIds);

//		Integer cnt = statisticsService.getStatisticAWS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym);
//		if (null != cnt) {
//			statisticsService.updateStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 7);
//		} else {
//			statisticsService.insertStatisticRDS(CommonCode.STATISTIC_TYPE.RDS_QUERY.code, ym, 7);
//		}
		
		LogUtil.clearGroup();
		return new Response();
	}

}
