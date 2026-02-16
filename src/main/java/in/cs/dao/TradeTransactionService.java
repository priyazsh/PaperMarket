package in.cs.dao;

public interface TradeTransactionService {
	 String buyStock(int userId, String symbol, int quantity);

	    String sellStock(int userId, String symbol, int quantity);
}
