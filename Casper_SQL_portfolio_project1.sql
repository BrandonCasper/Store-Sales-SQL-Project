#--------------------------------------------------------Exploratory Data Analysis---------------------------------------------------------
#1 How many unique product lines does the data have?

select distinct product_line 
from sales;

#2 What is the most common payment method?

select payment,
count(invoice_id)
from sales
group by payment
order by count(invoice_id) desc ;

#3 What is the most selling product line?

select product_line,
count(invoice_id) as number_purchases
from sales
group by product_line
order by count(invoice_id) desc
;

#4 What is the total revenue by branch?

select branch,
round(sum(total), 2) as total_rev
from sales
group by branch
order by branch;

#5 What product line had the largest revenue?

select product_line,
round(sum(total), 2) as total_rev
from sales
group by product_line
order by total_rev desc;

#6 What city had the largest revenue?

select city,
round(sum(total), 2) as total_rev
from sales
group by city
order by total_rev desc;

#7 Which product line had the largest tax?

select product_line,
round (avg(tax_pct), 2) as avg_tax
from sales
group by product_line
order by avg_tax desc;

#8 What is the average rating of each product line?

select product_line,
round(avg(rating),1) as avg_rating
from sales
group by product_line
order by avg_rating desc;

#9 What is the most common product line by gender?

select gender, product_line,
count(gender) as purchases
from sales
group by gender, product_line
order by count(gender) desc;

#10 Which branch sold more products than average products sold

select branch,
sum(quantity) as products_sold
from sales
group by branch
having sum(quantity) > (
			select avg(quantity)
            from sales)
 order by sum(quantity) desc;

#11 Fetch each product line and add a column to those product line showing "good", "bad". Good if its greater than average sales.

select 
product_line,
round(avg(total) over(partition by product_line),2) as product_avg,
(case
when round(avg(total) over(partition by product_line),2) > avg(total) then 'good'
else 'bad'
end) as Good_or_Bad
from sales
group by product_line
order by product_avg desc;


#12 Which customer type brought in the most money?

select customer_type,
round(sum(total),1) as total_rev
from sales
group by customer_type
order by total_rev desc;



#13 Which customer type pays the most in tax?

select customer_type,
round(avg(tax_pct),2) as avg_tax_pct
from sales
group by customer_type
order by avg_tax_pct desc;


#14 Which time of day do customers give the best ratings

select time_of_day,
round(avg(rating),1) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

#15 Which time of day do customers give the best ratings per branch

select branch, time_of_day,
round(avg(rating),1)  as avg_rating
from sales
group by branch, time_of_day
order by branch, avg_rating desc;