package in.cs.daoimpl;

import java.util.Properties;

import org.springframework.stereotype.Repository;

import in.cs.dao.EmailDao;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Repository
public class EmailDaoimpl implements EmailDao{

	
	@Override
	public void sendEmail(String setMessage,String email,String Subject) {
		
		String SendEmailFrom = "projectuse344@gmail.com";
		String Passkey = "zrcybzhxvoqmzzrl";
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(prop, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(SendEmailFrom, Passkey);
			}

		});
	
			
		
	

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(SendEmailFrom));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject(Subject);
			message.setText(setMessage);
			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();

		}
		
	}

}
