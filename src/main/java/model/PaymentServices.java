package model;
import java.util.*;

import com.paypal.api.payments.*;
import com.paypal.base.rest.*;



public class PaymentServices {
    private static final String CLIENT_ID = "AeQ6U5cyMWltG-47khtv2jT3JkUXozYhgwzYRXd1B5VDZHRWN428yFGAecV3HQAILQ0x5GyEjR9wcNNH";
    private static final String CLIENT_SECRET = "EPPmAY3xwhN2eWSUGM0Vlcg3T401TFjabBvExZxVT6tbJfwq4-re2xH_h3xwsN0ecmBbsLtAkfjR1Nr8";
    private static final String MODE = "sandbox";
 
    public String authorizePayment(ArrayList<OrderDetails> allOrderDetails)        
            throws PayPalRESTException {       
 
        Payer payer = getPayerInformation();
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
     
    private Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
         
        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName("John")
                 .setLastName("Doe")
                 .setEmail("sb-d3aez26518238@personal.example.com");
         
        payer.setPayerInfo(payerInfo);
         
        return payer;
    }
     
    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/PaypalTest/cancel.html");
        redirectUrls.setReturnUrl("http://localhost:8080/PaypalTest/review_payment");
         
        return redirectUrls;
    }
     
    private List<Transaction> getTransactionInformation(ArrayList<OrderDetails> allOrderDetails) {
      
       
        
     
        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal("40.00");
       
     
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
		/* transaction.setDescription(allOrderDetails.getProductName()); */
         
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
         
        for (OrderDetails orderDetails : allOrderDetails) {
            Item item = new Item(); // Create a new Item object for each iteration
            
            item.setCurrency("USD");
            item.setName(orderDetails.getProductName());
            item.setPrice("20.00");
            item.setQuantity(orderDetails.getQuantity());
            
            items.add(item);
        }

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
}
