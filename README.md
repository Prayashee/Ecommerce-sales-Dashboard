# E-commerce Sales & Profit Dashboard (Power BI)

A polished, interview-ready analytics project showcasing e-commerce KPIs and drilldowns. Includes a 65k+ line synthetic retail dataset (2023–2024), DAX measures, SQL mirrors, and a clean page layout you can recreate in Power BI.

![Dashboard Mock](../dashboard_mock.png)

---

## What This Demonstrates
- Business KPIs: GMV, Margin %, AOV, Return Rate
- Insights by Slice: Category, Brand, Region, and Time
- Merch & Promo Readiness: Seasonality peaks and event weeks
- Focus List: Top 10 SKUs by Profit; concentration via Top-Decile Profit SKUs %

---

## Folder Structure
```
ecommerce-sales-dashboard/
├── data/
│   ├── orders.csv          # 65k+ order lines with price, discount, returns, sessions, views
│   ├── products.csv        # 1.2k SKUs with category, brand, base_price, cost_ratio
│   └── calendar.csv        # Date table (year, month, week, is_event flags)
├── powerbi/
│   ├── DAX_measures.md     # KPIs: GMV, Margin %, AOV, CVR, Return Rate, Top-Decile Profit %
│   └── PowerQuery_M.txt    # Power Query script to load/typed CSVs
├── sql/
│   ├── schema.sql          # Optional: warehouse schema mirrors
│   └── queries.sql         # Example queries to reproduce KPIs
└── README.md
```

---

## Quick Start (Power BI Desktop)
1. Get Data -> Text/CSV and load all three files from /data.
2. (Optional) In Transform Data, open Advanced Editor and paste powerbi/PowerQuery_M.txt to set dtypes.
3. Relationships:
   - orders[order_date] -> calendar[date] (Many->1, mark calendar as Date Table)
   - orders[sku] -> products[sku] (Many->1)
4. Create measures by copying from powerbi/DAX_measures.md.
5. Rebuild the page using the wireframe below or your own visual style.

Wireframe:
- KPI bar (top): GMV, Margin %, AOV, Return Rate (Card visuals)
- Left (middle): GMV (Clustered Column) + Margin % (Line, secondary axis) by Month
- Right (middle): CVR & Return Rate by Brand (Clustered Bar)
- Left (bottom): CVR & Return Rate by Region (Clustered Bar)
- Right (bottom): Top 10 SKUs by Profit (Table)
- Slicers: Year, Category, Brand, Region

---

## Measures (DAX)
Copy from powerbi/DAX_measures.md. Core examples:
```DAX
GMV := SUMX(Orders, Orders[units] * Orders[unit_price] * (1 - Orders[discount_pct]))
Margin := [GMV] - SUMX(Orders, Orders[units] * Orders[unit_cost])
Margin % := DIVIDE([Margin], [GMV])
CVR := DIVIDE([Orders], [Views])
Top Decile Profit SKUs % := 
VAR TopSKUs =
    TOPN( ROUNDUP(DIVIDE(DISTINCTCOUNT(Orders[sku]),10),0),
          SUMMARIZE(Orders, Orders[sku], "Profit", [Margin]),
          [Profit], DESC)
VAR TopProfit := SUMX(TopSKUs, [Profit])
RETURN DIVIDE(TopProfit, [Margin])
```

---

## Business Story Talking Points
- Conversion & Returns: "Brand X in Region South shows strong CVR but a higher Return Rate — candidate for fit/size messaging."
- Seasonality: "Event weeks lift GMV; we ramp stock and campaigns accordingly."
- Profit Concentration: "Top 10% SKUs contribute ~Y% of total margin (measure included). Focus on availability and ads for these."
- Next Steps: "Add markdown simulator, CLV cohorts, and anomaly alerts for funnel drops."

## License
MIT
