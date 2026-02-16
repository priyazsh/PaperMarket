package in.cs.dao;

import java.util.List;

import in.cs.pojo.TradeTransaction;
import in.cs.pojo.User;

public interface TradeTransactionDao {

	
  public void SaveTradTransaction(TradeTransaction tradeTrans);
 
  List<TradeTransaction> findByUser(User user);  
}
