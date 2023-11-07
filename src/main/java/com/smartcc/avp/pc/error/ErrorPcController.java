package com.smartcc.avp.pc.error;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.error.model.ErrorLogInsertRequest;

@Controller
@RequestMapping(value="/pc/error")
public class ErrorPcController  extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ErrorPcController.class);
	
	/**
	 * 캠페인 목록을 조회한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/errorPage", method = {RequestMethod.GET})
	public String errorPage(HttpServletRequest request ,ModelMap modelMap) throws Exception {
		return "pc/error_page";
	}
	
	/**
	 * 에러 발생시 에러로그를 남기기 위한 AJAX
	 * @return 
	 * response Type : JSON
	 * @throws Exception
	 * 	 
	*/
	@RequestMapping(value="/errorLogInsert", method = {RequestMethod.POST})
	@ResponseBody
	public Response errorLogInsert(HttpServletRequest request, HttpServletResponse response,@RequestBody @Valid ErrorLogInsertRequest req) throws Exception {
		LogUtil.setGroup("JS.LEE PC");
		logger.error("error status :: "+ req.getStatus(), req);
		LogUtil.clearGroup();
		return new Response();
	}
	
	
	
	
}
