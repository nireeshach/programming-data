-- select Ingredient_Display_Name,  sum(Ingredient_to_Recipe_QTY) as QTY_Sold from   (

select * from (


select * from `tetris-effect-203015.EDW_Netsuite_Views_Dev.view_master_ingredient` as vmi

left join `tetris-effect-203015.EDW_Netsuite_Views_Dev.view_bridge_ingredient_recipe` as vbir

on vmi.Internal_ID = vbir.Ingredient_Internal_ID) as vmi_vbir


left join `tetris-effect-203015.EDW_Netsuite_Views_Dev.view_report_recipe_sales` as vrrs

on 
vmi_vbir.Recipe_Internal_ID = vrrs.Recipe_ID

-- -------------------Testing ---------------------
-- where  Recipe_ID = 7922 or Recipe_ID = 7925
-- ------------------------------------------------

-- ) as main1

-- group by Ingredient_Display_Name, Internal_ID
