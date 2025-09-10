<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.DAO.model.Restaurant" %> 

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FeastFleet — Order your favorite Food in minutes</title>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --brand: #fc8019;         /* Swiggy-like orange; swap with #e23744 for Zomato feel */
      --brand-alt: #e23744;     /* Zomato red */
      --bg: #0f0f10;            /* rich dark background accents */
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
    
    
    /* Header / Nav */
    header {
      position: sticky;
      top: 0px; /* below topbar */
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
    nav .cta:active { transform: translateY(0); }

    /* Hero */
    .hero {
      position: relative;
      min-height: 62vh;
      display: grid;
      place-items: center;
      background: radial-gradient(1200px 600px at 80% 20%, rgba(252,128,25,0.12), transparent 60%),
                  radial-gradient(800px 500px at 20% 80%, rgba(226,55,68,0.08), transparent 60%),
                  #0c0c0d;
      overflow: hidden;
    }
    .hero::before {
      content: "";
      position: absolute;
      inset: 0;
      background-image: url('https://images.unsplash.com/photo-1504674900240-9a9049b7d8ce?q=80&w=2070&auto=format&fit=crop');
      background-size: cover;
      background-position: center;
      opacity: 0.3;
      filter: saturate(1.2) contrast(1.1);
      transform: scale(1.04);
    }
    .hero::after {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(180deg, rgba(12,12,13,0.3) 0%, rgba(12,12,13,0.85) 60%, rgba(12,12,13,1) 100%);
    }
    
    /* Floating food icons */
    .floating-icons {
      position: absolute;
      inset: 0;
      pointer-events: none;
      overflow: hidden;
    }
    
    .floating-icon {
      position: absolute;
      font-size: 24px;
      opacity: 0.6;
      animation: float 6s ease-in-out infinite;
    }
    
    .floating-icon:nth-child(1) { top: 15%; left: 10%; animation-delay: 0s; }
    .floating-icon:nth-child(2) { top: 25%; right: 15%; animation-delay: 1s; }
    .floating-icon:nth-child(3) { top: 45%; left: 5%; animation-delay: 2s; }
    .floating-icon:nth-child(4) { top: 35%; right: 8%; animation-delay: 3s; }
    .floating-icon:nth-child(5) { top: 65%; left: 20%; animation-delay: 4s; }
    .floating-icon:nth-child(6) { top: 55%; right: 25%; animation-delay: 5s; }
    
    @keyframes float {
      0%, 100% { transform: translateY(0px) rotate(0deg); }
      50% { transform: translateY(-20px) rotate(10deg); }
    }
    .hero-inner {
      position: relative;
      z-index: 1;
      text-align: center;
      padding: 56px 0 64px;
      width: 100%;
    }
    .hero h1 {
      font-family: "Poppins", sans-serif;
      font-weight: 700;
      font-size: clamp(28px, 5vw, 44px);
      margin: 0 0 12px;
      letter-spacing: 0.3px;
    }
    .hero p.sub {
      color: var(--text-weak);
      margin: 0 auto 24px;
      max-width: 680px;
      font-size: 15px;
    }
    .search {
      display: grid;
      grid-template-columns: 1.2fr 2fr auto;
      gap: 10px;
      max-width: 820px;
      margin: 0 auto;
      background: rgba(22,22,25,0.7);
      border: 1px solid rgba(255,255,255,0.09);
      border-radius: 14px;
      padding: 10px;
      box-shadow: var(--shadow-1);
      backdrop-filter: blur(6px);
    }
    .input {
      display: flex;
      align-items: center;
      gap: 10px;
      background: #121215;
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: 10px;
      padding: 10px 12px;
      transition: border-color var(--transition), box-shadow var(--transition);
    }
    .input:focus-within { border-color: rgba(252,128,25,0.55); box-shadow: 0 0 0 4px rgba(252,128,25,0.18); }
    .input svg { width: 18px; height: 18px; color: var(--text-weak); flex-shrink: 0; }
    .input input {
      background: transparent; border: 0; outline: 0; color: var(--text);
      width: 100%; font-size: 14px;
    }
    .btn {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      white-space: nowrap;
      padding: 0 18px;
      border: 0;
      border-radius: 10px;
      color: #101010;
      font-weight: 700;
      font-family: "Poppins", sans-serif;
      background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
      box-shadow: 0 10px 20px rgba(252,128,25,0.3);
      cursor: pointer;
      transition: transform var(--transition), box-shadow var(--transition), filter var(--transition);
    }
    .btn:hover { transform: translateY(-2px); box-shadow: 0 14px 26px rgba(252,128,25,0.38); filter: saturate(1.05); }
    .btn:active { transform: translateY(0) scale(0.98); }

    /* Sections */
    section {
      padding: 44px 0;
    }
    .section-head {
      display: flex;
      align-items: baseline;
      justify-content: space-between;
      gap: 12px;
      margin-bottom: 18px;
    }
    .section-head h2 {
      font-family: "Poppins", sans-serif;
      font-size: 22px;
      margin: 0;
    }
    .section-head a.more {
      color: var(--text-weak);
      font-size: 14px;
      border: 1px solid rgba(255,255,255,0.08);
      padding: 8px 12px;
      border-radius: 10px;
      transition: background var(--transition), color var(--transition), transform var(--transition);
    }
    .section-head a.more:hover { background: rgba(255,255,255,0.06); color: var(--text); transform: translateY(-1px); }

   
    /* Featured Restaurants */
    .grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 16px;
    }
    .card {
      background: var(--card);
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow-soft);
      transition: transform var(--transition), box-shadow var(--transition), border-color var(--transition), filter var(--transition);
      cursor: pointer;
    }
    .card:hover { transform: translateY(-4px); box-shadow: var(--shadow-2); border-color: rgba(255,255,255,0.12); filter: saturate(1.03); }
    .card .media {
      position: relative; height: 160px; overflow: hidden;
    }
    .card .media img { width: 100%; height: 100%; object-fit: cover; transform: scale(1.04); transition: transform var(--transition); }
    .card:hover .media img { transform: scale(1.07); }
    .badge {
      position: absolute; top: 12px; left: 12px;
      background: linear-gradient(135deg, #1f1f22 0%, #151518 100%);
      color: #ffddc4;
      border: 1px solid rgba(252,128,25,0.5);
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 12px;
      display: inline-flex;
      gap: 8px;
      align-items: center;
      backdrop-filter: blur(6px);
    }
    .content { padding: 14px; }
    .title {
      display: flex; align-items: center; justify-content: space-between; gap: 10px;
      margin-bottom: 6px;
    }
    .title h3 {
      font-size: 16px; margin: 0; font-weight: 700; font-family: "Poppins", sans-serif;
    }
    .rating {
      display: inline-flex; align-items: center; gap: 6px;
      background: rgba(38,166,91,0.15);
      color: #a5e7c3;
      padding: 4px 8px;
      border-radius: 999px;
      font-size: 12px; font-weight: 700;
      border: 1px solid rgba(38,166,91,0.35);
    }
    .meta { color: var(--text-weak); font-size: 13px; }
    .meta span + span::before { content: "•"; margin: 0 6px; color: rgba(255,255,255,0.22); }

    
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
      .grid { grid-template-columns: repeat(3, 1fr); }
      .offers-row { grid-template-columns: repeat(2, 1fr); }
      .footer-grid { grid-template-columns: 1fr 1fr; }
    }
    @media (max-width: 768px) {
      header { top: 44px; }
      .nav { height: auto; padding: 10px 0; flex-wrap: wrap; }
      nav ul { flex-wrap: wrap; gap: 10px; }
      .hero { min-height: 58vh; }
      .search { grid-template-columns: 1fr; gap: 8px; padding: 10px; }
      .grid { grid-template-columns: repeat(2, 1fr); }
      .offers-row { grid-template-columns: 1fr; }
      .topbar-inner { height: auto; padding: 8px 0; flex-wrap: wrap; }
    }
    @media (max-width: 520px) {
      .grid { grid-template-columns: 1fr; }
      .brand .name { display: none; }
      .section-head a.more { display: none; }
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="container nav">
      <div class="brand">
        <div class="logo" aria-hidden="true">🍽</div>
        <div class="name">FeastFleet </div>
      </div>
      <nav>
        <ul>
          <li><a href="GetAllResturantsServlet">Home</a></li>
          <li><a href="#">Offers</a></li>
          <li><a href="Cart.jsp">Cart</a></li>
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

  <!-- Hero -->
  <section class="hero">
    <div class="floating-icons">
      <div class="floating-icon">🍕</div>
      <div class="floating-icon">🍔</div>
      <div class="floating-icon">🍜</div>
      <div class="floating-icon">🍣</div>
      <div class="floating-icon">🍰</div>
      <div class="floating-icon">🥘</div>
    </div>
    <div class="container hero-inner">
      <h1>Order your favorite Food 📈 in minutes</h1>
      <p class="sub">Discover top restaurants near you and get piping-hot meals delivered fast. Track orders live and enjoy exclusive deals every day.</p>

      <form class="search" action="search" method="get">
        <label class="input" aria-label="Enter your delivery location">
          <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 2a7 7 0 0 0-7 7c0 5.25 7 13 7 13s7-7.75 7-13a7 7 0 0 0-7-7Zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5Z"/></svg>
          <input type="text" name="location" placeholder="Enter your location (e.g., Indiranagar, Bangalore)" value="<%= request.getAttribute("searchLocation") != null ? request.getAttribute("searchLocation") : "" %>" />
        </label>
        <label class="input" aria-label="Search restaurants or dishes">
          <svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="m21.707 20.293-4.825-4.825A7.953 7.953 0 0 0 20 12a8 8 0 1 0-8 8 7.953 7.953 0 0 0 3.468-.882l4.825 4.825a1 1 0 0 0 1.414-1.414ZM6 12a6 6 0 1 1 6 6 6.006 6.006 0 0 1-6-6Z"/></svg>
          <input type="text" name="query" placeholder="Search for restaurants or food (e.g., Pizza, Biryani)" value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>" />
        </label>
        <button class="btn" type="submit">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="#101010" aria-hidden="true"><path d="M19 11H13V5h-2v6H5v2h6v6h2v-6h6z"/></svg>
          Search
        </button>
      </form>
    </div>
  </section>

  
  <!-- Featured Restaurants -->
  <section>
    <div class="container">
      <div class="section-head">
        <h2>
        <!-- Search querch -->
          <% if (request.getAttribute("searchQuery") != null || request.getAttribute("searchLocation") != null) { %>
            Search Results
            <% if (request.getAttribute("searchQuery") != null && !((String)request.getAttribute("searchQuery")).isEmpty()) { %>
              for "<%= request.getAttribute("searchQuery") %>"
            <% } %>
            <% if (request.getAttribute("searchLocation") != null && !((String)request.getAttribute("searchLocation")).isEmpty()) { %>
              in "<%= request.getAttribute("searchLocation") %>"
            <% } %>
          <% } else { %>
            Restaurants
          <% } %>
        </h2>
        
        
        <a class="more" href="GetAllResturantsServlet">See all</a>
      </div>
      <div class="grid">
      <%	List<Restaurant> res = (List<Restaurant>)request.getAttribute("AllRestaurants");
    for(Restaurant re : res)
    {
    %>  
        <!-- Card 1 -->
        <!-- we transfer the home to menu using restaurantID -->
        <a href="menus?restaurantId=<%= re.getRestaurantId()%>">
        <article class="card">
          <div class="media">
            <img src="<%=re.getImagePath() %>"alt="La Pizzeria" />
            <div class="badge">40% OFF • Use WELCOME40</div>
          </div>
          <div class="content">
            <div class="title">
              <h3><%=re.getName()%></h3>
              <div class="rating">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="m12 17.27 6.18 3.73-1.64-7.03L21.9 9.5l-7.19-.61L12 2 9.29 8.89 2.1 9.5l5.36 4.47-1.64 7.03L12 17.27z"/></svg>
                <%= re.getRating() %>
              </div>
            </div>
            <div class="meta">
              <span><%=re.getCusineType() %></span>
              <span><%= re.getEta() %> min</span>
              <span><%= re.getAddress() %></span>
             
            </div>
          </div>
        </article>
        </a>
       <%}
    %>
      </div>
    </div>
  </section>

  
  <footer>
    <div class="container footer">
      <div class="footer-grid">
        <div>
          <div class="brand">
            <div class="logo" aria-hidden="true">🍽️</div>
            <div class="name">FeastFleet</div>
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

</body>
</html>