package in.cs.dao;

import java.util.List;

import in.cs.EnumClass.userStatus;
import in.cs.pojo.User;

public interface userDao {

	public boolean createUser(User user);
	public User checkuserCredential(String email,String password);

	
	  public List<User> listAll(); 
	  public List<User> FindUserByStatus(userStatus
	  status);
	 
	public void sendEmail(String email);
}
