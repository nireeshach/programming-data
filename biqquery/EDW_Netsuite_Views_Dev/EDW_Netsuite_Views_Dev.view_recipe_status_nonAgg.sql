#WITH Sys_Item AS (
 #                 SELECT s1.item_id, s1.value_new, s1.value_old, s1.date_created 
  #                    FROM `tetris-effect-203015.EDW_Netsuite.SystemNotes` s1 LEFT JOIN `tetris-effect-203015.EDW_Netsuite.SystemNotes` s2
   #                   ON (s1.item_id = s2.item_id AND s1.date_created < s2.date_created)
    #                  WHERE s1.name = "CHANGE Display in Web Site" and s2.date_created IS NULL
     #             ),

WITH Sys_Item AS (
                  SELECT s1.* FROM (SELECT * FROM`tetris-effect-203015.EDW_Netsuite.SystemNotes` WHERE name = "CHANGE Display in Web Site") AS s1
                  INNER JOIN (SELECT item_id, max(date_created) AS Date_of_Change
                              FROM `tetris-effect-203015.EDW_Netsuite.SystemNotes`
                              WHERE name = "CHANGE Display in Web Site"
                              GROUP BY item_id) AS s2
                  ON (s1.item_id = s2.item_id AND s1.date_created = s2.Date_of_Change)
                  ),

      table_all AS (
                  SELECT EXTRACT(YEAR FROM t.order_date) as Year, r.ID , r.Name, r.Partner, r.isActive, max(t.order_date) as LastSale, min(t.order_date) as FirstSale,
                  count(t.order_number) as Orders, sum(CAST(r.Selling_Price AS FLOAT64)*t.item_count) AS Revenue 
                  From `tetris-effect-203015.EDW_Netsuite_Views.view_master_recipe`  AS r 
                  LEFT JOIN `tetris-effect-203015.EDW_Netsuite_Views.view_SalesOrders_TransactionsDetail` AS t ON t.tl_item_id = r.ID
                  group by Year, r.ID , r.Name, r.Partner, r.isActive
                  having orders > 0
                  )
            
SELECT t.ID, t.Name, t.Partner, t.Year, t.isActive, t.Revenue, s.value_new, s.value_old, s.date_created AS Date_of_Last_Changed, t.LastSale, t.FirstSale
FROM table_all AS t
LEFT JOIN Sys_Item AS s
ON t.ID = s.item_id
