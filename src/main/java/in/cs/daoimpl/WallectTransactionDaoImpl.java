package in.cs.daoimpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import in.cs.dao.WalletTransactionDao;
import in.cs.pojo.WalletTransaction;


@Transactional
@Component
public class WallectTransactionDaoImpl implements WalletTransactionDao {

	@Autowired
	private SessionFactory session;

	@Override
	public boolean saveTransactions(WalletTransaction transaction) {
		try {
                  session.getCurrentSession().persist(transaction);
                  return true;
		} catch (Exception e) {
			e.getMessage();
			return false;
		}

	}

	@Override
	public List<WalletTransaction> transactionsList(int userid) {
		Session lst = session.getCurrentSession();
		String hql = "from WalletTransaction wt where wt.user.id = :userid";
		List<WalletTransaction> list = lst.createQuery(hql,WalletTransaction.class).setParameter("userid", userid).list();
		
		if(list!=null) {
			return list;
		}
		else {
			return null;
		}
	}



}
