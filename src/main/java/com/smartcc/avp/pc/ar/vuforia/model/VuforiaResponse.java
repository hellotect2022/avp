package com.smartcc.avp.pc.ar.vuforia.model;

import lombok.Data;

@Data
public class VuforiaResponse {
	private String	uniqueTargetId;
	// TargetCreated
	// TargetNameExist
	// BadImage
	private String	resultCode;

}
