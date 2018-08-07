#standardSQL
SELECT distinct 
  member_id as Ingredient_Internal_ID,
  member_full_name as Ingredient_SKU,
  parent_id  as Recipe_Internal_ID,
  parent_full_name  as Recipe_SKU,
  quantity  as Ingredient_to_Recipe_QTY

FROM
  `tetris-effect-203015.Fivetran_Netsuite_Views.ItemGroup`
  
where parent_type_name = "Kit/Package"
