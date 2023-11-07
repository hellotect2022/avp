package com.smartcc.avp.pc.ar.vuforia.util;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;


//See the Vuforia Web Services Developer API Specification - https://developer.vuforia.com/resources/dev-guide/updating-target-cloud-database

public class UpdateTarget {

	//Server Keys
	private String accessKey = "fbf5d87f2b33febce2aa676ed5614f4ae8b00263";
	private String secretKey = "8623fc2c9594b6b5102b4395541ddef049aaaa1d";
	
	private String	metaData = "";
	private String targetName = "";
	private String targetId = "";
	private String url = "https://vws.vuforia.com";
	private File imageLocation;

	
	public String intiUpdateTarget(String targetId,String targetName ,File imageLocation, String meta) throws URISyntaxException, ClientProtocolException, IOException, JSONException {
		this.imageLocation = imageLocation;
		this.targetId = targetId;
		this.targetName = targetName;
		this.metaData = meta;

		HttpPut putRequest = new HttpPut();
		HttpClient client = new DefaultHttpClient();
		putRequest.setURI(new URI(url + "/targets/" + targetId));
		JSONObject requestBody = new JSONObject();
		
		setRequestBody(requestBody);
		putRequest.setEntity(new StringEntity(requestBody.toString()));
		setHeaders(putRequest); // Must be done after setting the body
		
		HttpResponse response = client.execute(putRequest);
		
		String responseBody = EntityUtils.toString(response.getEntity());
		System.out.println(responseBody);
		
		JSONObject jobj = new JSONObject(responseBody);
		
		String result_code = jobj.has("result_code") ? jobj.getString("result_code") : "";

		
//		System.out.println("reusltttt : " +EntityUtils.toString(response.getEntity()));
		
		return result_code;
	}
	
	
	private void setRequestBody(JSONObject requestBody) throws IOException, JSONException {
		File imageFile = this.imageLocation;
		String fileName = this.imageLocation.getName();
		if(!imageFile.exists()) {
			System.out.println("File location does not exist!");
			System.exit(1);
		}
		byte[] image = FileUtils.readFileToByteArray(imageFile);
		requestBody.put("name", targetName); // Mandatory
		requestBody.put("width", 320.0); // Mandatory
		requestBody.put("image", Base64.encodeBase64String(image)); // Mandatory
		requestBody.put("active_flag", 1); // Optional
		// meta data , 이미지 넹
		requestBody.put("application_metadata", Base64.encodeBase64String(this.metaData.getBytes())); // Optional
	}
	
	
	
	private void setHeaders(HttpUriRequest request) {
		SignatureBuilder sb = new SignatureBuilder();
		request.setHeader(new BasicHeader("Date", DateUtils.formatDate(new Date()).replaceFirst("[+]00:00$", "")));
		request.setHeader(new BasicHeader("Content-Type", "application/json"));
		request.setHeader("Authorization", "VWS " + accessKey + ":" + sb.tmsSignature(request, secretKey));
	}
	
}
