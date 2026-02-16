package in.cs.daoimpl;

import java.net.URI;
import java.net.URL;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import in.cs.dao.StocksDao;
import in.cs.pojo.Stocks;

@Transactional
@Component
public class StocksDaoImpl implements StocksDao {

	@Autowired
	private SessionFactory session;
	
	@Override
	public List<Stocks> totalStock() {
		Session currentSession = session.getCurrentSession();
	     Query<Stocks> query = currentSession.createQuery("From Stocks",Stocks.class);
		List<Stocks> list = query.list();
	    if(list!=null) {
	    	return list;
	    }
	    else {
	    	return null;
	    }
	}

	@Override
	public boolean addStocks(Stocks stock) {
		try {
			Session currentSession = session.getCurrentSession();
					
			Stocks exist = currentSession.get(Stocks.class, stock.getName());
			if(exist!=null) {
			return false;	
			}
			currentSession.persist(stock);
			currentSession.flush();
		
			return true;	
		}  catch (Exception e) {
	        
	        return false;
	    }
		
	}

	@Override
	public boolean deleteStock(String Symbol) {
		try {
			Session currentSession = session.getCurrentSession();
			Stocks stocks = currentSession.find(Stocks.class, Symbol);
			if(stocks!=null) {
		        currentSession.remove(stocks);
		        return true;
			}	
			else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}
	
	@Override
	public Stocks FindStockBySymbol(String symbol) {
		Stocks stocks = session.getCurrentSession().get(Stocks.class, symbol);
		if(stocks!=null) {
			return stocks;
		}else {
			return null;
		}
		
	}
	
	@Override
	public double getLivePrice(String symbol) {
	
		    try {
		        String url = "https://query1.finance.yahoo.com/v8/finance/chart/"
		                + symbol + ".NS?interval=1d&range=1d";

		        HttpClient client = HttpClient.newHttpClient();
		        HttpRequest request = HttpRequest.newBuilder()
		                .uri(URI.create(url))
		                .header("User-Agent", "Mozilla/5.0")   
		                .GET()
		                .build();

		        HttpResponse<String> response =
		                client.send(request, BodyHandlers.ofString());

		        int statusCode = response.statusCode();

		        if (statusCode != 200) {
		            System.out.println("API Error: " + statusCode);
		            return 0;
		        }

		        String json = response.body();

		      
		        if (json == null || !json.trim().startsWith("{")) {
		            System.out.println("Invalid API response: " + json);
		            return 0;
		        }

		        ObjectMapper obj = new ObjectMapper();
		        JsonNode tree = obj.readTree(json);

		        JsonNode resultNode = tree
		                .path("chart")
		                .path("result");

		        if (!resultNode.isArray() || resultNode.size() == 0) {
		            return 0;
		        }

		        double livePrice = resultNode
		                .get(0)
		                .path("meta")
		                .path("regularMarketPrice")
		                .asDouble();

		        return livePrice;

		    } catch (Exception e) {
		        System.out.println("Live price fetch failed");
		        return 0;
		    }
		}
	
	
	
	
}
