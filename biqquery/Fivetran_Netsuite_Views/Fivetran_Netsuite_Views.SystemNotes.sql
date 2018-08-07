#standardSQL
SELECT author_id
	,company_id
	,custom_field
	,date_created
	,event_id
	,item_id
	,line_id
	,line_transaction_id
	,name
	,note_type_id
	,operation
	,record_id
	,record_type_id
	,role_id
	,standard_field
	,transaction_id
	,value_new
	,value_old
	,DATE(date_created)		AS partition_key

FROM `protean-impact-174217.netsuite.system_notes`
