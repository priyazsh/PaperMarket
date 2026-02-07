package in.cs.Controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import in.cs.EnumClass.userStatus;
import in.cs.dao.userDao;
import in.cs.daoimpl.userDaoImpl;
import in.cs.pojo.User;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class RegController {




	@Autowired
	private userDao userdaoimpl;
	
	@PostMapping("/register")
	public ModelAndView Createuser(@RequestParam("name")String username,
			@RequestParam("email")String email,
			@RequestParam("phone")String phone,
			@RequestParam("panCard")String pancard,
			@RequestParam("password")String password,
			@RequestParam("confirmPassword")String confirmPassword,
			@RequestParam("photo") MultipartFile file) {
		User user=new User();
		user.setName(username);
		user.setEmail(email);
		user.setPhone(phone);
		user.setPanCard(pancard);
		user.setPassword(password);
		user.setConfirmPassword(confirmPassword);
	    user.setStatus(userStatus.PENDING);
	     
		ModelAndView mvc=null;
		try {
		
			user.setPhoto(file.getOriginalFilename());
			String path="/home/chetan/Documents/j2ee/SPRINGMVCPROJECTS/Paper-Market/src/main/webapp/assest/dp/";
			File f=new File(path+file.getOriginalFilename());
			
			if(userdaoimpl.createUser(user)) {
				file.transferTo(f);
			    
				userdaoimpl.sendEmail(email);
				
				mvc=new ModelAndView("approval","msg","Wait For Approval");
			}
			else {
				mvc=new ModelAndView("register","msg","Something went wrong try again");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		
	}
		return mvc;
	
	}
	
	
	
	@PostMapping("/userLogin")
	public ModelAndView LoginPage(@RequestParam("email")String email,@RequestParam("password")String password) {
		ModelAndView mvc=null;
		User credential = userdaoimpl.checkuserCredential(email, password);
		
		
		if(credential!=null) {
			String name = credential.getName();
			String photo = credential.getPhoto();
			mvc=new ModelAndView("market");
			mvc.addObject("name",name);
			mvc.addObject("Dp", photo);
			
			
		}
		else {
			mvc=new ModelAndView("login","msg","wrong email or password");
		}
		
		return mvc;
		
	}
	
	
	@GetMapping("/allData")
	public String getAllData(Model model) {
		List<User> users = userdaoimpl.listAll();
		model.addAttribute("users", users);
		return "admin";
	}
	
	@GetMapping("/approvedUser")
	public String filterStatusData(Model model) {
		List<User> approvedUser = userdaoimpl.FindUserByStatus(userStatus.APPROVED);
	     model.addAttribute("users", approvedUser);
		return "admin";
	}
	
	@GetMapping("/pendingUser")
	public String findPendingUser(Model model) {
		List<User> approvedUser = userdaoimpl.FindUserByStatus(userStatus.PENDING);
	     model.addAttribute("users", approvedUser);
		return "admin";
	}
	
	@GetMapping("/rejectUser")
	public String findRejectUser(Model model) {
		List<User> approvedUser = userdaoimpl.FindUserByStatus(userStatus.CANCLED);
	     model.addAttribute("users", approvedUser);
		return "admin";
	}
}
