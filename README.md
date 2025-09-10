# Food_Delivery_WebApp
"Online Food Delivery Web Application"

Overview
This is a full-stack web application for an online food delivery service, developed as a capstone project for the 6-month Full Stack Development course at Tap Academy. The application simulates an e-commerce platform where users can browse food items, place orders, and manage their account.

Key Features
User Management: Secure user registration, login, and profile management.

Product Catalog: Browse a list of available food items with details and images.

Shopping Cart: Add, remove, and manage food items in a session-based shopping cart.

Order Processing: A complete end-to-end ordering system from checkout to order confirmation.

Order History: Users can view a complete history of their past orders.

Technology Stack
The project is built using a classic Java-based web stack:

Frontend: HTML, CSS, JSP (JavaServer Pages)

Backend: Java, Servlets (for handling business logic and routing)

Database: MySQL (for data persistence)

Data Access: JDBC (Java Database Connectivity)

Project Architecture
The application follows a layered, MVC-like (Model-View-Controller) architectural pattern to ensure a clean separation of concerns:

Database Layer: Four core tables (users, products, orders, and order_items) were designed and populated with relevant data (specifically for India) to serve as the foundation.

Model Layer: Java POJO (Plain Old Java Object) classes were created to represent the data from each table.

DAO Layer: A Data Access Object (DAO) pattern was implemented with interfaces and concrete classes to manage all database interactions, keeping JDBC code isolated.

Controller & View Layer: Servlets act as controllers, handling user requests and orchestrating business logic, while JSPs serve as the views to render dynamic content.

This description highlights the key aspects of your project, the technologies you mastered, and the sound architectural principles you applied, making it an excellent reference for your portfolio.
