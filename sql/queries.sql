
WITH line AS (
  SELECT
    o.*,
    (units * unit_price * (1 - discount_pct)) AS gmv,
    (units * unit_cost) AS cost
  FROM orders o
)
SELECT
  c.year, c.month, o.category,
  SUM(line.gmv) AS gmv,
  SUM(line.gmv - line.cost) AS margin,
  COUNT(DISTINCT line.order_id) AS orders,
  CAST(COUNT(DISTINCT line.order_id) AS FLOAT) / NULLIF(SUM(line.product_views),0) AS cvr
FROM line
JOIN calendar c ON c.date = line.order_date
JOIN orders o ON o.order_id = line.order_id
GROUP BY c.year, c.month, o.category
ORDER BY c.year, c.month, o.category;

-- Top 10% SKUs profit share
WITH profit AS (
  SELECT sku, SUM(units * unit_price * (1 - discount_pct) - units * unit_cost) AS profit
  FROM orders
  GROUP BY sku
),
ranked AS (
  SELECT p.*, NTILE(10) OVER (ORDER BY profit DESC) AS decile
  FROM profit p
)
SELECT
  SUM(CASE WHEN decile = 1 THEN profit ELSE 0 END) / SUM(profit) AS top_decile_profit_share
FROM ranked;
