package model;

import java.util.Date;
import java.text.DecimalFormat;

public class PaidBook extends Book{
	
	
	private int orderid;
	private int quantityOrdered;
	
	public PaidBook(int bookid, String title, String author, Double price, int quantity, String publisher, Date date,
			String isbn, String genre, Double rating, String description, String imgurl, int orderid,
			int quantityOrdered) {
		super(bookid, title, author, price, quantity, publisher, date, isbn, genre, rating, description, imgurl);
		this.orderid = orderid;
		this.quantityOrdered = quantityOrdered;
	}

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}

	public int getQuantityOrdered() {
		return quantityOrdered;
	}

	public void setQuantityOrdered(int quantityOrdered) {
		this.quantityOrdered = quantityOrdered;
	}
	
	public String getTotalPaid() {
	    DecimalFormat decimalFormat = new DecimalFormat("#.00");
	    return decimalFormat.format( getPrice() * (double)quantityOrdered);
	}
	

}
