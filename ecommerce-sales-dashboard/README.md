
# E-commerce Sales & Profit Dashboard (Power BI)

A ready-to-demo project for Business Analyst interviews (e-commerce). Includes synthetic data (≥65k order lines), DAX measures, and SQL mirroring Power BI logic.

## Highlights
- Interactive slices by **Category / Brand / Region**
- KPIs: **GMV, Margin %, CVR, Return Rate, AOV**
- **Top-decile SKU profit share** and **seasonality/event peaks**

## Quick Start (Power BI)
1) Clone/download repo. In Power BI Desktop: **Get Data → Text/CSV** and load all three `/data` files.
2) (Optional) Paste `powerbi/PowerQuery_M.txt` into **Advanced Editor** of each query.
3) Create relationships: `orders[sku]→products[sku]`, `orders[order_date]→calendar[date]`.
4) Copy measures from `powerbi/DAX_measures.md`.
5) Build visuals: GMV/Margin% trends, CVR & Return Rate by Brand/Region, Top 10 SKUs by Profit, KPI cards.

## Data
- `orders.csv` — 2023–2024 orders with units, price, discount, returns, sessions/views/add-to-cart
- `products.csv` — 1.2k SKUs with base price & cost ratio
- `calendar.csv` — date table with **is_event** flag

## SQL
See `/sql/schema.sql` and `/sql/queries.sql` for schema and example analytics queries.

## Interview Talking Points
- “Built Power BI dashboard with DAX (GMV, Margin %, CVR, Returns) across Category/Brand/Region.”
- “Computed **Top-decile SKUs profit share**; identified seasonality peaks for event planning.”
- “Data size: **65k+** rows; relationships + date table; measures optimized with **SUMX** and **CALCULATE**.”

MIT License.
