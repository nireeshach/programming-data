#standardSQL
--   WITH cte_storage_temperature AS (
--   SELECT
--     item_id,
--     REPLACE(STRING_AGG(DISTINCT(st.list_item_name),
--         ","
--       ORDER BY
--         st.list_item_name), '&lt;', '<') AS storage_temperatures
--   FROM
--     `event-data-181217.NetsuiteSandboxOdbc.storage_temperature_map` AS stm
--   LEFT OUTER JOIN
--     `event-data-181217.NetsuiteSandboxOdbc.storage_temperature` AS st
--   ON
--     stm.storage_temperature_id = st.list_id
--   GROUP BY
--     item_id )
SELECT
  i.item_id,
  i.actual_oz_,
  i.added_shelf_life,
  i.allergen_details,
  i.allow_drop_ship,
  i.amz_bullet_point_1,
  i.amz_bullet_point_3,
  i.amz_bullet_point_4,
  i.amz_bullet_point_5,
  i.asin,
  i.assembly_version_id,
  i.asset_account_id,
  i.atp_method,
  i.auto_bagger_packaging_sku_des,
  i.auto_bagger_packaging_sku_id,
  i.auto_seo_data,
  i.auto_variant_title,
  i.available_in_portioned,
  i.available_on_doordash,
  i.available_to_partners,
  i.average_usage__13_weeks_ea,
  i.average_usage__1_week_ea,
  i.average_usage__2_weeks_ea,
  i.average_usage__4_weeks_ea,
  i.averagecost,
  i.backward_consumption_days,
  i.batch_version_id,
  i.beer_pairings_id,
  i.bill_after_time,
  i.bill_day_of_week_select_id,
  i.bill_price_variance_account_id,
  i.bill_qty_variance_account_id,
  i.bill_weeks_ahead,
  i.build_sub_assemblies,
  i.calories_per_nutritional_serv,
  i.case_cube,
  i.case_gross_weight_lb,
  i.case_height_in,
  i.case_length_in,
  i.case_net_weight_lb,
  i.case_width_in,
  i.catch_weight,
  i.chefd_item_type_id,
  i.config_json,
  i.costing_method,
  i.cost_0,
  i.cost_estimate_type,
  i.count_frequency_days,
  i.count_item,
  i.created,
  i.current_on_order_count,
  i.customerfacing_ingredient_lis,
  i.cutoff_after_time,
  i.cutoff_day_of_week_select_id,
  i.date_last_modified,
  i.department_id,
  i.deposit,
  i.displayname,
  i.effective_available,
  i.effective_bom_control_type,
  i.entered_cook_time,
  i.estimated_cost_portion_in_hou,
  i.eta,
  i.ete_testing,
  i.exclude_from_prebuild,
  i.expense_account_id,
  i.expiration_date_required,
  i.extends_ingredient_shelf_life,
  i.farapp_sync,
  i.featureddescription,
  i.featureditem,
  i.first_landed_date,
  i.first_visible_on_shopify,
  i.frozen_sku_id,
  i.full_name,
  i.future_quantity,
  i.gtin,
  i.half_sheet,
  i.has_ingredient_image,
  i.hazmat,
  i.include_child_subsidiaries,
  i.include_in_ingredient_pack,
  i.income_account_id,
  i.ingredient_pack_id,
  i.ingredient_statement,
  i.inventory_control_id,
  i.inventory_metafield_id,
  i.isinactive,
  i.isonline,
  i.istaxable,
  i.is_cont_rev_handling,
  i.is_enforce_min_qty_internally,
  i.is_hold_rev_rec,
  i.is_moss,
  i.is_phantom,
  i.is_protein,
  i.is_special_order_item,
  i.item_extid,
  i.item_height_in,
  i.item_length_in,
  i.item_volume,
  i.item_width_in,
  i.keep_bulk_shelf_life,
  i.kids_meal,
  i.label_quantity,
  i.label_sku_id,
  i.last_purchase_price,
  i.last_received_date,
  i.last_received_quantity,
  i.last_sync_with_shopify,
  i.limited_qty_set_datetime,
  i.live_on_amazon,
  i.location_id,
  i.lot_numbered_item,
  i.manual_minmax,
  i.manual_website_qoh,
  i.manufacturer,
  i.manufacturing_charge_item,
  i.master_case_upc,
  i.master_variant_id,
  i.match_bill_to_receipt,
  i.mav_oz_,
  i.meals_per_base_ui,
  i.microbial_testing,
  i.microbial_testing_frequency,
  i.modified,
  i.mpn,
  i.name,
  i.netsuite_create_after_time,
  i.netsuite_create_day_of_week_id,
  i.netsuite_create_weeks_ahead,
  i.net_carbs,
  i.next_available_eta,
  i.notes,
  i.notes_from_vendor,
  i.ns_lead_time,
  i.number_of_ingredients,
  i.number_of_servings,
  i.nutritional_information__serv,
  i.n_10_can,
  i.offersupport,
  i.onspecial,
  i.opened_shelf_life_days,
  i.packaging_sku_id,
  i.pack_quantity,
  i.pack_size,
  i.pallet_tiehigh,
  i.partner_id,
  i.portion_inhouse_brooklyn,
  i.portion_inhouse_el_segundo,
  i.portion_inhouse_montebello,
  i.portion_inhouse_pico_rivera,
  i.prices_include_tax,
  i.print_sub_items,
  i.product_category_id,
  i.purchasedescription,
  i.purchase_unit_id,
  i.purchase_uom_conversion,
  i.quantityavailable,
  i.quantitybackordered,
  i.quantityonhand,
  i.quantity_to_order_els,
  i.recipe_name,
  i.recipe_subtitle,
  i.recipe_type_id,
  i.recipe_volume_cubic_feet,
  i.recurring_order_email_subject,
  i.release_tag_id,
  i.reorder_multiple,
  i.replenishment_method,
  i.required_shelf_life_for_retur,
  i.resalable,
  i.retail_inhouse_shelf_life_day,
  i.retail_item,
  i.retail_shelf_life_days,
  i.returns_accepted,
  i.return_fees,
  i.round_up_as_component,
  i.run_data_sync,
  i.salesdescription,
  i.salesprice,
  i.sale_unit_id,
  i.send_to_staging,
  i.seo_meta_description,
  i.seo_page_title,
  i.serialized_item,
  i.set_as_out_of_stock,
  i.shelf_life_days,
  i.shopify_create_after_time,
  i.shopify_create_day_of_week__id,
  i.shopify_create_weeks_ahead,
  i.shopify_ingredients_411,
  i.shopify_meal_type_name,
  i.shopify_preorder_end_date,
  i.shopify_preorder_start_date,
  i.shopify_product_handle,
  i.shopify_product_id,
  i.shopify_tags,
  i.shopify_variant_id,
  i.shopify_website_description,
  i.skill_level_id,
  i.skipped_order_email_subject,
  i.special_work_order_item,
  i.spice_level_id,
  i.sps_item_synch,
  i.stock_unit_id,
  i.storedescription,
  i.storedetaileddescription,
  i.subtype,
  i.sync_batch_version,
  i.sync_data,
  i.sync_inventory,
  i.sync_ship_dates,
  i.thawed_shelf_life,
  i.time_units_id,
  i.totalvalue,
  i.true_life,
  i.type_name,
  i.units_type_id,
  i.upc_code,
  i.update_ingredients,
  i.use_assembly_version,
  i.use_batch_version,
  i.use_component_yield,
  i.variant_title,
  i.vendorname,
  i.vendor_id,
  i.visible_on_website,
  i.volume_units_id,
  i.vsoe_delivered,
  i.website_quantity_on_hand,
  i.weight,
  i.weight_in_user_defined_unit,
  i.weight_unit_index,
  i.wine_pairings_id,
  i.youtube_video_ids
  --Beer
  ,
  b.list_item_name AS beer_pairings
  --Chefd Item Type
  ,
  cit.list_item_name AS chefd_item_type
  --Departments
  ,
  d.name AS department
  --Locations
  ,
  l.full_name AS location_full_name,
  l.name AS location_name,
  l.city AS location_city,
  l.parent_id AS location_parent_id,
  clt.list_item_name AS chefd_location_type
  --Product Category
  ,
  pc.product_category_name AS product_category
  --Units Type
  ,
  ut.name AS units_type
  --Vendors
  ,
  v.full_name AS vendor
  --Wine Pairings
  ,
  w.list_item_name AS wine_pairings
--   Storage Temperature
--   ,
--   ctest.storage_temperatures
FROM
  `protean-impact-174217.netsuite.items` AS i
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.beer` AS b
ON
  i.beer_pairings_id = b.list_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.chefd_item_type` AS cit
ON
  i.chefd_item_type_id = cit.list_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.departments` AS d
ON
  i.department_id = d.department_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.locations` AS l
ON
  i.location_id = l.location_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.chefd_location_type` AS clt
ON
  l.chefd_location_type_id = clt.list_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.product_category` AS pc
ON
  i.product_category_id = pc.product_category_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.units_type` AS ut
ON
  i.units_type_id = ut.units_type_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.vendors` AS v
ON
  i.vendor_id = v.vendor_id
LEFT OUTER JOIN
  `protean-impact-174217.netsuite.wine` AS w
ON
  i.wine_pairings_id = w.list_id
  
  
-- LEFT OUTER JOIN
--   cte_storage_temperature AS ctest
-- ON
--   i.item_id = ctest.item_id
