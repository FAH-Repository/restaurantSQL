USE restaurant_db;
-- view all in menu_items table
SELECT * FROM menu_items;

-- view the number of items in menu_items
SELECT COUNT(*) FROM menu_items;

-- all from menu items, sorted by price in descending order
SELECT * FROM menu_items
ORDER BY price DESC;

--  how many Italian dishes in the menu
SELECT COUNT(*) FROM menu_items
WHERE category="Italian";

-- list the Italian dishes
SELECT *
FROM menu_items
WHERE category="Italian"
ORDER BY price DESC;

-- find the number of dishes per category
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- find average price of each dish category
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;

-- view the order_details table
SELECT * FROM order_details;

-- find the date range of the table
SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- how many items were made 
SELECT COUNT(DISTINCT order_id) FROM order_details;

-- how many many orders were made
SELECT COUNT(*) FROM order_details;

-- which orders had the most items?
SELECT order_id, COUNT(item_id) AS num_items FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- how many order have more than 12 items?
SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) AS num_items FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;

-- combine the menu_items and order_details into a single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id;

-- find the least and most ordered items
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases; -- and DESC

-- top 5 orders that spent the most money
SELECT order_id, SUM(price) AS total_spent
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spent DESC
LIMIT 5;

-- what are the details on the highest order
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = "440"
GROUP BY category;

-- view top 5 order details
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;




