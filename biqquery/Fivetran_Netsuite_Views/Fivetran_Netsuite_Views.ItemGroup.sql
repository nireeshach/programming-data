SELECT
	 ig.item_group_id
	,ig.bom_quantity
	,ig.component_yield
	,ig.effective_date
	,ig.effective_revision
	,ig.item_source
	,ig.line_id
	,ig.member_id
	,ig.obsolete_date
	,ig.obsolete_revision
	,ig.parent_id
	,ig.quantity
	,ig.rate_plan_id
	
	--Parent Item
	,pi.full_name				AS parent_full_name
	,pi.displayname				AS parent_displayname
  ,pi.type_name       AS parent_type_name
	
	--Member Item
	,mi.full_name				AS member_full_name
	,mi.displayname				AS member_displayname
	
FROM `protean-impact-174217.netsuite.item_group`						AS ig
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`					AS pi	ON ig.parent_id = pi.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`					AS mi	ON ig.member_id = mi.item_id
