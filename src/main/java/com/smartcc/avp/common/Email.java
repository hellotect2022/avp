package com.smartcc.avp.common;

import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

public class Email {

	public void sendEmail(){
		
	JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	mailSender.setHost("111.222.33.44");
	 
	// 메일 내용을 작성한다
	SimpleMailMessage msg = new SimpleMailMessage();
	msg.setFrom("ljsmr9457@naver.com");
	msg.setTo(new String[] {"ljsmr9457@naver.com"});
	msg.setSubject("제목이 이러저러합니다");
	msg.setText("본문이 어쩌구저쩌구합니다");
	 
	try {
	    mailSender.send(msg);
	} catch (MailException ex) {
	    // 적절히 처리
	}
	
	}
	
}
