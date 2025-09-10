<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
    import="java.util.List,com.DAO.model.Menu,com.DAO.model.Restaurant,com.DAO.model.Cart,com.DAO.model.CartItem"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>FeastFleet — Restaurant Menu</title>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Poppins:wght@500;600;700&display=swap"
	rel="stylesheet">
	<%
    Restaurant restaurant = (Restaurant) request.getAttribute("restDetalis");
    List<Menu> menus = (List<Menu>) request.getAttribute("menus");
%>
<style>
:root {
	--brand: #fc8019; /* Swap with #e23744 for Zomato-style */
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
	--shadow-1: 0 6px 18px rgba(0, 0, 0, 0.22);
	--shadow-2: 0 12px 28px rgba(0, 0, 0, 0.26);
	--shadow-soft: 0 2px 8px rgba(0, 0, 0, 0.18);
	--container: 1200px;
	--transition: 220ms cubic-bezier(.2, .7, .2, 1);
}

* {
	box-sizing: border-box;
}

html, body {
	margin: 0;
	padding: 0;
	background: #0c0c0d;
	color: var(--text);
	font-family: "Open Sans", system-ui, -apple-system, Segoe UI, Roboto,
		Ubuntu, Cantarell, "Helvetica Neue", Arial, "Noto Sans",
		"Apple Color Emoji", "Segoe UI Emoji";
	line-height: 1.5;
}

a {
	color: inherit;
	text-decoration: none;
}

img {
	display: block;
	max-width: 100%;
	height: auto;
}

.container {
	width: 100%;
	max-width: var(--container);
	margin: 0 auto;
	padding: 0 20px;
}

/* Header */
header {
	position: sticky;
	top:0px;
	z-index: 50;
	background: rgba(14, 14, 16, 0.88);
	backdrop-filter: blur(10px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.06);
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
}

.brand .logo {
	width: 36px;
	height: 36px;
	border-radius: 10px;
	background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
	box-shadow: 0 8px 18px rgba(252, 128, 25, 0.35);
	display: grid;
	place-items: center;
	color: #fff;
}

.brand .name {
	font-size: 18px;
}

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
	transition: color var(--transition), background var(--transition),
		transform var(--transition);
}

nav a:hover {
	color: var(--text);
	background: rgba(255, 255, 255, 0.06);
	transform: translateY(-1px);
}

nav .cta {
	background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
	color: #101010;
	border-radius: 12px;
	padding: 10px 14px;
	box-shadow: 0 10px 20px rgba(252, 128, 25, 0.3);
	font-weight: 800;
}

/* Restaurant hero */
.rest-hero {
	position: relative;
	min-height: 260px;
	background: #0c0c0d;
	overflow: hidden;
	border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}

.rest-hero::before {
	content: "";
	position: absolute;
	inset: 0; /* shorthand for top:0; right:0; bottom:0; left:0 */
	background-size: cover;
	background-position: center;
	opacity: 0.22;
	filter: saturate(1.1) contrast(1.05);
	transform: scale(1.04);
}


.rest-hero::after {
	content: "";
	position: absolute;
	inset: 0;
	background: linear-gradient(180deg, rgba(12, 12, 13, 0.2) 0%,
		rgba(12, 12, 13, 0.75) 70%, rgba(12, 12, 13, 1) 100%);
}

.rest-hero-inner {
	position: relative;
	z-index: 1;
	padding: 30px 0 18px;
}

.rest-card {
	display: grid;
	grid-template-columns: 100px 1fr;
	gap: 16px;
	align-items: center;
	background: rgba(22, 22, 25, 0.7);
	border: 1px solid rgba(255, 255, 255, 0.09);
	border-radius: var(--radius);
	padding: 14px;
	backdrop-filter: blur(6px);
	box-shadow: var(--shadow-1);
}

.rest-thumb {
	width: 100px;
	height: 100px;
	border-radius: 12px;
	overflow: hidden;
}

.rest-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.rest-meta h1 {
	margin: 0 0 6px;
	font-family: "Poppins";
	font-size: 22px;
}

.rest-meta .row {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
	color: var(--text-weak);
	font-size: 14px;
}

.chip {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 6px 10px;
	border-radius: 999px;
	background: rgba(255, 255, 255, 0.06);
	border: 1px solid rgba(255, 255, 255, 0.08);
	font-size: 12px;
	color: var(--text);
}

.chip.brand {
	background: rgba(252, 128, 25, 0.15);
	border-color: rgba(252, 128, 25, 0.4);
	color: #ffd6c0;
}

