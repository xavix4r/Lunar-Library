package model;

import java.util.Arrays;

public class OrderDetails {
    private String orderNumber;
    private int[] bookIds;
    private int[] quantities;
    private double totalCost;

    public OrderDetails() {
        // Default constructor
    }

    public OrderDetails(String orderNumber, int[] bookIds, int[] quantities, double totalCost) {
        this.orderNumber = orderNumber;
        this.bookIds = bookIds;
        this.quantities = quantities;
        this.totalCost = totalCost;
    }

    // Getters and setters for the attributes

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public int[] getBookIds() {
        return bookIds;
    }

    public void setBookIds(int[] bookIds) {
        this.bookIds = bookIds;
    }

    public int[] getQuantities() {
        return quantities;
    }

    public void setQuantities(int[] quantities) {
        this.quantities = quantities;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    @Override
    public String toString() {
        return "OrderDetails{" +
                "orderNumber='" + orderNumber + '\'' +
                ", bookIds=" + Arrays.toString(bookIds) +
                ", quantities=" + Arrays.toString(quantities) +
                ", totalCost=" + totalCost +
                '}';
    }
}
