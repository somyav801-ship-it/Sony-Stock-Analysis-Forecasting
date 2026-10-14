create database financial;
use financial;

CREATE TABLE sony_daily (
  trade_date DATE PRIMARY KEY, 
  open_p DECIMAL(10,4),
  high_p DECIMAL(10,4), 
  low_p DECIMAL(10,4),
  close_p DECIMAL(10,4), 
  volume BIGINT, 
  daily_return DECIMAL(10,6),
  ma20 DECIMAL(10,4), 
  ma50 DECIMAL(10,4), 
  ma200 DECIMAL(10,4), 
  vol30 DECIMAL(10,6),
  drawdown DECIMAL(10,6), 
  yr SMALLINT, 
  mth TINYINT);

-- 1. Yearly summary
SELECT yr, MIN(low_p) lo, MAX(high_p) hi, ROUND(AVG(close_p),2) avg_close, ROUND(AVG(volume)) avg_volume
FROM sony_daily GROUP BY yr ORDER BY yr;

-- 2. Year-over-year return from last close of each year
WITH ye AS (SELECT yr, SUBSTRING_INDEX(GROUP_CONCAT(close_p ORDER BY trade_date DESC),',',1) AS last_close
            FROM sony_daily GROUP BY yr)
SELECT yr, last_close, ROUND((last_close/LAG(last_close) OVER (ORDER BY yr)-1)*100,1) AS yoy_pct FROM ye;

-- 3. Average return by calendar month (seasonality)
SELECT mth, ROUND(AVG(daily_return)*21*100,2) AS approx_monthly_pct FROM sony_daily GROUP BY mth ORDER BY mth;

-- 4. Golden/death cross events (MA50 crossing MA200)
SELECT trade_date, CASE WHEN ma50>ma200 THEN 'Golden cross' ELSE 'Death cross' END AS cross_signal
FROM (SELECT *, LAG(ma50-ma200) OVER (ORDER BY trade_date) prev_diff FROM sony_daily WHERE ma200 IS NOT NULL) t
WHERE SIGN(ma50-ma200) <> SIGN(prev_diff);

-- 5. Ten highest-volume days
SELECT trade_date, close_p, volume, ROUND(daily_return*100,2) ret_pct FROM sony_daily ORDER BY volume DESC LIMIT 10;
