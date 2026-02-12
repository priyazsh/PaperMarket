package in.cs.daoimpl;

import java.util.List;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.hibernate.Session;
import in.cs.EnumClass.userStatus;
import in.cs.dao.userDao;
import in.cs.pojo.User;


@Transactional
@Component
public class userDaoImpl implements userDao {

	@Autowired
	private SessionFactory session;

	
//--------------------------------------------------------------------------
	//create user Register
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
//------------------------------------------------------------------------
	
	//Login user
	@Override
	public User checkuserCredential(String email, String password) {

		 Session se= session.getCurrentSession();

		String hql = "from User u where u.email = :email and u.password = :password";

		Query<User> query = se.createQuery(hql, User.class);
		query.setParameter("email", email);
		query.setParameter("password", password);
		

		User result = query.uniqueResult();
		if (result != null) {
			return result;
		} else {
			return null;
		}

	}


//-----------------------------------------------------------------
	//find all user
	@Override
	public List<User> listAll() {
		List<User> lst = session.getCurrentSession().createQuery("From User", User.class).list();
		if (lst != null) {
			return lst;
		} else {

			return null;
		}
	}
//-------------------------------------------------------------------------------
	
	//find user  by status
	@Override
	public List<User> FindUserByStatus(userStatus status) {

	    String hql = "from User where status = :status";

	    return session.getCurrentSession()
	                  .createQuery(hql, User.class)
	                  .setParameter("status", status)
	                  .getResultList();
	}
	
	
	

	
	@Override
	public boolean UpdateUserStatus(int id,userStatus uStatus) {
		try {
			 Session currentSession = session.getCurrentSession();
			   User user = currentSession.get(User.class, id);
			   if(user!=null) {
				   user.setStatus(uStatus);
				 
				  return true;
			   }else {
				   
				   return false;
			   }
		} catch (Exception e) {
		e.printStackTrace();
		return false;
		}
	 
	}

	@Override
	public long countUsers() {
		Session sess= session.getCurrentSession();
		String hql="select count(u) from User u";
		long u = sess.createQuery(hql,Long.class).uniqueResult();
		if(u>0) {
			return u;
		}else {
			return 0;			
		}
		

	}

	@Override
	public long countUserByStatus(userStatus status) {
	Session session2 = session.getCurrentSession();
	  String hql = "select count(u) from User u where u.status = :status";
	  
	 Long result = session2.createQuery(hql,Long.class).setParameter("status", status).uniqueResult();
	if(result>0) {
		return result;
	}
	else {
		return 0;
	}
	}

	@Override
	public User findUserByEmail(String email) {
	     Session s= session.getCurrentSession();
	     String hql="from User u where u.email = :email";
	     User user = s.createQuery(hql,User.class).setParameter("email", email).uniqueResult();
	     if(user!=null) {
	    	 return user;
	     }
	     else {
	    	 return null;
	    	 
	     }
	}

	@Override
	public User findUserById(int id) {
	User user = session.getCurrentSession().get(User.class, id);
	if(user!=null) {
		return user;
		
	}else{
		
		return null;
	}
	}

	@Override
	public boolean updateUser(User user) {
		try {
		 session.getCurrentSession().merge(user);
		return true;
		} catch (Exception e) {
			e.printStackTrace();
		return false;
		
		}
	}
	
//--------------------------------------------------------------------------------
	
	

}
