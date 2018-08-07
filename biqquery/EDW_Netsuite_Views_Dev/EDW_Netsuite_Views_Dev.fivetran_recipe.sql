#standardSQL
SELECT i.name
	,i.displayname
	,i.full_name
	,i.item_id
	,i.entered_cook_time
	,v.companyname																	AS partner_name
	,ROUND(SUM(COALESCE(IFNULL(il.pref_vendor_unit_price,0), IFNULL(il.last_cost,0), IFNULL(il.est__pih_cost,0),0)* ig.Quantity),2) AS recipe_cost
	,i.allergen_details																AS recipe_allergen_details
	
	--Ingredient Allergen Details
	,ARRAY_AGG(DISTINCT(IFNULL(ci.allergen_details,'None'))) AS ingredient_allergen_details
	
	--Type of Meal Map
	,ARRAY_AGG(DISTINCT(IFNULL(tm.list_item_name,'None')))	AS type_of_meal
	
	--Proteins Map
	,ARRAY_AGG(DISTINCT(IFNULL(pr.list_item_name,'None')))	AS proteins
	
	--Recipe Category Map
	,ARRAY_AGG(DISTINCT(IFNULL(rc.list_item_name,'None')))	AS recipe_categories
	
	--Cuisine Map
	, ARRAY_AGG(DISTINCT(IFNULL(cu.list_item_name,'None')))	AS cuisines
	
	--Dietary Lifestyle Map
	, ARRAY_AGG(DISTINCT(IFNULL(dl.list_item_name,'None'))) AS dietary_lifestyles
	
	--Time Units
	,tu.list_item_name 										AS time_units
	
	--Skill Level
	,sk.list_item_name 										AS skill_level
	
	--Spice Level
	,sp.list_item_name 										AS spice_level
	
	--Item Report Fields
	,i.shopify_product_id
	,i.recipe_name
	,webit.website_item_type_name
	,i.recipe_subtitle
	,i.salesdescription
  ,i.created
  ,i.isinactive                         AS isInActive
  ,i.shopify_tags
#  ,i.shopify_website_description
	,i.variant_title
	,i.salesprice
	,i.number_of_ingredients
	,i.number_of_servings
	,i.website_quantity_on_hand
	,i.visible_on_website
	,i.calories_per_nutritional_serv
	,i.customerfacing_ingredient_lis
  ,i.retail_item
  ,i.type_name
  ,i.chefd_item_type_id
  
  -- Product Category
  ,pc.product_category_name AS Indicator

	
	-- Release/Recipe Tag
	,tag.list_item_name 									AS release_tag
	
	-- Wine Pairings
	,w.list_item_name 										AS wine_pairings
	
	-- Beer Pairings
	,b.list_item_name 										AS beer_pairings
	
	-- Equipment
	,ARRAY_AGG(DISTINCT(IFNULL(eq.list_item_name,'None'))) 	AS equipment
	
	-- Extra Ingredients Needed
	,ARRAY_AGG(DISTINCT(IFNULL(ex.list_item_name,'None'))) 	AS extra_ingredients_needed
	
	-- Additional Tags
	,ARRAY_AGG(DISTINCT(IFNULL(adt.list_item_name,'None'))) AS additional_tags
	

FROM `protean-impact-174217.netsuite.items`										AS i
LEFT OUTER JOIN `protean-impact-174217.netsuite.type_of_meal_map` 				AS tm_map 	ON i.item_id = tm_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.type_of_meal` 					AS tm 		ON tm.list_id = tm_map.type_of_meal_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.proteins_map` 					AS pr_map 	ON i.item_id = pr_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.protein_filters` 				AS pr 		ON pr.list_id = pr_map.protein_filters_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.recipe_category_map` 			AS rc_map 	ON i.item_id = rc_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.recipe_categories` 				AS rc 		ON rc.list_id = rc_map.recipe_categories_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.cuisine_map` 					AS cu_map 	ON i.item_id = cu_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.cuisines` 						AS cu 		ON cu.list_id = cu_map.cuisines_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.dietary_lifestyle_map` 			AS dl_map 	ON i.item_id = dl_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.dietary_lifestyles` 			AS dl 		ON dl.list_id = dl_map.dietary_lifestyles_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.time_units` 					AS tu 		ON tu.list_id = i.time_units_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.skill_level`					AS sk		ON i.skill_level_id = sk.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.spice_level`					AS sp		ON i.spice_level_id = sp.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.item_group` 					AS ig 		ON i.item_id = ig.parent_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.items` 							AS ci 		ON ig.member_id = ci.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.vendors` 						AS v 		ON i.partner_id = v.vendor_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.item_location` 					AS il 		ON ig.member_id = il.item_id AND il.location_id = 1.0
LEFT OUTER JOIN `protean-impact-174217.netsuite.website_item_type` 				AS webit 	ON i.recipe_type_id = webit.website_item_type_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.beer` 							AS b 		ON i.beer_pairings_id = b.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.wine` 							AS w 		ON i.wine_pairings_id = w.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.recipe_tag` 					AS tag 		ON i.release_tag_id = tag.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.equipment_map` 					AS eq_map 	ON i.item_id = eq_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.equipment` 						AS eq 		ON eq_map.equipment_id = eq.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.extra_ingredients_needed_map` 	AS ex_map 	ON i.item_id = ex_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.extra_ingredients` 				AS ex 		ON ex_map.extra_ingredients_id = ex.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.additional_tags_map` 			AS adt_map 	ON i.item_id = adt_map.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.additional_recipe_tags` 		AS adt 		ON adt_map.additional_recipe_tags_id = adt.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.product_category`       AS pc     ON i.product_category_id = pc.product_category_id

wHERE i.chefd_item_type_id = 1.0 --Recipe
  or i.chefd_item_type_id = 9.0 --Covers Masterpacks

GROUP BY name
	,displayname
	,full_name
	,item_id
	,entered_cook_time
	,time_units
	,skill_level
	,spice_level
#	,isonline 
	,partner_name
	,recipe_allergen_details
	,shopify_product_id
	,recipe_name
	,website_item_type_name
	,recipe_subtitle
	,salesdescription
	,variant_title
	,salesprice
	,number_of_ingredients
	,number_of_servings
	,website_quantity_on_hand
	,i.visible_on_website
	,calories_per_nutritional_serv
	,customerfacing_ingredient_lis
	,release_tag
	,wine_pairings
	,beer_pairings
  ,shopify_tags
#  ,shopify_website_description
  ,isinactive
  ,created
  ,retail_item
  ,type_name
  ,chefd_item_type_id,
  pc.product_category_name
