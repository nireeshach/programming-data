#standardSQL

SELECT
	 vi.vendor_item_id
	,vi.case_cube
	,vi.case_height_in
	,vi.case_length_in
	,vi.case_width_in
	,vi.code
	,vi.gross_weight_lb
	,vi.is_inactive
	,vi.item_id
	,vi.item_not_available
	,vi.item_specific_lead_time_id
	,vi.last_modified_date					AS vendor_item_last_modified_date
	,vi.location_id
	,vi.master_case_upc
	,vi.microbial_testing
	,vi.microbial_testing_frequency
	,vi.net_weight_lb
	,vi.next_available_eta
	,vi.notes_from_vendor
	,vi.pack_quantity
	,vi.pack_size
	,vi.pallet_tiehigh
	,vi.preferred
	,vi.purchase_price
	,vi.purchase_units_id
	,vi.purchase_uom_conversion
	,vi.required_shelf_life_for_retur
	,vi.return_fees
	,vi.returns_accepted
	,vi.units_type_id
	,vi.vendor_guaranteed_shelf_life_
	,vi.vendor_item_extid

	-- Vendors
	,v.vendor_id						AS vendor_id
	,v.accept_trading_partner_prices 	AS accept_trading_partner_prices
	,v.account_manager_id 				AS account_manager_id
	,v.additional_information 			AS additional_information
	,v.affiliates_or_subsidiaries 		AS affiliates_or_subsidiaries
	,v.agreement_date 					AS agreement_date
	,v.altphone 						AS altphone
	,v.bill_shipping_to_3rd_party 		AS bill_shipping_to_3rd_party
	,v.bill_shipping_to_recipient 		AS bill_shipping_to_recipient
	,v.billaddress 						AS billaddress
	,v.city 							AS city
	,v.comments 						AS comments
	,v.companyname 						AS companyname
	,v.contract_end_date 				AS contract_end_date
	,v.country 							AS country
	,v.create_date 						AS create_date
	,v.creditlimit 						AS creditlimit
	,v.currency_id 						AS currency_id
	,v.date_last_modified 				AS date_last_modified
	,v.default_ship_method_id 			AS default_ship_method_id
	,v.default_vendor_message 			AS default_vendor_message
	,v.delivery_frequency 				AS delivery_frequency
	,v.edi_capability_id 				AS edi_capability_id
	,v.email 							AS email
	,v.enable_calendar_sync 			AS enable_calendar_sync
	,v.ete_testing 						AS ete_testing
	,v.exclude_customers_from_chefd_ 	AS exclude_customers_from_chefd_
	,v.exclude_from_reporting 			AS exclude_from_reporting
	,v.facilities__plants 				AS facilities__plants
	,v.fax 								AS fax
	,v.full_name 						AS full_name
	,v.hold_harmless_agreement 			AS hold_harmless_agreement
	,v.holiday_closures 				AS holiday_closures
	,v.is1099eligible 					AS is1099eligible
	,v.is_person 						AS is_person
	,v.isemailhtml 						AS isemailhtml
	,v.isemailpdf 						AS isemailpdf
	,v.isinactive 						AS isinactive
	,v.last_modified_date 				AS vendor_last_modified_date
	,v.lead_time 						AS lead_time
	,v.liability_insurance_active 		AS liability_insurance_active
	,v.line1 							AS line1
	,v.line2 							AS line2
	,v.loginaccess 						AS loginaccess
	,v.manufacturersprocessors_purch 	AS manufacturersprocessors_purch
	,v.minimum_ship_cases 				AS minimum_ship_cases
	,v.minimum_ship_dollars 			AS minimum_ship_dollars
	,v.minimum_ship_weight 				AS minimum_ship_weight
	,v.mobile_phone 					AS mobile_phone
	,v.name 							AS name
	,v.next_day_delivery_cutoff_time 	AS next_day_delivery_cutoff_time
	,v.nonnext_day_delivery_cutoff_t 	AS nonnext_day_delivery_cutoff_t
	,v.openbalance 						AS openbalance
	,v.openbalance_foreign 				AS openbalance_foreign
	,v.ordering_instructions 			AS ordering_instructions
	,v.partner_image_id 				AS partner_image_id
	,v.partner_image_type_id 			AS partner_image_type_id
	,v.partner_image_url 				AS partner_image_url
	,v.partner_status_id 				AS partner_status_id
	,v.payment_terms_id 				AS payment_terms_id
	,v.pdp_partner_description 			AS pdp_partner_description
	,v.pdp_partner_tags 				AS pdp_partner_tags
	,v.phone 							AS phone
	,v.printoncheckas 					AS printoncheckas
	,v.priority_id 						AS priority_id
	,v.receiving_frequency 				AS receiving_frequency
	,v.reserve_inventory 				AS reserve_inventory
	,v.royalty_amount_per_meal 			AS royalty_amount_per_meal
	,v.royalty_amount_per_serving 		AS royalty_amount_per_serving
	,v.royalty_lead_or_utm 				AS royalty_lead_or_utm
	,v.royalty_maximum_discount_perc 	AS royalty_maximum_discount_perc
	,v.royalty_percent_of_netgross 		AS royalty_percent_of_netgross
	,v.royalty_structure_id 			AS royalty_structure_id
	,v.sales_priority_id 				AS sales_priority_id
	,v.sales_rep_id 					AS sales_rep_id
	,v.shipaddress 						AS shipaddress
	,v.shopify_tags 					AS shopify_tags
	,v.state 							AS state
	,v.subsidiary 						AS subsidiary
	,v.taxidnum 						AS taxidnum
	,v.total_social_network_reach 		AS total_social_network_reach
	,v.unbilled_orders 					AS unbilled_orders
	,v.unbilled_orders_foreign 			AS unbilled_orders_foreign
	,v.url 								AS url
	,v.vendor_type_id 					AS vendor_type_id
	,v.vip_customer 					AS vip_customer
	,v.zipcode 							AS zipcode
	
	-- Items
	,i.full_name 						AS item_full_name
	,i.displayname 						AS item_displayname

	-- Location
	,l.full_name 						AS location_full_name
	,l.name 							AS location_name
	,l.city 							AS location_city
	,l.parent_id 						AS location_parent_id

	-- Unit Types
	,ut.name 							AS units_type
	

FROM `protean-impact-174217.netsuite.vendor_item`						AS vi
LEFT OUTER JOIN `protean-impact-174217.netsuite.vendors`				AS v	ON v.vendor_id = vi.vendor_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`					AS i	ON i.item_id = vi.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.locations`				AS l	ON l.location_id = vi.location_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.units_type`				AS ut	ON ut.units_type_id = vi.units_type_id
 WHERE vi._fivetran_deleted = False and
v._fivetran_deleted = False and
i._fivetran_deleted = False
