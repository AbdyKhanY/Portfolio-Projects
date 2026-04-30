📊 Business Insights & Analysis

The processed stock dataset was analyzed using SQL queries in Amazon Athena to extract meaningful financial insights and support data-driven decision-making.

🔹 Key Insights
Average Market Price:
The stock maintained an average closing price of ~$264, indicating a relatively stable trading range.
Price Extremes:
Highest price: $288.62 (Dec 3, 2025)
Lowest price: $243.42 (Jan 20, 2026)
👉 This reflects a moderate price spread and controlled market movement.
Volatility & Risk:
Average daily volatility: ~5.24
Peak volatility: 15.54 (Feb 12, 2026)
👉 Significant spikes indicate periods of increased market uncertainty and risk.
High-Volatility Periods:
Concentrated volatility spikes occurred in January–February 2026, suggesting unstable trading conditions during this window.
Top Performance Days:
Highest daily return: +4.06% (Feb 2, 2026)
Other strong gains clustered between late January and mid-February
👉 Indicates short-term bullish momentum during this period.
Market Activity (Liquidity):
Average daily trading volume was approximately 45 million shares, highlighting strong liquidity and active participation.
📸 Evidence (Athena Query Outputs)
1. Top Percentage Return Days

👉 Shows highest-performing trading days used to identify momentum opportunities.

2. High Volatility Days

👉 Highlights risk spikes and unstable trading periods.

3. Summary Statistics (Min / Max / Avg)

👉 Provides overall market performance benchmarks.

📈 Business Recommendations
Adopt a Trend-Aware Strategy:
Use the ~$264 average price as a benchmark for evaluating entry and exit positions.
Manage Risk During Volatility:
Avoid trading during extreme volatility spikes unless operating under high-risk strategies.
Leverage Momentum Windows:
Focus on periods with clustered positive returns (e.g., late Jan–Feb) for short-term opportunities.
Combine Signals for Better Decisions:
Use both price movement (returns) and volatility metrics to guide trading strategies.
Capitalize on High Liquidity:
Strong trading volume allows efficient execution of trades, making the asset suitable for active trading strategies.
🧾 Tools Used
Amazon Athena — SQL-based analytics
AWS S3 — Data lake storage
AWS Lambda — Serverless ETL processing
