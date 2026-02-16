package in.cs.daoimpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import in.cs.dao.StocksDao;
import in.cs.dao.UserHoldingDao;
import in.cs.pojo.Stocks;
import in.cs.pojo.User;
import in.cs.pojo.UserHolding;

@Transactional
@Component
public class UserHoldingDaoimpl implements UserHoldingDao {

   

	@Autowired
	private SessionFactory sf;

	
	@Override
	public UserHolding findByUserAndStock(User user, Stocks stock) {
	    Session session = sf.getCurrentSession();
	    Query<UserHolding> query = session.createQuery(
	        "from UserHolding where user = :user and stock = :stock",
	        UserHolding.class
	    );
	    query.setParameter("user", user);
	    query.setParameter("stock", stock);

	    List<UserHolding> list = query.getResultList();

	    if (list.isEmpty()) {
	        return null;
	    } else {
	        return list.get(0);
	    }
	}


	@Override
	public void save(UserHolding holding) {
		try {
			sf.getCurrentSession().persist(holding);
			
		} catch (Exception e) {
			e.printStackTrace();
           System.out.print("Holding Problem");
		}
		
		
	}

	@Override
	public void update(UserHolding holding) {
		
		try {
			sf.getCurrentSession().merge(holding);
           	
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("update holding problme");
		}
	}

	@Override
	public List<UserHolding> findByUser(User user) {
		Query<UserHolding> query =
	            sf.getCurrentSession()
	            .createQuery("from UserHolding where user = :user",
	                         UserHolding.class);

	        query.setParameter("user", user);

	        return query.getResultList();
	
	}


	

}
