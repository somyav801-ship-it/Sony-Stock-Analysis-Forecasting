# Sony Stock Analysis & Forecasting

End-to-end analysis of Sony (SONY) share price history (2014 to 2026): data cleaning, exploratory analysis, visualization, time series forecasting and an interactive dashboard.

**Tools:** Python (Pandas, NumPy, Matplotlib, Seaborn, Statsmodels) | SQL (MySQL) | Power BI

---

## Business Problem
An investor or analyst needs to understand how Sony's stock has behaved over the long run, how risky it is, whether seasonal or technical patterns exist, and what range of prices is plausible over the next 12 months.

## Dataset
| Item | Detail |
|---|---|
| Source | Historical daily stock data (`sony_stock_data.csv`) |
| Period | 2 Jan 2014 to 24 Aug 2026 |
| Rows | 3,179 trading days |
| Fields | Date, Open, High, Low, Close, Volume |
| Note | Prices are split-adjusted (Sony's 2024 stock split), so early prices look low |

## Project Workflow
1. **Data cleaning:** checked for missing values, duplicate dates, zero-volume days, non-positive prices, High/Low inconsistencies and date gaps. The data was clean, and two large daily moves (+17.7% on 2016-01-29, +12.2% on 2021-02-03) were verified as genuine earnings-driven jumps and kept.
2. **Feature engineering:** daily returns, 20/50/200-day moving averages, 30-day annualised volatility, drawdown, monthly and yearly aggregates.
3. **Exploratory analysis:** long-term trend, volatility regimes, drawdowns, calendar-month seasonality, return distribution.
4. **Forecasting:** Holt (damped), Holt-Winters and ARIMA compared against a naive baseline using a 12-month holdout backtest.
5. **Dashboard:** interactive view with year filters, metric switch .
6. **SQL:** analytical queries for yearly summary, YoY return, seasonality, MA crossovers and high-volume days.

## Key Findings
| Metric | Value |
|---|---|
| Total return (2014 to 2026) | 7.6x (about 17.4% CAGR) |
| Annualised volatility | 30% |
| Sharpe ratio (risk-free rate = 0) | 0.68 |
| Maximum drawdown | -50.6% (bottom on 2022-10-12) |
| All-time high | $30.26 (2025-11-12) |
| Latest close | $24.26 (about 20% below the high) |

- **Trend:** strongest growth came during 2017 to 2021 (positive every calendar year); 2022 was the only major down year (-39%).
- **Seasonality:** July (+6.7% average) and November (+5.6%) were the strongest months, though with only about 13 observations per month this is suggestive, not statistically reliable.
- **Risk:** returns are fat-tailed (kurtosis 5.5), and the 5% daily value-at-risk is about -2.7%.
- **Current signal:** price sits above both its 50-day and 200-day moving averages after a pullback from the late-2025 peak.

## Forecast Results
Models were trained up to Aug 2025 and tested on the following 12 months.

| Model | MAPE |
|---|---|
| ARIMA(2,1,2) | 18.2% |
| Naive (last price) | 19.2% |
| Holt-Winters | 24.1% |
| Holt (damped) | 24.3% |

**Interpretation:** ARIMA barely outperforms a naive forecast, and prices are non-stationary (ADF test), so there is little predictable structure. The 12-month ARIMA forecast centres around $24 to $25 with an 80% interval of roughly $17 to $34. The interval is more informative than the point estimate.

## Recommendations
- Treat forecasts as a **risk range**, not a price target.
- Use drawdown and volatility figures for **position sizing and risk limits**.
- To assess financial health (margins, cost reduction), extend this project with Sony's income statement and balance sheet, which are not part of this dataset.

## Dashboard
![Dashboard preview](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/sony_stock.pdf)



## Visualizations
| | |
|---|---|
| ![Price trend](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/price.png )

| ![Returns & volatility](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/CALENDER%20AND%20ANNUAL%20VOLATILITY.png) |


| ![Seasonality](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/MONTHLY%20average%20return.png) 

| ![Drawdown](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/daily%20retun.png) |



![Forecast](https://github.com/somyav801-ship-it/Sony-Stock-Analysis-Forecasting/blob/main/forecast.png)

## Repository Structure
```
├── data/
│   └── sony_stock_data.csv
├── notebooks/
│   └── Sony_Stock_Analysis.ipynb
├── sql/
│   └── sony_queries.sql
├── dashboard/
│   ├── sony_dashboard
│   
└── README.md
```

## Author
**Somya Verma** | Data Analyst

