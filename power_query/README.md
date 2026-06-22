# Power Query

This folder contains the Power Query (M language) scripts used for data ingestion, cleansing, standardization, and preparation within Power BI.

## Files

### opportunities_query.m

Imports the sales opportunity dataset and performs the main data preparation workflow, including:

* Column renaming and standardization.
* Data type validation and conversion.
* Text cleaning and formatting.
* Creation of derived boolean fields.
* Handling of missing or blank categorical values.
* Preparation of the opportunity table for downstream modeling and reporting.

### exchange_rate_query.m

Imports the exchange rate lookup table used for currency conversion.

This query:

* Loads exchange rate information.
* Standardizes column names.
* Applies data type validation.
* Prepares the lookup table used to convert opportunity values into USD.

## Purpose

The Power Query layer was designed to ensure data consistency, reproducibility, and transparency before DAX calculations and dashboard visualizations were applied. By separating data preparation from reporting logic, the model remains easier to maintain, audit, and extend.

