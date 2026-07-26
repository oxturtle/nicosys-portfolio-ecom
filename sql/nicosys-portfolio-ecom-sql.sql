


/*
Business Question:
What is the total gross and net sales from Squarespace and TikTok Shop?

Stakeholder:
Owner of e-commerce business

Purpose:
To see what the business total gross and net sales are from Squarespace and TikTok Shop platfroms.

SQL Query: Query Below

Findings:
Squarespace: Total Gross Sales: $379,500.00 | Total Net Sales: $339,287.77
TikTok Shop export only contained gross sales: Total Gross Sales $968,587.16

Business Insight:
TikTok Shop generated 74% of business sales while Squarespace made up the remaining 26%.
TikTok Shop didn't have gross sales data, only net. Squarespace gross sales were $379,500.00.
TikTok Shop's total net sales were $968,587.16, and Squarespace net sales were $339,287.77. 
The total sales overall for the company was $1,307,874.93. 

Recommendation:
On TikTok Shop and Squarespace, define the products that are responsible for generating the most sales, and then allocate more of the marketing budget towards those products. 
Further investigate Squarespace operational metrics and marketing to try and increase sales from Squarespace.
Obtain gross sales data from TikTok to get a better metric of overall TikTok income versus expenese.  
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
	sum(total_sales) as total_tiktok_sales
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
The top two highest selling products are Anime Mystery Box at $147,120.00 and Naruto Hoodie at $134,805.00.
The second highest selling products are MHA Backpack at $29,904.00 and One Piece Figure at $21,035.00.
Third highest selling products are Attack on Titan T-shirt at $18,200.00 and Dragon Ball Z Hat at $13,420.00
The bottom selling products are Demon Slayer Poster at $9,240.00 and Jujutsu Kaisen Keychain at $5,776.00

Business Insight 
Out of the 8 products sold on Squarespace, the highest sales of $147,120.00 are generated from Anime Mystery Box.
Anime Mystery Box makes up 39% (38.76%) of sales on Squarespace. 
Anime Mystery Box and Naruto Hoodie product sells at least 30% more than all other products.
Products are being sold within the 6, 5, and 4-figure ranges. 

Recommendation:
Reduce marketing budget from two lowest selling products, Demon Slayer Poster and Jujutsu Kaisen Keychain, and reallocate to 2 highest selling products. 
Futher investigate other 6 products to figure out how to increase sales. 

*/



--All sales by product | Top Selling Products | Total Sales: 379500
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
Business Question:
What are the top purchasing states? 

Stakeholder: Owner of E-commerce business. 

Purpose: To know how much states are purchsing and what are the top purchasing states. 

SQL Query: Query Below

Findings:
Texas purchased $83,919 worth of product.
California purchased $75,913 worth of product.
Florida purchased $73,809 worth of product. 

Business Insight:
Three states (TX, CA, and FL) were the only ones puchasing products totaling in 5-figures, while all other 17 states purchased within 4-figure amounts.
The top 3 highest purchasing states are responsbile for approximately 18% more sales than all other 17 states that buy from Squarespace.

Reccomendation:
Look at the top selling products for TX, CA, and FL and allocate more of marketing budget towards them. 
Investigate other products and/or opportunities to sell to states such as live events if visiting state(s). 

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



/*
Business Question:
What are the top selling products from the 3 top purchasing states?

Stakeholder: Owner of e-commerce business

Purpose:
To define the top selling prducts within highest purchasing states. 

SQL Query: Query Below 

Findings:
Texas' highest sales of $33,780 are generated from Anime Mystery Box purchases. 
California's highest sales of $30,780 are generated from Anime Mystery Box purchases.
Florida's highest sales of $27,420 are generated from Naruto Hoodie purchases. 

Business Insight:
The top selling products from Texas, California, and Florida were Anime Mystery Box and Naruto Hoodie. 

Recommendation:
Investigate other products and look into how to increase sales, or reallocate market funds to higher selling products.  
*/


--Highest Sales by product from Top 3 Selling States 
--Anime Mystery Box | Naruto Hoodie 
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
		
		--Where
		--	product_name in ('Anime Mystery Box', 'Naruto Hoodie') 

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













--SQL Code below are extra 

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