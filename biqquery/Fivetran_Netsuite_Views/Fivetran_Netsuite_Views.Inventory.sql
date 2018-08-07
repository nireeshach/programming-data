#standardSQL
WITH cte_BinInventoryItemMap AS (
	SELECT   MAX(tl.transaction_id) 		AS transaction_id
			,MAX(tl.transaction_line_id) 	AS transaction_line_id
			,tl.item_id
			,tl.location_id
			,tin.inventory_number
			
	FROM `protean-impact-174217.netsuite.transaction_lines`					AS tl
	JOIN `protean-impact-174217.netsuite.transaction_inventory_numbers`		AS tin ON tin.transaction_id = tl.transaction_id AND tin.transaction_line = tl.transaction_line_id

	GROUP BY item_id,location_id,inventory_number

), cte_LatestBinInventoryItemMap AS (
	SELECT   cte.item_id
			,cte.location_id
			,cte.inventory_number
			,tbn.bin_number
			
	FROM cte_BinInventoryItemMap											AS cte
	JOIN `protean-impact-174217.netsuite.transaction_bin_numbers`			AS tbn ON tbn.transaction_id = cte.transaction_id AND tbn.transaction_line = cte.transaction_line_id
	
	GROUP BY item_id,location_id,inventory_number,bin_number

), cte_LatestItemLocationRecord AS (
SELECT   MAX(item_location_id) AS item_location_id
		,item_id
		,location_id

FROM `protean-impact-174217.netsuite.item_location`

GROUP BY item_id, location_id
), cte_ItemLocation AS (
SELECT   il.*

FROM `protean-impact-174217.netsuite.item_location` il
JOIN cte_LatestItemLocationRecord					cte ON il.item_location_id = cte.item_location_id

)
SELECT inv.inventory_number_id
	,inv.inventory_number
	,inv.actual_oz_
	,inv.added_shelf_life
	,inv.adjustment_reason_id
	,inv.allergen_details
	,inv.auto_bagger_packaging_sku_des
	,inv.auto_bagger_packaging_sku_id
	,inv.available_count
	,inv.available_in_portioned
	,inv.average_usage__13_weeks_ea
	,inv.average_usage__1_week_ea
	,inv.average_usage__2_weeks_ea
	,inv.average_usage__4_weeks_ea
	,inv.beer_pairings_id
	,inv.calories_per_nutritional_serv
	,inv.case_cube
	,inv.case_gross_weight_lb
	,inv.case_height_in
	,inv.case_length_in
	,inv.case_net_weight_lb
	,inv.case_width_in
	,inv.catch_weight
	,inv.chefd_item_type_id
	,inv.country_of_origin
	,inv.count_frequency_days
	,inv.count_item
	,inv.date_last_modified
	,inv.date_received
	,inv.description
	,inv.effective_available
	,inv.estimated_cost_portion_in_hou
	,inv.ete_testing
	,inv.expiration_date
	,inv.expiration_date_required
	,inv.extends_ingredient_shelf_life
	,inv.firmness
	,inv.first_landed_date
	,inv.from_bin_id
	,inv.frozen_sku_id
	,inv.future_quantity
	,inv.gtin
	,inv.half_sheet
	,inv.has_ingredient_image
	,inv.include_in_ingredient_pack
	,inv.ingredient_statement
	,inv.inventory_control_id
	,inv.inventory_reserved_for_id
	,inv.in_transit_count
	,inv.is_protein
	,inv.item_height_in
	,inv.item_id
	,inv.item_length_in
	,inv.item_volume
	,inv.item_width_in
	,inv.keep_bulk_shelf_life
	,inv.label_sku_id
	,inv.last_modified
	,inv.last_modified_by_id
	,inv.last_received_date
	,inv.last_received_quantity
	,inv.location_id
	,inv.manual_minmax
	,inv.master_case_upc
	,inv.master_variant_id
	,inv.mav_oz_
	,inv.meals_per_base_ui
	,inv.memo
	,inv.microbial_testing
	,inv.microbial_testing_frequency
	,inv.next_available_eta
	,inv.notes
	,inv.notes_from_vendor
	,inv.no_longer_extendable
	,inv.number_of_servings
	,inv.number_type
	,inv.nutritional_information__serv
	,inv.n_10_can
	,inv.on_hand_count
	,inv.on_order_count
	,inv.opened_shelf_life_days
	,inv.packaging_sku_id
	,inv.packed_on_date
	,inv.pack_quantity
	,inv.pack_size
	,inv.pallet_tiehigh
	,inv.partner_id
	,inv.portion_inhouse_brooklyn
	,inv.portion_inhouse_el_segundo
	,inv.portion_inhouse_montebello
	,inv.portion_inhouse_pico_rivera
	,inv.product_category_id
	,inv.purchase_uom_conversion
	,inv.quantity_moved_or_removed
	,inv.quantity_to_order_els
	,inv.recipe_name
	,inv.recipe_subtitle
	,inv.recipe_volume_cubic_feet
	,inv.rejected
	,inv.release_tag_id
	,inv.required_shelf_life_for_retur
	,inv.retail_inhouse_shelf_life_day
	,inv.retail_item
	,inv.retail_shelf_life_days
	,inv.returns_accepted
	,inv.return_fees
	,inv.send_to_staging
	,inv.shelf_life_days
	,inv.size_0
	,inv.skill_level_id
	,inv.smell
	,inv.spice_level_id
	,inv.sps_item_synch
	,inv.sync_data
	,inv.sync_inventory
	,inv.thawed_shelf_life
	,inv.to_bin_id
	,inv.true_life
	,inv.true_life_0
	,inv.viscosity
	,inv.visual_inspection_notes
	,inv.volume_units_id
	,inv.weight
	,inv.wine_pairings_id
	
	--Adjustment Reason Codes
	,arc.list_item_name			AS reason_for_adjustment
	
	--Chefd Item Type
	,cit.list_item_name			AS chefd_item_type
	
	--Items
	,i.full_name				AS item_full_name
	,i.displayname				AS item_displayname
	,i.name						AS item_name
	,i.isinactive				AS item_isinactive
	,i.eta						AS item_eta
	,i.type_name				AS item_type_name
	
	--Locations
	,l.full_name				AS location_full_name
	,l.name						AS location_name
	,l.city						AS location_city
	,l.parent_id				AS location_parent_id
	,clt.list_item_name			AS chefd_location_type
	
	--Product Category
	,pc.product_category_name 	AS product_category
	,pc.food_item				AS pc_food_item
	
	--Beer
	,b.list_item_name 			AS beer_pairings
	
	--Wine
	,w.list_item_name 			AS wine_pairings
	
	--Skill Level
	,sk.list_item_name 			AS skill_level
	
	--Spice Level
	,sp.list_item_name 			AS spice_level
	
	-- Item Location
	,il.preferred_vendor_id
	,v.companyname				AS preferred_vendor
	,il.last_cost
	,il.est__pih_cost
	,il.pref_vendor_unit_price
	,il.ave__usage__13_week_ea
	,il.ave__usage__2_week_ea
	,il.ave__usage__4_week_ea
	,il.usage__1_week
	,il.eta						AS item_location_eta
	
	-- Item Location Map
	,inv.on_hand_count			AS ilm_on_hand_count
	,inv.available_count		AS ilm_available_count
	,inv.on_order_count			AS ilm_on_order_count
	,ilm.reorderpoint			AS ilm_reorder_point
	,ilm.quantitybackordered	AS ilm_quantitybackordered
	
	-- Bin
	,ARRAY_AGG(DISTINCT(IFNULL(bin.bin_number,'None'))) AS bin_number

