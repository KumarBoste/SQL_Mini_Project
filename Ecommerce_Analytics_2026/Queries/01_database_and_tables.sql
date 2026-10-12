-- PROJECT: E-Commerce Analytics 2026

CREATE DATABASE ecommerce_analytics_2026;

USE ecommerce_analytics_2026;

-- Verify selected database
SELECT DATABASE();

-- Creating Tables :
-- Table 1 : Customers
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    City VARCHAR(50),
    Gender VARCHAR(20),
    SignupDate DATE
);

-- Table 2 : Products
CREATE TABLE products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    CHECK (Price >= 0),
    CHECK (Stock >= 0)
);

-- Table 3 : Orders
CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(30),
    DeliveryDate DATE,
    FOREIGN KEY (CustomerID)
        REFERENCES customers(CustomerID)
);

-- Table 4 : Order_Items
CREATE TABLE order_items (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID)
        REFERENCES orders(OrderID),
    FOREIGN KEY (ProductID)
        REFERENCES products(ProductID),
    CHECK (Quantity > 0),
    CHECK (UnitPrice >= 0)
);

-- Table 5 : Payments
CREATE TABLE payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentDate DATE,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30),
    PaymentStatus VARCHAR(30),
    FOREIGN KEY (OrderID)
        REFERENCES orders(OrderID),
    CHECK (Amount >= 0)
);
