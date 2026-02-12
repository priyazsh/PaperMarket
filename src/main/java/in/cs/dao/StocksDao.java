package in.cs.dao;

import java.util.List;

import in.cs.pojo.Stocks;

public interface StocksDao {
	public boolean addStocks(Stocks stock);
	public boolean deleteStock(String Symbol);
	public List<Stocks> totalStock();
}
