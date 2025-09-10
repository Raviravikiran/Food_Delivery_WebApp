## 🚀 Food Delivery Web Application  
A full-stack web application built using **HTML, CSS, JS, JSP, Servlets, JDBC, and MySQL**.  

🔗 [View Repository](https://github.com/AbivarnaMasanam/FoodDeliveryApplication)  


1. Introduction
   
   Foodly is an online food delivery web application that allows users to browse restaurants, explore menus, place food orders, and get them delivered conveniently.
The application provides a smooth and user-friendly interface for customers to order their favorite meals online in just a few clicks.
The system integrates frontend technologies (HTML, CSS, JavaScript) with backend technologies (Java Servlets, JSP, JDBC) and a MySQL database to store user, restaurant, and order details.
________________________________________
2. Objectives

   •To develop a responsive and user-friendly food delivery platform.
   
   •To provide restaurant listings with menu details.
   
   •To enable users to add items to the cart and place orders.
   
   •To manage order history and delivery details efficiently.
   
   •To ensure secure login and order processing.
________________________________________
3. Technologies Used
   
Frontend:

•HTML5 – Structure of web pages.

•CSS3 – Styling and responsiveness.

•JavaScript – Client-side interactivity.

Backend:

•Java Servlet & JSP – Server-side logic & dynamic page rendering.

•JDBC (Java Database Connectivity) – Database interaction.

Database:

•MySQL – Storage of user data, restaurant details, menu items, orders, and transaction details.

Tools & Server:

•Apache Tomcat – Web server for running servlets and JSP.

•Eclipse – IDE for development.
________________________________________

4. System Architecture
   
    The system follows a 3-tier architecture:

   1.Presentation Layer (Frontend) – HTML, CSS, JS (User interface).
   
   2.Application Layer (Backend) – Java Servlets, JSP (Business logic).
   
   3.Database Layer – MySQL (Data storage).
   
Flow:
User → Web Browser (UI) → Servlet/JSP → JDBC → MySQL Database
________________________________________
5. Modules of the Application

        1. User Module
   
                •User Registration & Login (Authentication).
                •Profile Management.
   
        2. Restaurant Module
   
                •View restaurant listings.
                •View restaurant details & menu.
   
        3. Search & Filter Module
   
                •Search by location, restaurant, or food item.
                •Filter by Veg / Non-Veg / Bestseller.
   
        4. Cart Module
   
                •Add/remove menu items.
                •View cart summary (items, quantity, price).
   
        5. Order Module
    
                •Place order with delivery details.
                •Select payment method (Cash on Delivery / Online).
                •Order tracking & confirmation.
   
        6. Admin Module
    
                •Manage restaurants, menu, and offers.
                •Track orders and users.
________________________________________
6. Database Design
   
Main Tables (Example sample):

                1.Users – (user_id, name, email, password, phone, address)
                2.Restaurants – (restaurant_id, name, location, rating, offers)
                3.Menu – (menu_id, restaurant_id, item_name, price, category, veg/non-veg)
                4.Cart – (cart_id, user_id, menu_id, quantity)
                5.Orders – (order_id, user_id, restaurant_id, total_price, status, order_time)
                6.Order_Items – (order_item_id, order_id, menu_id, quantity, price)
________________________________________
7. Workflow
   
        🔹 Homepage
                •Search restaurants and food items.
                •View offers and popular restaurants.
        
        🔹 Restaurant Listings
                •Display of restaurants with ratings, cuisine, and delivery time.
        
        🔹 Menu Page
                •Display of restaurant menu with categories.
                •Option to add items to cart.
        🔹 Cart Page
                •View selected items.
                •Update quantity or remove items.
                •Order summary with subtotal, taxes, and delivery fee.
        🔹 Checkout Page
                •Enter delivery details.
                •Choose payment method.
                •Place final order.
        🔹 Order Confirmation
                •Order ID & confirmation message.
                •Estimated delivery time.
________________________________________
8. Key Features
   
   •User authentication (Login/Signup).
   
   •Restaurant and menu browsing.
   
   •Dynamic cart and checkout system.
   
   •Real-time order summary.
   
   •Discount and offer integration.
   
   •Secure and scalable architecture.
________________________________________
9. Future Enhancements
    
   •Live order tracking with delivery partner module.
   
   •AI-based food recommendations.

   •Admin dashboard for analytics.
   
   •Push notifications for order status.
________________________________________
10. Conclusion
    
     The Foodly Food Delivery Web Application provides an efficient way for users to order food online from multiple restaurants. Using Java Servlets, JSP, and MySQL, the application ensures smooth order management and data handling. With a responsive UI built with HTML, CSS, and JavaScript, it enhances the user experience and brings convenience to customers.

