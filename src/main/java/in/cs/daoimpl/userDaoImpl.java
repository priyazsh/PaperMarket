package in.cs.daoimpl;

import java.util.List;
import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import in.cs.EnumClass.userStatus;
import in.cs.dao.userDao;
import in.cs.pojo.User;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Transactional
@Component
public class userDaoImpl implements userDao {

	@Autowired
	private SessionFactory session;

	public void setSession(SessionFactory session) {
		this.session = session;
	}

	@Override
	public boolean createUser(User user) {
		try {
			session.getCurrentSession().persist(user);

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	@Override
	public List<User> listAll() {
		List<User> lst = session.getCurrentSession().createQuery("From User", User.class).list();
		if (lst != null) {
			return lst;
		} else {

			return null;
		}
	}

	@Override
	public List<User> FindUserByStatus(userStatus status) {
		String query = "from User where status=:status";
		return session.getCurrentSession().createQuery("from users where status=:status", User.class)
				.setParameter("status", status).getResultList();

	}

	@Override
	public void sendEmail(String email) {

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
			message.setSubject("Registration Paper Market");
			message.setText("Waiting For Admin Approval");
			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	
	@Override
	public User checkuserCredential(String email, String password) {
		userStatus status = userStatus.PENDING;
		org.hibernate.Session se = session.getCurrentSession();

		String hql = "from User u where u.email = :email and u.password = :password and u.status = :status";

		Query<User> query = se.createQuery(hql, User.class);
		query.setParameter("email", email);
		query.setParameter("password", password);
		query.setParameter("status", status);

		User result = query.uniqueResult();
		if(result!=null) {
			return result;
		}
		else {
			return null;
		}
		
	}

}
