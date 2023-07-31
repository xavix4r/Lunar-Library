package model;
import java.util.*;

import com.paypal.api.payments.*;
import com.paypal.base.rest.*;



public class PaymentServices {
    private static final String CLIENT_ID = "AeQ6U5cyMWltG-47khtv2jT3JkUXozYhgwzYRXd1B5VDZHRWN428yFGAecV3HQAILQ0x5GyEjR9wcNNH";
    private static final String CLIENT_SECRET = "EPPmAY3xwhN2eWSUGM0Vlcg3T401TFjabBvExZxVT6tbJfwq4-re2xH_h3xwsN0ecmBbsLtAkfjR1Nr8";
    private static final String MODE = "sandbox";
 
    public String authorizePayment(ArrayList<OrderDetails> allOrderDetails, String fname, String lname)        
            throws PayPalRESTException {       
 
        Payer payer = getPayerInformation(fname, lname);
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(allOrderDetails);
         
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");
 
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
 
        Payment approvedPayment = requestPayment.create(apiContext);
 
        return getApprovalLink(approvedPayment);
 
    }
     
    private Payer getPayerInformation(String fname, String lname) {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
         
        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName(fname)
                 .setLastName(lname)
                 .setEmail("sb-d3aez26518238@personal.example.com");
        		
        
         
        payer.setPayerInfo(payerInfo);
         
        return payer;
    }
     
    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/PaypalTest/cancel.html");
        redirectUrls.setReturnUrl("http://localhost:8080/JADCA2/ReviewPayment");
         
        return redirectUrls;
    }
     
    private List<Transaction> getTransactionInformation(ArrayList<OrderDetails> allOrderDetails) {
    	 Details details = new Details();
			
    	    
    	   
        double totalAmount = 0.00;
       double totalTax = 0.00;
     
        Amount amount = new Amount();
        amount.setCurrency("SGD");
        amount.setDetails(details);
		
       
     
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
		
        
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
         
        for (OrderDetails orderDetails : allOrderDetails) { 
        	totalAmount += orderDetails.getTotal();
        	totalTax += orderDetails.getTax();
            Item item = new Item(); // Create a new Item object for each iteration
            
            item.setCurrency("SGD");
            item.setName(orderDetails.getProductName());
            item.setPrice(orderDetails.getTotalStr());
            item.setQuantity(orderDetails.getQuantity());
			
            
            items.add(item);
        }
        details.setTax(String.format("%.2f", totalTax));
        details.setSubtotal(String.format("%.2f", totalAmount));
        amount.setTotal(String.format("%.2f", totalAmount + totalTax));
        
        
        itemList.setItems(items);
        transaction.setItemList(itemList);
     
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);  
         
        return listTransaction;
    }
     
    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;
         
        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }      
         
        return approvalLink;
    }
    
    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }
    
    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);
     
        Payment payment = new Payment().setId(paymentId);
     
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
     
        return payment.execute(apiContext, paymentExecution);
    }

}
