package com.smartcc.avp.common.Wrapper;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils;

import com.smartcc.avp.common.util.AESUtils;

public class DecodingRequestWrapper extends HttpServletRequestWrapper{

	private byte[] inputbyte;
	private byte[] outputbyte;
	
	
	public DecodingRequestWrapper(HttpServletRequest request) throws IOException{
		super(request);
		
		InputStream is = super.getInputStream();
		inputbyte = IOUtils.toByteArray(is);		

 		String requestStringBody = new String(inputbyte); 		
 		String requestBody = "";
 		try {

 			String formType = request.getParameter("form");
 			
 			if(formType != null && formType.equals("multipart/form-data") == true) {
 				requestBody = requestStringBody;
 			}else {
 				requestBody = AESUtils.Decrypt(requestStringBody);	
 			}			
 			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			requestBody = requestStringBody;
		}
 		
		/*
		String url = request.getRequestURI();
		if(url.indexOf("intfc") < 0) {
			requestBody = requestStringBody;

		}else {
			//암호화 풀기
	 		try {
	 			requestBody = AESUtils.Decrypt(requestStringBody);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				requestBody = requestStringBody;
			}
		} 		
 		*/
 		outputbyte = requestBody.getBytes();
	}
	
	public ServletInputStream getInputStream() throws IOException {

 		final ByteArrayInputStream bis = new ByteArrayInputStream(outputbyte);	
 		return new ServletInputStreamImpl(bis);
 	}

 	class ServletInputStreamImpl extends ServletInputStream{
 		private InputStream is; 		

 		public ServletInputStreamImpl(InputStream bis){
 			is = bis;
 		} 		

 		public int read() throws IOException {
 			return is.read();
 		}
		

 		public int read(byte[] b) throws IOException {
 			return is.read(b);
 		}

 	}

}
