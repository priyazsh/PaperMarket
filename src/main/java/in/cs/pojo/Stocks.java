package in.cs.pojo;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="stocks")
public class Stocks {
@Id
   private String symbol;
	private String name;
	private Long volume;
	private Integer status;

	@OneToMany(mappedBy = "stock",cascade=CascadeType.ALL)
	private List<TradeTransaction> tt;
	
	@OneToMany(mappedBy = "stock",cascade=CascadeType.ALL)
	private List<UserHolding> userhold;
	public Stocks() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public String getSymbol() {
		return symbol;
	}



	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public Long getVolume() {
		return volume;
	}



	public void setVolume(Long volume) {
		this.volume = volume;
	}



	public Integer getStatus() {
		return status;
	}



	public void setStatus(Integer status) {
		this.status = status;
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



	public Stocks(String symbol, String name, Long volume, Integer status, List<TradeTransaction> tt,
			List<UserHolding> userhold) {
		super();
		this.symbol = symbol;
		this.name = name;
		this.volume = volume;
		this.status = status;
		this.tt = tt;
		this.userhold = userhold;
	}



	@Override
	public String toString() {
		return "Stocks [symbol=" + symbol + ", name=" + name + ", volume=" + volume + ", status=" + status + "]";
	}
	
	
	
}