.rest-actions {
	margin-top: 12px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.search-inline {
	display: flex;
	align-items: center;
	gap: 10px;
	background: #121215;
	border: 1px solid rgba(255, 255, 255, 0.07);
	border-radius: 10px;
	padding: 10px 12px;
	min-width: 260px;
	transition: border-color var(--transition), box-shadow var(--transition);
}

.search-inline input {
	background: transparent;
	border: 0;
	outline: 0;
	color: var(--text);
	width: 100%;
	font-size: 14px;
}

.search-inline:focus-within {
	border-color: rgba(252, 128, 25, 0.55);
	box-shadow: 0 0 0 4px rgba(252, 128, 25, 0.18);
}

/* Layout */
.page {
	padding: 24px 0 90px;
}

.content {
	display: grid;
	grid-template-columns: 260px 1fr;
	gap: 20px;
}

/* Categories sidebar */
.sidebar {
	position: sticky;
	top: 140px;
	align-self: start;
}

.side-card {
	background: var(--card);
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: var(--radius);
	padding: 12px;
	box-shadow: var(--shadow-soft);
}

.side-title {
	margin: 0 0 8px;
	font-family: "Poppins";
	font-size: 14px;
	color: #d9dade;
}

.cat-list {
	list-style: none;
	margin: 0;
	padding: 0;
	display: grid;
	gap: 4px;
}

.cat-list a {
	display: block;
	padding: 8px 10px;
	border-radius: 10px;
	color: var(--text-weak);
	font-size: 14px;
}

.cat-list a:hover, .cat-list a.active {
	color: var(--text);
	background: rgba(255, 255, 255, 0.06);
}

/* Filters */
.filters {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 12px;
}

.filter {
	cursor: pointer;
	transition: transform var(--transition), background var(--transition),
		border-color var(--transition);
}

.filter:hover {
	transform: translateY(-1px);
}

.filter.active {
	background: rgba(252, 128, 25, 0.15);
	border-color: rgba(252, 128, 25, 0.4);
	color: #ffd6c0;
}

/* Menu sections */
.menu-section {
	margin-bottom: 28px;
}

.menu-title {
	margin: 0 0 10px;
	font-family: "Poppins";
	font-size: 18px;
}

.menu-grid {
	display: grid;
	grid-template-columns: 1fr;
	gap: 12px;
}

.item {
	display: grid;
	grid-template-columns: 1fr 120px;
	gap: 14px;
	background: var(--card);
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: var(--radius);
	overflow: hidden;
	box-shadow: var(--shadow-soft);
	transition: transform var(--transition), box-shadow var(--transition),
		border-color var(--transition), filter var(--transition);
}

.item:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-2);
	border-color: rgba(255, 255, 255, 0.12);
	filter: saturate(1.02);
}

.item-body {
	padding: 14px;
}

.item-top {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-bottom: 6px;
}

.tag {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 4px 8px;
	font-size: 11px;
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 999px;
	color: var(--text-weak);
}

.tag.veg {
	border-color: rgba(38, 166, 91, 0.35);
	background: rgba(38, 166, 91, 0.12);
	color: #a5e7c3;
}

.tag.nonveg {
	border-color: rgba(226, 55, 68, 0.45);
	background: rgba(226, 55, 68, 0.12);
	color: #ffb3bb;
}

.item h3 {
	margin: 0;
	font-size: 16px;
	font-family: "Poppins";
}

.desc {
	margin: 6px 0 10px;
	color: var(--text-weak);
	font-size: 13px;
}

.price {
	font-weight: 700;
}

.actions {
	margin-top: 10px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	padding: 8px 12px;
	border-radius: 10px;
	border: 0;
	cursor: pointer;
	background: linear-gradient(135deg, var(--brand) 0%, #ff9d4b 100%);
	color: #101010;
	font-family: "Poppins";
	font-weight: 700;
	box-shadow: 0 10px 20px rgba(252, 128, 25, 0.3);
	transition: transform var(--transition), box-shadow var(--transition),
		filter var(--transition);
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 14px 26px rgba(252, 128, 25, 0.38);
	filter: saturate(1.05);
}

.btn:active {
	transform: translateY(0) scale(0.98);
}

.qty {
	display: inline-flex;
	align-items: center;
	gap: 10px;
	background: rgba(255, 255, 255, 0.06);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 999px;
	padding: 6px;
}

.qty button {
	width: 30px;
	height: 30px;
	border: 0;
	border-radius: 999px;
	background: rgba(255, 255, 255, 0.08);
	color: var(--text);
	cursor: pointer;
}

.qty span {
	min-width: 18px;
	text-align: center;
	font-weight: 700;
}

.item-media {
	position: relative;
	height: 120px;
	overflow: hidden;
}

.item-media img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transform: scale(1.05);
	transition: transform var(--transition);
}

