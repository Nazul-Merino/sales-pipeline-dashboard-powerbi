# Screenshots

This folder contains screenshots of the two dashboard pages developed in Power BI, along with the solution architecture diagram.

## Files

### 1_Sales_Pipeline_Overview.png

The first page focuses on descriptive analytics and provides an executive overview of the sales pipeline.

Key elements include:

* KPI cards summarizing pipeline performance.
* Revenue distribution by sales stage.
* Monthly opportunity and revenue trends.
* Weekly win-rate monitoring.
* Revenue distribution by region and segment.
* Top revenue drivers by primary reason.
* Geographic visualization of open opportunities.
* Box-and-whisker analysis of revenue distribution.

This page is designed to answer the question:

**"What happened and where?"**

---

### 2_Pipeline_Forecast.png

The second page focuses on predictive analytics, forecasting, and pricing-related risk assessment.

The page follows a business storytelling approach built around three questions:

1. What may happen?
2. How stable is demand?
3. Where is pricing most exposed?

Key elements include:

* Revenue forecast with uncertainty bands.
* Revenue volatility analysis by region.
* FX-driven pricing risk assessment by region.

Together, these visualizations guide decision-makers from current pipeline performance toward future outlook and potential commercial risks.

---

### 3_Architecture_Diagram.png

This architecture diagram illustrates the end-to-end analytics workflow implemented in the project, from CRM opportunity data ingestion to executive dashboard delivery. Raw opportunity data are first imported into Power BI and transformed using Power Query for data cleaning, normalization, and preparation. The processed data are then modeled with DAX to support business calculations and KPI generation.

Advanced analytics are performed using embedded Python scripts, including revenue forecasting with confidence intervals, regional revenue volatility analysis, and FX-driven pricing risk assessment. These analytical outputs are integrated into a two-page executive dashboard that combines descriptive and predictive analytics, enabling stakeholders to monitor pipeline performance, evaluate future revenue scenarios, identify regional demand variability, and assess pricing exposure caused by foreign exchange fluctuations.

The architecture demonstrates how Power Query, DAX, and Python can be integrated within Power BI to build a scalable business intelligence solution that supports data-driven commercial decision-making.

---

## Dashboard Design Philosophy

The dashboard was intentionally designed to balance analytical depth with executive clarity. Rather than presenting isolated charts, the visualizations are organized into a coherent storyline that supports strategic decision-making for sales and commercial leadership teams.
