# Airbnb Data Analysis Project

This project provides an analysis of Airbnb listing data using R, focusing on data cleaning, statistical insights, and visualizations.

## Features

### 1. **Data Cleaning**
- Removed columns with all null values.
- Dropped rows with excessive missing data.
- Replaced textual percentage values with numeric equivalents for columns like `host_acceptance_rate` and `host_response_rate`.
- Converted `price` values from text to numeric and replaced missing values with the mean.
- Filled missing values in other columns (e.g., `bedrooms`, `review_scores_value`) with appropriate measures like mean or mode.

### 2. **Statistical Analysis**
- Computed summary statistics for key features such as latitude, longitude, and review scores.
- Analyzed grouped statistics to derive insights based on factors like `beds` and `host_is_superhost`.

### 3. **Visualizations**
- Scatter plots to show relationships (e.g., `Price` vs. `Accommodates`).
- Boxplots for availability metrics.
- Bar plots and grouped bar plots for categorical variables like `Room Type` and `Host Response Time`.
- Pie charts for distribution of neighborhoods.
- Histograms for analyzing room availability trends over a year.
- Correlation analysis between `number_of_reviews` and `review_scores_rating`.

## Key Dependencies
- `dplyr`: For data manipulation.
- `moments`: For statistical computations.
- `DescTools`: For computing mode and other descriptive statistics.
- `ggplot2`: For advanced data visualizations.
- `plotly`: For interactive plots.
- `maps` and `mapview`: For geospatial analysis.
- `sf`: For handling spatial data.

## Instructions to Run

1. **Set Up Environment**:
   - Install the required libraries if not already installed:
     ```R
     install.packages(c("dplyr", "moments", "DescTools", "ggplot2", "plotly", "maps", "mapview", "sf"))
     ```

2. **Load Data**:
   - Ensure the `listings.csv` file is in the working directory.
   - The script automatically reads and processes the data.

3. **Execute the Script**:
   - Run the R script in any R environment (RStudio is recommended).

4. **Inspect Outputs**:
   - The console will display data summaries and statistical results.
   - Plots and visualizations will be generated in the R graphics device.

## Output Highlights

### Data Cleaning
- Columns dropped: `bathrooms`, `calendar_updated`, `license`.
- Missing data handled for critical columns.

### Statistical Insights
- Average and standard deviation for geographic coordinates.
- Analysis of ratings and response times.
- Grouped statistics for superhosts and non-superhosts.

### Visualizations
- Scatter plots, boxplots, and bar plots for key variables.
- Pie charts for neighborhood group distribution.
- Histogram for yearly availability.

---