FROM `protean-impact-174217.netsuite.inventory_number`						AS inv
LEFT OUTER JOIN `protean-impact-174217.netsuite.adjustment_reason_codes`	AS arc	ON inv.adjustment_reason_id = arc.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.chefd_item_type`			AS cit	ON inv.chefd_item_type_id = cit.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`						AS i	ON inv.item_id = i.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.locations`					AS l	ON inv.location_id = l.location_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.chefd_location_type`		AS clt	ON l.chefd_location_type_id = clt.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.product_category`			AS pc	ON inv.product_category_id = pc.product_category_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.beer`						AS b	ON inv.beer_pairings_id = b.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.wine`						AS w	ON inv.wine_pairings_id = w.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.skill_level`				AS sk	ON inv.skill_level_id = sk.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.spice_level`				AS sp	ON inv.spice_level_id = sp.list_id
LEFT OUTER JOIN cte_ItemLocation											AS il	ON inv.item_id = il.item_id AND inv.location_id = il.location_id
-- LEFT OUTER JOIN `event-data-181217.NetsuiteSandboxOdbc.item_location_map`	AS ilm	ON inv.item_id = ilm.item_id AND inv.location_id = ilm.location_id
left outer join `protean-impact-174217.netsuite.inventory_items` as ilm ON inv.item_id = ilm.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.vendors`					AS v	ON il.preferred_vendor_id = v.vendor_id
LEFT OUTER JOIN `cte_LatestBinInventoryItemMap`								AS bin	ON inv.inventory_number = bin.inventory_number AND inv.item_id = bin.item_id AND inv.location_id = bin.location_id

