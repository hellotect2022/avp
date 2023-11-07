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
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;

import com.smartcc.avp.pc.ar.vuforia.model.VuforiaResponse;

// See the Vuforia Web Services Developer API Specification - https://developer.vuforia.com/resources/dev-guide/adding-target-cloud-database-api

public class PostNewTarget implements TargetStatusListener {

	VuforiaResponse res = new VuforiaResponse();

	// Server Keys
//	private String accessKey = "fbf5d87f2b33febce2aa676ed5614f4ae8b00263";
//	private String secretKey = "8623fc2c9594b6b5102b4395541ddef049aaaa1d";
	//@Value("#{config['vf.db.server.accesskey']}")
	private String accessKey = "d30f77e4aa06590539b5f573e07bfe1a00c94bc6";
	
	//@Value("#{config['vf.db.server.secretkey']}")
	private String secretKey = "c97263c5896036ee43e7f4c802565a44d47edb4b";

	private String url = "https://vws.vuforia.com";
	// private String url = "https://vws.vuforia.com/targets";
	private String targetName = "";
	private File imageLocation;
	private String metaData = "";
	private TargetStatusPoller targetStatusPoller;

	private final float pollingIntervalMinutes = 60;// poll at 1-hour interval

	private VuforiaResponse postTarget()
			throws URISyntaxException, ClientProtocolException, IOException, JSONException {
		HttpPost postRequest = new HttpPost();
		HttpClient client = new DefaultHttpClient();
		postRequest.setURI(new URI(url + "/targets"));
		JSONObject requestBody = new JSONObject();

		setRequestBody(requestBody);
		postRequest.setEntity(new StringEntity(requestBody.toString()));
		setHeaders(postRequest); // Must be done after setting the body

		HttpResponse response = client.execute(postRequest);
		String responseBody = EntityUtils.toString(response.getEntity());
		System.out.println(responseBody);

		JSONObject jobj = new JSONObject(responseBody);

		String uniqueTargetId = jobj.has("target_id") ? jobj.getString("target_id") : "";
		// TargetCreated
		// TargetNameExist
		// BadImage
		String result_code = jobj.has("result_code") ? jobj.getString("result_code") : "";
		System.out.println("\nCreated target with id: " + uniqueTargetId);
		System.out.println("result_code" + result_code);

		res.setUniqueTargetId(uniqueTargetId);
		res.setResultCode(result_code);
		return res;
	}

	private void setRequestBody(JSONObject requestBody) throws IOException, JSONException {
		File imageFile = this.imageLocation;

		String fileName = this.imageLocation.getName();

		System.out.println("fileName ::" + fileName);
		if (!imageFile.exists()) {
			System.out.println("File location does not exist!");
			System.exit(1);
		}
		byte[] image = FileUtils.readFileToByteArray(imageFile);
		requestBody.put("name", targetName); // Mandatory
		requestBody.put("width", 320.0); // Mandatory
		requestBody.put("image", Base64.encodeBase64String(image)); // Mandatory
		requestBody.put("active_flag", 1); // Optional
		// meta data , 이미지 
		requestBody.put("application_metadata", Base64.encodeBase64String(this.metaData.getBytes())); // Optional
	}

	private void setHeaders(HttpUriRequest request) {
		SignatureBuilder sb = new SignatureBuilder();
		request.setHeader(new BasicHeader("Date", DateUtils.formatDate(new Date()).replaceFirst("[+]00:00$", "")));
		request.setHeader(new BasicHeader("Content-Type", "application/json"));
		request.setHeader("Authorization", "VWS " + accessKey + ":" + sb.tmsSignature(request, secretKey));
	}

	/**
	 * Posts a new target to the Cloud database; then starts a periodic polling
	 * until 'status' of created target is reported as 'success'.
	 * 
	 * @param metaData
	 */
	public VuforiaResponse postTargetThenPollStatus(File test, String targetName, String metaData) {
		this.imageLocation = test;
		this.targetName = targetName;
		this.metaData = metaData;
		String createdTargetId = "";
		try {
			res = postTarget();
		} catch (URISyntaxException | IOException | JSONException e) {
			e.printStackTrace();
			return null;
		}

		// Poll the target status until the 'status' is 'success'
		// The TargetState will be passed to the OnTargetStatusUpdate callback
		if (createdTargetId != null && !createdTargetId.isEmpty()) {
			targetStatusPoller = new TargetStatusPoller(pollingIntervalMinutes, createdTargetId, accessKey, secretKey,
					this);
			targetStatusPoller.startPolling();
		}

		return res;
	}

	// Called with each update of the target status received by the
	// TargetStatusPoller
	@Override
	public void OnTargetStatusUpdate(TargetState target_state) {
		if (target_state.hasState) {

			String status = target_state.getStatus();

			System.out.println("Target status is: " + (status != null ? status : "unknown"));

			if (target_state.getActiveFlag() == true && "success".equalsIgnoreCase(status)) {

				targetStatusPoller.stopPolling();

				System.out.println("Target is now in 'success' status");
			}
		}
	}

//	public static void main(String[] args) throws URISyntaxException, ClientProtocolException, IOException, JSONException {
//		PostNewTarget p = new PostNewTarget();
//		p.postTargetThenPollStatus();
//	}

}
