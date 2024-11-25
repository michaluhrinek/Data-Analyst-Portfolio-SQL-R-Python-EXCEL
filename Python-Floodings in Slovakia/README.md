PROJECT: Flooding Data Analysis in Slovakia
DESCRIPTION: Analyzes historical flooding data in Slovakia to identify patterns, assess damages, and visualize trends.
CREATED: November 25, 2024
AUTHOR: Michal Uhrinek

MAIN COMPONENTS:
1. Data Loading: Uses `pandas` to load flooding data from an Excel file into a DataFrame for analysis.
2. Data Processing:
   - Converts date columns to datetime format for time-based analysis.
   - Groups data by date and location to count events and assess impacts.
3. Visualization:
   - Utilizes `matplotlib` to create scatter plots, bar charts, and line charts for visualizing flooding events, costs, and affected populations over time.
4. Analysis:
   - Calculates total costs and number of people affected by floods.
   - Summarizes flooding events by year, location, and river.

CHALLENGES OVERCOME:
- Managed conversion of date formats to ensure accurate grouping and analysis.
- Addressed potential font glyph issues in plots for better readability.
- Handled large datasets efficiently using pandas for data manipulation.

DEPENDENCIES:
- `numpy`: Numerical operations
- `pandas`: Data manipulation
- `matplotlib`: Data visualization

USAGE:
Run the script to load the flooding data from the specified Excel file path. The script will generate various plots to visualize flooding trends, costs, and affected populations in Slovakia over time.
