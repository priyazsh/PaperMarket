package in.cs.dao;

import java.util.List;

import in.cs.EnumClass.userStatus;
import in.cs.pojo.User;

public interface userDao {

	public boolean createUser(User user);
	
	public boolean updateUser(User user);

	public User checkuserCredential(String email, String password);

	public List<User> listAll();

	public List<User> FindUserByStatus(userStatus status);
	
	public User findUserByEmail(String email);
	
	public User findUserById(int id);
	
	public long countUsers();
	
	public long countUserByStatus(userStatus status);
	
	public boolean UpdateUserStatus(int id,userStatus uStatus);
	


}
