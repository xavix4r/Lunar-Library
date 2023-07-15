package model;

import java.util.Date;

public class Book {
	private int bookid;
	private String title;
	private String author;
	private Double price;
	private int quantity;
	private String publisher;
	private Date date;
	private String isbn;
	private String genre;
	private Double rating;
	private String description;
	private String imgurl;

	
	public Book(int bookid, String title, String author, Double price, int quantity, String publisher, Date date,
			String isbn, String genre, Double rating, String description, String imgurl) {
		super();
		this.bookid = bookid;
		this.title = title;
		this.author = author;
		this.price = price;
		this.quantity = quantity;
		this.publisher = publisher;
		this.date = date;
		this.isbn = isbn;
		this.genre = genre;
		this.rating = rating;
		this.description = description;
		this.imgurl = imgurl;
	}


	public int getBookid() {
		return bookid;
	}


	public void setBookid(int bookid) {
		this.bookid = bookid;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public Double getPrice() {
		return price;
	}
	
	public String getPriceStr() {
		 return String.format("%.2f", price);
	}


	public void setPrice(Double price) {
		this.price = price;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public String getPublisher() {
		return publisher;
	}


	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}


	public Date getDate() {
		return date;
	}


	public void setDate(Date date) {
		this.date = date;
	}


	public String getIsbn() {
		return isbn;
	}


	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}


	public String getGenre() {
		return genre;
	}


	public void setGenre(String genre) {
		this.genre = genre;
	}


	public Double getRating() {
		return rating;
	}


	public void setRating(Double rating) {
		this.rating = rating;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getImgurl() {
		return imgurl;
	}


	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	
}
