package in.cs.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping("/trade")
public class TradeController {


    @Autowired
    private TradeTransactionService tradeService;
    
    @Autowired
    private UserHoldingDao userHoldingDao;
    
    

    @PostMapping("/buy")
    @ResponseBody
    public String buyStock(@RequestParam("symbol") String symbol,
            @RequestParam("quantity") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "Please login first";
        }
        return tradeService.buyStock(user.getId(), symbol, quantity);
    }

    @PostMapping("/sell")
    @ResponseBody
    public String sellStock(@RequestParam("symbol") String symbol,
            @RequestParam("quantity") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "Please login first";
        }
        return tradeService.sellStock(user.getId(), symbol, quantity);
    }
    
    
   @GetMapping("/holdings")
   public String holdingTrade(HttpSession session,Model model) {
	   User user = (User) session.getAttribute("loggedUser");
	 List<UserHolding> list = userHoldingDao.findByUser(user);
	 Double invested = 0.0;
	 
	 
	 Map<String, Object> map = new HashMap<>();
	 model.addAttribute("list", list);
	System.out.print(list);
	   return "holdings";
   }

	
}