.item:hover .item-media img {
	transform: scale(1.08);
}

/* Bottom cart bar */
.cartbar {
	position: fixed;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 70;
	background: rgba(18, 18, 20, 0.9);
	backdrop-filter: blur(10px);
	border-top: 1px solid rgba(255, 255, 255, 0.06);
}

.cartbar-inner {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
	padding: 12px 0;
}

.cart-info {
	color: var(--text-weak);
	font-size: 14px;
}

/* Offers row */
.offers-row {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 12px;
	margin-top: 14px;
}

.offer {
	position: relative;
	height: 120px;
	border-radius: var(--radius);
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, 0.06);
	background: linear-gradient(135deg, #1a1a1d 0%, #121214 100%);
	box-shadow: var(--shadow-soft);
}

.offer .bg {
	position: absolute;
	inset: 0;
	opacity: 0.22;
	filter: saturate(1.2) contrast(1.05);
	background-size: cover;
	background-position: center;
}

.offer .inner {
	position: relative;
	z-index: 1;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	padding: 14px;
}

.offer .kicker {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-size: 11px;
	color: #ffd6c0;
	background: rgba(252, 128, 25, 0.15);
	border: 1px solid rgba(252, 128, 25, 0.4);
	padding: 4px 8px;
	border-radius: 999px;
	width: fit-content;
	margin-bottom: 6px;
}

.offer h4 {
	margin: 0 0 4px;
	font-family: "Poppins";
	font-size: 16px;
}

.offer p {
	margin: 0;
	color: var(--text-weak);
	font-size: 12px;
}

/* Footer */
footer {
	margin-top: 44px;
	background: #0b0b0c;
	border-top: 1px solid rgba(255, 255, 255, 0.06);
	padding: 34px 0;
}

.footer-grid {
	display: grid;
	grid-template-columns: 1.2fr 1fr 1fr 1fr;
	gap: 16px;
}

.footer h4 {
	margin: 0 0 10px;
	font-size: 14px;
	color: #d9dade;
	letter-spacing: 0.2px;
}

.footer ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: grid;
	gap: 8px;
}

.footer a {
	color: var(--text-weak);
	font-size: 14px;
}

.footer a:hover {
	color: var(--text);
}

/* Responsive */
@media ( max-width : 1024px) {
	.content {
		grid-template-columns: 220px 1fr;
	}
	.offers-row {
		grid-template-columns: repeat(2, 1fr);
	}
	.footer-grid {
		grid-template-columns: 1fr 1fr;
	}
}

