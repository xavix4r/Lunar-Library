package model;


public class OrderDetails {
    private String productName;
    
    private int bookId;
    private Double total;
	private int quantity;
 
    public OrderDetails(int bookId, String productName, String quantity,
            String total) {
        this.productName = productName;
        this.bookId = bookId;
        this.quantity = Integer.parseInt(quantity);
        this.total = Double.parseDouble(total);
        
    }
 
    public String getProductName() {
        return productName;
    }
 
   public int getbookId() {
	   return bookId;
   }
 
   public double getTotal() {
	   return total * quantity;
   }
     
    public String getTotalStr() {
       
        return String.format("%.2f", total);
    }

	public String getQuantity() {
		
		return String.valueOf(quantity);
	}
	
public int getQuantityInt() {
		
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public double getTax() {
		return (total * quantity) * 0.08;
	}
}