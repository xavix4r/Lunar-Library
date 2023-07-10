package model;

public class Address {
	
	public Address(int userid, String addressLine1, String addressLine2, int postal) {
		super();
		this.userid = userid;
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.postal = postal;
	}
	private int userid;
	private String addressLine1;
	private String addressLine2;
	private int postal;
	
	
	
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	public int getPostal() {
		return postal;
	}
	public void setPostal(int postal) {
		this.postal = postal;
	}

}
