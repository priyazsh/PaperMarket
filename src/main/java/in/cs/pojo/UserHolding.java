package in.cs.pojo;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class UserHolding {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne
	@JoinColumn(nullable = false)
	private User user;
	@ManyToOne
	@JoinColumn(nullable = false)
	private Stocks stock;
	
	
	private double qty;
	
	@Column(name="basePrice")
	private double price;
	
	
	public UserHolding() {
		super();
		// TODO Auto-generated constructor stub
	}


	public UserHolding(int id, User user, Stocks stock, double qty, double price) {
		super();
		this.id = id;
		this.user = user;
		this.stock = stock;
		this.qty = qty;
		this.price = price;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Stocks getStock() {
		return stock;
	}


	public void setStock(Stocks stock) {
		this.stock = stock;
	}


	public double getQty() {
		return qty;
	}


	public void setQty(double qty) {
		this.qty = qty;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "UserHolding [id=" + id + ", user=" + user + ", stock=" + stock + ", qty=" + qty + ", price=" + price
				+ "]";
	}
	
	
}
