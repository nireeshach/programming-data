-- select main3.*,  vbib.Bulk_Internal_ID,
--   vbib.Bulk_to_Portion_QTY   from (SELECT
--   main2.*,
--   uom3.unit_of_measure_name AS sale_unit
-- FROM (
--   SELECT
--     main.*,
--     uom2.unit_of_measure_name AS purchase_unit
--   FROM (
--     SELECT

--       full_name AS SKU,
--       type_name,
--       item_id AS Internal_ID,
--       product_category AS Product_Category,
--       displayname AS Ingredient_Display_Name,
--       shelf_life_days AS Shelf_Life_Days,
--       storage_temperatures AS Storage_Temprature,
--       portion_inhouse_brooklyn AS Is_Portioned_In_House_Brooklyn,
--       portion_inhouse_el_segundo AS Is_Portioned_In_House_ElSegundo,
--       portion_inhouse_montebello AS Is_Portioned_In_House_Montebello,
--       portion_inhouse_pico_rivera AS Is_Portioned_In_House_Pico,
--       allergen_details AS Allergens,
--       stock_unit_id AS Stock_Unit_ID,
--       sale_unit_id AS Sale_Unit_ID,
--       purchase_unit_id AS Purchase_Unit_ID,
--       purchase_uom_conversion Unit_Of_Measurement,
--       units_type AS Units_Type,
--       include_in_ingredient_pack Is_Included_In_Ingredient_Pack,
--       uom.unit_of_measure_name AS Stock_Unit
--     FROM
--       `tetris-effect-203015.EDW_Netsuite.Items`
      
      
      
--     LEFT JOIN (
--       SELECT
--         DISTINCT tl_item_full_name,
--         unit_of_measure_id,
--         unit_of_measure_name
--       FROM
--         `tetris-effect-203015.EDW_Netsuite.Transactions`
--       WHERE
--         unit_of_measure_id IS NOT NULL
        

--         ) AS uom
--     ON
--       uom.tl_item_full_name = full_name
--       AND uom.unit_of_measure_id = stock_unit_id 
--       where  type_name = "Assembly/Bill of Materials" and  isinactive = "No"
       
      
--       ) AS main
--   LEFT JOIN (
--     SELECT
--       DISTINCT tl_item_full_name,
--       unit_of_measure_id,
--       unit_of_measure_name
--     FROM
--       `tetris-effect-203015.EDW_Netsuite.Transactions`
--     WHERE
--       unit_of_measure_id IS NOT NULL) AS uom2
--   ON
--     uom2.tl_item_full_name = main.SKU
--     AND uom2.unit_of_measure_id = main.purchase_unit_id ) AS main2
-- LEFT JOIN (
--   SELECT
--     DISTINCT tl_item_full_name,
--     unit_of_measure_id,
--     unit_of_measure_name
--   FROM
--     `tetris-effect-203015.EDW_Netsuite.Transactions`
--   WHERE
--     unit_of_measure_id IS NOT NULL) AS uom3
-- ON
--   uom3.tl_item_full_name = main2.SKU
--   AND uom3.unit_of_measure_id = main2.sale_unit_id) as main3

-- LEFT JOIN
--   `tetris-effect-203015.EDW_Netsuite_Views.view_bridge_ingredient_bulk`  AS vbib
-- ON

-- vbib.Ingredient_Internal_ID = main3.Internal_id

  
-- --   ------   FOR TESTING   ------

-- --   WHERE
-- --     product_category is null


-- --    WHERE
-- --     item_id = 345
-- --   -----------------------------



select main3.*,  vbib.Bulk_Internal_ID,
  vbib.Bulk_to_Portion_QTY   from (SELECT
  main2.*,
  uom3.unit_of_measure_name AS sale_unit
FROM (
  SELECT
    main.*,
    uom2.unit_of_measure_name AS purchase_unit
  FROM (
    SELECT

      full_name AS SKU,
      type_name,
      item_id AS Internal_ID,
      product_category AS Product_Category,
      displayname AS Ingredient_Display_Name,
      shelf_life_days AS Shelf_Life_Days,
--       storage_temperatures AS Storage_Temprature,
      portion_inhouse_brooklyn AS Is_Portioned_In_House_Brooklyn,
      portion_inhouse_el_segundo AS Is_Portioned_In_House_ElSegundo,
      portion_inhouse_montebello AS Is_Portioned_In_House_Montebello,
      portion_inhouse_pico_rivera AS Is_Portioned_In_House_Pico,
      allergen_details AS Allergens,
      stock_unit_id AS Stock_Unit_ID,
      sale_unit_id AS Sale_Unit_ID,
      purchase_unit_id AS Purchase_Unit_ID,
      purchase_uom_conversion Unit_Of_Measurement,
      units_type AS Units_Type,
      include_in_ingredient_pack Is_Included_In_Ingredient_Pack,
      uom.unit_of_measure_name AS Stock_Unit
    FROM
--       `tetris-effect-203015.EDW_Netsuite.Items`
      `tetris-effect-203015.Fivetran_Netsuite_Views.Items`  
      
      
      
    LEFT JOIN (
      SELECT
        DISTINCT tl_item_full_name,
        unit_of_measure_id,
        unit_of_measure_name
      FROM
--         `tetris-effect-203015.EDW_Netsuite.Transactions`
      `tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` 

      WHERE
        unit_of_measure_id IS NOT NULL
        

        ) AS uom
    ON
      uom.tl_item_full_name = full_name
      AND uom.unit_of_measure_id = stock_unit_id 
      where  type_name = "Assembly/Bill of Materials" and  isinactive = "No"
       
      
      ) AS main
  LEFT JOIN (
    SELECT
      DISTINCT tl_item_full_name,
      unit_of_measure_id,
      unit_of_measure_name
    FROM
--       `tetris-effect-203015.EDW_Netsuite.Transactions`
      `tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` 

WHERE
      unit_of_measure_id IS NOT NULL) AS uom2
  ON
    uom2.tl_item_full_name = main.SKU
    AND uom2.unit_of_measure_id = main.purchase_unit_id ) AS main2
LEFT JOIN (
  SELECT
    DISTINCT tl_item_full_name,
    unit_of_measure_id,
    unit_of_measure_name
  FROM
--     `tetris-effect-203015.EDW_Netsuite.Transactions`
      `tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` 

  WHERE
    unit_of_measure_id IS NOT NULL) AS uom3
ON
  uom3.tl_item_full_name = main2.SKU
  AND uom3.unit_of_measure_id = main2.sale_unit_id) as main3

LEFT JOIN
  `tetris-effect-203015.EDW_Netsuite_Views.view_bridge_ingredient_bulk`  AS vbib
ON

vbib.Ingredient_Internal_ID = main3.Internal_id

  
--   ------   FOR TESTING   ------

  WHERE
    product_category not in ("Packaging","Smallwares", "Prebuild Pack", "Recipe", "Case Pack")


--    WHERE
--     item_id = 345
--   -----------------------------
