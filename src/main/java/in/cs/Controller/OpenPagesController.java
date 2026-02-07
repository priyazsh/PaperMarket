package in.cs.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class OpenPagesController {
	
	
	@GetMapping("/")
	public String root() {
		return "index";
	}

	@GetMapping("/index")
	public String openIndex() {
		return "index";
	}


	@GetMapping("/login")
	public String openLogin() {
		return "login";
	}

	@GetMapping("/register")
	public String openRegister() {
		return "register";
	}

	@GetMapping("/forgot-password")
	public String openForgotPassword() {
		return "login";
	}

	@GetMapping("/logout")
	public String openLogout() {
		// TODO: Add session invalidation logic
		return "redirect:/login";
	}

	@GetMapping("/approval")
	public String openApproval() {
		return "approval";
	}

	@GetMapping("/holdings")
	public String openHoldings() {
		return "holdings";
	}

	@GetMapping("/market")
	public String openMarket() {
		return "market";
	}

	@GetMapping("/chart")
	public String openChart() {
		return "chart";
	}

	@GetMapping("/funds")
	public String openFunds() {
		return "funds";
	}

	@GetMapping("/orders")
	public String openOrders() {
		return "orders";
	}


	@GetMapping("/admin")
	public String openAdmin() {
		return "admin";
	}


	@GetMapping("/about")
	public String openAbout() {
		return "index";
	}
	
	@GetMapping("/admin/stocks")
	public String openAdminStocks() {
		return "stocks";
	}


	@GetMapping("/terms")
	public String openTerms() {
		return "index";
	}

	@GetMapping("/privacy")
	public String openPrivacy() {
		return "index";
	}

	@GetMapping("/contact")
	public String openContact() {
		return "index";
	}
}
