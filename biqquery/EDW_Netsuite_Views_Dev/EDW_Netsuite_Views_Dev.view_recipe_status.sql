WITH Sys_Item AS (
                  SELECT s1.* FROM (SELECT * FROM`tetris-effect-203015.EDW_Netsuite.SystemNotes` WHERE name = "CHANGE Display in Web Site") AS s1
                  INNER JOIN (SELECT item_id, max(date_created) AS date_of_last_change
                              FROM `tetris-effect-203015.EDW_Netsuite.SystemNotes`
                              WHERE name = "CHANGE Display in Web Site"
                              GROUP BY item_id) AS s2
                  ON (s1.item_id = s2.item_id AND s1.date_created = s2.date_of_last_change)
                  ),

      table_all AS (
                  SELECT  r.ID , r.Name, r.Partner, r.isActive, t.order_date, r.Selling_Price, t.item_count,
                  
                  count(t.order_number) as number_of_orders 
                  From `tetris-effect-203015.EDW_Netsuite_Views.view_master_recipe`  AS r 
                  LEFT JOIN `tetris-effect-203015.EDW_Netsuite_Views.view_SalesOrders_TransactionsDetail` AS t ON t.tl_item_id = r.ID
                  group by r.ID , r.Name, r.Partner, r.isActive, t.order_date, r.Selling_Price, t.item_count
                  having number_of_orders > 0
                  )
            
SELECT t.ID, t.Name, t.Partner, t.isActive, s.value_new, s.value_old, s.date_created AS date_of_last_change, max(t.order_date) as last_sale_date, min(t.order_date) as first_sale_date,
SUM(CASE  WHEN EXTRACT(YEAR FROM t.order_date) = 2015 THEN CAST(t.Selling_Price AS FLOAT64)*t.item_count ELSE 0 END) AS sales_revenue_2015,
SUM(CASE  WHEN EXTRACT(YEAR FROM t.order_date) = 2016 THEN CAST(t.Selling_Price AS FLOAT64)*t.item_count ELSE 0 END) AS sales_revenue_2016,
SUM(CASE  WHEN EXTRACT(YEAR FROM t.order_date) = 2017 THEN CAST(t.Selling_Price AS FLOAT64)*t.item_count ELSE 0 END) AS sales_revenue_2017,
SUM(CASE  WHEN EXTRACT(YEAR FROM t.order_date) = 2018 THEN CAST(t.Selling_Price AS FLOAT64)*t.item_count ELSE 0 END) AS sales_revenue_2018
FROM table_all AS t
LEFT JOIN Sys_Item AS s
ON t.ID = s.item_id
GROUP BY t.ID, t.Name, t.Partner, t.isActive, s.value_new, s.value_old, date_of_last_change
