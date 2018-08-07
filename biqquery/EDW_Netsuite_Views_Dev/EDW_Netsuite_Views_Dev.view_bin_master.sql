SELECT
	 bnc.bin_id
	,bnc.bin_number
	,bnc.item_id
	,bnc.location_id
	,bnc.available_count
	,bnc.on_hand_count

	--Items
	,i.full_name			AS item_full_name
	,i.displayname			AS item_displayname
	,i.name					AS item_name
	
	--Locations
	,l.full_name			AS location_full_name
	,l.name					AS location_name
	,l.city					AS location_city
	,l.parent_id			AS location_parent_id
	,clt.list_item_name		AS chefd_location_type
	
	
FROM `protean-impact-174217.netsuite.bin_number_counts`					AS bnc
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`					AS i		ON bnc.item_id = i.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.locations`				AS l		ON bnc.location_id = l.location_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.chefd_location_type`	AS clt		ON l.chefd_location_type_id = clt.list_id
where i._fivetran_deleted = false 
and clt._fivetran_deleted = false
