package model;

public class BookRanking {
    private String title;
    private int copiesSold;
    private int quantity; 

    public BookRanking(String title, int copiesSold) {
        this.title = title;
        this.copiesSold = copiesSold;
    }

    public BookRanking(String title, int copiesSold, int quantity) {
        this.title = title;
        this.copiesSold = copiesSold;
        this.quantity = quantity;
    }

    public String getTitle() {
        return title;
    }

    public int getCopiesSold() {
        return copiesSold;
    }

    public int getQuantity() {
        return quantity;
    }
}
