create database online_store;
use online_store;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    registration_date DATE
);
INSERT INTO customers VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', '2022-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', '2022-02-20'),
(3, 'Robert', 'Johnson', 'robert.j@email.com', '555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601', '2022-03-10'),
(4, 'Emily', 'Williams', 'emily.w@email.com', '555-0104', '321 Elm St', 'Houston', 'TX', '77001', '2022-04-05'),
(5, 'Michael', 'Brown', 'michael.b@email.com', '555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001', '2022-05-12');
select *from customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    stock_quantity INT,
    supplier_id INT,
    created_at DATE
);
INSERT INTO products VALUES
(101, 'Wireless Headphones', 'Electronics', 99.99, 'Noise-cancelling wireless headphones with 30hr battery', 50, 1, '2022-01-01'),
(102, 'Smart Watch', 'Electronics', 199.99, 'Fitness tracker with heart rate monitor', 30, 1, '2022-01-10'),
(103, 'Cotton T-Shirt', 'Clothing', 19.99, '100% cotton crew neck t-shirt', 100, 2, '2022-02-01'),
(104, 'Running Shoes', 'Footwear', 89.99, 'Lightweight running shoes with cushioned soles', 40, 3, '2022-02-15'),
(105, 'Coffee Maker', 'Home', 49.99, '12-cup programmable coffee maker', 25, 4, '2022-03-01'),
(106, 'Backpack', 'Accessories', 39.99, 'Water-resistant backpack with laptop compartment', 60, 5, '2022-03-10'),
(107, 'Bluetooth Speaker', 'Electronics', 79.99, 'Portable speaker with 20hr playtime', 35, 1, '2022-04-01'),
(108, 'Yoga Mat', 'Fitness', 29.99, 'Non-slip yoga mat with carrying strap', 45, 6, '2022-04-15');
select*from products;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    payment_method VARCHAR(50),
    shipping_address VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders VALUES
(1001, 1, '2022-06-01', 199.98, 'Delivered', 'Credit Card', '123 Main St, New York, NY 10001'),
(1002, 2, '2022-06-05', 89.99, 'Shipped', 'PayPal', '456 Oak Ave, Los Angeles, CA 90001'),
(1003, 3, '2022-06-10', 229.97, 'Processing', 'Credit Card', '789 Pine Rd, Chicago, IL 60601'),
(1004, 1, '2022-06-15', 59.98, 'Delivered', 'Debit Card', '123 Main St, New York, NY 10001'),
(1005, 4, '2022-06-20', 129.98, 'Shipped', 'PayPal', '321 Elm St, Houston, TX 77001');

select * from orders;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_items VALUES
(1, 1001, 101, 2, 99.99, 199.98),
(2, 1002, 104, 1, 89.99, 89.99),
(3, 1003, 102, 1, 199.99, 199.99),
(4, 1003, 108, 1, 29.99, 29.99),
(5, 1004, 103, 3, 19.99, 59.97),
(6, 1005, 107, 1, 79.99, 79.99),
(7, 1005, 106, 1, 39.99, 39.99),
(8, 1006, 105, 1, 49.99, 49.99);
select* from order_items;

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200)
);
INSERT INTO suppliers VALUES
(1, 'TechGadgets Inc', 'David Chen', 'david@techgadgets.com', '555-0201', '100 Tech Park, San Jose, CA'),
(2, 'FashionWear Co', 'Sarah Miller', 'sarah@fashionwear.com', '555-0202', '200 Textile Ave, New York, NY'),
(3, 'FootComfort Ltd', 'James Wilson', 'james@footcomfort.com', '555-0203', '300 Shoe St, Boston, MA'),
(4, 'HomeEssentials', 'Lisa Taylor', 'lisa@homeessentials.com', '555-0204', '400 Appliance Blvd, Chicago, IL'),
(5, 'TravelGear', 'Mark Davis', 'mark@travelgear.com', '555-0205', '500 Luggage Lane, Seattle, WA'),
(6, 'FitLife', 'Amy Johnson', 'amy@fitlife.com', '555-0206', '600 Fitness Way, Denver, CO');
select*from suppliers;
-- solution
				           -- Practice SQL Queries
				-- Here are some query ideas to practice with this dataset:

-- 1:Find all customers from New York
SELECT 
    *
FROM
    customers
WHERE
    city = 'new york';


-- List all products in the Electronics category
SELECT 
    *
FROM
    products
WHERE
    category = 'electronics';
    
    -- how to create view of customer name,city and address
    CREATE VIEW nessary AS
    SELECT 
        first_name, last_name, city, address
    FROM
        customers;
SELECT 
    *
FROM
    nessary;

-- Calculate total sales for each customer
SELECT 
    first_name, SUM(total_amount) AS sales
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
GROUP BY first_name
ORDER BY sales DESC;

-- Find the most popular product (by quantity sold)
SELECT 
    product_name, category, quantity
FROM
    products AS p
        JOIN
    order_items AS oi ON p.product_id = oi.product_id
ORDER BY quantity DESC
LIMIT 1; 

-- List orders with their customer names and order dates
SELECT 
    first_name, order_date
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id;

-- Find products with low stock (less than 40)
SELECT 
    product_name, stock_quantity
FROM
    products
WHERE
    stock_quantity < 40;


-- Calculate total revenue by product category
SELECT 
    category,
    COUNT(quantity),
    SUM(unit_price * quantity) AS revenue
FROM
    products AS p
        JOIN
    order_items AS o ON p.product_id = o.product_id
GROUP BY category;


-- Find customers who haven't placed any orders
SELECT 
    *
FROM
    customers AS c
        JOIN
    orders AS o ON c.customer_id = o.customer_id
WHERE
    order_date IS NULL;


-- List all orders with their items and subtotals
SELECT 
    product_name AS item_name, subtotal
FROM
    products AS p
        JOIN
    order_items AS oi ON p.product_id = oi.product_id;
    
    
-- Find the average order value

SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM 
    orders;
 
