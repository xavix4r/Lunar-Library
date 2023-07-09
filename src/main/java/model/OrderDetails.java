package model;


public class OrderDetails {
    private String productName;
    
    
    private Double total;
	private int quantity;
 
    public OrderDetails(String productName, String quantity,
            String total) {
        this.productName = productName;
        
        this.quantity = Integer.parseInt(quantity);
        this.total = Double.parseDouble(total);
        
    }
 
    public String getProductName() {
        return productName;
    }
 
   
 
   public double getTotal() {
	   return total;
   }
     
    public String getTotalStr() {
       
        return String.format("%.2f", total);
    }

	public String getQuantity() {
		
		return String.valueOf(quantity);
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public double getTax() {
		return total * 0.08;
	}
}