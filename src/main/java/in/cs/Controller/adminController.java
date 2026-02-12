package in.cs.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.cs.EnumClass.userStatus;
import in.cs.dao.EmailDao;
import in.cs.dao.StocksDao;
import in.cs.dao.userDao;
import in.cs.pojo.Stocks;
import in.cs.pojo.User;

@Controller
public class adminController {

	@Autowired
	private userDao userdaoimpl;
	@Autowired
	private StocksDao stocksdaoimpl;
	@Autowired
	private EmailDao emaildaoimpl;

	@GetMapping("/userApproval")
	public String adminPage(@RequestParam(name = "status", required = false) String status, Model model) {

		List<User> users;

		if (status == null || status.equalsIgnoreCase("all")) {
			users = userdaoimpl.listAll();
		} else if (status.equalsIgnoreCase("pending")) {
			users = userdaoimpl.FindUserByStatus(userStatus.PENDING);

		} else if (status.equalsIgnoreCase("approved")) {
			users = userdaoimpl.FindUserByStatus(userStatus.APPROVED);
		} else if (status.equalsIgnoreCase("rejected")) {
			users = userdaoimpl.FindUserByStatus(userStatus.CANCLED);
		} else {
			users = userdaoimpl.listAll();
		}

		if (users == null) {
			users = new ArrayList<>();
		}
		long totalUsers = userdaoimpl.countUsers();
		long approvedUsers = userdaoimpl.countUserByStatus(userStatus.APPROVED);
		long cancleUsers = userdaoimpl.countUserByStatus(userStatus.CANCLED);
		long pendingUsers = userdaoimpl.countUserByStatus(userStatus.PENDING);

		model.addAttribute("users", users);
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("approvedUsers", approvedUsers);
		model.addAttribute("cancleUsers", cancleUsers);
		model.addAttribute("pendingUsers", pendingUsers);
		return "admin";
	}

	@PostMapping("/updateStatus")
	public String updateUserStatus(@RequestParam("userId") int userid,@RequestParam("email")String email, @RequestParam("status") userStatus status,
			Model model) {
		
		boolean updateUserStatus = userdaoimpl.UpdateUserStatus(userid, status);
		if(updateUserStatus) {
		if(status==userStatus.APPROVED) {
			emaildaoimpl.sendEmail("You Can Login Now Your Request is Approved", email, "Paper Market");
			
		}
		else if(status==userStatus.CANCLED) {
			emaildaoimpl.sendEmail("You Are Not Applicable Sorry", email, "Paper Market");
		}
		}
		return "redirect:/userApproval";
	}
	
	
	
	@GetMapping("/admin/stocks")
	public String showStocksAdmin(Model model) {
		List<Stocks> totalStock = stocksdaoimpl.totalStock();
		model.addAttribute("list", totalStock);
		return "stocks";
	}
	
	@GetMapping("/market")
	public String showStocksUser(Model model) {
		List<Stocks> totalStock = stocksdaoimpl.totalStock();
		model.addAttribute("list", totalStock);
		return "market";
	}
	
	
	
	@PostMapping("/admin/stocks/add")
	public String updateStocks(@ModelAttribute Stocks stock,RedirectAttributes rd) {
           
		boolean stocks = stocksdaoimpl.addStocks(stock);
               if(stocks) {
            	rd.addFlashAttribute("success"," Stock Added Successfully");
               }
               else {
            	   rd.addFlashAttribute("error","Stock already exists (duplicate entry)");
               }
               return "redirect:/admin/stocks";
	}
	
	
	@PostMapping("/admin/stocks/delete")
	public String deleteStock(@RequestParam("stockSymbol")String symbol,RedirectAttributes re) {
		boolean deleteStock = stocksdaoimpl.deleteStock(symbol);
		if(deleteStock) {
			re.addFlashAttribute("delete","Deleted");
		}
		return "redirect:/admin/stocks";
	}
	

}
