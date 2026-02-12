package in.cs.daoimpl;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.Utils;

import in.cs.EnumClass.TrasactionType;
import in.cs.dao.PaymentDao;
import in.cs.dao.WalletTransactionDao;
import in.cs.dao.userDao;
import in.cs.pojo.WalletTransaction;
import in.cs.pojo.User;

@Transactional
@Component
public class PaymentDaoImpl implements PaymentDao{

  
	private static final String KEY="rzp_test_RugB55jp26V8wq";
	private static final String SECRET="LKFA8T5SimSCMVFbks5JeddT";
	
	@Autowired
	private userDao userdao;
	@Autowired
	private WalletTransactionDao transdao;

	@Override
	public String createOrder(long amount) {
	       	try {
				RazorpayClient client=new RazorpayClient(KEY, SECRET);
				JSONObject option=new JSONObject();
				option.put("amount", amount * 100);
				option.put("currency", "INR");
				option.put("receipt", "wallet_"+System.currentTimeMillis());
				
				Order order=client.orders.create(option);
				
				return order.toString();
			} catch (Exception e) {
				e.printStackTrace();
				return "404";
			}
	}

	@Override
	public void verifyDeposite(int userid, String orderId, String paymentId, String signature, long amount) {
		try {
	        JSONObject data = new JSONObject();
	        data.put("razorpay_order_id", orderId);
	        data.put("razorpay_payment_id", paymentId);
	        data.put("razorpay_signature", signature);

	        Utils.verifyPaymentSignature(data, SECRET);

	        User user = userdao.findUserById(userid);
	        if(user!=null) {
	        long Oldbalance = user.getBalance();
	        long newbalance=Oldbalance+amount;
	       	user.setBalance(newbalance);
	        userdao.updateUser(user);
	        System.out.println(user.getBalance());
	        
	        WalletTransaction trans = new WalletTransaction();
	        trans.setUser(user);
	        trans.setAmmount(amount);
	        trans.setBalance(newbalance);
	        trans.setDescription("razorpay");
	        trans.setType(TrasactionType.DEPOSITE);
	        

	        transdao.saveTransactions(trans);
	        }
	    } catch (Exception e) {
	       e.printStackTrace();
	    }
		
	}

	@Override
	public boolean withdraw(int id,long amount) {
		User user = userdao.findUserById(id);
		if(user!=null) {
			long oldbalance = user.getBalance();
			long newbalance= oldbalance-amount;
			user.setBalance(newbalance);
			userdao.updateUser(user);
			
           WalletTransaction trans=new WalletTransaction();
           trans.setUser(user);
           trans.setBalance(newbalance);
           trans.setDescription("razorpay");
           trans.setType(TrasactionType.WITHDRAW);
           trans.setAmmount(amount);
           
           transdao.saveTransactions(trans);
           return true;
			
		}
		else {
			
			return false;
		}
	}

}