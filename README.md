# Applying linear regression in finances. Is it possible to predict the a stock market index?
We received the challenge of predicting the value of the stock market index Bovespa for the day based on the previous day and other variables using a predictive model. We chose the variables Nikkei-225 and Dow Jones Industrial Average.

## Data Sources
### What data was used?

The analyzed data consists of the historical return series of the Bovespa index, Dow Jones Industrial Average, and Nikkei-225.

### What was the period of this data?

The data period is from January 1, 2012, to January 1, 2024.

### How were these data collected?

We extracted the Bovespa index data using the Yahoo! Finance API and the Dow Jones and Nikkei-225 index data from the Macro Trends website.
- Dow Jones: [Macro Trends Dow Jones](https://www.macrotrends.net/1358/dow-jones-industrial-average-last-10-years#google_vignette)
- Nikkei-225: [Macro Trends Nikkei-225](https://www.macrotrends.net/2593/nikkei-225-index-historical-chart-data)

## Tools
### What programming language was used?

Python was used for data extraction from the API and processing, and R was used for statistical calculations.

### What libraries were used?

Python: yfinance, pandas, numpy, seaborn, and matplotlib
R: readr, dplyr, caret, ggplot2, and tidyr

### Were any software programs used? If so, which ones?

The software programs used were posit, colab, and canva.

## Data Treatment
### Was any data preprocessing done? If so, what and why?

Yes, data preprocessing was performed:
- Decimal comma to point conversion in numerical data to transform it into numeric values.
- Renaming columns for convenience.

### Are there outliers present in the data?

Yes, using the z-score method, it was evident that there are several outliers in the collected data. Visual representation via boxplots showed outliers exceeding the minimum and maximum bounds.

## Calculating Statistical Metrics of the Data
### Mean
### Standard deviation
### Correlation matrix

## Data Visualization (before model application)
### Histograms
### Scatter plots
### Correlation matrix

## Interpreting Each of the Graphs
### Histograms
- Bovespa: The histogram indicates that 55% of daily percentage variations were between -0.05% and 0.05%, suggesting a relatively stable market with occasional significant declines and increases.
- Nikkei: The histogram shows that 60% of daily percentage variations were between 0% and 0.05%, indicating a stable market with a slight upward trend.
- Dow Jones: The histogram reveals that 45% of daily percentage variations were between -0.05% and 0.05%, indicating a stable market with more volatility compared to Bovespa and Nikkei.

### Scatter Plots

### After Model Application

### Correlation Matrix

Weak correlation with both chosen variables, with DJI and IBOV at -0.08 and NI225 and IBOV at 0.04. This weak correlation suggests a weak linear relationship between the indices.

## Conclusion of the Descriptive Report
Even without applying the model, what are the group's expectations regarding the results?

The group has low expectations regarding the model's accuracy and concerns about visualization outcomes.

## Model Presentation
### Explanatory variables

### What are they?
DJI and NI-225.

### Why did the group choose them?

The scientific article aimed to study the relationship between these variables and out of curiosity about the results.

### What is their economic relevance relative to the Ibovespa?

According to the article "Influence of the Dow Jones Industrial Average and Nikkei-225 on the IBOVESPA," these indices influence the pace of the Ibovespa, the compass of the Brazilian stock market. This interconnection occurs due to global economic integration, presence of foreign investors, and influence of commodities and currencies. However, this relationship is dynamic and shaped by economic performance, geopolitical events, and governmental measures.

## Chosen Model
### Linear regression or logistic?

Linear regression.

### Why did you choose one over the other?

Greater familiarity with the model and recommendation by Professor João Carlos.

### Present the equation of the line/sigmoid found

IBOV = 0.000425 - 0.134275 * DJI + 0.067853 * NI225

## Model Performance
### What was the accuracy percentage?

RMSE: 0.01460527 (1.46%)
MAE: 0.01114098 (1.11%)
MAPE: 114.9839%

### What was the R² of the model?

Exactly 0.01014757 or 1.01%

### Does the group consider the model's performance satisfactory?

No.

## Considerations
The RMSE and MAE values indicate that the model can predict the Ibovespa with relative accuracy in index units. However, the high MAPE value suggests the model may not be suitable for predicting percentage changes in the Ibovespa, especially near zero. The low R² value suggests the model needs improvement, possibly with other informative independent variables.

## Model Improvement
### Did the group choose at least one of the following methods to try to improve the model?

Analyze if the model we are using is suitable considering the data we have.

### What was the selected method and how was it done?

Analyzing whether the model we are using is suitable given the data we have.

### Did the attempted improvement actually improve or worsen the model?

No. We understand that for better results, other variables should be used.
