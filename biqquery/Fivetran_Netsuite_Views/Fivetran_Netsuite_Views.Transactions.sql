#standardSQL
WITH cte_transaction_inventory_numbers AS (
	SELECT   transaction_id
			, transaction_line
			,STRING_AGG(tin.inventory_number, ",")	AS inventory_numbers
			
	FROM `protean-impact-174217.netsuite.transaction_inventory_numbers`	AS tin
	
	GROUP BY transaction_id, transaction_line
	
), cte_transaction_bin_numbers AS (
	SELECT   transaction_id
			, transaction_line
			,STRING_AGG(tbn.bin_number, ",")		AS bin_numbers
			
	FROM `protean-impact-174217.netsuite.transaction_bin_numbers`	AS tbn
	
	GROUP BY transaction_id, transaction_line
	
)
SELECT

--Transaction
t.ab_test,t.account_based_number,t.account_copy_id,t.accounting_book_id,t.accounting_period_id,t.actual_shipping_carrier,t.actual_shipping_cost,t.actual_shipping_service,t.amount_unbilled,t.amz_deliverby_enddate,t.amz_deliverby_startdate,t.amz_shipby_enddate,t.amz_shipby_startdate,t.approval_box,t.auto_control,t.available_for_bulk_fulfill,t.back_order_demand,t.back_ordered_next_ship_day,t.back_ordered_today,t.bill_after_datetime,t.bill_pay_transaction,t.bill_shipping_to_3rd_party,t.bill_shipping_to_recipient,t.billaddress,t.billing_error,t.box_weights,t.build_needed_by,t.buyer_accepts_marketing,t.cancellation_reason,t.carrier_transportation_method,t.closed,t.company_status_id,t.complete_orders,t.cordial_order_created,t.country_of_origin_label,t.create_date,t.create_in_shopify_datetime,t.created_by_id,t.created_from_id,t.currency_id,t.custom_form_id,t.customer_order_count,t.date_last_modified,t.date_sent,t.deadline_email_text,t.delivery_date,t.dont_process_shipping_details,t.due_date,t.email,t.email_subject,t.end_date,t.entity_id,t.error_notes,t.errors_0,t.ete_testing,t.exchange_rate,t.exclude_from_cost_calculation,t.excluded_line_id_numbers,t.expected_close,t.external_ref_number,t.extra_large_box_quantity,t.extra_large_insert_qty,t.extra_large_liner_qty,t.fax,t.fob,t.forecast_type,t.fulfillment_shipping_cost,t.gift_card_amount,t.high_priority_order,t.include_in_forecast,t.incoterm,t.is_advanced_intercompany,t.is_autocalculate_lag,t.is_compliant,t.is_created_from_merge,t.is_finance_charge,t.is_firmed,t.is_intercompany,t.is_merged_into_arrangements,t.is_non_posting,t.is_payment_hold,t.is_reversal,t.is_tax_reg_override,t.is_wip,t.job_id,t.large_box_quantity,t.large_gel_brick_quantity,t.large_insert_qty,t.large_liner_qty,t.last_modified_date,t.lead_source_id,t.lines_to_pick,t.location_id,t.meal_plan_id,t.meals_swapped_from,t.memo,t.memorized,t.message,t.needs_bill,t.needs_revenue_commitment,t.notes_zip,t.notified_customer__replacemen,t.opening_balance_transaction,t.order_created_date,t.order_fulfillment_in_progress,t.order_problem,t.order_type,t.original_delivery_date,t.pack_end_time,t.pack_start_time,t.packaging_added,t.packer_id,t.partner_order_id,t.payment_gateways,t.payment_terms_id,t.pick_locked_by,t.pick_start_time,t.pick_type_id,t.platform,t.po_date,t.po_type,t.portioning_machine_temp_id,t.preferred_location_id,t.prepacker,t.previous_order_date,t.priority,t.priority_level,t.probability,t.production_line,t.projected_total,t.published_shipping_cost,t.qa_verified,t.qc_approval_required,t.queued_for_cross_references,t.ready_for_edi,t.reason_for_adjustment_id,t.recipe_cards_printed,t.recommended_box_type_id,t.redeemed_gift_card_last_4,t.related_tranid,t.renewal,t.requested_delivery_date,t.required_finished_shelf_life,t.reserve_inventory_for_id,t.revenue_commitment_status,t.revenue_committed,t.revenue_status,t.reversing_transaction_id,t.royalties_calculated,t.sales_effective_date,t.sales_rep_id,t.sent_tracking_to_shopify,t.ship_to_code,t.ship_to_code_qualifier,t.shipaddress,t.shipment_received,t.shipping_item_id,t.shopify_address_type,t.shopify_avs_result_code,t.shopify_credit_card_bin,t.shopify_credit_card_company,t.shopify_credit_card_number,t.shopify_cvv_result_code,t.shopify_discount_code,t.shopify_financial_status,t.shopify_landing_site,t.shopify_name,t.shopify_note,t.shopify_note_attributes,t.shopify_order_id,t.shopify_order_number,t.shopify_referring_site,t.shopify_reorder,t.shopify_source_name,t.shopify_token,t.skip_status,t.small_box_quantity,t.small_gel_brick_quantity,t.small_insert_qty,t.small_liner_qty,t.solochain_order_status_id,t.special_delivery_instructions,t.sps_routing_key,t.start_date,t.status,t.store_reference,t.storefront,t.storefront_order,t.stripe_charge_id,t.subscription_id,t.suppress_shipping_email,t.title,t.trandate,t.tranid,t.trans_is_vsoe_bundle,t.transaction_extid,t.transaction_id,t.transaction_number,t.transaction_partner,t.transaction_purpose,t.transaction_source,t.transaction_type,t.transfer_location,t.uploaded_tracking_,t.urgent,t.use_item_cost_as_transfer_cost,t.vendor_confirmed_delivery_dat,t.vendor_number,t.vip_order,t.visible_in_customer_center,t.weighted_total,t.work_order_complete,t.work_order_in_progress,t.work_order_type_id,

