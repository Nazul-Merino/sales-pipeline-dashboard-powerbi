# Sales Pipeline Dashboard

## Problem

Sales leaders often need a consolidated view of pipeline performance to understand current business activity, identify revenue drivers, monitor opportunity conversion, and assess future commercial risk. However, operational CRM data is typically distributed across multiple fields, currencies, and opportunity stages, making it difficult to obtain actionable insights through raw tables alone.

This project addresses that challenge by transforming opportunity-level CRM data into an executive dashboard that combines descriptive analytics, forecasting, and pricing-risk assessment within a single decision-support tool.

---

## Objective

Develop an interactive Power BI dashboard that provides an executive-level overview of the sales pipeline while enabling users to:

* Monitor pipeline value and opportunity performance.
* Analyze revenue distribution across stages, regions, and segments.
* Track opportunity trends and win rates over time.
* Identify key revenue drivers.
* Forecast future revenue.
* Evaluate revenue volatility and FX-driven pricing risk.

The dashboard was designed following a storytelling approach, guiding decision-makers from current pipeline performance toward future outlook and commercial risk exposure.

---

## Dataset Overview

The dashboard uses opportunity-level data extracted from a sales CRM system.

Each record represents a commercial opportunity and includes information related to:

* Opportunity status and stage.
* Revenue amount and currency.
* Opportunity ownership.
* Region and country.
* Segmentation and grading.
* Creation date and sales cycle information.

An additional exchange-rate lookup table was used to standardize all monetary values into USD, enabling consistent cross-region reporting and comparison.

The original dataset is not included in this repository.

---

## Approach

Before creating DAX measures, calculated columns, visualizations, and forecasting models, the data underwent a preprocessing and standardization phase using Power Query (M Language).

The preparation workflow included:

* Column renaming and standardization.
* Data type validation and conversion.
* Removal of redundant fields.
* Text cleaning and formatting.
* Standardization of categorical values.
* Handling of blank values.
* Creation of boolean fields used for downstream analysis.
* Currency standardization through exchange-rate integration.

This preprocessing layer was designed to improve data quality, consistency, reproducibility, and transparency before the analytical and visualization stages.

For implementation details, refer to:

```text
power_query/opportunities_query.m
power_query/exchange_rate_query.m
```

---

## Repository Structure

### screenshots/

Contains screenshots of the two dashboard pages, showcasing both the descriptive and predictive components of the solution.

### docs/

Contains supporting documentation describing the dashboard design, business logic, storytelling approach, and analytical framework.

### power_query/

Contains the Power Query (M Language) scripts used for data ingestion, cleansing, standardization, and preparation.

### dax/

Contains a curated selection of DAX measures, calculated columns, and supporting logic used throughout the dashboard, including examples based on functions such as `SUMX()`, `LOOKUPVALUE()`, `SELECTEDVALUE()`, `SWITCH()`, and parameter-driven dynamic visualizations.

### data/

Provides a high-level description of the source data structure and supporting lookup tables used in the project.

---

## Technology Stack

### Business Intelligence

* Power BI Desktop
* Power Query (M Language)
* DAX

### Python Visuals

* pandas
* numpy
* matplotlib
* statsmodels

### Visualization Techniques

* KPI Cards
* Dynamic Parameter-Driven Charts
* Geographic Mapping
* Box-and-Whisker Analysis
* Revenue Forecasting
* Volatility Analysis
* FX Risk Assessment

---

## Dashboard Overview

### Page 1 — Sales Pipeline Overview

Focuses on descriptive analytics and answers:

**"What happened and where?"**

Key features include:

* KPI monitoring.
* Revenue by stage.
* Opportunity trends.
* Win-rate analysis.
* Revenue distribution by region and segment.
* Geographic opportunity mapping.
* Revenue driver analysis.
* Distribution analysis using Python visuals.

### Page 2 — Pipeline Forecast

Focuses on predictive analytics and business risk.

The storyline is structured around three questions:

1. What may happen?
2. How stable is demand?
3. Where is pricing most exposed?

Key features include:

* Revenue forecasting with uncertainty bands.
* Revenue volatility analysis by region.
* FX-driven pricing-risk assessment.

Together, these visualizations help decision-makers connect current pipeline performance with future commercial outcomes and potential pricing risks.
