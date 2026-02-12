package in.cs.dao;

public interface PaymentDao {

	public String createOrder(long amount);
	public void verifyDeposite(int userid,String orderId,String paymentId,String signature,long amount);
	public boolean withdraw(int id,long amount);
	
}
