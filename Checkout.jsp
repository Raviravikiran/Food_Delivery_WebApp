<%@ page language="java" contentType="text/html; charset=UTF-8"
	 pageEncoding="UTF-8"%>
<%@ page import="com.DAO.model.Cart, com.DAO.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FeastFleet— Checkout</title>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --brand: #fc8019;
      --brand-alt: #e23744;
      --bg: #0f0f10;
      --surface: #111113;
      --card: #161619;
      --muted: #7c7f87;
      --text: #e8e8ea;
      --text-weak: #b7b8be;
      --success: #26a65b;
      --warning: #ffb020;
      --radius: 14px;
      --radius-sm: 10px;
      --shadow-1: 0 6px 18px rgba(0,0,0,0.22);
      --shadow-2: 0 12px 28px rgba(0,0,0,0.26);
      --shadow-soft: 0 2px 8px rgba(0,0,0,0.18);
      --container: 1200px;
      --transition: 220ms cubic-bezier(.2,.7,.2,1);
    }

    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      background: #0c0c0d;
      color: var(--text);
      font-family: "Open Sans", system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
      line-height: 1.5;
    }

    a { color: inherit; text-decoration: none; }
    img { display: block; max-width: 100%; height: auto; }

    .container {
      width: 100%;
      max-width: var(--container);
      margin: 0 auto;
      padding: 0 20px;
    }

    /* Header */
    header {
      position: sticky;
      top: 0;
      z-index: 40;
      background: rgba(14,14,16,0.88);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255,255,255,0.06);
    }
    .nav {
      display: flex;
      align-items: center;
      justify-content: space-between;
      height: 68px;
      gap: 16px;
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      font-family: "Poppins", sans-serif;
      font-weight: 700;
      letter-spacing: 0.2px;
    }
    .brand .logo {
      width: 36px;
      height: 36px;
      border-radius: 10px;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      box-shadow: 0 8px 18px rgba(252,128,25,0.35);
      display: grid;
      place-items: center;
      color: #fff;
    }
    .brand .name { font-size: 18px; }

    /* Checkout Layout */
    .checkout-container {
      padding: 40px 0;
      display: grid;
      grid-template-columns: 1fr 400px;
      gap: 40px;
      align-items: start;
    }

    .checkout-form {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 32px;
      box-shadow: var(--shadow-soft);
    }

    .form-section {
      margin-bottom: 32px;
    }

    .form-section h2 {
      font-family: "Poppins", sans-serif;
      font-size: 20px;
      margin: 0 0 20px;
      color: var(--text);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: var(--text);
    }

    .form-group input, .form-group textarea, .form-group select {
      width: 100%;
      padding: 12px 16px;
      background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: var(--radius-sm);
      color: var(--text);
      font-size: 14px;
      transition: border-color var(--transition), box-shadow var(--transition);
    }

    .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
      outline: none;
      border-color: var(--brand);
      box-shadow: 0 0 0 3px rgba(252,128,25,0.1);
    }

    .form-group textarea {
      resize: vertical;
      min-height: 80px;
    }

    .payment-options {
      display: grid;
      gap: 12px;
    }

    .payment-option {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 16px;
      background: rgba(255,255,255,0.02);
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: var(--radius-sm);
      cursor: pointer;
      transition: border-color var(--transition), background var(--transition);
    }

    .payment-option:hover {
      border-color: rgba(255,255,255,0.16);
      background: rgba(255,255,255,0.04);
    }

    .payment-option input[type="radio"] {
      width: auto;
      margin: 0;
    }

    .payment-option.selected {
      border-color: var(--brand);
      background: rgba(252,128,25,0.1);
    }

    /* Order Summary */
    .order-summary {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 24px;
      box-shadow: var(--shadow-soft);
      position: sticky;
      top: 100px;
    }

    .summary-title {
      font-family: "Poppins", sans-serif;
      font-size: 18px;
      margin: 0 0 20px;
      color: var(--text);
    }

    .summary-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 0;
      font-size: 14px;
    }

    .summary-item.total {
      border-top: 1px solid rgba(255,255,255,0.08);
      margin-top: 16px;
      padding-top: 16px;
      font-weight: 700;
      font-size: 16px;
      color: var(--text);
    }

    .summary-item .label { color: var(--text-weak); }
    .summary-item .value { color: var(--text); }

    .btn {
      width: 100%;
      padding: 16px 20px;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      border: 0;
      border-radius: var(--radius-sm);
      color: #101010;
      font-weight: 700;
      font-family: "Poppins", sans-serif;
      font-size: 16px;
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition);
      margin-top: 20px;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(252,128,25,0.3);
    }

    .btn:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .checkout-container {
        grid-template-columns: 1fr;
        gap: 24px;
      }
      .order-summary {
        position: static;
      }
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="container nav">
      <div class="brand">
        <div class="logo" aria-hidden="true">🍽️</div>
        <div class="name">Foodly</div>
      </div>
    </div>
  </header>

  <!-- Checkout Content -->
  <main class="container">
    <%
      // Check if user is logged in
      if (session.getAttribute("userId") == null) {
        response.sendRedirect("Login.jsp?redirectTo=Checkout.jsp");
        return;
      }
      
      // Check if cart exists and has items
      Cart cart = (Cart) session.getAttribute("cart");
      if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("Cart.jsp");
        return;
      }
    %>
    <div class="checkout-container">
      
      <!-- Checkout Form -->
      <div class="checkout-form">
        <form action="order" method="post" id="checkoutForm">
          <input type="hidden" name="action" value="place" />
          
          <!-- Delivery Information -->
          <div class="form-section">
            <h2>Delivery Information</h2>
            
            <div class="form-group">
              <label for="fullName">Full Name</label>
              <input type="text" id="fullName" name="fullName" required>
            </div>
            
            <div class="form-group">
              <label for="phone">Phone Number</label>
              <input type="tel" id="phone" name="phone" required>
            </div>
            
            <div class="form-group">
              <label for="address">Delivery Address</label>
              <textarea id="address" name="address" required placeholder="Enter your complete delivery address"></textarea>
            </div>
            
            <div class="form-group">
              <label for="landmark">Landmark (Optional)</label>
              <input type="text" id="landmark" name="landmark" placeholder="Near hospital, school, etc.">
            </div>
          </div>

          <!-- Payment Method -->
          <div class="form-section">
            <h2>Payment Method</h2>
            <div class="payment-options">
              <label class="payment-option">
                <input type="radio" name="paymentMode" value="COD" checked>
                <span>Cash on Delivery</span>
              </label>
              <label class="payment-option">
                <input type="radio" name="paymentMode" value="CARD">
                <span>Credit/Debit Card</span>
              </label>
              <label class="payment-option">
                <input type="radio" name="paymentMode" value="UPI">
                <span>UPI</span>
              </label>
              <label class="payment-option">
                <input type="radio" name="paymentMode" value="WALLET">
                <span>Digital Wallet</span>
              </label>
            </div>
          </div>
        </form>
      </div>

      <!-- Order Summary -->
      <div class="order-summary">
        <h3 class="summary-title">Order Summary</h3>
        
        <%
          int totalItems = 0;
          int subtotal = 0;
          if (cart != null && cart.getItems() != null) {
            for (CartItem item : cart.getItems().values()) {
              totalItems += item.getQuantity();
              subtotal += item.getQuantity() * item.getPrice();
            }
          }
          int deliveryFee = totalItems > 0 ? 30 : 0;
          int taxes = (int) Math.round(subtotal * 0.075);
          int total = subtotal + deliveryFee + taxes;
        %>
        
        <div class="summary-item">
          <span class="label">Items (<%= totalItems %>)</span>
          <span class="value">₹<%= subtotal %></span>
        </div>
        
        <div class="summary-item">
          <span class="label">Delivery Fee</span>
          <span class="value">₹<%= deliveryFee %></span>
        </div>
        
        <div class="summary-item">
          <span class="label">Taxes & Charges</span>
          <span class="value">₹<%= taxes %></span>
        </div>
        
        <div class="summary-item total">
          <span class="label">Total</span>
          <span class="value">₹<%= total %></span>
        </div>

        <button type="submit" form="checkoutForm" class="btn">
          Place Order • ₹<%= total %>
        </button>
      </div>
    </div>
  </main>

  <script>
    // Payment option selection
    document.querySelectorAll('.payment-option input[type="radio"]').forEach(radio => {
      radio.addEventListener('change', function() {
        // Remove selected class from all options
        document.querySelectorAll('.payment-option').forEach(option => {
          option.classList.remove('selected');
        });
        
        // Add selected class to current option
        if (this.checked) {
          this.closest('.payment-option').classList.add('selected');
        }
      });
    });

    // Form validation
    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
      const address = document.getElementById('address').value.trim();
      const phone = document.getElementById('phone').value.trim();
      
      if (!address || !phone) {
        e.preventDefault();
        alert('Please fill in all required fields');
        return false;
      }
      
      // Basic phone validation
      if (phone.length < 10) {
        e.preventDefault();
        alert('Please enter a valid phone number');
        return false;
      }
    });
  </script>

</body>
</html>
