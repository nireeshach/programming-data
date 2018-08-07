SELECT
  ir.item_id AS recipe_item_id,
  ir.name AS recipe_item_name,
  ir.displayname AS recipe_item_displayname,
  ir.type_name AS recipe_item_type_name,
  ir.salesprice AS recipe_item_sales_price,
  ir.salesdescription AS recipe_item_sales_description,
  v.full_name AS partner_vendor_full_name,
  igr.quantity AS ingredient_item_group_quantity,
  ii.item_id AS ingredient_item_id,
  ii.name AS ingredient_item_name,
  ii.displayname AS ingredient_item_displayname,
  igb.quantity AS bulk_item_group_quantity,
  CASE
    WHEN (ib.item_id = 257 OR (ib.portion_inhouse_el_segundo = "F" AND ib.portion_inhouse_brooklyn = "F")) AND ibf.item_id IS NOT NULL THEN ibf.item_id
    ELSE ib.item_id
  END AS bulk_item_id,
  CASE
    WHEN (ib.item_id = 257 OR (ib.portion_inhouse_el_segundo = "F" AND ib.portion_inhouse_brooklyn = "F")) AND ibf.item_id IS NOT NULL THEN ibf.name
    ELSE ib.name
  END AS bulk_item_name,
  CASE
    WHEN (ib.item_id = 257 OR (ib.portion_inhouse_el_segundo = "F" AND ib.portion_inhouse_brooklyn = "F")) AND ibf.item_id IS NOT NULL THEN ibf.displayname
    ELSE ib.displayname
  END AS bulk_item_displayname,
  ii.portion_inhouse_el_segundo AS bulk_item_portion_inhouse_el_segundo,
  ii.portion_inhouse_brooklyn AS bulk_item_portion_inhouse_brooklyn,
  ii.portion_inhouse_montebello AS bulk_item_portion_inhouse_montebello,
  ii.portion_inhouse_pico_rivera AS bulk_item_portion_inhouse_pico_rivera,
  CASE
    WHEN (ib.item_id = 257 OR (ib.portion_inhouse_el_segundo = "F" AND ib.portion_inhouse_brooklyn = "F")) AND ibf.item_id IS NOT NULL THEN pcf.product_category_name
    ELSE pc.product_category_name
  END AS bulk_product_category
FROM
  `protean-impact-174217.netsuite.items`  ir
LEFT JOIN
--   `NetsuiteReplica.item_group` 
`protean-impact-174217.netsuite.item_group` igr
ON
  igr.parent_id = ir.item_id
LEFT JOIN

--   `NetsuiteReplica.items` ii
`protean-impact-174217.netsuite.items` ii
  
ON
  ii.item_id = igr.member_id
LEFT JOIN
--   `NetsuiteReplica.item_group` igb
`protean-impact-174217.netsuite.item_group` igb
ON
  igb.parent_id = igr.member_id
LEFT JOIN
--   `NetsuiteReplica.items` ib
`protean-impact-174217.netsuite.items` ib
ON
  ib.item_id = igb.member_id
LEFT JOIN
--   `NetsuiteReplica.product_category` pc
`protean-impact-174217.netsuite.product_category` pc
ON
  ib.product_category_id = pc.product_category_id
LEFT JOIN
--   `NetsuiteReplica.items` ibf
`protean-impact-174217.netsuite.items` ibf
ON
  ibf.item_id = ii.frozen_sku_id
LEFT JOIN
--   `NetsuiteReplica.product_category` pcf
`protean-impact-174217.netsuite.product_category` pcf
ON
  ibf.product_category_id = pcf.product_category_id
LEFT JOIN
--   `NetsuiteReplica.vendors` v
`protean-impact-174217.netsuite.vendors` v
ON
  v.vendor_id = ir.partner_id
WHERE
  ir.chefd_item_type_id = 1 --(1 is recipe)
ORDER BY
  recipe_item_name,
  ingredient_item_name,
  bulk_item_name
