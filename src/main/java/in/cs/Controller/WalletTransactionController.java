package in.cs.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import in.cs.dao.PaymentDao;
import in.cs.dao.WalletTransactionDao;
import in.cs.pojo.WalletTransaction;
import in.cs.pojo.User;
import jakarta.servlet.http.HttpSession;

@Controller
public class WalletTransactionController {

	@Autowired
	private WalletTransactionDao walletDao;

	@Autowired
	private PaymentDao pDao;
	
    @PostMapping("/create-order")
    @ResponseBody
    public String createOrder(@RequestParam("amount") long amount,
                              HttpSession session) {

      System.out.println(amount);
        User user = (User) session.getAttribute("loggedUser");
        
        
     if(user==null) {
    	  return "ERROR:LOGIN_REQUIRED";
     }
     
     if(amount<=0) {
    	return "ERROR:INSUFFCIENT BALANCE";
     }
     
     String ordercreated = pDao.createOrder(amount);
    System.out.print(ordercreated);	
  
       return ordercreated;
    }


    @PostMapping("/verify")
    @ResponseBody
    public String verifyPayment(
            @RequestParam("razorpay_order_id") String orderId,
            @RequestParam("razorpay_payment_id") String paymentId,
            @RequestParam("razorpay_signature") String signature,
            @RequestParam("amount") long amount,
            HttpSession session,Model model) {

    	
        User user = (User) session.getAttribute("loggedUser");
      
       
        if (user == null) {
            return "{\"status\":\"NOT_LOGGED_IN\"}";
        }

        try {
            pDao.verifyDeposite(
                    user.getId(),
                    orderId,
                    paymentId,
                    signature,
                    amount
            );
            
            
            user.setBalance(user.getBalance() + amount);
            session.setAttribute("loggedUser", user);

            return "{\"status\":\"SUCCESS\"}";

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"status\":\"FAILED\"}";
        }
    }
    
    
    @PostMapping("/withdraw")
    public String withdrawAmmount(@RequestParam("amount")long amount,HttpSession session) {
   User user =(User) session.getAttribute("loggedUser");
   if(user==null) return "login";
   
    
	  boolean withdraw = pDao.withdraw(user.getId(), amount);
	  if(withdraw) {
		  user.setBalance(user.getBalance() - amount);
          session.setAttribute("loggedUser", user);
          return "redirect:/funds";
	  }else {
		  
		  return "404";
	  }
	   
   
    	
    }
    
    
    @GetMapping("/funds")
    public String openFunds(HttpSession session,Model model) {
    	User user =(User) session.getAttribute("loggedUser");
    	if(user!=null) {
    		int id = user.getId();
    	   List<WalletTransaction> transactionsList =walletDao.transactionsList(id);	
    	  model.addAttribute("list", transactionsList);
    	}
    	return "funds";
    }
    
    
    
    
    
}