package in.cs.pojo;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import in.cs.EnumClass.SellBuyType;
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
public class TradeTransaction {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="transaction_id")
	private int id;
	@ManyToOne
	@JoinColumn(nullable = false)
	private User user;

	@ManyToOne
	@JoinColumn(nullable = false)
	private Stocks stock;

	private int quantity;
	@Column(name="basePrice")
	private double price;
	private double totalammount;
	
	@Enumerated(EnumType.STRING)
	private SellBuyType type;
	
	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime trade_time;

	public TradeTransaction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TradeTransaction(int id, User user, Stocks stock, int quantity, double price, double totalammount,
			SellBuyType type, LocalDateTime trade_time) {
		super();
		this.id = id;
		this.user = user;
		this.stock = stock;
		this.quantity = quantity;
		this.price = price;
		this.totalammount = totalammount;
		this.type = type;
		this.trade_time = trade_time;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}



	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}


	public double getTotalammount() {
		return totalammount;
	}

	public void setTotalammount(double totalammount) {
		this.totalammount = totalammount;
	}

	public SellBuyType getType() {
		return type;
	}

	public void setType(SellBuyType type) {
		this.type = type;
	}

	public LocalDateTime getTrade_time() {
		return trade_time;
	}

	public void setTrade_time(LocalDateTime trade_time) {
		this.trade_time = trade_time;
	}

	@Override
	public String toString() {
		return "TradeTransaction [id=" + id + ", user=" + user + ", stock=" + stock + ", quantity=" + quantity
				+ ", price=" + price + ", totalammount=" + totalammount + ", type=" + type + ", trade_time="
				+ trade_time + "]";
	}
	
	

}
