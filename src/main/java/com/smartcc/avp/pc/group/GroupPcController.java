package com.smartcc.avp.pc.group;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.BaseController;
import com.smartcc.avp.common.code.CommonCode;
import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.util.DateUtil;
import com.smartcc.avp.common.util.LogUtil;
import com.smartcc.avp.pc.user.model.User;
import com.smartcc.avp.pc.group.model.GroupListRequest;
import com.smartcc.avp.pc.group.model.GroupListResponse;
import com.smartcc.avp.pc.group.service.GroupService;

import lombok.Setter;

@Controller
@RequestMapping(value="/group/desktop")
public class GroupPcController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(GroupPcController.class);
	
	@Setter
	@Resource GroupService groupService;
		
	public static   	String ym = DateUtil.getMonth();
	
	@RequestMapping(value="/groupList", method = {RequestMethod.POST})
	@ResponseBody
	public Response groupList() throws Exception {
		LogUtil.setGroup("J.Bum PC");
		Map<String, Object> result = new HashMap<>();
		
		//req.set
		List<GroupListResponse> cmpgns = groupService.getGroupList();

		result.put("companys", cmpgns);
		
//		return new Response(resData);
		LogUtil.clearGroup();
		return new Response(result);
	}
	
}
