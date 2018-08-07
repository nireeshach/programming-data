SELECT  
  item_id as ID,
  recipe_name as Name,
  full_name as Code, 
  partner_name as Partner,
  entered_cook_time as Cook_Time,
  dietary_lifestyles,
  recipe_categories,
  cuisines,
  type_of_meal,
  skill_level as Skill_Level,
  spice_level as Spice_Level,
  proteins as Proteins,
  salesprice as Selling_Price,
  visible_on_website as isVisible_On_Website,
  isinactive as isInActive,
  variant_title as Serving_Size,
  recipe_allergen_details,
  shopify_product_id,
  number_of_ingredients,
  number_of_servings,
  wine_pairings,
  beer_pairings,
  shopify_tags,
  created, type_name, chefd_item_type_id, retail_item
  
FROM
--   `tetris-effect-203015.EDW_Netsuite.Recipe` AS R
`tetris-effect-203015.Fivetran_Netsuite_Views.Recipe` 

WHERE chefd_item_type_id in (1, 9)
AND type_name NOT IN ("Kit/Package", "Assembly/Bill of Materials")
