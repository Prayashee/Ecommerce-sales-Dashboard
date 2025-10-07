
CREATE TABLE products (
  sku TEXT PRIMARY KEY,
  category TEXT,
  brand TEXT,
  base_price NUMERIC,
  cost_ratio NUMERIC
);
CREATE TABLE calendar (
  date DATE PRIMARY KEY,
  year INT, month INT, day INT, dow INT, week INT,
  is_event INT
);
CREATE TABLE orders (
  order_id TEXT,
  order_date DATE REFERENCES calendar(date),
  sku TEXT REFERENCES products(sku),
  category TEXT,
  brand TEXT,
  region TEXT,
  units INT,
  unit_price NUMERIC,
  discount_pct NUMERIC,
  unit_cost NUMERIC,
  returned INT,
  sessions INT,
  product_views INT,
  add_to_cart INT
);
