--synthetic squarespace data
Select 
	*
From 
	squarespace_s
;



Select
	sum(gross_sales) as total_gross_sales_ss
From
	squarespace_s
;

Select
	sum(net_sales) as total_net_sales_ss
From
	squarespace_s
;

--sales by product
Select
	  sum(gross_sales) as total_sales_by_product
	, product_name

From
	squarespace_s
	
Group By
	product_name

Order By
	total_sales_by_product desc
;


--sales by state
Select
	  sum(gross_sales) as total_sales_by_product
	, state_abv

From
	squarespace_s
	
Group By
	state_abv

Order by
	total_sales_by_product desc
;


--sales by state
Select
	sum(total_sales_by_product)

From (
		Select
			  sum(gross_sales) as total_sales_by_product
			, state_abv
			, product_name
		
		From
			squarespace_s
			
		Where
			product_name != 'Anime Mystery Box' 
			and product_name != 'Naruto Hoodie'
		
		Group By
			  state_abv
			, product_name
		
		Having
			--state_abv = 'Texas'
			--state_abv = 'California'
			state_abv = 'Florida'
		
		Order by
			total_sales_by_product desc
	)
;



--total ss refunds
Select
	  sum(refund_amount) as total_ss_refund

From
	squarespace_s
;


--total ss discount
Select
	  sum(discount_amount) as total_refund

From
	squarespace_s
;



--total ss and tt sales by day
Select
	sum(total_sales_overall) as total_between_platforms

From (
		Select 
			  ss.order_date as ss_order_date
			, tts.order_date as tiktok_order_date
			, sum(ss.net_sales) as total_ss_sales
			--, tts.total_sales as total_tiktok_sales --Commented out due to null values
			, coalesce (tts.total_sales, 0) as not_null_total_tiktok_sales
			, sum(ss.net_sales) + (coalesce (tts.total_sales, 0)) as total_sales_overall
		
		From 
			squarespace_s ss
				left join tiktok_s as tts
					on ss.order_date = tts.order_date 
		
		Group By
			  ss.order_date
			, tiktok_order_date
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

--total tiktok sales
Select
	sum(total_sales) as total_tiktok_sales
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