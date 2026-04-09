-- Q1: Last booked room per user
SELECT user_id, room_no
FROM bookings b1
WHERE booking_date = (
    SELECT MAX(booking_date)
    FROM bookings b2
    WHERE b1.user_id = b2.user_id
);

-- Q2: Billing in November 2021
SELECT b.booking_id,
SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date)=11 AND YEAR(b.booking_date)=2021
GROUP BY b.booking_id;

-- Q3: Bills > 1000
SELECT bill_id,
SUM(item_quantity * item_rate) AS amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bill_date)=10 AND YEAR(bill_date)=2021
GROUP BY bill_id
HAVING amount > 1000;

-- Q4: Most & Least ordered item
SELECT *
FROM (
    SELECT MONTH(bill_date) month,
           item_id,
           SUM(item_quantity) qty,
           RANK() OVER (PARTITION BY MONTH(bill_date) ORDER BY SUM(item_quantity) DESC) r1,
           RANK() OVER (PARTITION BY MONTH(bill_date) ORDER BY SUM(item_quantity)) r2
    FROM booking_commercials
    GROUP BY MONTH(bill_date), item_id
) t
WHERE r1=1 OR r2=1;

-- Q5: 2nd Highest bill
SELECT *
FROM (
    SELECT bill_id,
           MONTH(bill_date) month,
           SUM(item_quantity * item_rate) amount,
           DENSE_RANK() OVER (PARTITION BY MONTH(bill_date) ORDER BY SUM(item_quantity * item_rate) DESC) rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY bill_id, MONTH(bill_date)
) t
WHERE rnk=2;