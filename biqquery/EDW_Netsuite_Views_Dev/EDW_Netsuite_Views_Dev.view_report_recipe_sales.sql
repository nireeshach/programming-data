#standardSQL
select t_bpir.*, vmr.name , vmr.partner, vmr.cook_time, vmr.skill_level , vmr.spice_level , vmr.proteins, vmr.Serving_Size as Serving_Size      from (SELECT
  CASE
      WHEN bpir.Parent_ID IS NULL THEN tl_item_id
      ELSE bpir.Parent_ID end
    as Recipe_ID,
    tl_item_id,
    tl_item_displayname,
    tranid,
    customer_full_name,
    status,
    rate_for_shopify,
    amount_pending,
    amount,
    amount_unbilled,
    date_created,
    trandate,
    order_type, 
    location_full_name 
    
  FROM
`tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` as t
  LEFT JOIN
    `tetris-effect-203015.EDW_Netsuite_Views.view_bridge_packs_ingredient_recipe`  AS bpir
  ON
    bpir.Pack_ID = t.tl_item_id
  WHERE
    transaction_type = "Sales Order"
    AND status IN ("Billed",
      "Pending Fulfillment")
    AND 
      tl_item_type_name = "Kit/Package"
    
      ) as t_bpir
      
      
    left join  `tetris-effect-203015.EDW_Netsuite_Views_Dev.view_master_recipe`  as vmr
    
    on t_bpir.Recipe_ID = vmr.id

