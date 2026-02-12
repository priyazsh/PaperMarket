package in.cs.daoimpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import in.cs.dao.StocksDao;
import in.cs.pojo.Stocks;

@Transactional
@Component
public class StocksDaoImpl implements StocksDao {

	@Autowired
	private SessionFactory session;
	
	@Override
	public List<Stocks> totalStock() {
		Session currentSession = session.getCurrentSession();
	     Query<Stocks> query = currentSession.createQuery("From Stocks",Stocks.class);
		List<Stocks> list = query.list();
	    if(list!=null) {
	    	return list;
	    }
	    else {
	    	return null;
	    }
	}

	@Override
	public boolean addStocks(Stocks stock) {
		try {
			Session currentSession = session.getCurrentSession();
					
			Stocks exist = currentSession.get(Stocks.class, stock.getName());
			if(exist!=null) {
			return false;	
			}
			currentSession.persist(stock);
			currentSession.flush();
		
			return true;	
		}  catch (Exception e) {
	        
	        return false;
	    }
		
	}

	@Override
	public boolean deleteStock(String Symbol) {
		try {
			Session currentSession = session.getCurrentSession();
			Stocks stocks = currentSession.find(Stocks.class, Symbol);
			if(stocks!=null) {
		        currentSession.remove(stocks);
		        return true;
			}	
			else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}

}
