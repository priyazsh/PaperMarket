package in.cs.pojo;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;

import in.cs.EnumClass.Role;
import in.cs.EnumClass.userStatus;
import jakarta.annotation.Nonnull;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@Column(unique = true, nullable = false)
	private String email;
	private String phone;
	private String password;
	@Transient
	private String confirmPassword;
	private String panCard;
	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime createdAt;
	private String photo;
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private userStatus status;
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Role role = Role.USER;
	
	@OneToMany(mappedBy = "user",cascade = CascadeType.ALL)
	private List<WalletTransaction> list;
	
	@OneToMany(mappedBy = "user",cascade=CascadeType.ALL)
	private List<TradeTransaction> tt;
	
	@OneToMany(mappedBy = "user",cascade=CascadeType.ALL)
	private List<UserHolding> userhold;
	@Column(scale=2)
	private double balance;

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int id, String name, String email, String phone, String password, String confirmPassword,
			String panCard, LocalDateTime createdAt, String photo, userStatus status, Role role,
			List<WalletTransaction> list, List<TradeTransaction> tt, List<UserHolding> userhold, double balance) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.confirmPassword = confirmPassword;
		this.panCard = panCard;
		this.createdAt = createdAt;
		this.photo = photo;
		this.status = status;
		this.role = role;
		this.list = list;
		this.tt = tt;
		this.userhold = userhold;
		this.balance = balance;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getPanCard() {
		return panCard;
	}

	public void setPanCard(String panCard) {
		this.panCard = panCard;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public userStatus getStatus() {
		return status;
	}

	public void setStatus(userStatus status) {
		this.status = status;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<WalletTransaction> getList() {
		return list;
	}

	public void setList(List<WalletTransaction> list) {
		this.list = list;
	}

	public List<TradeTransaction> getTt() {
		return tt;
	}

	public void setTt(List<TradeTransaction> tt) {
		this.tt = tt;
	}

	public List<UserHolding> getUserhold() {
		return userhold;
	}

	public void setUserhold(List<UserHolding> userhold) {
		this.userhold = userhold;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", password=" + password
				+ ", confirmPassword=" + confirmPassword + ", panCard=" + panCard + ", createdAt=" + createdAt
				+ ", photo=" + photo + ", status=" + status + ", role=" + role + ", balance=" + balance + "]";
	}



	


}