@media ( max-width : 768px) {
	.rest-card {
		grid-template-columns: 1fr;
	}
	.content {
		grid-template-columns: 1fr;
	}
	.sidebar {
		position: static;
	}
	.offers-row {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 520px) {
	.brand .name {
		display: none;
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
			      <nav>
        <ul>
          <li><a href="GetAllResturantsServlet">Home</a></li>
          <li><a href="#" style="color: var(--text)">Restaurants</a></li>
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

	<!-- Restaurant Hero -->
	<!-- Restaurant detalis below  -->
	<section class="rest-hero">
		<div class="container rest-hero-inner">
			<div class="rest-card">
			
				<div class="rest-thumb">

					<img src="<%=restaurant.getImagePath() %>" alt="<%= restaurant.getName()%>" />
				</div>
				<div class="rest-meta">
					<h1>"<%= restaurant.getName()%>"</h1>
					<div class="row">
						<span class="chip" title="Rating">⭐ <%=restaurant.getRating() %></span>
						<span class="chip" title="Delivery time">⏱️<%=restaurant.getEta() %>mins</span>
						</span> <span class="chip brand" title="Offer">40% OFF • Use
							WELCOME40</span>
					</div>
					<div class="row" style="margin-top: 8px"><%=restaurant.getCusineType() %></div>
					<div class="rest-actions">
						<div class="search-inline" aria-label="Search in menu">
							<svg width="18" height="18" viewBox="0 0 24 24"
								fill="currentColor" aria-hidden="true">
								<path
									d="m21.707 20.293-4.825-4.825A7.953 7.953 0 0 0 20 12a8 8 0 1 0-8 8 7.953 7.953 0 0 0 3.468-.882l4.825 4.825a1 1 0 0 0 1.414-1.414ZM6 12a6 6 0 1 1 6 6 6.006 6.006 0 0 1-6-6Z" /></svg>
							<input type="search"
								placeholder="Search in menu (e.g., Margherita, Garlic Bread)" />
						</div>
						<span class="chip filter active">All</span> <span
							class="chip filter">Veg</span> <span class="chip filter">Non-Veg</span>
						<span class="chip filter">Bestsellers</span>
					</div>
				</div>
			</div>

			<!-- Restaurant offers -->
			<div class="offers-row">
				<article class="offer">
					<div class="bg"
						style="background-image: url('ass/banner.png');"></div>
					<div class="inner">
						<span class="kicker">Bank Offer</span>
						<h4>Flat 20% OFF up to ₹100</h4>
						<p>Use cards from select banks</p>
					</div>
				</article>
				<article class="offer">
					<div class="bg"
     				style="background-image: url('ass/buybanner.png');"></div>

					<div class="inner">
						<span class="kicker">Combo Deal</span>
						<h4>Buy 1 Get 1 on Pizzas</h4>
						<p>Valid on medium and large</p>
					</div>
				</article>
				<article class="offer">
					<div class="bg"
						style="background-image: url('https://images.unsplash.com/photo-1540713434306-58505cf1b6fc?q=80&amp;w=1887&amp;auto=format&amp;fit=crop');"></div>
					<div class="inner">
						<span class="kicker">Wallet</span>
						<h4>Extra 10% via Foodly Wallet</h4>
						<p>Min order ₹249</p>
					</div>
				</article>
			</div>
		</div>
	</section>

	<!-- Page Content -->
	<main class="page">
		<div class="container content">
			<!-- Sidebar categories -->
			<aside class="sidebar">
				<div class="side-card">
					<h3 class="side-title">Menu Categories</h3>
					<ul class="cat-list">
						<li><a class="active" href="#bestsellers">Bestsellers</a></li>
						<li><a href="#pizzas">Pizzas</a></li>
						<li><a href="#garlic-breads">Garlic Breads</a></li>
						<li><a href="#pastas">Pastas</a></li>
						<li><a href="#desserts">Desserts</a></li>
						<li><a href="#beverages">Beverages</a></li>
					</ul>
				</div>
			</aside>

			<!-- Menu list -->
			<section>
				<!-- Bestsellers -->
				<div class="menu-section" id="bestsellers">
					<h2 class="menu-title">Menu</h2>
					<div class="menu-grid">
					<% 
       						for (Menu menu : menus) { %>
						<article class="item">
							<div class="item-body">
								<div class="item-top">
					<span class="tag veg">Veg</span>
                  <span class="tag">Bestseller</span>
								</div>
								<h3><%= menu.getItemName() %></h3>
								<p class="desc"><%= menu.getDescription() %></p>
                                <div class="price">₹<%= menu.getPrice() %></div>
								<div class="actions">
								
                                <form action="callfromMenu" method="post" style="margin:0; padding:0; display:inline;">
                                <input type="hidden" name="itemID" value="<%=menu.getMenuID() %>">
								<input type="hidden" name="quantity" value ="1">
								<input type="hidden" name="restaurantId" value="<%=menu.getRestaurantID() %>">
								<input type="hidden" name="imgscr" value="<%=menu.getImagepath() %>">
								<input type="hidden" name="action" value="add"><br> 
                                <input type="hidden" name="from" value="menu">
								<button class="btn" type="submit">Add</button>			
								</form>	
								</div>
							</div>
							<div class="item-media">
								<img src="<%= menu.getImagepath() %>" alt="<%=menu.getItemName() %>" />
							</div>
							</article>
							<%   }
    %>
					</div>
				</div>
			</section>
		</div>
	</main>

	<!-- Cart Bar -->
    <% 
        Cart sessionCart = (Cart) session.getAttribute("cart");
        int cartItemsCount = 0;
        int cartSubtotal = 0;
        if (sessionCart != null && sessionCart.getItems() != null) {
            for (CartItem it : sessionCart.getItems().values()) {
                cartItemsCount += it.getQuantity();
                cartSubtotal += it.getQuantity() * it.getPrice();
            }
        }
        if (cartItemsCount > 0) {
    %>
    <div class="cartbar">
        <div class="container cartbar-inner">
            <div class="cart-info"><%= cartItemsCount %> items • ₹<%= cartSubtotal %></div>
            <a class="btn" href="Cart.jsp">View Cart</a>
        </div>
    </div>
    <% } %>

	<!-- Footer -->
	<footer>
		<div class="container footer">
			<div class="footer-grid">
				<div>
					<div class="brand">
						<div class="logo" aria-hidden="true">🍽️</div>
						<div class="name">Foodly</div>
					</div>
					<p
						style="color: var(--text-weak); font-size: 14px; margin-top: 10px; max-width: 420px;">
						Bringing your favorite meals to your door — fast, fresh, and with
						the best deals in town.</p>
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