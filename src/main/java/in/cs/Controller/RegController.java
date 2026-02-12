	package in.cs.Controller;
	
	import java.io.File;
	import java.security.SecureRandom;
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
	import in.cs.dao.EmailDao;
	import in.cs.dao.userDao;
	import in.cs.daoimpl.userDaoImpl;
	import in.cs.pojo.User;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpSession;
	
	import org.springframework.web.bind.annotation.RequestBody;
	
	
	@Controller
	public class RegController {
	
		@Autowired
		private userDao userdaoimpl;
		
		@Autowired
		private EmailDao emaildaoimpl;
		
		@PostMapping("/register")
		public ModelAndView Createuser(@RequestParam(value="name",required=false)String username,
				@RequestParam(value="email",required=false)String email,
				@RequestParam(value="phone",required=false)String phone,
				@RequestParam(value="panCard",required=false)String pancard,
				@RequestParam(value="password",required=false)String password,
				@RequestParam(value="confirmPassword",required=false)String confirmPassword,
				@RequestParam(value="photo",required=false) MultipartFile file,
			    @RequestParam(value="bt",required=false)String button,
			    @RequestParam(value="otp",required=false)String otp,
			    HttpSession session) {
		
			ModelAndView mvc=new ModelAndView();
			
			User user=new User();
			user.setName(username);
			user.setEmail(email);
			user.setPhone(phone);
			user.setPanCard(pancard);
			user.setPassword(password);
			user.setConfirmPassword(confirmPassword);
		    user.setStatus(userStatus.PENDING);
		    
		    if("sendOtp".equals(button)) {
		    	System.out.print("send ho gya");
		    	SecureRandom securerandom=new SecureRandom();
		               String Otp = String.valueOf(100000+securerandom.nextInt(900000));
		               emaildaoimpl.sendEmail("Your Otp: "+ Otp, email, "Paper Market");
		    	session.setAttribute("otp", Otp);
		    	  session.setAttribute("otpSent", true);
		    	 mvc=new ModelAndView("register","otpMessage","Otp send Successfully Check Your Email");
		    	 mvc.addObject("user", user);
		    }
		    else if("verifyOtp".equals(button)) {
		    	 String Verifyotp=(String) session.getAttribute("otp");
		    	 
		    	 if(Verifyotp!=null && Verifyotp.equals(otp)) {
		    		   session.setAttribute("otpVerified", true);
		    		    session.setAttribute("otpSent", true);   
		    		    session.removeAttribute("otp");
		    		 mvc=new ModelAndView("register","message","Verification Done");
		    		 mvc.addObject("user", user);	
		    	 }
		    	 else {
			    	  session.setAttribute("otpSent", true);	
		    		 mvc=new ModelAndView("register","message","Wrong Otp");
		    		 mvc.addObject("user", user);
		    		 
		    	 }
		    }
		   
		    else if("register".equals(button)) {
		    	Boolean verified = (Boolean) session.getAttribute("otpVerified");
	
		    	if(verified == null || !verified) {
		    	    mvc = new ModelAndView("register","msg","Please verify OTP first");
		    	    mvc.addObject("user", user);
		    	    return mvc;
		    	}
	
		    	
		        User useremail = userdaoimpl.findUserByEmail(email);
				 if(useremail!=null) {
					return mvc=new ModelAndView("register","msg","Email Already Exist");
				 }
				
				try {
				
					user.setPhoto(file.getOriginalFilename());
					String path="/home/chetan/Documents/j2ee/SPRINGMVCPROJECTS/Paper-Market/src/main/webapp/assest/dp/";
					File f=new File(path+file.getOriginalFilename());
					
					if(userdaoimpl.createUser(user)) {
						file.transferTo(f);
						
						session.removeAttribute("otpVerified");
						session.removeAttribute("otpSent");
						session.removeAttribute("otp");
						emaildaoimpl.sendEmail("Pending For Approval", email,"Paper Market");
						
						mvc=new ModelAndView("approval","msg","Wait For Approval");
					}
					else {
						mvc=new ModelAndView("register","msg","Something went wrong try again");
					}
					
					
				} catch (Exception e) {
					e.printStackTrace();
				
			}
		    }
		    
		
			return mvc;
		
		}
		
		
		@PostMapping("/userLogin")
		public ModelAndView LoginPage(@RequestParam("email")String email,@RequestParam("password")String password,HttpServletRequest request) {
			ModelAndView mvc=null;
		HttpSession session = request.getSession(false);
		if(session!=null) {
			session.invalidate();
		}
			
			User credential = userdaoimpl.checkuserCredential(email, password);
			
			if(credential==null) {
				mvc=new ModelAndView("login","msg","wrong email or password");
				return mvc;
			}
			
			if(credential.getStatus()!=userStatus.APPROVED) {
				mvc = new ModelAndView("login","message", "Your account is not approved yet"); 
		     
		        return mvc;
				
			}
			session=request.getSession(true);
			session.setAttribute("loggedUser",credential);
			
			String name = credential.getName();
					
				mvc=new ModelAndView("market");
				mvc.addObject("name",name);
			
				
			return mvc;
			
		}
		
		
	}
