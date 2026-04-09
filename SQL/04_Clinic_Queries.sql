-- Q1 Revenue by channel
SELECT sales_channel, SUM(amount)
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY sales_channel;

-- Q2 Top 10 customers
SELECT uid, SUM(amount) total
FROM clinic_sales
GROUP BY uid
ORDER BY total DESC
LIMIT 10;

-- Q3 Profit/Loss
SELECT m.month, m.revenue, e.expense,
(m.revenue - e.expense) profit,
CASE WHEN (m.revenue - e.expense)>0 THEN 'Profit'
ELSE 'Loss' END status
FROM
(SELECT MONTH(datetime) month, SUM(amount) revenue
 FROM clinic_sales GROUP BY MONTH(datetime)) m
JOIN
(SELECT MONTH(datetime) month, SUM(amount) expense
 FROM expenses GROUP BY MONTH(datetime)) e
ON m.month = e.month;

-- Q4 Most profitable clinic
SELECT *
FROM (
    SELECT cid, SUM(amount) profit,
    RANK() OVER (ORDER BY SUM(amount) DESC) rnk
    FROM clinic_sales
    GROUP BY cid
) t WHERE rnk=1;

-- Q5 Second least profitable
SELECT *
FROM (
    SELECT cid, SUM(amount) profit,
    DENSE_RANK() OVER (ORDER BY SUM(amount)) rnk
    FROM clinic_sales
    GROUP BY cid
) t WHERE rnk=2;