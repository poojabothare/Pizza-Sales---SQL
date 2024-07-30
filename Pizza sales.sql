-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT pizza_category, pizza_name, revenue
FROM
	(SELECT pizza_category, pizza_name, revenue,
	RANK() OVER (PARTITION BY pizza_category ORDER BY revenue DESC) AS rnk
	FROM
		(SELECT pt.category AS pizza_category, pt.name AS pizza_name,
		round(sum(od.quantity * p.price ),2) as revenue
		FROM pizza_types pt
		join pizzas p ON pt.pizza_type_id = p.pizza_type_id
		join order_details od ON od.pizza_id =  p.pizza_id
		GROUP BY pizza_category, pizza_name) AS a) AS b
WHERE rnk <= 3;