GROUP BY inv.inventory_number_id
	,inv.inventory_number
	,inv.actual_oz_
	,inv.added_shelf_life
	,inv.adjustment_reason_id
	,inv.allergen_details
	,inv.auto_bagger_packaging_sku_des
	,inv.auto_bagger_packaging_sku_id
	,inv.available_count
	,inv.available_in_portioned
	,inv.average_usage__13_weeks_ea
	,inv.average_usage__1_week_ea
	,inv.average_usage__2_weeks_ea
	,inv.average_usage__4_weeks_ea
	,inv.beer_pairings_id
	,inv.calories_per_nutritional_serv
	,inv.case_cube
	,inv.case_gross_weight_lb
	,inv.case_height_in
	,inv.case_length_in
	,inv.case_net_weight_lb
	,inv.case_width_in
	,inv.catch_weight
	,inv.chefd_item_type_id
	,inv.country_of_origin
	,inv.count_frequency_days
	,inv.count_item
	,inv.date_last_modified
	,inv.date_received
	,inv.description
	,inv.effective_available
	,inv.estimated_cost_portion_in_hou
	,inv.ete_testing
	,inv.expiration_date
	,inv.expiration_date_required
	,inv.extends_ingredient_shelf_life
	,inv.firmness
	,inv.first_landed_date
	,inv.from_bin_id
	,inv.frozen_sku_id
	,inv.future_quantity
	,inv.gtin
	,inv.half_sheet
	,inv.has_ingredient_image
	,inv.include_in_ingredient_pack
	,inv.ingredient_statement
	,inv.inventory_control_id
	,inv.inventory_reserved_for_id
	,inv.in_transit_count
	,inv.is_protein
	,inv.item_height_in
	,inv.item_id
	,inv.item_length_in
	,inv.item_volume
	,inv.item_width_in
	,inv.keep_bulk_shelf_life
	,inv.label_sku_id
	,inv.last_modified
	,inv.last_modified_by_id
	,inv.last_received_date
	,inv.last_received_quantity
	,inv.location_id
	,inv.manual_minmax
	,inv.master_case_upc
	,inv.master_variant_id
	,inv.mav_oz_
	,inv.meals_per_base_ui
	,inv.memo
	,inv.microbial_testing
	,inv.microbial_testing_frequency
	,inv.next_available_eta
	,inv.notes
	,inv.notes_from_vendor
	,inv.no_longer_extendable
	,inv.number_of_servings
	,inv.number_type
	,inv.nutritional_information__serv
	,inv.n_10_can
	,inv.on_hand_count
	,inv.on_order_count
	,inv.opened_shelf_life_days
	,inv.packaging_sku_id
	,inv.packed_on_date
	,inv.pack_quantity
	,inv.pack_size
	,inv.pallet_tiehigh
	,inv.partner_id
	,inv.portion_inhouse_brooklyn
	,inv.portion_inhouse_el_segundo
	,inv.portion_inhouse_montebello
	,inv.portion_inhouse_pico_rivera
	,inv.product_category_id
	,inv.purchase_uom_conversion
	,inv.quantity_moved_or_removed
	,inv.quantity_to_order_els
	,inv.recipe_name
	,inv.recipe_subtitle
	,inv.recipe_volume_cubic_feet
	,inv.rejected
	,inv.release_tag_id
	,inv.required_shelf_life_for_retur
	,inv.retail_inhouse_shelf_life_day
	,inv.retail_item
	,inv.retail_shelf_life_days
	,inv.returns_accepted
	,inv.return_fees
	,inv.send_to_staging
	,inv.shelf_life_days
	,inv.size_0
	,inv.skill_level_id
	,inv.smell
	,inv.spice_level_id
	,inv.sps_item_synch
	,inv.sync_data
	,inv.sync_inventory
	,inv.thawed_shelf_life
	,inv.to_bin_id
	,inv.true_life
	,inv.true_life_0
	,inv.viscosity
	,inv.visual_inspection_notes
	,inv.volume_units_id
	,inv.weight
	,inv.wine_pairings_id
	
	--Adjustment Reason Codes
	, reason_for_adjustment
	
	--Chefd Item Type
	, chefd_item_type
	
	--Items
	, item_full_name
	, item_displayname
	, item_name
	, item_isinactive
	, item_eta
	, item_type_name
	
	--Locations
	, location_full_name
	, location_name
	, location_city
	, location_parent_id
	, chefd_location_type
	
	--Product Category
	, product_category
	, pc_food_item
	
	--Beer
	, beer_pairings
	
	--Wine
	, wine_pairings
	
	--Skill Level
	, skill_level
	
	--Spice Level
	, spice_level
	
	-- Item Location
	,il.preferred_vendor_id
	, preferred_vendor
	,il.last_cost
	,il.est__pih_cost
	,il.pref_vendor_unit_price
	,il.ave__usage__13_week_ea
	,il.ave__usage__2_week_ea
	,il.ave__usage__4_week_ea
	,il.usage__1_week
	,item_location_eta
	
	-- Item Location Map
	, ilm_on_hand_count
	, ilm_available_count
	, ilm_on_order_count
	, ilm_reorder_point
	, ilm_quantitybackordered
