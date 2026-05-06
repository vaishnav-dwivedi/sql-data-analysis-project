 _ _Total Sales By category_ _
   SELECT `Customer Name`  , SUM(Sales) AS Total_Sales
FROM sample_dataset 
GROUP BY `Customer Name` 
Order by Total_Sales desc 
LIMIT 10 ; 


_ _Top 5 Products By Sales _ _
SELECT `Product Name`,
       SUM(Sales) AS Total_Sales,
       RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM sample_dataset
GROUP BY `Product Name`
LIMIT 5 ;

_ _Top 5 Customers With Highest Losses_ _  
SELECT `Product Name` , SUM(Profit) AS Total_Profit
FROM sample_dataset 
GROUP BY `Product Name` 
HAVING Total_Profit < 0 
Order by Total_Profit ASC 
LIMIT 5 ;


_ _Top Customers in every Region _ _
SELECT Region , `Customer Name` , Total_Sales
FROM (
      SELECT Region ,
      `Customer Name` ,
      SUM(Sales) AS Total_Sales,
      RANK() OVER (partition BY Region ORDER BY SUM(Sales) DESC) AS rnk 
      FROM sample_dataset 
      GROUP BY 	Region , `Customer Name` 
      )t
      WHERE rnk = 1 ;

_ _ Classifying Customers  on the Basis Of Sales _ _
SELECT `Customer Name` , SUM(Sales) AS Total_Sales ,
CASE
WHEN SUM(Sales) < 6000 THEN 'low Value Customer'
WHEN SUM(Sales) BETWEEN 5000 AND 8000 THEN 'Medium Value Customer'
ELSE 'High Value Customer '
END AS Customer_Value 
FROM sample_dataset
GROUP BY `Customer Name` 
ORDER BY SUM(Sales) DESC ; 