--TransactionLines
tl.account_id AS tl_account_id,tl.amount,tl.amount_foreign,tl.amount_foreign_linked,tl.amount_linked,tl.amount_pending,tl.amount_settlement,tl.amount_taxed,tl.bill_variance_status,tl.bom_quantity,tl.case_net_weight_lb,tl.company_id,tl.component_id,tl.component_yield,tl.cost_estimate_type,tl.date_cleared,tl.date_closed,tl.date_created,CAST(NULL as TIMESTAMP) AS tl_date_last_modified,CAST(NULL as TIMESTAMP) AS date_last_modified_gmt,tl.date_revenue_committed,tl.delay_rev_rec,tl.department_id,tl.do_not_display_line,tl.do_not_print_line,tl.do_restock,tl.error_type_id,tl.estimated_cost,tl.estimated_cost_foreign,tl.expected_receipt_date,tl.expense_category_id,tl.gross_amount,tl.has_cost_line,tl.isbillable,tl.iscleared,tl.isnonreimbursable,tl.istaxable,tl.is_allocation,tl.is_amortization_rev_rec,tl.is_commitment_confirmed,tl.is_cost_line,tl.is_exclude_from_rate_request,tl.is_fx_variance,tl.is_item_value_adjustment,tl.is_landed_cost,tl.is_scrap,tl.is_vsoe_allocation_line,tl.item_count,tl.item_id AS tl_item_id,tl.item_received,tl.item_source,tl.item_unit_price,tl.kit_part_number,tl.location_id AS tl_location_id,tl.match_bill_to_receipt,tl.memo AS tl_memo,tl.needs_revenue_element,tl.net_amount,tl.net_amount_foreign,tl.non_posting_line,tl.number_billed,tl.order_priority,tl.pack_size,tl.payment_method_id,tl.period_closed,tl.quantity_committed,tl.quantity_packed,tl.quantity_picked,tl.quantity_received_in_shipment,tl.rate_for_shopify,tl.receivebydate,tl.rejected,tl.royalty_amount,tl.shipdate,tl.shipment_received AS tl_shipment_received,tl.shipping_group_id,tl.subsidiary_id,tl.tax_item_id,tl.tax_type,tl.tobeemailed,tl.tobefaxed,tl.tobeprinted,tl.transaction_discount_line,tl.transaction_line_id,tl.transaction_order,tl.transfer_order_item_line,tl.transfer_order_line_type,tl.unique_key,tl.unit_of_measure_id,tl.vendor_code,tl.vsoe_delivered,tl.weight_received_pounds

	--Accounts (T/TL)
	,a.full_name 					AS account_copy_full_name
	,a.name 						AS account_copy_name
	,a.type_name					AS account_copy_type_name
	,a.parent_id					AS account_copy_parent_id
	,a.accountnumber				AS account_copy_number
	,a2.full_name 					AS tl_account_full_name
	,a2.name 						AS tl_account_name
	,a2.type_name					AS tl_account_type_name
	,a2.parent_id					AS tl_account_parent_id
	,a2.accountnumber				AS tl_account_number
	
	--Entity (T)
	,en.full_name					AS entity_full_name
	,en.name						AS entity_name
	,en.email						AS entity_email
	,en.state						AS entity_state
	,en.city						AS entity_city
	,en.zipcode						AS entity_zipcode

	--Locations (T/TL)
	,l.full_name					AS location_full_name
	,l.name							AS location_name
	,l.city							AS location_city
	,l.parent_id					AS location_parent_id
	,clt.list_item_name				AS chefd_location_type
	,l2.full_name					AS tl_location_full_name
	,l2.name						AS tl_location_name
	,l2.city						AS tl_location_city
	,l2.parent_id					AS tl_location_parent_id
	,clt2.list_item_name			AS tl_chefd_location_type

	--Employees (T)
	,em.name						AS employee_name
	,em.supervisor_id				AS employee_supervisor_id
	,em.jobtitle					AS employee_jobtitle

	--Adjustment Reason Codes (T)
	,arc.list_item_name				AS reason_for_adjustment

	--Shipping Items (T)
	,si.name						AS shipping_item_name
	,si.display_name				AS shipping_item_displayname
	,si.full_name					AS shipping_item_full_name
	
	--Work Order Types (T)
	,wot.list_item_name				AS work_order_type

	--Items (TL)
	,i.full_name					AS tl_item_full_name
	,i.displayname					AS tl_item_displayname
	,i.name							AS tl_item_name
	,i.type_name					AS tl_item_type_name

	--UOM (TL)
	,u.name							AS unit_of_measure_name
	,u.plural_name					AS unit_of_measure_plural_name

	--Transaction Inventory Numbers
	,ctetin.inventory_numbers
	
	--Transaction Bin Numbers
	,ctetbn.bin_numbers
	
	--Created By ID
	,cbi.name						AS created_by_name
	
	--Customers
	,c.full_name					AS customer_full_name
	,c.customer_extid				AS customer_shopify_id
	
	--Vendors
	,v.vendor_id					AS vendor_id
	,v.companyname					AS vendor_company_name
	,v.full_name					AS vendor_full_name
	,v.labor_cost					AS vendor_labor_cost
	,v.priority_id					AS vendor_priority_id
	,v.recipe_id					AS vendor_recipe_id
	,v.royalty_amount_per_serving	AS vendor_royalty_amount_per_serving
	,v.state						AS vendor_state
	,v.vendor_type_id				AS vendor_type_id
	
	
	--Partition Key
	,DATE(tl.date_created)	AS partition_key

