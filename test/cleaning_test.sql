-- REMOVE DUPLICATE

SELECT *
FROM order_1;


SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
							  `date`, customer_id, age, gender, country, state, category_id, category,
                              sub_category, product_name, quantity, unit_cost, unit_price) AS row_num
FROM order_1;

WITH duplicate_cte AS(
					  SELECT *,
					  ROW_NUMBER() OVER(PARTITION BY 
					  `date`, customer_id, age, gender, country, state, category_id, category,
					  sub_category, product_name, quantity, unit_cost, unit_price) AS row_num
FROM order_1
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `order_2` (
  `date` text,
  `customer_id` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` text,
  `country` text,
  `state` text,
  `category_id` int DEFAULT NULL,
  `category` text,
  `sub_category` text,
  `product_name` text,
  `quantity` int DEFAULT NULL,
  `unit_cost` int DEFAULT NULL,
  `unit_price` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO order_2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
							  `date`, customer_id, age, gender, country, state, category_id, category,
                              sub_category, product_name, quantity, unit_cost, unit_price) AS row_num
FROM order_1;

DELETE 
FROM order_2
WHERE row_num > 1;





