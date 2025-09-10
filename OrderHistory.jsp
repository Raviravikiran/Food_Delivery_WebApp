<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.DAO.daoImp.OrderDAOimpl,com.DAO.daoImp.OrderItemDAOimpl,com.DAO.model.Order,com.DAO.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FeastFleet — Order History</title>
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

    /* Content */
    .page {
      padding: 40px 0;
    }

    .page-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .page-header h1 {
      font-family: "Poppins", sans-serif;
      font-size: 32px;
      margin: 0 0 8px;
    }

    .page-header p {
      color: var(--text-weak);
      margin: 0;
    }

    .order-card {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      padding: 24px;
      margin-bottom: 20px;
      box-shadow: var(--shadow-soft);
    }

    .order-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
      padding-bottom: 16px;
      border-bottom: 1px solid rgba(255,255,255,0.08);
    }

    .order-id {
      font-family: "Poppins", sans-serif;
      font-size: 18px;
      font-weight: 600;
    }

    .order-status {
      padding: 6px 12px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
    }

    .status-confirmed { background: rgba(38,166,91,0.15); color: #a5e7c3; border: 1px solid rgba(38,166,91,0.35); }
    .status-preparing { background: rgba(255,176,32,0.15); color: #ffd699; border: 1px solid rgba(255,176,32,0.35); }
    .status-shipped { background: rgba(252,128,25,0.15); color: #ffd6c0; border: 1px solid rgba(252,128,25,0.35); }
    .status-delivered { background: rgba(38,166,91,0.15); color: #a5e7c3; border: 1px solid rgba(38,166,91,0.35); }
    .status-cancelled { background: rgba(226,55,68,0.15); color: #ffb3bb; border: 1px solid rgba(226,55,68,0.35); }

    .order-meta {
      display: flex;
      gap: 24px;
      margin-bottom: 16px;
      color: var(--text-weak);
      font-size: 14px;
    }

    .order-items {
      margin-bottom: 20px;
    }

    .order-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 0;
      border-bottom: 1px solid rgba(255,255,255,0.04);
    }

    .order-item:last-child {
      border-bottom: none;
    }

    .item-details {
      flex: 1;
    }

    .item-name {
      font-weight: 600;
      margin-bottom: 4px;
    }

    .item-meta {
      color: var(--text-weak);
      font-size: 13px;
    }

    .item-price {
      font-weight: 600;
      color: var(--brand);
    }

    .order-total {
      text-align: right;
      font-size: 18px;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 16px;
    }

    .cancel-btn {
      background: rgba(226,55,68,0.1);
      border: 1px solid rgba(226,55,68,0.3);
      color: #ffb3bb;
      padding: 8px 16px;
      border-radius: var(--radius-sm);
      cursor: pointer;
      font-size: 14px;
      transition: background var(--transition);
    }

    .cancel-btn:hover {
      background: rgba(226,55,68,0.2);
    }

    .cancel-btn:disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }

    .empty-state {
      text-align: center;
      padding: 60px 20px;
      color: var(--text-weak);
    }

    .empty-state h3 {
      font-family: "Poppins", sans-serif;
      font-size: 20px;
      margin: 0 0 12px;
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
      <nav>
        <ul>
          <li><a href="GetAllResturantsServlet">Home</a></li>
          <li><a href="#">Offers</a></li>
          <li><a href="Cart.jsp">Cart</a></li>
          <li><a href="OrderHistory.jsp" style="color: var(--text)">Order History</a></li>
                          <li><a class="cta" href="logout">Logout</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <!-- Content -->
  <main class="container page">
    <div class="page-header">
      <h1>Order History</h1>
      <p>Track your past orders and their status</p>
    </div>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    OrderDAOimpl dao = new OrderDAOimpl();
    OrderItemDAOimpl itemDao = new OrderItemDAOimpl();
    List<Order> orders = dao.getOrdersByUser(userId);
    if (orders.isEmpty()) {
%>
      <div class="empty-state">
        <h3>No orders yet</h3>
        <p>Start ordering delicious food to see your order history here</p>
        <a href="GetAllResturantsServlet" class="btn" style="display: inline-block; margin-top: 16px;">Browse Restaurants</a>
      </div>
<%
    } else {
      for (Order o : orders) {
        String statusClass = "status-" + o.getStatus().toLowerCase();
        boolean canCancel = "CONFIRMED".equalsIgnoreCase(o.getStatus()) || "PREPARING".equalsIgnoreCase(o.getStatus());
%>
        <div class="order-card">
          <div class="order-header">
            <div class="order-id">Order #<%=o.getOrderId()%></div>
            <div class="order-status <%=statusClass%>"><%=o.getStatus()%></div>
          </div>
          
          <div class="order-meta">
            <span>Date: <%=o.getOrderDate()%></span>
            <span>Payment: <%=o.getPaymentMode()%></span>
            <span>Address: <%=o.getAddress()%></span>
          </div>
          
          <div class="order-items">
<%
            for (OrderItem it : itemDao.getItemsByOrder(o.getOrderId())) {
%>
            <div class="order-item">
              <div class="item-details">
                <div class="item-name">Menu Item #<%=it.getMenuID()%></div>
                <div class="item-meta">Quantity: <%=it.getQuantity()%></div>
              </div>
              <div class="item-price">₹<%=it.getTotalPrice()%></div>
            </div>
<%
            }
%>
          </div>
          
          <div class="order-total">Total: ₹<%=o.getTotalAmount()%></div>
          
          <form action="order" method="post" style="display: inline;">
            <input type="hidden" name="action" value="cancel" />
            <input type="hidden" name="orderId" value="<%=o.getOrderId()%>" />
            <button type="submit" class="cancel-btn" <%= !canCancel ? "disabled" : "" %>>
              <%= canCancel ? "Cancel Order" : "Cannot Cancel" %>
            </button>
          </form>
        </div>
<%
      }
    }
%>
  </main>

</body>
</html>


