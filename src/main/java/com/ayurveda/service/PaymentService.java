package com.ayurveda.service;

import com.ayurveda.entity.Booking;
import com.ayurveda.entity.ProductOrder;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.math.BigDecimal;
import java.util.Formatter;

@Service
public class PaymentService {

    @Value("${razorpay.key.id:rzp_test_RIlD5bEKRjyn3h}")
    private String razorpayKeyId;

    @Value("${razorpay.key.secret:Ltg6uo9vI8TiFMVfj2cGm4I8}")
    private String razorpayKeySecret;

    private RazorpayClient razorpayClient;

    private RazorpayClient getRazorpayClient() throws RazorpayException {
        if (razorpayClient == null) {
            razorpayClient = new RazorpayClient(razorpayKeyId, razorpayKeySecret);
        }
        return razorpayClient;
    }

    /**
     * Create a Razorpay order for payment
     */
    public String createRazorpayOrder(ProductOrder productOrder) throws RazorpayException {
        JSONObject orderRequest = new JSONObject();
        
        // Convert amount to paise (smallest currency unit)
        int amountInPaise = productOrder.getTotalAmount().multiply(new BigDecimal(100)).intValue();
        
        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt", productOrder.getOrderNumber());
        orderRequest.put("payment_capture", 1); // Auto capture

        // Add notes
        JSONObject notes = new JSONObject();
        notes.put("order_number", productOrder.getOrderNumber());
        notes.put("user_id", productOrder.getUser().getId());
        orderRequest.put("notes", notes);

        Order razorpayOrder = getRazorpayClient().orders.create(orderRequest);
        return razorpayOrder.get("id");
    }

    /**
     * Verify payment signature
     */
    public boolean verifyPaymentSignature(String orderId, String paymentId, String signature) {
        try {
            String payload = orderId + "|" + paymentId;
            String expectedSignature = calculateHmacSha256(payload, razorpayKeySecret);
            return expectedSignature.equals(signature);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Calculate HMAC SHA256 signature
     */
    private String calculateHmacSha256(String data, String secret) throws Exception {
        SecretKeySpec secretKeySpec = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(secretKeySpec);
        byte[] hmacData = mac.doFinal(data.getBytes());
        
        Formatter formatter = new Formatter();
        for (byte b : hmacData) {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    /**
     * Create a Razorpay order for Booking payment
     */
    public String createRazorpayOrderForBooking(Booking booking) throws RazorpayException {
        JSONObject orderRequest = new JSONObject();
        
        // Convert amount to paise (smallest currency unit)
        int amountInPaise = booking.getTotalAmount().multiply(new BigDecimal(100)).intValue();
        
        orderRequest.put("amount", amountInPaise);
        orderRequest.put("currency", "INR");
        orderRequest.put("receipt", booking.getBookingNumber());
        orderRequest.put("payment_capture", 1); // Auto capture

        // Add notes
        JSONObject notes = new JSONObject();
        notes.put("booking_number", booking.getBookingNumber());
        if (booking.getUser() != null) {
            notes.put("user_id", booking.getUser().getId());
        }
        notes.put("hospital_id", booking.getHospital().getId());
        orderRequest.put("notes", notes);

        Order razorpayOrder = getRazorpayClient().orders.create(orderRequest);
        return razorpayOrder.get("id");
    }

    /**
     * Get Razorpay key ID for frontend
     */
    public String getRazorpayKeyId() {
        return razorpayKeyId;
    }
}

