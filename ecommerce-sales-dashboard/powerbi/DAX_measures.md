# DAX Measures
GMV := SUMX(Orders, Orders[units] * Orders[unit_price] * (1 - Orders[discount_pct]))
Gross Cost := SUMX(Orders, Orders[units] * Orders[unit_cost])
Margin := [GMV] - [Gross Cost]
Margin % := DIVIDE([Margin], [GMV])
Orders := DISTINCTCOUNT(Orders[order_id])
Units := SUM(Orders[units])
AOV := DIVIDE([GMV], [Orders])
Return Units := SUMX(Orders, Orders[units] * Orders[returned])
Return Rate := DIVIDE([Return Units], [Units])
Sessions := SUM(Orders[sessions])
Views := SUM(Orders[product_views])
AddsToCart := SUM(Orders[add_to_cart])
CVR := DIVIDE([Orders], [Views])
Event GMV := CALCULATE([GMV], 'Calendar'[is_event] = 1)
Non-Event GMV := CALCULATE([GMV], 'Calendar'[is_event] = 0)
YoY GMV := CALCULATE([GMV], SAMEPERIODLASTYEAR('Calendar'[date]))
Top Decile Profit SKUs % := 
VAR TopSKUs =
    TOPN( ROUNDUP(DIVIDE(DISTINCTCOUNT(Orders[sku]),10),0),
          SUMMARIZE(Orders, Orders[sku], "Profit", [Margin]),
          [Profit], DESC)
VAR TopProfit := SUMX(TopSKUs, [Profit])
RETURN DIVIDE(TopProfit, [Margin])