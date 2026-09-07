-- ============================================================
-- FOUR SQL QUERY USE CASES
-- ============================================================


-- USE CASE 1 (SIMPLE): High-income customers for premium product targeting
-- ------------------------------------------------------------
SELECT first_name, last_name, employment_status, annual_income
FROM CUSTOMER
WHERE annual_income > 100000
ORDER BY annual_income DESC;


-- ------------------------------------------------------------
-- USE CASE 2 (SIMPLE): Fixed-rate loan products under 6%
-- Scenario: A broker wants to quickly shortlist competitive fixed-rate
-- products to recommend to a rate-sensitive first-home-buyer client.
-- Single table, WHERE clause with a Boolean operator (AND) combining an
-- equality/IN check and a comparison operator.
-- ------------------------------------------------------------
SELECT product_name, interest_rate_type, base_interest_rate, max_lvr
FROM LOAN_PRODUCT
WHERE interest_rate_type = 'Fixed'
  AND base_interest_rate < 6.0
ORDER BY base_interest_rate ASC;


-- ------------------------------------------------------------
-- USE CASE 3 (MODERATELY COMPLEX): Broker pipeline report
-- Scenario: A broker manager wants a report of every mortgage
-- application, showing the customer, the broker handling it, the
-- property involved and the lender/product being applied for, so
-- they can review the current pipeline at a glance.
-- Joins 3+ tables.
-- ------------------------------------------------------------
SELECT
    ma.application_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    b.first_name || ' ' || b.last_name AS broker_name,
    p.suburb || ', ' || p.state AS property_location,
    lp.product_name,
    l.lender_name,
    ma.requested_amount,
    ma.application_status
FROM MORTGAGE_APPLICATION ma
JOIN CUSTOMER c        ON ma.customer_id = c.customer_id
JOIN BROKER b           ON ma.broker_id = b.broker_id
JOIN PROPERTY p          ON ma.property_id = p.property_id
JOIN LOAN_PRODUCT lp     ON ma.product_id = lp.product_id
JOIN LENDER l            ON lp.lender_id = l.lender_id
ORDER BY ma.application_date;


-- ------------------------------------------------------------
-- USE CASE 4 (COMPLEX): Loans priced below the portfolio average rate
-- Scenario: The credit risk team wants to identify which active loans
-- were written at a more competitive (lower) interest rate than the
-- average rate across the whole active loan book, along with the
-- customer, to review pricing consistency.
-- Uses a 1-level nested subquery in the WHERE clause.
-- ------------------------------------------------------------
SELECT
    l.loan_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    l.loan_amount,
    l.interest_rate,
    l.loan_status
FROM LOAN l
JOIN MORTGAGE_APPLICATION ma ON l.application_id = ma.application_id
JOIN CUSTOMER c ON ma.customer_id = c.customer_id
WHERE l.interest_rate < (
    SELECT AVG(interest_rate)
    FROM LOAN
    WHERE loan_status = 'Active'
)
AND l.loan_status = 'Active'
ORDER BY l.interest_rate ASC;
