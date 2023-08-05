package model;

import java.util.Date;

public class PaidOrder {
    private int userId;
    private int orderId;
    private Double total;
    private Date orderDate;
    private String username;

    public PaidOrder(int userId, int orderId, Double total, Date orderDate) {
        this.userId = userId;
        this.orderId = orderId;
        this.total = total;
        this.orderDate = orderDate;
    }
    
    public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public PaidOrder(Double total, Date orderDate, String username) {
    	this.total = total;
    	this.orderDate = orderDate;
    	this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}

