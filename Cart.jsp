<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.model.Cart, com.DAO.model.CartItem" %>    
    
    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FeastFleet— Your Cart</title>
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
      top: 0px;
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
    nav ul {
      display: flex;
      align-items: center;
      list-style: none;
      gap: 16px;
      margin: 0;
      padding: 0;
    }
    nav a {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 12px;
      border-radius: 10px;
      color: var(--text-weak);
      transition: color var(--transition), background var(--transition), transform var(--transition);
    }
    nav a:hover { color: var(--text); background: rgba(255,255,255,0.06); transform: translateY(-1px); }
    nav .cta {
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      color: #fff;
      border-radius: 12px;
      padding: 10px 14px;
      box-shadow: 0 10px 20px rgba(252,128,25,0.3);
      transition: transform var(--transition), box-shadow var(--transition), filter var(--transition);
    }
    nav .cta:hover { transform: translateY(-2px); box-shadow: 0 14px 26px rgba(252,128,25,0.38); filter: saturate(1.05); }

    /* Cart Hero */
    .cart-hero {
      position: relative;
      min-height: 200px;
      background: #0c0c0d;
      overflow: hidden;
      border-bottom: 1px solid rgba(255,255,255,0.06);
    }
    .cart-hero::before {
      content: "";
      position: absolute;
      inset: 0;
      background-image: url('https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?q=80&w=2070&auto=format&fit=crop');
      background-size: cover;
      background-position: center;
      opacity: 0.15;
      filter: saturate(1.1) contrast(1.05);
      transform: scale(1.04);
    }
    .cart-hero::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(180deg, rgba(12,12,13,0.3) 0%, rgba(12,12,13,0.85) 60%, rgba(12,12,13,1) 100%);
    }
    .cart-hero-inner {
      position: relative;
      z-index: 1;
      padding: 40px 0 20px;
    }
    .cart-header {
      text-align: center;
      margin-bottom: 20px;
    }
    .cart-header h1 {
      font-family: "Poppins", sans-serif;
      font-weight: 700;
      font-size: 32px;
      margin: 0 0 8px;
      letter-spacing: 0.3px;
    }
    .cart-header p {
      color: var(--text-weak);
      margin: 0;
      font-size: 16px;
    }

    /* Layout */
    .page { padding: 24px 0 90px; }
    .content { 
      display: grid; 
      grid-template-columns: 1fr 380px; 
      gap: 24px; 
      max-width: 1200px;
      margin: 0 auto;
    }

    /* Cart Items */
    .cart-section {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 20px;
      box-shadow: var(--shadow-soft);
    }
    .section-title {
      margin: 0 0 16px;
      font-family: "Poppins", sans-serif;
      font-size: 20px;
      color: var(--text);
    }

    .cart-item {
      display: grid;
      grid-template-columns: 80px 1fr auto;
      gap: 16px;
      padding: 16px;
      background: rgba(255,255,255,0.02);
      border: 1px solid rgba(255,255,255,0.04);
      border-radius: var(--radius-sm);
      margin-bottom: 12px;
      transition: transform var(--transition), box-shadow var(--transition), border-color var(--transition);
    }
    .cart-item:hover {
      transform: translateY(-1px);
      box-shadow: var(--shadow-soft);
      border-color: rgba(255,255,255,0.08);
    }
    .cart-item:last-child { margin-bottom: 0; }

    .item-image {
      width: 80px;
      height: 80px;
      border-radius: 10px;
      overflow: hidden;
    }
    .item-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .item-details h3 {
      margin: 0 0 6px;
      font-family: "Poppins", sans-serif;
      font-size: 16px;
      font-weight: 600;
    }
    .item-details .restaurant {
      color: var(--text-weak);
      font-size: 13px;
      margin-bottom: 8px;
    }
    .item-details .price {
      font-weight: 700;
      color: var(--brand);
      font-size: 16px;
    }

    .item-actions {
      display: flex;
      flex-direction: column;
      align-items: flex-end;
      gap: 8px;
    }

    .qty-controls {
      display: flex;
      align-items: center;
      gap: 8px;
      background: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 999px;
      padding: 4px;
    }
    .qty-controls button {
      width: 28px;
      height: 28px;
      border: 0;
      border-radius: 999px;
      background: rgba(255,255,255,0.08);
      color: var(--text);
      cursor: pointer;
      display: grid;
      place-items: center;
      transition: background var(--transition), transform var(--transition);
    }
    .qty-controls button:hover {
      background: rgba(255,255,255,0.12);
      transform: scale(1.05);
    }
    .qty-controls span {
      min-width: 20px;
      text-align: center;
      font-weight: 700;
      font-size: 14px;
    }

    .remove-btn {
      background: none;
      border: none;
      color: var(--text-weak);
      cursor: pointer;
      padding: 4px;
      border-radius: 4px;
      transition: color var(--transition), background var(--transition);
    }
    .remove-btn:hover {
      color: #ff6b6b;
      background: rgba(255,107,107,0.1);
    }

    /* Empty Cart */
    .empty-cart {
      text-align: center;
      padding: 60px 20px;
    }
    .empty-cart svg {
      width: 80px;
      height: 80px;
      color: var(--text-weak);
      margin: 0 auto 20px;
    }
    .empty-cart h3 {
      margin: 0 0 12px;
      font-family: "Poppins", sans-serif;
      font-size: 20px;
    }
    .empty-cart p {
      color: var(--text-weak);
      margin: 0 0 24px;
    }

    /* Order Summary */
    .order-summary {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 20px;
      box-shadow: var(--shadow-soft);
      position: sticky;
      top: 140px;
      align-self: start;
    }

    .summary-title {
      margin: 0 0 16px;
      font-family: "Poppins", sans-serif;
      font-size: 18px;
      color: var(--text);
    }

    .summary-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 0;
      font-size: 14px;
    }
    .summary-row.total {
      border-top: 1px solid rgba(255,255,255,0.08);
      margin-top: 12px;
      padding-top: 16px;
      font-weight: 700;
      font-size: 16px;
      color: var(--text);
    }
    .summary-row .label { color: var(--text-weak); }
    .summary-row .value { color: var(--text); }

    /* Delivery Info */
    .delivery-info {
      background: rgba(252,128,25,0.08);
      border: 1px solid rgba(252,128,25,0.2);
      border-radius: var(--radius-sm);
      padding: 16px;
      margin: 16px 0;
    }
    .delivery-info h4 {
      margin: 0 0 8px;
      font-family: "Poppins", sans-serif;
      font-size: 14px;
      color: #ffd6c0;
    }
    .delivery-info p {
      margin: 0;
      font-size: 13px;
      color: var(--text-weak);
    }

    /* Buttons */
    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      width: 100%;
      padding: 14px 20px;
      border: 0;
      border-radius: 12px;
      color: #101010;
      font-weight: 700;
      font-family: "Poppins", sans-serif;
      font-size: 16px;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      box-shadow: 0 10px 20px rgba(252,128,25,0.3);
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition), filter var(--transition);
    }
    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 14px 26px rgba(252,128,25,0.38);
      filter: saturate(1.05);
    }
    .btn:active { transform: translateY(0) scale(0.98); }

    .btn.secondary {
      background: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.12);
      color: var(--text);
      box-shadow: none;
    }
    .btn.secondary:hover {
      background: rgba(255,255,255,0.08);
      border-color: rgba(255,255,255,0.18);
      box-shadow: var(--shadow-soft);
    }

    /* Offers */
    .offers-section {
      margin-top: 20px;
    }
    .offer-card {
      background: linear-gradient(135deg, #1a1a1d 0%, #121214 100%);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius-sm);
      padding: 12px;
      margin-bottom: 8px;
      transition: transform var(--transition), border-color var(--transition);
    }
    .offer-card:hover {
      transform: translateY(-1px);
      border-color: rgba(255,255,255,0.12);
    }
    .offer-card:last-child { margin-bottom: 0; }
    .offer-title {
      font-size: 13px;
      font-weight: 600;
      color: #ffd6c0;
      margin: 0 0 4px;
    }
    .offer-desc {
      font-size: 12px;
      color: var(--text-weak);
      margin: 0;
    }

    /* Footer */
    footer {
      margin-top: 44px;
      background: #0b0b0c;
      border-top: 1px solid rgba(255,255,255,0.06);
      padding: 34px 0;
    }
    .footer-grid {
      display: grid;
      grid-template-columns: 1.2fr 1fr 1fr 1fr;
      gap: 16px;
    }
    .footer h4 { margin: 0 0 10px; font-size: 14px; color: #d9dade; letter-spacing: 0.2px; }
    .footer ul { list-style: none; margin: 0; padding: 0; display: grid; gap: 8px; }
    .footer a { color: var(--text-weak); font-size: 14px; }
    .footer a:hover { color: var(--text); }
    .socials { display: inline-flex; align-items: center; gap: 10px; margin-top: 10px; }
    .socials a {
      width: 36px; height: 36px; display: grid; place-items: center; border-radius: 10px;
      background: rgba(255,255,255,0.04);
      border: 1px solid rgba(255,255,255,0.08);
      transition: transform var(--transition), background var(--transition), border-color var(--transition);
    }
    .socials a:hover { transform: translateY(-2px); background: rgba(255,255,255,0.08); border-color: rgba(255,255,255,0.18); }

    /* Responsive */
    @media (max-width: 1024px) {
      .content { grid-template-columns: 1fr 320px; }
      .footer-grid { grid-template-columns: 1fr 1fr; }
    }
    @media (max-width: 768px) {
      .content { grid-template-columns: 1fr; }
      .order-summary { position: static; }
      .cart-item { grid-template-columns: 80px 1fr; }
      .item-actions { grid-column: 1 / -1; flex-direction: row; justify-content: space-between; align-items: center; margin-top: 12px; }
      .footer-grid { grid-template-columns: 1fr; }
    }
    @media (max-width: 520px) {
      .brand .name { display: none; }
      .cart-header h1 { font-size: 24px; }
      .cart-item { grid-template-columns: 1fr; text-align: center; }
      .item-image { margin: 0 auto; }
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="container nav">
      <div class="brand">
        <div class="logo" aria-hidden="true">🍽️</div>
        <div class="name">FeastFleet</div>
      </div>
      <nav>
        <ul>
          <li><a href="GetAllResturantsServlet">Home</a></li>
          <li><a href="#">Offers</a></li>
          <li><a href="#" style="color: var(--text)">Cart</a></li>
          <% if (session.getAttribute("userId") != null) { %>
            <li><a href="OrderHistory.jsp">Order History</a></li>
                                  <li><a class="cta" href="logout">Logout</a></li>
          <% } else { %>
            <li><a class="cta" href="Login.jsp">Login / Sign Up</a></li>
          <% } %>
        </ul>
      </nav>
    </div>
  </header>

  <!-- Cart Hero -->
  <section class="cart-hero">
    <div class="container cart-hero-inner">
      <div class="cart-header">
        <h1>Your Cart</h1>
        <p>Review your items and proceed to checkout</p>
      </div>
    </div>
  </section>

  <!-- Page Content -->
  <main class="page">
    <div class="container content">
      <!-- Cart Items -->
      <section class="cart-section">
          <%
        Cart cart = (Cart)session.getAttribute("cart");
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
       
        %>
        <h2 class="section-title">Cart Items</h2>
        
        <!-- Cart Item 1 -->
    <% 
        if(cart != null && !cart.getItems().isEmpty()){
        	for(CartItem item : cart.getItems().values()){
        		
        %>
        <div class="cart-item">
          <div class="item-image">
            <img src="<%= item.getItemimagescr() %>" alt="<%= item.getItemName() %> image" >
          </div>
          <div class="item-details">
            <h3><%=item.getItemName() %></h3>
            <div class="restaurant"></div>
            <div class="price">₹<%=item.getPrice() %></div>
          </div>
          <div class="item-actions">
         

          
          
            <div class="qty-controls">
            
			  <!-- Increase Quantity Form -->
              <form action="callfromMenu" method="post" style="display: inline;">
                <input type="hidden" name="itemID" value="<%= item.getCartitemID() %>">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                <input type="hidden" name="from" value="cart">
                <input type="hidden" name="restaurantId" value="<%= session.getAttribute("restaurantId") %>">
			    <button  <% if (item.getQuantity() == 1) { %> disabled <% } %>>-</button>
			</form>
			
			
			  <!-- Display Current Quantity -->
			  <span><%=item.getQuantity() %></span>
			
			
			
			  <!-- Decrease Quantity Form -->
              <form action="callfromMenu" method="post" style="display: inline;">
                <input type="hidden" name="itemID" value="<%= item.getCartitemID() %>">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                <input type="hidden" name="from" value="cart">
                <input type="hidden" name="restaurantId" value="<%= session.getAttribute("restaurantId") %>">
              <button>+</button>
              </form>
            </div>
            
            
            
            <form action="callfromMenu" method="post">
                <input type="hidden" name="itemID" value="<%= item.getCartitemID() %>">
                <input type="hidden" name="restaurantId" value="<%= session.getAttribute("restaurantId") %>">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="from" value="cart">
           		 <button class="remove-btn">
		              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
		                <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/>
		              </svg>
            	</button>
            </form>
          </div>
        </div>
        <%
        	}
        }%>

        <!-- Empty cart message -->
        <% if(cart == null || cart.getItems().isEmpty()){ %>
        <div class="empty-cart">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12L8.1 13h7.45c.75 0 1.41-.41 1.75-1.03L21.7 4H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
          </svg>
          <h3>Your cart is empty</h3>
          <p>Add some delicious items to get started</p>
          <a href="GetAllResturantsServlet" class="btn">
            Browse Restaurants
          </a>
        </div>
        <% } %>
      </section>

      <!-- Order Summary Sidebar -->
      <aside class="order-summary">
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
        
        <h3 class="summary-title">Order Summary</h3>
        
        <div class="summary-row">
          <span class="label">Subtotal (<%= totalItems %> items)</span>
          <span class="value">₹<%= subtotal %></span>
        </div>
        
        <div class="summary-row">
          <span class="label">Delivery Fee</span>
          <span class="value">₹<%= deliveryFee %></span>
        </div>
        
        <div class="summary-row">
          <span class="label">Taxes & Charges</span>
          <span class="value">₹<%= taxes %></span>
        </div>
        <div class="summary-row total">
          <span class="label">Total</span>
          <span class="value">₹<%=total %></span>
        </div>


        <div class="delivery-info">
          <!-- <h4>🚚 Free Delivery</h4> -->
          <p>Your order will be delivered in 30-40 minutes</p>
        </div>

        <% if(totalItems > 0) { %>
        <a href="Checkout.jsp" class="btn">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
          </svg>
          Proceed to Checkout
        </a>
        <% } %>

        <a href="GetAllResturantsServlet" class="btn secondary">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
            <path d="M19 13H5v-2h14v2z"/>
          </svg>
          Continue Shopping
        </a>
	 
        <!-- Offers -->
       
        <div class="offers-section">
          <h4 style="margin: 0 0 12px; font-family: 'Poppins'; font-size: 14px; color: var(--text);">Available Offers</h4>
          
          <div class="offer-card">
            <div class="offer-title">🎉 10% OFF up to ₹30</div>
            <div class="offer-desc">Use code WELCOME10 on orders above ₹199</div>
          </div>
          
          <div class="offer-card">
            <div class="offer-title">💳 9% OFF with Cards</div>
            <div class="offer-desc">Use cards from select banks</div>
          </div>
          
          <div class="offer-card">
            <div class="offer-title">🎁 Free Delivery</div>
            <div class="offer-desc">On orders above ₹499</div>
          </div>
        </div>
        </aside>
    </div>
  </main>

  <!-- Footer -->
  <footer>
    <div class="container footer">
      <div class="footer-grid">
        <div>
          <div class="brand">
            <div class="logo" aria-hidden="true">🍽️</div>
            <div class="name">Foodly</div>
          </div>
          <p style="color:var(--text-weak); font-size:14px; margin-top:10px; max-width:420px;">
            Bringing your favorite meals to your door — fast, fresh, and with the best deals in town.
          </p>
          <div class="socials">
            <a href="#" aria-label="Instagram">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M7 2h10a5 5 0 0 1 5 5v10a5 5 0 0 1-5 5H7a5 5 0 0 1-5-5V7a5 5 0 0 1 5-5Zm0 2a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3H7Zm5 3.5A5.5 5.5 0 1 1 6.5 13 5.5 5.5 0 0 1 12 7.5Zm0 2A3.5 3.5 0 1 0 15.5 13 3.5 3.5 0 0 0 12 9.5Zm5.75-3.25a1.25 1.25 0 1 1-1.25 1.25 1.25 1.25 0 0 1 1.25-1.25Z"/></svg>
            </a>
            <a href="#" aria-label="Twitter">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M22 5.8c-.7.3-1.5.6-2.3.7.8-.5 1.4-1.2 1.7-2.2-.7.4-1.6.8-2.5 1-1.5-1.6-4-1.6-5.6-.1-1 1-1.4 2.5-1 3.9-3.2-.2-6-1.7-7.9-4.1-1 1.7-.5 3.8 1.1 4.9-.6 0-1.1-.2-1.6-.4 0 1.9 1.4 3.6 3.3 4-.6.2-1.2.2-1.9.1.5 1.6 2 2.8 3.8 2.9-1.4 1.1-3.2 1.7-5 1.7H2c1.9 1.2 4.1 1.8 6.3 1.8 7.6 0 11.8-6.4 11.8-11.9v-.5c.8-.6 1.4-1.2 1.9-2Z"/></svg>
            </a>
            <a href="#" aria-label="Facebook">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M13 10h3l.5-3H13V5.5c0-.9.3-1.5 1.5-1.5H16V1.1c-.3 0-1-.1-2-.1-2.3 0-3.8 1.4-3.8 4V7H8v3h2v10h3V10Z"/></svg>
            </a>
          </div>
        </div>
        <div>
          <h4>Company</h4>
          <ul>
            <li><a href="#">About Us</a></li>
            <li><a href="#">Careers</a></li>
            <li><a href="#">Press</a></li>
          </ul>
        </div>
        <div>
          <h4>Support</h4>
          <ul>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Help & FAQ</a></li>
            <li><a href="#">Cancellations</a></li>
          </ul>
        </div>
        <div>
          <h4>Legal</h4>
          <ul>
            <li><a href="#">Terms & Privacy</a></li>
            <li><a href="#">Refund Policy</a></li>
            <li><a href="#">Security</a></li>
          </ul>
        </div>
      </div>
    </div>
  </footer>

  <script>
    // Update quantity
    function updateQuantity(button, change) {
      const qtySpan = button.parentElement.querySelector('span');
      let currentQty = parseInt(qtySpan.textContent);
      let newQty = currentQty + change;
      
      if (newQty < 1) {
        newQty = 1;
      }
      
      qtySpan.textContent = newQty;
      updateOrderSummary();
    }

    // Remove item
    function removeItem(button) {
      const cartItem = button.closest('.cart-item');
      cartItem.style.opacity = '0';
      cartItem.style.transform = 'translateX(-20px)';
      
      setTimeout(() => {
        cartItem.remove();
        updateOrderSummary();
        
        // Check if cart is empty
        const remainingItems = document.querySelectorAll('.cart-item');
        if (remainingItems.length === 0) {
          showEmptyCart();
        }
      }, 200);
    }

    // Update order summary
    function updateOrderSummary() {
      const items = document.querySelectorAll('.cart-item');
      let totalItems = 0;
      let subtotal = 0;
      
      items.forEach(item => {
        const qty = parseInt(item.querySelector('.qty-controls span').textContent);
        const price = parseInt(item.querySelector('.price').textContent.replace('₹', ''));
        totalItems += qty;
        subtotal += qty * price;
      });
      
      const deliveryFee = totalItems > 0 ? 30 : 0;
      const taxes = Math.round(subtotal * 0.075); // 7.5% tax
      const total = subtotal + deliveryFee + taxes;
      
      // Update summary display
   document.querySelector('.subtotal-value').textContent = `₹${subtotal}`;
document.querySelector('.delivery-fee-value').textContent = `₹${deliveryFee}`;
document.querySelector('.taxes-value').textContent = `₹${taxes}`;
document.querySelector('.total-value').textContent = `₹${total}`;

      
      // Update section title
      document.querySelector('.section-title').textContent = `Cart Items (${totalItems})`;
    }

    // Show empty cart
    function showEmptyCart() {
      const cartSection = document.querySelector('.cart-section');
      cartSection.innerHTML = `
        <div class="empty-cart">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12L8.1 13h7.45c.75 0 1.41-.41 1.75-1.03L21.7 4H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/>
          </svg>
          <h3>Your cart is empty</h3>
          <p>Add some delicious items to get started</p>
          <button class="btn" onclick="window.location.href='menu.html'">
            Browse Restaurants
          </button>
        </div>
      `;
    }

    // Proceed handled via form submit to /order

    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
      updateOrderSummary();
    });
  </script>

</body>
</html>
