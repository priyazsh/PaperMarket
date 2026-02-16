package in.cs.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import in.cs.dao.TradeTransactionDao;
import in.cs.pojo.Stocks;
import in.cs.pojo.TradeTransaction;
import in.cs.pojo.User;
@Transactional
@Component
public class TradeTransactionDaoImpl implements TradeTransactionDao{

	@Autowired
	private SessionFactory session; 
	
	@Override
	public void SaveTradTransaction(TradeTransaction tradeTrans) {
		try {

			session.getCurrentSession().persist(tradeTrans);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<TradeTransaction> findByUser(User user) {
		
		return null;
	}

	





}
