package in.cs.pojo;

import java.time.LocalDateTime;
import org.hibernate.annotations.CreationTimestamp;
import in.cs.EnumClass.TrasactionType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class WalletTransaction {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="transaction_id")
	private int id;

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime datetime;

	@Enumerated(EnumType.STRING)

	private TrasactionType type;

	private String description;
	private long ammount;
	private double balance;

	@ManyToOne
	@JoinColumn( nullable = false)
	private User user;

	public WalletTransaction() {
		super();
		// TODO Auto-generated constructor stub
	}
 
	public WalletTransaction(int id, LocalDateTime datetime, TrasactionType type, String description, long ammount,
			double balance, User user) {
		super();
		this.id = id;
		this.datetime = datetime;
		this.type = type;
		this.description = description;
		this.ammount = ammount;
		this.balance = balance;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getDatetime() {
		return datetime;
	}

	public void setDatetime(LocalDateTime datetime) {
		this.datetime = datetime;
	}

	public TrasactionType getType() {
		return type;
	}

	public void setType(TrasactionType type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getAmmount() {
		return ammount;
	}

	public void setAmmount(long ammount) {
		this.ammount = ammount;
	}

	
	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Transaction [id=" + id + ", datetime=" + datetime + ", type=" + type + ", description=" + description
				+ ", ammount=" + ammount + ", balance=" + balance + ", user=" + user + "]";
	}

	
}
