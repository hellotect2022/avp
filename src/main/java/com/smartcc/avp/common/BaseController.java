package com.smartcc.avp.common;

import static com.smartcc.avp.common.BaseConst.Code.AUTH_TOKEN_EXPIRED;
import static com.smartcc.avp.common.BaseConst.Code.INVALID_ERROR;
import static com.smartcc.avp.common.BaseConst.Code.SYSTEM_ERROR;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smartcc.avp.common.model.ApiException;
import com.smartcc.avp.common.model.response.Header;
import com.smartcc.avp.common.model.response.Payload;
import com.smartcc.avp.common.model.response.Response;
import com.smartcc.avp.common.model.response.ResponseHeader;

@Controller
public class BaseController {

	private final Logger LOGGER = LoggerFactory.getLogger(BaseController.class);
	
	public final static String RESPONSE_HTML 	= "RESPONSE_HTML";
	public final static String RESPONSE_JSON 	= "RESPONSE_JSON";
	public final static String ADMIN_USER		=	"adminUser";
	
	/**
	 * @param e Biz Logic 외의 예상하지 못한 Runtime Exception에 대한 예외를 처리한다.
	 * @return
	 */
	@ExceptionHandler(RuntimeException.class)
	@ResponseBody
	public ResponseEntity<Response>  runtimeException(Exception e, HttpServletResponse httpServletResponse) {
		e.printStackTrace();
		LOGGER.error(">>> SYSTEM_ERROR: {}", e);
		Response response;
		if (e instanceof HttpMessageNotReadableException) {
			//response = new Response(new ApiException(INVALID_ERROR, "Wrong Parameter : " + e.getLocalizedMessage()));
			LOGGER.error("Internal Server Error", e);
			response = new Response(new ApiException(SYSTEM_ERROR, "잘못 된 값이 전달되어 에러가 발생했습니다. 관리자에게 문의해주세요."));
		} else {
			LOGGER.error("Internal Server Error", e);
			//response = new Response(new ApiException(SYSTEM_ERROR, "RuntimeException : " + e.getLocalizedMessage()));
			response = new Response(new ApiException(SYSTEM_ERROR, "처리 중 에러가 발생했습니다. 관리자에게 문의해주세요."));
		}
		
        return new ResponseEntity<Response>(response, makeHttpStatusCode(response));

	}	
	
	
	/**
	 * 스마트 투어의 Biz Logic에서 발생하는 예외 상황에 대해 지정된 형식의 json으로 Http Response를 생성하고 전달한다.
	 * @param e {@link ApiException}
	 * @return response {@link Response}
	 */
	@ExceptionHandler(ApiException.class) 
	@ResponseBody
	public ResponseEntity<Response>  handleBlException(HttpServletResponse httpServletResponse, ApiException e){
		LOGGER.error(">>> ApiException : {}" , e.getMessage());		
		Response response = new Response(e);		
		ResponseEntity<Response> result = new ResponseEntity<Response>(response, makeHttpStatusCode(response));
		return result;
	}
	
	/**
	 * Valid Annotation의 validation 실패 시 지정된 형식 json으로 Http Respons를 생성하고 전달한다.
	 * */
	@ExceptionHandler(MethodArgumentNotValidException.class)
	@ResponseBody
	public ResponseEntity<Response> handleJsr303ValidException(HttpServletResponse httpServletResponse, MethodArgumentNotValidException e) {
		BindingResult error = e.getBindingResult();
		LOGGER.error(">>> ValidationException : {}", error);
        Response response = new Response(new ApiException(INVALID_ERROR, "Request Parameter Not Valid[" + error.getFieldError().getField() + "]: " + error.getFieldError().getDefaultMessage()));
        return new ResponseEntity<Response>(response, makeHttpStatusCode(response));
	}
	
	private HttpStatus makeHttpStatusCode(Response resp) {
		Payload payload = resp.getResponse(); 
		if (payload instanceof ResponseHeader) {
			ResponseHeader respHeader = (ResponseHeader) payload;
			Header header = (Header) respHeader.getHeader();
			int statusCode = header.getStatusCode();
			
			if(statusCode == AUTH_TOKEN_EXPIRED)
			{
				return HttpStatus.UNAUTHORIZED;
			}
			else
			{
				switch (statusCode / 100) {
				case 2 : return HttpStatus.OK;
				case 4 : return HttpStatus.BAD_REQUEST;
				case 5 : return HttpStatus.FORBIDDEN;
				default : return HttpStatus.INTERNAL_SERVER_ERROR;
				}
			}
		} else {
			return HttpStatus.OK;
		}
	}
	
}
