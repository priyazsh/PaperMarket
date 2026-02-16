package in.cs.dao;

import java.util.List;

import in.cs.pojo.Stocks;
import in.cs.pojo.User;
import in.cs.pojo.UserHolding;

public interface UserHoldingDao {	
	UserHolding findByUserAndStock(User user, Stocks stock);

    void save(UserHolding holding);

    void update(UserHolding holding);
    
    List<UserHolding> findByUser(User user);
    
    
}
