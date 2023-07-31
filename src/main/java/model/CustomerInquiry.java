package model;

public class CustomerInquiry {
    private int userId;
    private String inquiryType;
    private String inquiryText;
    private boolean requireResponse;
    private String email;
    private int inquiryId;


    public CustomerInquiry(int userId, String inquiryType, String inquiryText, boolean requireResponse, String email) {
        this.userId = userId;
        this.inquiryType = inquiryType;
        this.inquiryText = inquiryText;
        this.requireResponse = requireResponse;
        this.email = email;
    }


    public CustomerInquiry(int inquiryId, int userId, String inquiryType, String inquiryText, boolean requireResponse, String email) {
    	this.inquiryId = inquiryId;
    	this.userId = userId;
        this.inquiryType = inquiryType;
        this.inquiryText = inquiryText;
        this.requireResponse = requireResponse;
        this.email = email;
	}

    public int getInquiryId() {
        return inquiryId;
    }

    public void setInquiryId(int inquiryId) {
        this.inquiryId = inquiryId;
    }

   
	public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getInquiryType() {
        return inquiryType;
    }

    public void setInquiryType(String inquiryType) {
        this.inquiryType = inquiryType;
    }

    public String getInquiryText() {
        return inquiryText;
    }

    public void setInquiryText(String inquiryText) {
        this.inquiryText = inquiryText;
    }

    public boolean isRequireResponse() {
        return requireResponse;
    }

    public void setRequireResponse(boolean requireResponse) {
        this.requireResponse = requireResponse;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
