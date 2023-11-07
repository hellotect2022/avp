package com.smartcc.avp.common.util;



import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class AESUtils {
	private static String key = "smartcc2018";

    public static String Decrypt(String text) throws Exception{

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        byte[] keyBytes= new byte[16];
        byte[] b= AESUtils.key.getBytes("UTF-8");

        int len= b.length;

        if (len > keyBytes.length) len = keyBytes.length;

        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);

        cipher.init(Cipher.DECRYPT_MODE,keySpec,ivSpec);

        byte [] results = cipher.doFinal(Base64.decodeBase64(text.getBytes()));

        return new String(results,"UTF-8");
    }
}
