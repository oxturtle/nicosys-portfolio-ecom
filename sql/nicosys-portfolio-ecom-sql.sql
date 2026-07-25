/*
Business Question
Stakeholder
Purpose
SQL Query
Findings:
Business Insight 
*/







/*
Business Question:
What is the total gross and net sales from Squarespace and TikTok Shop?

Stakeholder:
Owner of e-commerce business

Purpose:
To see what the business total gross and net sales are from Squarespace platfrom.

SQL Query: Query Below

Findings:
Squarespace: Total Gross Sales: $379,500.00 | Total Net Sales: $339,287.77
TikTok shop export only contained gross sales: Total Gross Sales $968,587.16

Business Insight:
TikTok Shop generates 74% of business sales while Squarespace generates the remaining 26%.
TikTok shop didn't have gross sales data. Squarespace gross sales were 

*/

--Total Gross and Net Squarespace sales
Select
	  sum(gross_sales) as total_gross_sales_ss
	, sum(net_sales) as total_net_sales_ss
	, sum(gross_sales) - sum(net_sales) as total_taxes_and_fees
From
	squarespace_s
;


--total tiktok sales
Select
	sum(total_sales) as total_gross_tiktok_sales
From
	tiktok_s
;

--Sales by Platform and Total Sales Overall 
Select
	  sum(total_tts_sales_clean) as total_tts_sales
	, sum(total_ss_sales) as total_ss_sales
	, sum(total_tts_sales_clean) + sum(total_ss_sales) as total_biz_sales 
From
	(--Query showing daily sales between TikTok Shop and Squarespace
		Select
			  ss.order_date as order_date --Since Squarespace data has more days of year reported, will use date field to represent both shops
			  , sum(ss.net_sales) as total_ss_sales
			--, tts.order_date as tt_order_date --commented out becuase we only need 1 date column to represent each store
			--, tt.total_sales as total_tt_sales --commented out due to null values
			, coalesce (tts.total_sales,0) as total_tts_sales_clean
			, sum(ss.net_sales)+(coalesce (tts.total_sales,0)) as total_sales_overall

		From
			squarespace_s ss
				left join tiktok_s as tts
					on ss.order_date=tts.order_date
		Group By
			  ss.order_date
			, tts.order_date
			, tts.total_sales
		Order By
			ss.order_date
	)
;


/*
Business Question:
What are the top selling products?

Stakeholder:
Owner of e-commerce business

Purpose:
To define which products are selling most. 

SQL Query: query below 

Findings:

Business Insight 
*/

--sales by product
Select
	  sum(gross_sales) as total_sales_by_product
	, product_name
From
	squarespace_s
Group by
	product_name
Order By
	total_sales_by_product desc
;




/*
Business Question
Stakeholder
Purpose
SQL Query
Findings:
Business Insight 
*/


/*
Business Question:
What are the top purchasing states? 
Stakeholder
Purpose
SQL Query
Findings:
Business Insight 
*/

--Total sales by state
Select 
	  sum(ss.gross_sales) as total_sales_by_product
	, ss.state
From
	squarespace_s ss
Group By
	ss.state
Order By
	total_sales_by_product desc
;



--Highest Sales by product from Top 3 Selling States 
Select
	sum(total_sales_by_product) Total_sales_top_states_products
From 
	(
		Select
			  sum(ss.gross_sales) as total_sales_by_product
			, ss.state
			, ss.product_name

		From
			squarespace_s ss
		
		Where
			product_name in ('Anime Mystery Box', 'Naruto Hoodie') 

		Group By
			  ss.state
			, product_name
		Having
			ss.state in ('Texas', 'California', 'Florida')

		Order By
			total_sales_by_product desc
	)
;


--Within the highest purchasing states, what products accunted for the most sales? 
--Products sold in top purcashing states
Select
			  sum(ss.gross_sales) as total_sales_by_product
			, ss.state
			, ss.product_name

		From
			squarespace_s ss
		
		--Where
		--	product_name in ('Anime Mystery Box', 'Naruto Hoodie') 

		Group By
			  ss.state
			, product_name
		Having
			ss.state in ('Texas', 'California', 'Florida')

		Order By
			total_sales_by_product desc


--total ss refunds
Select
	sum(ss.refund_amount) as total_ss_refund

From
	squarespace_s ss
;


--total ss discount
Select
	sum(ss.discount_amount) as total_refund

From
	squarespace_s ss
;



--total ss and tt sales by day
Select
	sum(total_sales_overall) as total_tts_and_ss
From
	(--the subquery code to show combined order dates and totals between ss and tts
		Select
			  ss.order_date as ss_order_date
			, tts.order_date as tt_order_date
			, sum(ss.net_sales) as total_ss_sales
			--, tt.total_sales as total_tt_sales --commented out due to null values
			, coalesce (tts.total_sales,0) as not_null_total_tts_sales
			, sum(ss.net_sales)+(coalesce (tts.total_sales,0)) as total_sales_overall

		From
			squarespace_s ss
				left join tiktok_s as tts
					on ss.order_date=tts.order_date
		Group By
			  ss.order_date
			, tts.order_date
			, tts.total_sales
		Order By
			ss.order_date
	)
;



--synthetic tiktok data
Select 
	*
From 
	tiktok_s
;





Create Table squarespace_s (
	  order_id varchar (55)
	, order_date date
	, product_name varchar(55)
	, quantity int
	, unit_price decimal (12,2)
	, gross_sales decimal (12,2)
	, discount_amount decimal (12,2)
	, refund_amount decimal (12,2)
	, net_sales decimal (12,2)
	, state varchar (55)
)
; 


Create Table tiktok_s (
	  order_date date
	, total_sales decimal (12,2)
)
; 