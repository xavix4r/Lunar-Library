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
 
   
 
   
     
    public String getTotal() {
        double roundedTotal = Math.round(total * 100.0) / 100.0;
        return String.format("%.2f", roundedTotal);
    }

	public String getQuantity() {
		
		return String.valueOf(quantity);
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}