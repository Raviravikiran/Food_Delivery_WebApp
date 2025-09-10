CREATE DATABASE food_delivery_app;
SHOW DATABASES;
USE food_delivery_app;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    address_line_1 VARCHAR(255),
    address_line_2 VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255),
    category VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Pending', 'Processing', 'Delivered', 'Cancelled') NOT NULL DEFAULT 'Pending',
    shipping_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_item DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (username, password, email, first_name, last_name, phone_number, address_line_1, city, state, pincode, country) VALUES
('ravikiran_s', 'hashed_password_1', 'ravikiran@gmail.com', 'Ravi', 'Kiran', '9342823800', '123, Gandhi Street', 'Chennai', 'Tamil Nadu', '600001', 'India'),
('priya_s', 'hashed_password_2', 'priya.s@example.com', 'Priya', 'Sharma', '8765432109', '45, Nehru Marg', 'Mumbai', 'Maharashtra', '400001', 'India');


INSERT INTO products (product_name, description, price, image_url, category) VALUES
('Butter Chicken', 'Tender chicken pieces in a creamy tomato sauce.', 450.00, 'butter_chicken.jpg', 'Non-Veg Main Course'),
('Dal Makhani', 'Slow-cooked black lentils with butter and cream.', 300.00, 'dal_makhani.jpg', 'Veg Main Course'),
('Paneer Tikka', 'Grilled cottage cheese cubes marinated in spices.', 350.00, 'paneer_tikka.jpg', 'Starter'),
('Chicken Biryani', 'Aromatic basmati rice cooked with succulent chicken.', 400.00, 'chicken_biryani.jpg', 'Biryani'),
('Gulaab Jamun', 'Fried milk-solids balls soaked in a rose-flavored syrup.', 120.00, 'gulaab_jamun.jpg', 'Dessert');