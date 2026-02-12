package in.cs.dao;

import java.util.List;

import in.cs.pojo.WalletTransaction;

public interface WalletTransactionDao {

	public boolean saveTransactions(WalletTransaction transaction);
	
	public List<WalletTransaction> transactionsList(int userid);

}
