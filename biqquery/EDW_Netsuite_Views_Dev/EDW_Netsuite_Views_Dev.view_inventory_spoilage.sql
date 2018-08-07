SELECT EXTRACT(Month FROM trandate) AS Month, EXTRACT(Year FROM trandate) AS Year
, tranid, tl_item_id AS ID, tl_item_displayname AS Name, reason_for_adjustment, account_copy_full_name, REPLACE(REPLACE(location_full_name, " : Quality Reject", ""), " : QC", "") AS Location
, item_count, -net_amount

FROM `tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` 
WHERE transaction_type = 'Inventory Adjustment'
AND 
(reason_for_adjustment IS NULL AND account_copy_full_name IN ("Inventory Adjustment : COGS : Waste", "Other Expense : Inventory Adjustment: Donated Food", "Inventory Adjustment : COGS : Waste / Damaged (internal)", "Inventory Adjustment : COGS : Damaged (Vendor)", "Inventory Adjustment : COGS : Expired Product (Spoilage)"))
OR
(reason_for_adjustment IN ("Expired - To Waste (503010)", "Expired - To Donations (609730)", "Discontinued - To Waste (503010)", "Damaged/Spoiled - Vendor (503030)", "Damaged/Spoiled - Internal (503050)", "Discontinued - To Donations (609730)"))
OR
(reason_for_adjustment IN ("Inventory Creation - Store Run (503080)", "Consumption - Chef'd - Gel Bricks (500170)", "Consumption - Chef'd - Ingredients (503020)", "Inventory Discrepancy - Reason Unknown (503020)") AND account_copy_full_name IN ("Inventory Adjustment : COGS : Damaged (Vendor)", "Inventory Adjustment : COGS : Expired Product (Spoilage)", "Inventory Adjustment : COGS : Waste / Damaged (internal)", "Other Expense : Inventory Adjustment: Donated Food"))
