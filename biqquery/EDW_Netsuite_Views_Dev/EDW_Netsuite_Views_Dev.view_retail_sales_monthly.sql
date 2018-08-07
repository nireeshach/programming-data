select 
  tt.rtl_month_year,
  tt.tran_date,
  tt.order_number,
  tt.transaction_line_id,
  tt.sales_amount,
  tt.item_code,
  tt.item_count,
  tt.rtl_conversion_factor,
  tt.order_status,
  tt.account_name,
  tt.account_full_name,
  tt.rtl_monthly_sales_amount,
  tt.pct_of_revenue,
  case 
    when tt.item_code like 'RTL.%' or tt.item_code like 'GR.%' then ar.ar_rtl_monthly_revenue 
    else null end 
    as ar_rtl_monthly_revenue,
  tt.pct_of_revenue * ar_rtl_monthly_revenue as adjusted_revenue,
  safe_divide((tt.pct_of_revenue * ar_rtl_monthly_revenue),(tt.item_count*rtl_conversion_factor)) as avg_rev_per_unit

from
# TRANSACTIONS FROM view_SalesOrders_TransactionsDetail
  (select 
    t.*, 
    case 
      when t.item_code like 'RTL.%' or t.item_code like 'GR.%' then mv.monthly_sales_amount 
      else null end 
      as rtl_monthly_sales_amount, 
    case 
      when t.item_code like 'RTL.%' or t.item_code like 'GR.%' then safe_divide(t.sales_amount, mv.monthly_sales_amount) 
      else null end 
      as pct_of_revenue -- pct of sales order revenue for retail for month
  from 
    `tetris-effect-203015.EDW_Netsuite_Views.view_SalesOrders_TransactionsDetail` t

  # MONTHLY SALES ORDER TOTALS RETAIL
  left join 
      (SELECT 
        extract(year from tran_date) as year, 
        extract(month from tran_date) as month,
        sum(sales_amount) as monthly_sales_amount
      FROM `tetris-effect-203015.EDW_Netsuite_Views.view_SalesOrders_TransactionsDetail`
      where item_code like 'RTL.%' or item_code like 'GR.%'
      group by 1,2
      -- order by 1 desc
      ) mv    
  on t.rtl_month_year = date(mv.year,mv.month,1)
  ) tt

# ACCOUNTS RECEIVABLE SUMMARY
left join
  (SELECT 
    extract(year from trandate) as year,
    extract(month from trandate) as month,
    sum(amount)*-1 as ar_rtl_monthly_revenue
  FROM `tetris-effect-203015.Fivetran_Netsuite_Views.Transactions` 
  where 
    (tl_account_full_name = 'Sales : Retail : Gelson\'s' and transaction_type = 'Invoice')
    or (tl_account_full_name = 'Sales : Retail : Smithfield' and transaction_type in ('Invoice','Journal'))
  group by 1, 2
  ) ar
on tt.rtl_month_year = date(ar.year,ar.month,1)

where tt.item_code like 'RTL.%' or tt.item_code like 'GR.%'

