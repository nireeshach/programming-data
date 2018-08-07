SELECT
  DISTINCT t_1.SKU,
  t_1.Ingredient_Display_Name,
  t_1.Internal_id,
  t_1.shelf_life_days,
  t_1.Location_Full_Name,
  SUM(t_1.total_on_hand_count) AS total_on_hand_count,
  SUM(t_2.Weekly_Usage_Two_Weeks) AS Weekly_Usage_Two_Weeks
FROM (
  SELECT
    SKU,
    Ingredient_Display_Name,
    Internal_id,
    mi.shelf_life_days,
    REPLACE(i.location_full_name, " : QC", "") AS Location_Full_Name,
    SUM(on_hand_count) AS total_on_hand_count
  FROM
    `tetris-effect-203015.EDW_Netsuite_Views.view_master_ingredient` AS mi
  JOIN
    `tetris-effect-203015.Fivetran_Netsuite_Views.Inventory` AS i
  ON
    i.item_id = mi.Internal_ID
  WHERE
    expiration_date > TIMESTAMP(CURRENT_DATE())
  GROUP BY
    Internal_id,
    SKU,
    Ingredient_Display_Name,
    shelf_life_days,
    i.location_full_name ) AS t_1
JOIN (
  SELECT
    Internal_ID,
    Ingredient_Display_Name,
    location_full_name,
    SUM(Ingredient_to_Recipe_QTY) / 2 AS Weekly_Usage_Two_Weeks
  FROM
    `tetris-effect-203015.EDW_Netsuite_Views.view_report_ingredient_sales`
  WHERE
    trandate BETWEEN TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 2 WEEK))
    AND TIMESTAMP(CURRENT_DATE())
  GROUP BY
    Internal_ID,
    Ingredient_Display_Name,
    location_full_name) AS t_2
ON
  t_1.Internal_id = t_2.Internal_ID
  AND t_1.location_full_name = t_2.location_full_name
GROUP BY
  SKU,
  Ingredient_Display_Name,
  Internal_id,
  shelf_life_days,
  Location_Full_Name
