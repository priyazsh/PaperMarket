package in.cs.daoimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import in.cs.EnumClass.SellBuyType;
import in.cs.dao.StocksDao;
import in.cs.dao.TradeTransactionDao;
import in.cs.dao.TradeTransactionService;
import in.cs.dao.UserHoldingDao;
import in.cs.dao.userDao;
import in.cs.pojo.Stocks;
import in.cs.pojo.TradeTransaction;
import in.cs.pojo.User;
import in.cs.pojo.UserHolding;

@Component
public class TradeTransactionServiceImpl implements TradeTransactionService {

    @Autowired
    private userDao userdao;

    @Autowired
    private StocksDao stockdao;

    @Autowired
    private TradeTransactionDao tradeTransactiondao;

    @Autowired
    private UserHoldingDao userholdingdao;
	@Override
	public String buyStock(int userId, String symbol, int quantity) {
		 User user = userdao.findUserById(userId);
	        if (user == null) return "User not found";

	        Stocks stock = stockdao.FindStockBySymbol(symbol);
	        if (stock == null) return "Stock not found";

	        double livePrice = stockdao.getLivePrice(symbol);
	        double total = livePrice * quantity;

	        if (user.getBalance() < total)
	            return "Insufficient Balance";

	        
	        user.setBalance(user.getBalance() - total);
	        userdao.updateUser(user);

	        
	        TradeTransaction td = new TradeTransaction();
	        td.setUser(user);
	        td.setStock(stock);
	        td.setQuantity(quantity);
	        td.setPrice(livePrice);
	        td.setTotalammount(total);
	        td.setType(SellBuyType.BUY);

	        tradeTransactiondao.SaveTradTransaction(td);

	        
	        UserHolding holding = userholdingdao.findByUserAndStock(user, stock);

	        if (holding == null) {
	            holding = new UserHolding();
	            holding.setUser(user);
	            holding.setStock(stock);
	            holding.setQty(quantity);
	            holding.setPrice(livePrice);
	            userholdingdao.save(holding);
	        } else {
	           double oldQty=	holding.getQty();
	           double oldprice=holding.getPrice();
	           
	           double newQty= oldQty + quantity;
	           
	           double newAvgPrice =
	        	        ((oldQty * oldprice) + (quantity * livePrice)) / newQty;

	           holding.setQty(newQty);
	           holding.setPrice(newAvgPrice);
	            userholdingdao.update(holding);
	            
	        }

	        return "Stock Purchased Successfully";
	}

	@Override
	public String sellStock(int userId, String symbol, int quantity) {

        User user = userdao.findUserById(userId);
        if (user == null) return "User not found";

        Stocks stock = stockdao.FindStockBySymbol(symbol);
        if (stock == null) return "Stock not found";

        UserHolding holding = userholdingdao.findByUserAndStock(user, stock);

        if (holding == null || holding.getQty() < quantity)
            return "Not enough shares to sell";

        double livePrice = stockdao.getLivePrice(symbol);
        double total = livePrice * quantity;

        
        user.setBalance(user.getBalance() + total);
        userdao.updateUser(user);

       
        holding.setQty(holding.getQty() - quantity);
        userholdingdao.update(holding);

        
        TradeTransaction td = new TradeTransaction();
        td.setUser(user);
        td.setStock(stock);
        td.setQuantity(quantity);
        td.setPrice(livePrice);
        td.setTotalammount(total);
        td.setType(SellBuyType.SELL);

        tradeTransactiondao.SaveTradTransaction(td);

        return "Stock Sold Successfully";
	}

}