FROM `protean-impact-174217.netsuite.transaction_lines`							AS tl
LEFT OUTER JOIN `protean-impact-174217.netsuite.transactions`					AS t		ON t.transaction_id = tl.transaction_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.accounts`						AS a		ON t.account_copy_id = a.account_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.entity`							AS en		ON t.entity_id = en.entity_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.locations`						AS l		ON t.location_id = l.location_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.chefd_location_type`			AS clt		ON l.chefd_location_type_id = clt.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.employees`						AS em		ON t.packer_id = em.employee_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.adjustment_reason_codes`		AS arc		ON t.reason_for_adjustment_id = arc.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.shipping_items`					AS si		ON t.shipping_item_id = si.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.work_order_type`				AS wot		ON t.work_order_type_id = wot.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.accounts`						AS a2		ON tl.account_id = a2.account_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.items`							AS i		ON tl.item_id = i.item_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.locations`						AS l2		ON tl.location_id = l2.location_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.chefd_location_type`			AS clt2		ON l2.chefd_location_type_id = clt2.list_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.uom`							AS u		ON tl.unit_of_measure_id = u.uom_id
LEFT OUTER JOIN `cte_transaction_inventory_numbers`								AS ctetin	ON tl.transaction_id = ctetin.transaction_id AND tl.transaction_line_id = ctetin.transaction_line
LEFT OUTER JOIN `cte_transaction_bin_numbers`									AS ctetbn	ON tl.transaction_id = ctetbn.transaction_id AND tl.transaction_line_id = ctetbn.transaction_line
LEFT OUTER JOIN `protean-impact-174217.netsuite.entity`							AS cbi		ON t.created_by_id = cbi.entity_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.customers`						AS c		ON t.entity_id = c.customer_id
LEFT OUTER JOIN `protean-impact-174217.netsuite.vendors`						AS v		ON t.entity_id = v.vendor_id
--LEFT OUTER JOIN `protean-impact-174217.netsuite.vendor_item`						AS vi		ON t.entity_id = vi.vendor_id AND tl.item_id = vi.item_id AND tl.location_id = vi.location_id

WHERE t._fivetran_deleted = False
