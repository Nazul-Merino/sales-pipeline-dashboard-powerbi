
# Key DAX Measures and Calculated Columns

This document summarizes a selection of DAX measures, calculated columns, and supporting logic used throughout the dashboard.

In addition to DAX, several visualizations were developed using Python visuals integrated within Power BI.

---

# 1. Currency Conversion to USD

The original dataset contains opportunity values in multiple currencies. To standardize reporting and enable cross-region comparisons, all monetary values were converted to USD using the exchange-rate lookup table.

```DAX
Amount_converted_USD =
SUMX(
    'DataSource',
    'DataSource'[Amount]
        / LOOKUPVALUE(
            'Exchange_Rate_table'[Exchange_Rate],
            'Exchange_Rate_table'[Opportunity_Currency],
            'DataSource'[Amount_Currency]
        )
)
```

This measure retrieves the corresponding exchange rate for each opportunity and converts the original amount into USD before aggregation.

---

# 2. Dynamic Weekly Trend Analysis

The trend chart located in the lower-left section of the **Sales Pipeline Overview** page was designed as a dynamic visual that allows users to switch between:

* Number of Opportunities
* Number of Opportunities Won
* Amount (USD)

### Calculated Column

A week label was created from the opportunity creation date:

```DAX
Week_Label =
FORMAT(
    WEEKNUM('DataSource'[Created_Date], 2),
    "00"
)
```

### Supporting Parameter Table

```DAX
Trend_Metric_Selector =
DATATABLE(
    "Metric", STRING,
    {
        {"No. of Opportunities"},
        {"No. of Opportunities Won"},
        {"Amount (USD)"}
    }
)
```

### Dynamic Measure

```DAX
Selected_Trend_Metric =
VAR SelectedMetric =
    SELECTEDVALUE(
        Trend_Metric_Selector[Metric]
    )
RETURN
SWITCH(
    SelectedMetric,

    "No. of Opportunities",
        DISTINCTCOUNT(
            'DataSource'[Opportunity_ID]
        ),

    "No. of Opportunities Won",
        CALCULATE(
            DISTINCTCOUNT(
                'DataSource'[Opportunity_ID]
            ),
            'DataSource'[Won] = 1
        ),

    "Amount (USD)",
        [Amount_converted_USD],

    BLANK()
)
```

The chart uses:

* X-axis → `Week_Label`
* Y-axis → `Selected_Trend_Metric`
* Slicer → `Trend_Metric_Selector[Metric]`

This design allows users to dynamically switch between multiple business metrics without duplicating visuals.

---

# 3. Dynamic Monthly Opportunity Analysis

A similar approach was used to build the monthly bar chart that allows users to switch between opportunity volume and revenue.

### Calculated Column

```DAX
Month_Year =
FORMAT(
    'DataSource'[Created_Date],
    "MMM yyyy",
    "en-US"
)
```

### Supporting Parameter Table

```DAX
Parameter_Selector =
DATATABLE(
    "Selector", STRING,
    {
        {"No. of Opportunities"},
        {"Amount (USD)"}
    }
)
```

### Dynamic Measure

```DAX
Selected_Parameter_Value =
VAR SelectedParameter =
    SELECTEDVALUE(
        'Parameter_Selector'[Selector],
        "No. of Opportunities"
    )
RETURN
SWITCH(
    SelectedParameter,

    "No. of Opportunities",
        COUNT(
            'DataSource'[Opportunity_ID]
        ),

    "Amount (USD)",
        [Amount_converted_USD],

    BLANK()
)
```

The chart uses:

* X-axis → `Month_Year`
* Y-axis → `Selected_Parameter_Value`
* Slicer → `Parameter_Selector[Selector]`

This approach provides a flexible user experience while minimizing the number of dashboard visuals.

---

# 4. Box-and-Whisker Analysis Using Python Visuals

To analyze revenue distribution and identify potential outliers, a box-and-whisker chart was created using Power BI's Python Visual functionality.

### Calculated Column

```DAX
Amount_USD_Row =
'DataSourceHoneywell'[Amount]
    / LOOKUPVALUE(
        'Exchange_Rate_table'[Exchange_Rate],
        'Exchange_Rate_table'[Opportunity_Currency],
        'DataSourceHoneywell'[Amount_Currency]
    )
```

This column converts each individual opportunity amount into USD at the row level.

### Python Visual

The resulting column was then passed to a Python visual inside Power BI.

```python
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

title_fontsize = 16
axis_label_fontsize = 14
tick_fontsize = 14

data = dataset['Amount_USD_Row']
data = data[data > 0]

data_m = data / 1_000_000

plt.figure()
plt.boxplot(data_m, vert=True)

plt.title(
    'Amount Distribution',
    fontsize=title_fontsize
)

plt.ylabel(
    'USD (Millions)',
    fontsize=axis_label_fontsize
)

plt.gca().yaxis.set_major_formatter(
    FuncFormatter(
        lambda x, _: f'{x:,.1f} M'
    )
)

plt.xticks([])
plt.yticks(fontsize=tick_fontsize)

plt.tight_layout()
plt.show()
```

The visualization highlights the distribution of opportunity values, revealing variability, skewness, and the presence of potential outliers across the sales pipeline.
