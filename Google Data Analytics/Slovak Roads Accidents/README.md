PROJECT: Traffic Accident Data Management
DESCRIPTION: Processes and prepares traffic accident data for analysis by renaming columns, adding calculated fields, and handling null values.
CREATED: November 25, 2024
AUTHOR: Michal Uhrinek

MAIN COMPONENTS:
1. Data Selection: Retrieves specific records and columns from the `nehody$` table.
2. Column Renaming: Uses `sp_rename` to rename columns for clarity.
3. Column Type Inspection: Queries the data types of columns for understanding the dataset structure.
4. Data Manipulation:
   - Adds new columns to calculate average metrics per month and day.
   - Updates these new columns with calculated values from existing data.
5. Null Value Handling: Replaces `NULL` values with `0` to ensure data consistency.

CHALLENGES OVERCOME:
- Managed column renaming to improve readability and prevent errors in future queries.
- Calculated average metrics efficiently by adding new columns and updating them with computed values.
- Addressed potential data integrity issues by replacing `NULL` values across various columns.
-  Drunk drivers could be also speeding or be on their phone so because of it the reason for accidents are the main reasons in each category based on data from Slovvak website.

DEPENDENCIES:
- SQL Server or compatible database system for executing SQL scripts.

USAGE:
Execute the SQL script in a SQL Server environment to prepare the `nehody$` table for further analysis, ensuring all relevant metrics are available and consistent.
