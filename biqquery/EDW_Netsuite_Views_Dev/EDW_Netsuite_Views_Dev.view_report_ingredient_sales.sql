select t_1.*, t_2.Weekly_Usage_Two_Weeks	 from (select SKU,Ingredient_Display_Name, Internal_id, shelf_life_days, sum(on_hand_count) as total_on_hand_count from (

select mi.*, i.on_hand_count from `tetris-effect-203015.EDW_Netsuite_Views_Dev.view_master_ingredient` as mi

join `tetris-effect-203015.Fivetran_Netsuite_Views.Inventory`  as i

on 

i.item_id = mi.Internal_ID )

-- Testing ---------------------
-- where Internal_ID = 768
--------------------------------

group by Internal_id, SKU, Ingredient_Display_Name, shelf_life_days
) as t_1

join 

(

select Internal_ID , Ingredient_Display_Name, sum(Ingredient_to_Recipe_QTY) / 2 as Weekly_Usage_Two_Weeks from `tetris-effect-203015.EDW_Netsuite_Views.view_report_ingredient_sales`


-- -------------------Testing ---------------------
-- where  Ingredient_Internal_ID = 768
-- and trandate between timestamp(DATE_SUB(CURRENT_DATE(), INTERVAL 2 WEEK)) and timestamp(CURRENT_DATE()) 


-- ------------------------------------------------


where  trandate between timestamp(DATE_SUB(CURRENT_DATE(), INTERVAL 2 WEEK)) and timestamp(CURRENT_DATE()) 

group by  Internal_ID , Ingredient_Display_Name

) as t_2


on t_1.Internal_id = t_2.Internal_ID


-- left join 



-- (

-- select Internal_ID , Ingredient_Display_Name, sum(Ingredient_to_Recipe_QTY) / 4 as Weekly_Usage_Two_Weeks from (


-- select * from `tetris-effect-203015.EDW_Netsuite_Views.view_report_ingredient_sales` )


-- -- -------------------Testing ---------------------
-- -- where  Ingredient_Internal_ID = 768
-- -- and trandate between timestamp(DATE_SUB(CURRENT_DATE(), INTERVAL 2 WEEK)) and timestamp(CURRENT_DATE()) 


-- -- ------------------------------------------------


-- where  trandate between timestamp(DATE_SUB(CURRENT_DATE(), INTERVAL 4 WEEK)) and timestamp(CURRENT_DATE()) 

-- group by  Internal_ID , Ingredient_Display_Name

-- ) as t_3


-- on t_1.Internal_id = t_3.Internal_ID
