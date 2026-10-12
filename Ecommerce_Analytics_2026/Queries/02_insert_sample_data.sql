-- Table 1: Customers
INSERT INTO customers VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', 'Mumbai', 'Male', '2026-01-05'),
(2, 'Priya Patil', 'priya@gmail.com', 'Pune', 'Female', '2026-01-10'),
(3, 'Rahul Verma', 'rahul@gmail.com', 'Delhi', 'Male', '2026-01-15'),
(4, 'Sneha Joshi', 'sneha@gmail.com', 'Mumbai', 'Female', '2026-02-01'),
(5, 'Vikram Singh', 'vikram@gmail.com', 'Bengaluru', 'Male', '2026-02-10'),
(6, 'Ananya Desai', 'ananya@gmail.com', 'Pune', 'Female', '2026-02-15'),
(7, 'Rohan Gupta', 'rohan@gmail.com', 'Delhi', 'Male', '2026-03-01'),
(8, 'Neha Kulkarni', 'neha@gmail.com', 'Nashik', 'Female', '2026-03-10'),
(9, 'Karan Mehta', 'karan@gmail.com', 'Mumbai', 'Male', '2026-03-15'),
(10, 'Isha Shah', 'isha@gmail.com', 'Surat', 'Female', '2026-04-01');

-- Table 2: Products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000, 15),
(102, 'Smartphone', 'Electronics', 25000, 25),
(103, 'Headphones', 'Accessories', 2000, 50),
(104, 'Keyboard', 'Accessories', 1500, 40),
(105, 'Office Chair', 'Furniture', 8000, 12),
(106, 'Desk', 'Furniture', 12000, 8),
(107, 'Smart Watch', 'Electronics', 5000, 30),
(108, 'Backpack', 'Accessories', 1800, 35),
(109, 'Monitor', 'Electronics', 15000, 10),
(110, 'Mouse', 'Accessories', 800, 60);

-- Table 3: Orders
INSERT INTO orders VALUES
(1001, 1, '2026-01-12', 'Delivered', '2026-01-15'),
(1002, 2, '2026-01-18', 'Delivered', '2026-01-20'),
(1003, 3, '2026-02-02', 'Delivered', '2026-02-08'),
(1004, 1, '2026-02-14', 'Delivered', '2026-02-17'),
(1005, 4, '2026-02-20', 'Cancelled', NULL),
(1006, 5, '2026-03-05', 'Delivered', '2026-03-09'),
(1007, 6, '2026-03-10', 'Delivered', '2026-03-12'),
(1008, 2, '2026-03-15', 'Returned', '2026-03-18'),
(1009, 7, '2026-04-01', 'Delivered', '2026-04-04'),
(1010, 8, '2026-04-05', 'Shipped', NULL),
(1011, 9, '2026-04-10', 'Delivered', '2026-04-13'),
(1012, 10, '2026-04-12', 'Processing', NULL),
(1013, 3, '2026-05-02', 'Delivered', '2026-05-06'),
(1014, 5, '2026-05-10', 'Cancelled', NULL),
(1015, 1, '2026-05-15', 'Delivered', '2026-05-18');

-- Table 4: Order items
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 60000),
(2, 1001, 103, 2, 2000),
(3, 1002, 102, 1, 25000),
(4, 1002, 110, 2, 800),
(5, 1003, 105, 1, 8000),
(6, 1003, 104, 2, 1500),
(7, 1004, 107, 2, 5000),
(8, 1004, 108, 1, 1800),
(9, 1005, 106, 1, 12000),
(10, 1006, 109, 2, 15000),
(11, 1006, 110, 1, 800),
(12, 1007, 103, 3, 2000),
(13, 1007, 104, 1, 1500),
(14, 1008, 102, 1, 25000),
(15, 1009, 101, 1, 60000),
(16, 1009, 107, 1, 5000),
(17, 1010, 108, 2, 1800),
(18, 1011, 106, 1, 12000),
(19, 1011, 104, 2, 1500),
(20, 1012, 110, 3, 800),
(21, 1013, 102, 2, 25000),
(22, 1013, 103, 1, 2000),
(23, 1014, 105, 1, 8000),
(24, 1015, 109, 1, 15000),
(25, 1015, 110, 2, 800);

-- Table 5: Payments
INSERT INTO payments VALUES
(1, 1001, '2026-01-12', 64000, 'UPI', 'Paid'),
(2, 1002, '2026-01-18', 26600, 'Card', 'Paid'),
(3, 1003, '2026-02-02', 11000, 'UPI', 'Paid'),
(4, 1004, '2026-02-14', 11800, 'Card', 'Paid'),
(5, 1005, '2026-02-20', 12000, 'UPI', 'Refunded'),
(6, 1006, '2026-03-05', 30800, 'Net Banking', 'Paid'),
(7, 1007, '2026-03-10', 7500, 'UPI', 'Paid'),
(8, 1008, '2026-03-15', 25000, 'Card', 'Refunded'),
(9, 1009, '2026-04-01', 65000, 'Card', 'Paid'),
(10, 1010, '2026-04-05', 3600, 'UPI', 'Pending'),
(11, 1011, '2026-04-10', 15000, 'Net Banking', 'Paid'),
(12, 1012, '2026-04-12', 2400, 'UPI', 'Pending'),
(13, 1013, '2026-05-02', 52000, 'Card', 'Paid'),
(14, 1014, '2026-05-10', 8000, 'UPI', 'Refunded'),
(15, 1015, '2026-05-15', 16600, 'UPI', 'Paid');
